#!/bin/sh
./jopply-curl.pl
./jopply-curl.pl --lanid
./jopply-curl.pl -n=lärare,cad -l=12
./jopply-curl.pl --nyckelord=lärare,cad --lanid=12 --epost --verbose
./jopply-curl.pl -k=lärare,cad -l=12 -w
./jopply-curl.pl -k=lärare,cad -l=12 -w -e
./jopply-curl.pl -a=2621881
./jopply-curl.pl --help
