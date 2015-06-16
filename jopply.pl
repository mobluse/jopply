#!/usr/bin/perl
use strict;
use warnings;
#use utf8;
use Getopt::Long;
use URI::Escape;
use Encode qw(decode encode);
use WWW::Curl::Easy;
use JSON;
use Data::Dumper;
use Pod::Usage;
my $man = 0;
my $help = 0;

my $nyckelord = 'CAD,3D';
my $lanid = '';
my $ansokan_epostadress = '';
my $ansokan_webbadress = '';
my $annonsid = '';
GetOptions('help|?' => \$help, man => \$man,
           'nyckelord|keyword=s' => \$nyckelord,
           'lanid:i' => \$lanid,
           'epostadress' => \$ansokan_epostadress,
           'webbadress' => \$ansokan_webbadress,
           'annonsid=s' => \$annonsid)
  or pod2usage(2);
pod2usage(1) if $help;
pod2usage(-exitval => 0, -verbose => 2) if $man;

$nyckelord = join(' ', split(/,/, $nyckelord));
$nyckelord = uri_escape($nyckelord);
my $curl = WWW::Curl::Easy->new;
$curl->setopt(CURLOPT_HEADER, 0);
my @H = ('Accept-Language:sv');
$curl->setopt(CURLOPT_HTTPHEADER, \@H);
my $URL = "http://api.arbetsformedlingen.se/af/v0/platsannonser";
my $response_body;
my $retcode;
my $decoded_json;
$curl->setopt(CURLOPT_WRITEDATA, \$response_body);
if ($annonsid) {
  $curl->setopt(CURLOPT_URL, "$URL/$annonsid");
  $response_body = '';
  $retcode = $curl->perform;
  $decoded_json = decode_json($response_body);
  print Dumper $decoded_json;
  exit 0;
}
if ($lanid ne '' && $lanid == 0) {
  $curl->setopt(CURLOPT_URL, "$URL/soklista/lan");
  $retcode = $curl->perform;
  $decoded_json = decode_json($response_body);
  #print(Dumper $decoded_json);
  foreach my $elem (values $decoded_json->{'soklista'}{'sokdata'}) {
    printf "%2d:%s\n", $elem->{id}, encode('utf-8', decode('iso-8859-1', $elem->{namn}));
  }
  exit 0;
}

$curl->setopt(CURLOPT_URL, "$URL/matchning?lanid=$lanid"
  . "&nyckelord=$nyckelord&antalrader=9999");
$retcode = $curl->perform;
$decoded_json = decode_json($response_body);

#print(Dumper $decoded_json);

#for my $elem (values $decoded_json->{'soklista'}{'sokdata'}) {
#  print encode('utf-8', decode('iso-8859-1', $elem->{'namn'})) . "\n";
#}

my $total = 0;
my $line = 0;
my @annonsid = values $decoded_json->{'matchningslista'}{'matchningdata'};
foreach my $elem (@annonsid) {
  #print("$elem->{'annonsid'}\n");
  ++$total;
  $curl->setopt(CURLOPT_URL, "$URL/$elem->{'annonsid'}");
  if($ansokan_epostadress || $ansokan_webbadress) {
    $response_body = '';
    $retcode = $curl->perform;
    $decoded_json = decode_json($response_body);
    my $epostadress = $decoded_json->{'platsannons'}{'ansokan'}{'epostadress'};
    my $webbadress = $decoded_json->{'platsannons'}{'ansokan'}{'webbplats'};
    my $b_line = 0;
    if ($ansokan_epostadress && $epostadress) {
      $b_line = 1;
      ++$line;
      print("$line: $elem->{'annonsid'}: $epostadress");
    }
    if ($ansokan_webbadress && $webbadress) {
      if ($b_line) {
        print(": $webbadress\n");
      }
      else {
        $b_line = 1;
        ++$line;
        print("$line: $elem->{'annonsid'}: : $webbadress\n");
      }
    }
    else {
      if ($b_line) {
        print("\n");
      }
    }
    if ($b_line) {
      print(Dumper $elem);
      print(Dumper $decoded_json->{'platsannons'}{'ansokan'});
    }
  }
  else {
    ++$line;
    print("$line: $elem->{'annonsid'}\n");
    print(Dumper $elem);
  }
}
print("$line/$total=".sprintf('%.2f', 100*$line/$total)."%\n");

__END__

=head1 NAME

sample - Using Getopt::Long and Pod::Usage

=head1 SYNOPSIS

./jopply.pl [options ...]

Options:
  --help brief help message
  --man full documentation
  --lanid=14 läns-ID
  --nyckelord=CAD,3D lista med söktermer
  --epost visa jobb som söks via e-post
  --webb visa jobb som söks via webbtjänst

=head1 OPTIONS

=over 8

=item B<-help>

Print a brief help message and exits.

=item B<-man>

Prints the manual page and exits.

=item B<-lanid>

Väljer läns-ID. Om ID utelämnas så visas en lista med ID och län.

=item B<-nyckelord>

Lista med nyckelord/sökord som separeras med komma.

=item B<-epost>

Visa jobb som kan sökas via e-post och e-postadressen.

=item B<-webb>

Visa jobb som söks via webbtjänst.

=back

=head1 DESCRIPTION

B<This program> will read the given input file(s) and do something
useful with the contents thereof.

=cut