# Jopply
Jopply (a portmanteau of job and apply) helps applying for jobs.
This is a very early release and everything will change. The rest of
the text is in Swedish, because right now it only works for a Swedish
web service. The command-line arguments are also in Swedish and are the
same as in the specification from Arbetsförmedlingen, but English
arguments will be added in the future.

## Exempel:
#### Visar den inbyggda hjälpen:
###./jopply.pl --help

#### Visar alla län med läns-ID:
###./jopply.pl --lanid

#### Visar annonsid för jobbannonser i Stockholms län som innehåller CAD och 3D:
###./jopply.pl --n=CAD,3D --l=1

#### Visar annonsid och e-postadress för jobbannonser i Stockholms län som innehåller CAD och som är sökbara via e-post:
###./jopply.pl --nyckelord=CAD --lanid=1 --epost

#### Visar annons med annonsid:
###./jopply.pl --annonsid=2621881