#!/bin/sh
./furl-jopply.pl
./furl-jopply.pl --lanid
./furl-jopply.pl -n=lärare,cad -l=12
./furl-jopply.pl --nyckelord=lärare,cad --lanid=12 --epost --verbose
./furl-jopply.pl -k=lärare,cad -l=12 -w
./furl-jopply.pl -k=lärare,cad -l=12 -w -e
./furl-jopply.pl -a=2621881
./furl-jopply.pl --help
