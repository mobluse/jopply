#!/bin/sh
./jopply.pl
./jopply.pl --lanid
./jopply.pl -n=lärare,cad -l=12
./jopply.pl --nyckelord=lärare,cad --lanid=12 --epost --verbose
./jopply.pl -k=lärare,cad -l=12 -w
./jopply.pl -k=lärare,cad -l=12 -w -e
./jopply.pl -a=2621881
./jopply.pl --help
