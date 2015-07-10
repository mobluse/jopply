#!/usr/bin/perl
use strict;
use warnings;
use utf8;
open INFILE, '<', 'email-appl.txt';
my @appl = <INFILE>;
close INFILE;
chomp @appl;
open INFILE, '<', 'email-total.txt';
my @total = <INFILE>;
close INFILE;
for my $i (@appl) {
    for my $j (@total) {
        if (index($j, $i) > -1) {
            print "$j";
        }
    }
}
