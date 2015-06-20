# Jopply
Jopply (a portmanteau of job and apply) helps applying for jobs.
This is a very early release and everything will change. The rest of the
text is in Swedish, because right now it only works for a Swedish web
service. There is also very high unemployment in Sweden. Therefore we
don't need more people here and it's better to educate those who already
live here so they can fill these jobs. The only people we need from
abroad to work here are those who create more jobs for those who already
live here. Thus we try to minimize job applications from abroad by only
providing this program in Swedish. There is also a lack of food in
Sweden, since we produce less food than we eat, and that means we are
importing food and this creates starvation in other parts of the world.
One positive thing though is that we produce more electricity than we
consume, due to the snow melting in the mountains.

[sv] Jopply hjälper dig att söka jobb. Detta är en mycket tidig version
och allt kommer att ändras. Det finns tre olika varianter i hopp om att
någon skall fungera. De skiljer sig med avseende på hur
nätverkskommunikationen sker.

### Hur man installerar och kör i Windows med [Git Bash](https://git-scm.com/downloads "Git Downloads")
Perl och Curl ingår i Git Bash, men du måste installera vissa Perl-moduler
(Pod::Usage, URI::Escape och JSON), men det finns ett installationsprogram
som gör detta automatiskt. Starta Git Bash och ge dessa kommandon:
#### git clone https://github.com/mobluse/jopply.git
#### cd jopply
Du behöver oftast bara skriva de första tecknen i ett kommando sedan
kan du trycka på Tab och då fyller datorn i resten.
#### ./install-in-git-bash.sh
#### ./jopply
Testat i Git Bash för Windows på x86-32. De övriga varianterna av
Jopply fungerar inte i Git Bash för Windows.

### Hur man installerar i Linux (t.ex. Ubuntu, Debian, Raspbian):
#### sudo apt-get update && sudo apt-get install libjson-perl
#### ./jopply
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
det behöver kanske inte du.
#### perl jopply-curl.pl
Alternativt (förutsatt att du har curl i PATH),
#### perl jopply-sys.pl
Testat i Windows Vista Command/MS-DOS-prompt på x86-32 och fungerar med
cp850 (vilket är standardvärdet). Dock har Command nackdelen att man
inte kan rulla tillbaka och se långa utskrifter. Det kan dock lösas
genom att lägga till ' | more' efter kommandot. Då trycker man på
mellanslag för att se nästa sida. Detta fungerar även i Linux.

[en] The command-line arguments are also in
Swedish and are the same as in the specification from
Arbetsförmedlingen (Swedish government organisation).

[sv] Kommandoradsargumenten är samma som i specifikationen från
Arbetsförmedlingen.

## Exempel
för Linux där valfri jopply-X.pl länkats till jopply eller att man har
ett shellskript som startar jopply. I Windows kan man göra en bat-fil
som anropar valfri jopply-X.pl.
#### Visa den inbyggda hjälpen!
##### ./jopply --help

#### Visa alla län med läns-ID!
##### ./jopply --lanid

#### Visa annonsid för alla jobbannonser i Stockholms län som innehåller CAD och 3D!
##### ./jopply --n=CAD,3D --l=1 --verbose

#### Visa annons-ID och e-postadress för jobbannonser i Stockholms län som innehåller CAD och som är sökbara via e-post!
##### ./jopply --nyckelord=CAD --lanid=1 --epost

#### Visa annonsid och webbplats för jobbannonser i Stockholms län som innehåller CAD och som är sökbara via webbplatser!
##### ./jopply --nyckelord=CAD --lanid=1 --web

#### Visa annonsid och webbplats eller e-postadress för jobbannonser i Stockholms län som innehåller CAD och som är sökbara via webbplatser eller e-post!
##### ./jopply -n=CAD -l=1 -w -e

#### Visa annons med annons-ID!
##### ./jopply --annonsid=2621881