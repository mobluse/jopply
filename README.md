# Jopply
Jopply (a portmanteau of job and apply) helps applying for jobs.
This is a very early release and everything will change.

### How to install and run in Linux:
#### sudo apt-get update && sudo apt-get install libjson-perl libwww-curl-perl
### ./jopply.pl
Alternatively,
#### sudo apt-get update && sudo apt-get install libjson-perl cpanminus && sudo cpanm Furl
### ./furl-jopply.pl

### How to install and run in Windows using ActivePerl:
#### ppm install WWW-Curl --force
### perl jopply.pl
Alternatively,
#### ppm install Furl
### perl furl-jopply.pl
Tested in Windows Vista on x86-32 and works with cp850.

The rest of the text is in Swedish, because right now it only works
for a Swedish web service. The command-line arguments are also in
Swedish and are the same as in the specification from
Arbetsförmedlingen, but English arguments will be added in the future.

## Exempel:
#### Visa den inbyggda hjälpen!
###./jopply.pl --help

#### Visa alla län med läns-ID!
###./jopply.pl --lanid

#### Visa annonsid för alla jobbannonser i Stockholms län som innehåller CAD och 3D!
###./jopply.pl --n=CAD,3D --l=1 --verbose

#### Visa annons-ID och e-postadress för jobbannonser i Stockholms län som innehåller CAD och som är sökbara via e-post!
###./jopply.pl --nyckelord=CAD --lanid=1 --epost

#### Visa annonsid och webbplats för jobbannonser i Stockholms län som innehåller CAD och som är sökbara via webbplatser!
###./jopply.pl --keyword=CAD --lanid=1 --web

#### Visa annonsid och webbplats eller e-postadress för jobbannonser i Stockholms län som innehåller CAD och som är sökbara via webbplatser eller e-post!
###./jopply.pl -k=CAD -l=1 -w -e

#### Visa annons med annons-ID!
###./jopply.pl --annonsid=2621881