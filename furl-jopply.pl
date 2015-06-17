#!/usr/bin/perl
# Furl-Jopply 2015-06-17 by M.O.B. as Perl command-line application.
# Copyright (C) 2015 by Mikael O. Bonnier, Lund, Sweden.
# License: GNU AGPL v3 or later, https://gnu.org/licenses/agpl-3.0.txt
# Donations are welcome to PayPal mikael.bonnier@gmail.com.
# The source code is at https://github.com/mobluse/jopply/
#
# It was developed in Raspbian on Raspberry Pi 2.
#
# How to install and run in Linux:
# sudo apt-get update && sudo apt-get install cpanminus && sudo cpanm Furl
# ./furl-jopply.pl
#
# Not tested in Windows.
#
# The advantage of Furl is that it is Pure Perl.
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
######################################################################

use strict;
use warnings;
use utf8;
use Time::HiRes qw(sleep);
use Getopt::Long;
use URI::Escape;
use Encode qw(decode encode);
use Data::Dumper;
use Pod::Usage;
use JSON;
#use WWW::Curl::Easy;
use Furl;

my $encoding = $^O eq 'MSWin32' ? 'cp850' : 'utf8';
if ($encoding ne 'utf8') {
  binmode(STDOUT, ":encoding($encoding)" );
  binmode(STDIN, ":encoding($encoding)" );
}

my $help = 0;
my $man = 0;
my $verbose = 0;
my $nyckelord = '';
my $lanid = '';
my $ansokan_epostadress = '';
my $ansokan_webbplats = '';
my $annonsid = '';
GetOptions('help|?' => \$help, man => \$man, verbose => \$verbose,
           'nyckelord|keyword=s' => \$nyckelord,
           'lanid:i' => \$lanid,
           'epostadress' => \$ansokan_epostadress,
           'webbadress' => \$ansokan_webbplats,
           'annonsid=s' => \$annonsid)
  or pod2usage(2);
if ($man) {
  pod2usage(-exitval => 0, -verbose => 2);
}
if (($help || !$nyckelord) && !$annonsid
  && !($lanid ne '' && $lanid == 0)) {
  pod2usage(1);
}

$nyckelord = join(' ', split(/,/, $nyckelord));
if ($encoding ne 'utf8') {
  $nyckelord = uri_escape_utf8($nyckelord);
}
else {
  $nyckelord = uri_escape($nyckelord);
}

my $furl = Furl->new(
        headers => [ 'Accept' => 'application/json', 'Accept-Language' => 'sv' ],
    );
my $URL = "http://api.arbetsformedlingen.se/af/v0/platsannonser";
my $response;
my $decoded_json;
if ($annonsid) {
  $response = $furl->get("$URL/$annonsid");
  $decoded_json = decode_json($response->body);
  print Dumper $decoded_json;
  exit 0;
}
if ($lanid ne '' && $lanid == 0) {
  $response = $furl->get("$URL/soklista/lan");
  $decoded_json = decode_json($response->body);
  #print(Dumper $decoded_json);
  foreach my $elem (values $decoded_json->{'soklista'}{'sokdata'}) {
    printf "%2d; %s\n", $elem->{id}, iso2utf($elem->{namn});
  }
  exit 0;
}

$response = $furl->get("$URL/matchning?lanid=$lanid"
  . "&nyckelord=$nyckelord&antalrader=9999");
$decoded_json = decode_json($response->body);
if ((keys $decoded_json)[0] eq 'Error') {
  print Dumper $decoded_json;
  exit 0;
}

if (!$decoded_json->{'matchningslista'}{'antal_sidor'}) {
  exit 1;
}
my $total = 0;
my $line = 0;
my @annonsid = values $decoded_json->{'matchningslista'}{'matchningdata'};
foreach my $elem (@annonsid) { # Bug in Perl if using directly.
  ++$total;
  if($ansokan_epostadress || $ansokan_webbplats) {
    sleep 0.2;
    $response = $furl->get("$URL/$elem->{'annonsid'}");
    $decoded_json = decode_json($response->body);
    my $epostadress = $decoded_json->{'platsannons'}{'ansokan'}{'epostadress'};
    my $webbplats = $decoded_json->{'platsannons'}{'ansokan'}{'webbplats'};
    # According to the specification webbplats should be webbadress.
    my $b_line = 0;
    if ($ansokan_epostadress && $epostadress) {
      $b_line = 1;
      ++$line;
      print("$line; $elem->{'annonsid'}; $epostadress");
    }
    if ($ansokan_webbplats && $webbplats) {
      $webbplats = iso2utf($webbplats);
      if ($b_line) {
        print("; $webbplats\n");
      }
      else {
        $b_line = 1;
        ++$line;
        print("$line; $elem->{'annonsid'}; ; $webbplats\n");
      }
    }
    else {
      if ($b_line) {
        print("\n");
      }
    }
    if ($b_line && $verbose) {
      print(Dumper $elem);
      print(Dumper $decoded_json->{'platsannons'}{'ansokan'});
    }
  }
  else {
    ++$line;
    my $annonsrubrik = iso2utf($elem->{'annonsrubrik'});
    print("$line; $elem->{'annonsid'}; $annonsrubrik\n");
    if ($verbose) {
      print(Dumper $elem);
    }
  }
}
print("Total; $line/$total=".sprintf('%.2f', 100*$line/$total)."%\n");

sub iso2utf {
  my ($s) = @_;
  if ($encoding eq 'utf8') {
    $s = encode($encoding, decode('cp1252', $s));
  }
  else {
    $s = decode('cp1252', $s);
  }
  return $s;
}

__END__

=head1 NAME

jopply.pl - Hjälper till att söka jobb i Sverige.

=head1 SYNOPSIS

./jopply.pl [options ...]

Options:
  --help kortfattat hjälpmeddelande
  --man full dokumentation (koden)
  --verbose mer text om varje post
  --lanid=12 läns-ID
  --nyckelord=CAD,3D lista med söktermer
  --epost visa jobb som söks via e-post
  --webb visa jobb som söks via webbtjänster

=head1 OPTIONS

=over 8

=item B<--help>

Skriver ut en kortfattad hjälptext och avslutar.
[en] Prints a brief help message and exits.

=item B<--man>

Visar manualsidan (men nu koden). Avsluta med q.

=item B<--verbose>

Visar mer text om varje post.

=item B<--lanid>

Väljer läns-ID. Om ID utelämnas så visas en lista med ID och län.

=item B<--nyckelord eller --keyword>

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
