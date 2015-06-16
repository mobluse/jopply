#!/usr/bin/perl
# Jopply 2015-06-16 by M.O.B. as Perl command-line application.
# Copyright (C) 2015 by Mikael O. Bonnier, Lund, Sweden.
# License: GNU GPL v3 or later, http://www.gnu.org/licenses/gpl.txt
# Donations are welcome to PayPal mikael.bonnier@gmail.com.
# The source code is at https://github.com/mobluse/jopply/
#
# It was developed in Raspbian on Raspberry Pi 2.
#
# Howto install and run in Linux:
# sudo apt-get update && sudo apt-get install libwww-curl-perl libjson-perl
# ./jopply.pl
#
# Revision history:
# 2015-Jun: Alpha versions.
#
# Suggestions, improvements, and bug-reports
# are always welcome to:
# Mikael Bonnier
# Osten Undens gata 88
# SE-227 62 LUND
# SWEDEN
#
# Or use my internet addresses:
# mikael.bonnier@gmail.com
# http://www.df.lth.se.orbin.se/~mikaelb/
#              _____
#             /   / \
# ***********/   /   \***********
#           /   /     \
# *********/   /       \*********
#         /   /   / \   \
# *******/   /   /   \   \*******
#       /   /   / \   \   \
# *****/   /   /***\   \   \*****
#     /   /__ /_____\   \   \
# ***/               \   \   \***
#   /_________________\   \   \
# **\                      \  /**
#    \______________________\/
#
# Mikael Bonnier
#/////////////////////////////////////////////////////////////////////

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

my $help = 0;
my $man = 0;
my $nyckelord = '';
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
pod2usage(1) if $help || !$nyckelord;
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

my $total = 0;
my $line = 0;
my @annonsid = values $decoded_json->{'matchningslista'}{'matchningdata'};
foreach my $elem (@annonsid) {
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

jopply.pl - Jopply helps applying for jobs in Sweden.

=head1 SYNOPSIS

./jopply.pl [options ...]

Options:
  --help brief help message
  --man full documentation
  --lanid=12 läns-ID
  --nyckelord=CAD,3D lista med söktermer
  --epost visa jobb som söks via e-post
  --webb visa jobb som söks via webbtjänster

=head1 OPTIONS

=over 8

=item B<--help>

Prints a brief help message and exits.

=item B<--man>

Prints the manual page and exits.

=item B<--lanid>

Väljer läns-ID. Om ID utelämnas så visas en lista med ID och län.

=item B<--nyckelord>

Lista med nyckelord/sökord som separeras med komma.

=item B<--epost>

Visa jobb som kan sökas via e-post och e-postadressen.

=item B<--webb>

Visa jobb som söks via webbtjänster.

=back

=head1 DESCRIPTION

B<Jopply> (a portmanteau of job and apply) helps applying for jobs.
This is a very early release and everything will change. The rest of
the text is in Swedish. The command-line arguments are also in Swedish
and are the same as in the specification, but English arguments will be
added in the future.

=cut