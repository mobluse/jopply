#!/bin/sh
perl jopply-sys.pl
perl jopply-sys.pl --lanid
perl jopply-sys.pl -n=lärare,cad --lanid=12
perl jopply-sys.pl --nyckelord=lärare,cad --lanid=12 --epost --verbose
perl jopply-sys.pl -n=lärare,cad --lanid=12 -w
perl jopply-sys.pl -n lärare,cad --lanid 12 -w -e
perl jopply-sys.pl --ann=2621881
perl jopply-sys.pl --help
