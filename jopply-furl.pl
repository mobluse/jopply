#!/usr/bin/perl
# Jopply-Furl 2015-06-28 by M.O.B. as Perl command-line application.
# Copyright (C) 2015 by Mikael O. Bonnier, Lund, Sweden.
# License: GNU AGPL v3 or later, https://gnu.org/licenses/agpl-3.0.txt
# ABSOLUTELY NO WARRANTY.
# See libjopply.pl.
#
# How to install and run in Linux:
# Download zip and unpack or use git clone.
# sudo apt-get update && sudo apt-get install libjson-perl cpanminus && sudo cpanm Furl
# ./jopply-furl.pl
#
# How to install and run in Windows using ActivePerl:
# Download zip and unpack or use git clone.
# In Command/MS-DOS-prompt and in the directory where you unpacked
# jopply, issue these commands:
# ppm install Furl
# perl furl-jopply.pl
# Tested in Windows Vista on x86-32 and works with cp850.
#
# The advantage of Furl is that it is Pure Perl.
#
# It doesn't work in Git Bash for Windows.
#
######################################################################

use strict;
use warnings;
use utf8;
use Time::HiRes qw(sleep);
use Getopt::Long;
use Encode qw(decode encode);
use Data::Dumper;
use Pod::Usage;
use URI::Escape;
use JSON;
use Furl;
use 5.008008;

require 'libjopply.pl';
our $xurl;

sub url_get {
    my ($u) = @_;
    return $xurl->get($u)->body;
}

sub url_new {
    return Furl->new( headers =>
            [ 'Accept' => 'application/json', 'Accept-Language' => 'sv' ], );
}
__END__

=encoding utf8

=head1 NAME

jopply-furl.pl - Hjälper till att söka jobb i Sverige.

=head1 SYNOPSIS

./jopply-furl.pl [options ...]

Options:
  --help kortfattat hjälpmeddelande
  --man full dokumentation
  --verbose mer text om varje post
  --lanid=12 läns-ID
  --kommunid=1281 kommunid
  --nyckelord=CAD,3D lista med söktermer
  --epost visa jobb som söks via e-post
  --webb visa jobb som söks via webbtjänster

=head1 OPTIONS

=over 8

=item B<--help>

Skriver ut en kortfattad hjälptext och avslutar.
[en] Prints a brief help message and exits.

=item B<--man>

Visar manualsidan. Avsluta med q.

=item B<--verbose>

Visar mer text om varje post.

=item B<--lanid>

Väljer läns-ID. Om ID utelämnas så visas en lista med ID och län.

=item B<--kommunid>

Väljer kommun-ID. Om ID utelämnas så visas en lista med ID och kommuner,
under förutstättning att lanid är satt.

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
