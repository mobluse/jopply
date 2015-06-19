# Jopply
Jopply (a portmanteau of job and apply) helps applying for jobs.
This is a very early release and everything will change. The rest of the
text is in Swedish, because right now it only works for a Swedish web
service. There is also high unemployment in Sweden.

Jopply hjälper dig att söka jobb. Detta är en mycket tidig version och
allt kommer att ändras. Det finns tre olika varianter i hopp om att
någon skall fungera.

### Hur man installerar och kör i Windows med Git Bash:
Git Bash kommer med Perl och Curl, men du måste installera modulerna
Pod::Usage, URI::Escape och JSON, men man kan klona.
Starta Git Bash och ge dessa kommandon:
#### git clone https://github.com/mobluse/jopply.git
#### git clone https://github.com/mobluse/jopply-pm.git
#### cd jopply
#### ./jopply-sys.pl
Testat i Git Bash för Windows på x86-32. De övriga varianterna av
Jopply fungerar inte i Git Bash för Windows.

### Hur man installerar i Linux (t.ex. Ubuntu, Debian, Raspbian):
#### sudo apt-get update && sudo apt-get install libjson-perl
#### ./jopply-sys.pl
Alternativt,
#### sudo apt-get update && sudo apt-get install libjson-perl libwww-curl-perl
#### ./jopply-curl.pl
Alternativt,
#### sudo apt-get update && sudo apt-get install libjson-perl cpanminus && sudo cpanm Furl
#### ./jopply-furl.pl
Testat i Raspbian på Raspberry Pi och Ubuntu på x86-32.

### Hur man installerar och kör i Windows med ActivePerl:
#### ppm install Furl
#### perl jopply-furl.pl
Alternativt,
#### ppm install WWW-Curl --force
Jag behövde använda --force p.g.a. att jag har flera repositorier, men
du måste kanske inte göra det.
#### perl jopply-curl.pl
Alternativt (förutsatt att du har curl i PATH),
#### perl jopply-sys.pl
Testet i Windows Vista Command/MS-DOS-prompt på x86-32 och fungerar med
cp850 (vilket är standardvärdet).

[en] The command-line arguments are also in
Swedish and are the same as in the specification from
Arbetsförmedlingen (Swedish government organisation), but English
arguments will be added in the future.

Kommandoradsargumenten är samma som i specifikationen från Arbetsförmedlingen.

## Exempel
för Linux där valfri jopply-X.pl länkats till jopply. I Windows kan man
göra en bat-fil.
#### Visa den inbyggda hjälpen!
##### ./jopply --help

#### Visa alla län med läns-ID!
##### ./jopply --lanid

#### Visa annonsid för alla jobbannonser i Stockholms län som innehåller CAD och 3D!
##### ./jopply --n=CAD,3D --l=1 --verbose

#### Visa annons-ID och e-postadress för jobbannonser i Stockholms län som innehåller CAD och som är sökbara via e-post!
##### ./jopply --nyckelord=CAD --lanid=1 --epost

#### Visa annonsid och webbplats för jobbannonser i Stockholms län som innehåller CAD och som är sökbara via webbplatser!
##### ./jopply --keyword=CAD --lanid=1 --web

#### Visa annonsid och webbplats eller e-postadress för jobbannonser i Stockholms län som innehåller CAD och som är sökbara via webbplatser eller e-post!
##### ./jopply -k=CAD -l=1 -w -e

#### Visa annons med annons-ID!
##### ./jopply --annonsid=2621881