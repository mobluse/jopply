#!/bin/sh
./jopply-sys.pl
./jopply-sys.pl --lanid
./jopply-sys.pl -n=lärare,cad -l=12
./jopply-sys.pl --nyckelord=lärare,cad --lanid=12 --epost --verbose
./jopply-sys.pl -k=lärare,cad -l=12 -w
./jopply-sys.pl -k=lärare,cad -l=12 -w -e
./jopply-sys.pl -a=2621881
./jopply-sys.pl --help
