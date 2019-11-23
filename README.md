# Jopply
Jopply (a portmanteau of job and apply) helps applying for jobs.
This is a very early release and everything will change. Its API is 
discontinued, but new, very different exists. The rest of the
text is in Swedish, because right now it only works for a Swedish web
service. There is also very high unemployment and lack of food in
Sweden.

[sv] Jopply hjälper dig att söka jobb. Detta är en mycket tidig version
och allt kommer att ändras. Det finns tre olika varianter i hopp om att
någon skall fungera. De skiljer sig med avseende på hur
nätverkskommunikationen sker.

### Hur man installerar och kör i Windows med [Git Bash](https://git-scm.com/downloads "Git Downloads")
Perl och Curl ingår i Git Bash, men du måste installera vissa Perl-moduler
(Pod::Usage, URI::Escape och JSON), men det finns ett installationsprogram
som gör detta automatiskt. Starta Git Bash och ge dessa kommandon:
#### `git clone https://github.com/mobluse/jopply`
#### `cd jopply`
Du behöver oftast bara skriva de första tecknen i ett kommando sedan
kan du trycka på Tab och då fyller datorn i resten.
#### `./install-in-git-bash.sh`
#### `./jopply.sh`
Testat i Git Bash för Windows på x86-32. Denna teknik fungerar nog även
med Git för Mac OS X, ty det har Curl, men där kan man även installera
modulerna med CPAN. Det finns handledningar om hur man använder CPAN i
Mac OS X. Denna teknik fungerar även på One.com via SSH, men då måste
man skriva `sh install-in-git-bash.sh` och `sh jopply.sh`. De övriga
varianterna av Jopply fungerar inte i Git Bash för Windows.

### Hur man installerar i Linux (t.ex. [Ubuntu](http://ubuntu-se.org/drupal/download "Ladda ner Ubuntu"), [Debian](https://www.debian.org/index.sv.html "Debian"), [Raspbian](https://www.raspberrypi.org/downloads/ "Raspbian Downloads")):
Hämta ner zip-filen och packa upp om du inte har Git. Byt katalog till
där Jopply packades upp eller hämtades ner.
#### `sudo apt-get update && sudo apt-get install libterm-encoding-perl libany-uri-escape-perl libjson-perl`
#### `./jopply.sh`
Alternativt,
#### `sudo apt-get update && sudo apt-get install libterm-encoding-perl libany-uri-escape-perl libjson-perl libwww-curl-perl`
#### `./jopply-curl.pl`
Alternativt,
#### `sudo apt-get update && sudo apt-get install libterm-encoding-perl libany-uri-escape-perl libjson-perl libfurl-perl`
#### `./jopply-furl.pl`
Testat i Raspbian på Raspberry Pi och Ubuntu på x86-32.

### Hur man installerar och kör i Windows med [ActivePerl]( http://www.activestate.com/activeperl/downloads "ActivePerl Downloads"):
Hämta ner zip-filen och packa upp om du inte har Git. Starta
Kommandotolken och byt katalog till där Jopply packades upp eller
hämtades ner. Möjligen behöver du först köra enbart `ppm` om du aldrig
kört detta tidigare för att den skall synka.
#### `ppm install Furl`
#### `perl jopply-furl.pl`
Alternativt,
#### `ppm install WWW-Curl --force`
Jag behövde använda --force p.g.a. att jag har flera repositorier, men
det behöver kanske inte du.
#### `perl jopply-curl.pl`
Alternativt (förutsatt att du har curl i PATH),
#### `jopply.bat`
Testat i Windows Vista Kommandotolken/MS-DOS-prompt på x86-32 och
fungerar med teckenkodningen cp850 (vilket är standardvärdet). Dock har
Kommandotolken nackdelen att man inte kan rulla tillbaka och se långa
utskrifter. Det kan dock lösas genom att lägga till ` | more` efter
kommandot. Då trycker man på mellanslag för att se nästa sida. Detta
fungerar även i Linux.

Har man hämtat ner Jopply med Git, är det väldigt lätt att uppdatera
till senaste versionen, ty man ger bara kommandot `./update.sh` eller
`sh update.sh` i katalogen jopply.

Jopply sparar alla hämtade annonser i katalogen ad och läser i första
hand annonser därifrån innan den vid behov hämtar från nätet. Mappen ad
kan behöva rensas ibland.

[en] The command-line arguments are also in
Swedish and are the same as in the specification from
Arbetsförmedlingen (Swedish government organisation).

[sv] Kommandoradsargumenten är samma som i specifikationen från
Arbetsförmedlingen.

## Exempel
för Linux där valfri jopply-X.pl länkats till jopply eller att man har
ett shellskript som startar jopply. I Windows kan man göra en bat-fil
som anropar valfri jopply-X.pl. Det följer med exempel på jopply.sh
(Ash-skript) och jopply.bat som startar jopply-sys.pl. Alla
växlar kan förkortas, men de måste vara unika.
#### Visa den inbyggda hjälpen!
##### `./jopply.sh --help`

#### Visa alla län med läns-ID!
##### `./jopply.sh --lanid`

#### Visa alla kommuner med kommun-ID i Skåne!
##### `./jopply.sh --lanid=12 --kommunid`

#### Visa annonsid och rubrik för alla jobbannonser i Stockholms län som innehåller CAD och 3D!
##### `./jopply.sh --nyckelord=CAD,3D --lanid=1 --verbose`

#### Visa annons-ID och e-postadress för jobbannonser i Stockholms län som innehåller CAD och som är sökbara via e-post!
##### `./jopply.sh --nyckelord=CAD --lanid=1 --epost`

#### Visa annonsid och webbplats för jobbannonser i Stockholms län som innehåller CAD och som är markerade som sökbara via webbplats!
##### `./jopply.sh --n=CAD --lanid=1 --webb`

#### Visa annonsid och webbplats eller e-postadress för jobbannonser i Stockholms län som innehåller CAD och som är sökbara via webbplatser eller e-post!
##### `./jopply.sh --n CAD --lanid 1 --w --e`

#### Visa annons med annons-ID!
##### `./jopply.sh --annonsid=2621881`
##### `./jopply.sh --ann 2621881`

## Var såg du denna platsannons första gången?/Var har du sett annonsen?
Detta är en vanlig fråga när man söker ett jobb. Svara helst "Annat"
och ge länken till Jopply, ty då svarar du sanningsenligt och
hjälper Jopply:
https://github.com/mobluse/jopply
