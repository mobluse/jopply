#Synpunkter på http://api.arbetsformedlingen.se/
I specifikationen står det webbadress, men i verkligheten är det
webbplats -- i varje fall i sektionen ansokan. Jag tycker ni i detta
fall borde ändra specifikationen till det som det är i verkligheten.

Det verkar som om data ni skickar oftast är i cp1252 (d.v.s. den
kodning som används av äldre versioner av Windows), men ibland är det
utf8. Här är exempel på en annons med fält i utf8: 6319553. Här är
en annons i cp1252: 6316405. Det borde alltid vara samma kodning på
alla annonser. Så länge man bara har annonser på engelska och svenska
så duger cp1252, men om man även ska ha annonser på t.ex. arabiska och
kinesiska så behöver man utf8.

Det borde framgå redan när man hämtar rubrikerna vilket språk annonsen
är på. Egentligen hade det varit bäst om man kunde filtrera annonserna
på språk.

När man skickar data till er så skall det vara URL-kodad utf8, men
detta verkar inte framgå av specifikationen.