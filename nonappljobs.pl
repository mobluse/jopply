#!/usr/bin/perl
use strict;
use warnings;
use utf8;
open INFILE, '<', 'email-appl.txt';
my @appl = <INFILE>;
close INFILE;
chomp @appl;
open INFILE, '<', 'email-new.txt';
my @new = <INFILE>;
close INFILE;
for my $j (@new) {
    my $found = 0;
    for my $i (@appl) {
        if (index($j, $i) > -1) {
            $found = 1;
            last;
        }
    }
    if (!$found) {
        print $j;
    }
}
