#!/bin/sh
perl jopply-furl.pl
perl jopply-furl.pl --lanid
perl jopply-furl.pl -n=lärare,cad -l=12
perl jopply-furl.pl --nyckelord=lärare,cad --lanid=12 --epost --verbose
perl jopply-furl.pl -k=lärare,cad -l=12 -w
perl jopply-furl.pl -k=lärare,cad -l=12 -w -e
perl jopply-furl.pl -a=2621881
perl jopply-furl.pl --help
