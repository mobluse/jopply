#!/bin/sh
perl jopply-furl.pl
perl jopply-furl.pl --lanid
perl jopply-furl.pl -n=lärare,cad --lanid=12
perl jopply-furl.pl --nyckelord=lärare,cad --lanid=12 --epost --verbose
perl jopply-furl.pl -n=lärare,cad --lanid=12 -w
perl jopply-furl.pl -n lärare,cad --lanid 12 -w -e
perl jopply-furl.pl --lanid=12 --kommunid
perl jopply-furl.pl --kommunid=1381 -n lärare | grep Laholm
perl jopply-furl.pl --ann=2621881
perl jopply-furl.pl --help
