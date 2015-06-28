#!/bin/sh
perl jopply-curl.pl
perl jopply-curl.pl --lanid
perl jopply-curl.pl -n=lärare,cad --lanid=12
perl jopply-curl.pl --nyckelord=lärare,cad --lanid=12 --epost --verbose
perl jopply-curl.pl -n=lärare,cad --lanid=12 -w
perl jopply-curl.pl -n lärare,cad --lanid 12 -w -e
perl jopply-curl.pl --lanid=12 --kommunid
perl jopply-curl.pl --kommunid=1381 -n lärare | grep Laholm
perl jopply-curl.pl --ann=2621881
perl jopply-curl.pl --help
