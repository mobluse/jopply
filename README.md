# Jopply
Jopply (a portmanteau of job and apply) helps applying for jobs.
This is a very early release and everything will change.

### How to install and run in Linux (e.g. Ubuntu, Debian, Raspbian):
#### sudo apt-get update && sudo apt-get install libjson-perl libwww-curl-perl
### ./jopply-curl.pl
Alternatively,
#### sudo apt-get update && sudo apt-get install libjson-perl cpanminus && sudo cpanm Furl
### ./jopply-furl.pl
Alternatively,
#### sudo apt-get update && sudo apt-get install libjson-perl
### ./jopply-sys.pl
Tested in Raspbian on Raspberry Pi and Ubuntu on x86-32.

### How to install and run in Windows using Git Bash:
Git Bash includes Perl and Curl, but you have to install the modules
Pod::Usage, URI::Escape, and JSON, manually, by e.g. copying from
ActivePerl.
### ./jopply-sys.pl
Tested in Git Bash for Windows on x86-32.

### How to install and run in Windows using ActivePerl:
#### ppm install WWW-Curl --force
I needed to use --force due to different repositories, but you may not
need to use that.
### perl jopply-curl.pl
Alternatively,
#### ppm install Furl
### perl jopply-furl.pl
Alternatively (provided you have curl in the PATH),
### perl jopply-sys.pl
Tested in Windows Vista Command/MS-DOS on x86-32 and works with cp850
(which is default).

The rest of the text is in Swedish, because right now it only works
for a Swedish web service. The command-line arguments are also in
Swedish and are the same as in the specification from
Arbetsförmedlingen (Swedish government organisation), but English
arguments will be added in the future.

## Exempel
för Linux där valfri jopply-X.pl länkats till jopply. I Windows kan man
göra en bat-fil.
#### Visa den inbyggda hjälpen!
###./jopply --help

#### Visa alla län med läns-ID!
###./jopply --lanid

#### Visa annonsid för alla jobbannonser i Stockholms län som innehåller CAD och 3D!
###./jopply --n=CAD,3D --l=1 --verbose

#### Visa annons-ID och e-postadress för jobbannonser i Stockholms län som innehåller CAD och som är sökbara via e-post!
###./jopply --nyckelord=CAD --lanid=1 --epost

#### Visa annonsid och webbplats för jobbannonser i Stockholms län som innehåller CAD och som är sökbara via webbplatser!
###./jopply --keyword=CAD --lanid=1 --web

#### Visa annonsid och webbplats eller e-postadress för jobbannonser i Stockholms län som innehåller CAD och som är sökbara via webbplatser eller e-post!
###./jopply -k=CAD -l=1 -w -e

#### Visa annons med annons-ID!
###./jopply --annonsid=2621881