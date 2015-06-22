#!/bin/sh
./jopply-furl.pl
./jopply-furl.pl --lanid
./jopply-furl.pl -n=lärare,cad -l=12
./jopply-furl.pl --nyckelord=lärare,cad --lanid=12 --epost --verbose
./jopply-furl.pl -k=lärare,cad -l=12 -w
./jopply-furl.pl -k=lärare,cad -l=12 -w -e
./jopply-furl.pl -a=2621881
./jopply-furl.pl --help
