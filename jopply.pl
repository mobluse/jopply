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

my $nyckelord = 'CAD,3D';
my $lanid = '';
my $ansokan_epostadress = '';
my $annonsid = '';
GetOptions ('nyckelord=s' => \$nyckelord,
            'lanid:i' => \$lanid,
            'epostadress' => \$ansokan_epostadress,
            'annonsid=s' => \$annonsid)
  or die("Fel i kommandoradsargument.\n");
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

my @annonsid = values $decoded_json->{'matchningslista'}{'matchningdata'};
my $total = 0;
my $line = 0;
foreach my $elem (@annonsid) {
  #print("$elem->{'annonsid'}\n");
  ++$total;
  $curl->setopt(CURLOPT_URL, "$URL/$elem->{'annonsid'}");
  if($ansokan_epostadress) {
    $response_body = '';
    $retcode = $curl->perform;
    $decoded_json = decode_json($response_body);
    my $epostadress = $decoded_json->{'platsannons'}{'ansokan'}{'epostadress'};
    if ($epostadress) {
      ++$line;
      print("$line: $elem->{'annonsid'}: $epostadress\n");
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