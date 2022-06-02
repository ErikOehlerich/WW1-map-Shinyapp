#here i make some shortcuts, for my tabitems im not 100% sure yet of how to make this work but im trying diffrent things from here.



tt <- "Hej! mit navn er Erik Luis Lanuza Oehlerich, jeg er en historie studerende på fjerde semester og det her er mit projekt som jeg har gået og arbejdet på. Projektet startede i vinteren 2021, hvor jeg skulle finde et projekt til mit fag, som hed Digitale Metoder på Århus Universitet. Da jeg blev færdig i januar 2022, havde jeg skabt et basic kort, som der havde mange mangler, men som dog illustrerede min ide. Kortet havde dengang ikke nogen muligheder for at filtrere, og det kunne heller ikke finde ud af at vise Æ-Ø-Å. Nu har jeg taget projektet op igen og jeg har fået løst problemet med de særlige karakterer således, at jeg nu kan få programmet til at læse Æ-Ø-Å. Det vil sige, at jeg ikke ændrer i teksten, programmet læser bare min CSV-fil med de rå data. Dog har jeg i forbindelse med mine filtre været nødt til at systematisere og rense dataene for at kunne lave de to kategorier. Jeg har videreudviklet kortet til en Shinyapp sådan, at programmet er oppe og køre på en server. Dermed kan man sende et link ud til folk, som skulle virke uden problemer. Selve programmet er ment som et redskab, som folk kan bruge til at undersøge, hvor de danske soldater i tysk tjeneste faldt. Jeg håber, at mit projekt kan inspirere andre og hjælpe dem med deres egne projekter, da min kode er opensource, så længe man husker at kreditere mig som jeg har beskrevet inden på min GitHub. Mvh. Erik."

ll <- "I denne del vil jeg snakke om mine problemer, som jeg har med programmet på nuværende tidspunkt. Geokoding er at kunne tage et navn på et sted og placere det på et kort med koordinaterne, når man skal til at geokode, er udfordringen, at det er som en sort box. Man har dataene med stednavne og kan smide det ind i boxen, hvorefter man får en masse længde og breddegrader ud. Men jeg kan ikke følge med i, hvordan programmet geokoder fordi jeg bruger en tilføjelse i RStudio. Yderligere bruger jeg ikke Googlemaps API til geokodningen, men OPS = Openstreetmap, som er en gratis og tilgængelig kort leverandør til opensource projekter, men deres software er ikke 100% lige så god som Googles. Det resulterer i steder, som ikke bliver geokodet eller som får den forkerte lokalitet. Det er hvad jeg kalder den indre og ydre udfordring, den indre er alle de steder som allerede er geokodet, men som er blevet placeret forkert. Den ydre udfordring er de steder, som programmet ikke kan finde ud af at placere. Dette er to problemer som jeg har tænkt mig at løse, men som kommer til at tage lang tid. Jeg har allerede forsøgt at løse den ydre udfordring manuelt og få dem placeret inde på kortet, men det er en langsom og meget besværlig proces. Alle steder udenfor Europa er steder som egentlig skal dobbelttjekkes, så man skal være ekstra forsigtigt med disse steder. Når man kører mit program i R, vil man se, at programmet ignorer 1.536 personer, det er naturligt og det skyldes flere faktorer. Fx er der mange soldater, som slet ikke har et dødssted noteret, der er i alt 6.665 personer i datasættet, men 842 af dem har ikke nogen lokalitet. De resterende 694 steder er steder som jeg allerede har forsøgt at finde med googlemaps, men som jeg ikke kan finde fordi de ikke længere hedder det samme som dengang. 
Et af mine store mål er at skabe en WW1 baggrund til mit kort. Jeg har længe ville have en baggrund til kortet, som havde grænser som i 1914. Der er så det problem, at der ikke mig bekendt er noget kort tilgængelige på nuværende tidspunkt som kan bruges interaktivt. Jeg kender til et enkelt projekt, som også foregår i Shiny, som forsøger at opnå noget lignede. Det heder Operation 44, men det er for WW2. Generelt er det her en niche, som der ikke er særligt mange, der arbejder på. Derfor er der ikke nogen nuværende kort med WW1 grænser, som er interaktive med koordinater. Det er dog et punkt som jeg har fokus på, og som jeg prøver at se om jeg ikke selv kan lave. Det er et projekt, som bliver udfordrende, men ikke umuligt, og jeg har allerede kigget på forskellige kort programmer som fx QGIS og ArcGis til at lave det. Jeg får desværre ikke tid til at kigge på programmerne før sommerferien da det er noget, som kommer til at tage lang tid."

BB <- "Jeg kan ikke lide at ændre ved dataene, men når det kommer til filterne, så har jeg set mig nødsaget til at gå ind og rense sådan, at jeg kunne lave en liste over dødsårsager. Til det projekt brugte jeg et program ved navn Openrefine. Programmet muliggør, at hvis der er flere der har den samme kategori, så kan jeg samle dem og navngive dem til noget tredje. Fx disse tre former for selvmord: 'Selv mord', 'Selvmord', 'Selv-mord' = til Selvmord. Jeg gjorde det samme ved alderen for de døde, hvor jeg ikke kendte alderen, der tog jeg de blanke celler og gav dem beskrivelsen NA fordi det betyder not available. Men derudover har jeg ikke rørt dataene."

CC <- "I forhold til projektet; hvis jeg får løst mine problemer med geokodningen, så vil dette projekt være færdigt. Hvis jeg yderligere får lavet en kort pakke, som indeholder et kort med grænser fra første verdenskrig, så ville jeg nok kunne sige, at jeg har opnået alle mine mål med dette projekt. Selve projektet har været ambitiøst især fordi jeg startede uden at have kodet før. Projektet har været utroligt lærerigt og til tider frustrerende, men jeg har fået utroligt meget ud af dette arbejde.
Jeg håber, at mit kort bliver et værktøj til folk, der interesserer sig for emnet og at mit kort kan demonstrere at man godt kan visualisere og formidle data inden for humaniora og især historie. Mvh. Erik."

PP <-"Værktøjerne er forskellige, der er alt fra forskellige kort, søgefunktionen, måleværktøjet, og to filtre til at vælge alder og dødsårsager. Der er mange forskellige funktioner i mit program man kan bruge, da det er sat op på en brugervenlig måde. Et konkret eksempel på, hvordan man kan bruge værktøjerne, finder man, hvis man kigger på landsbyen Moulin-Sous-Touvent. Her kan man se, at der er 175 danskere, som døde i landsbyen. Hvis man skifter over til satellitmode, kan man se på overfladen og jorden rundt omkring landsbyen, at landskabet stadig bærer ar fra første verdenskrig. Idet satellitbillederne tydeligt viser, hvor skyttegravene er løbet. Med måleværktøjet kan man endda undersøge distancen imellem skyttegravene. Det er værktøjer som man kan bruge til at undersøge og få en idé om, hvad de danske soldater oplevede. Jeg vil lige understrege, at blandt de forskellige korttyper er der et kort, som viser moderne jernbaner ikke de gamle."
  
JJ <- "Jeg har mine data fra hjemmesiden: https://denstorekrig1914-1918.dk/faldne-lister/liste-over-faldne-1914-1918/. Her bruger jeg deres alfabetiske liste fra november 2021. Det arbejde som de har lavet, er meget stort og omfattende. Jeg er dybt taknemmelig for, at der var så godt et datasæt som jeg kunne arbejde med da det har været utroligt lærerigt og spændende."

KK <- "Mit projekt er stadig i et tidligt stadie fordi jeg arbejder alene og når jeg har tid til det, men hvis der er fejl i datasættet eller I finder et sted, som er forkert placeret, så må I meget gerne skrive til mig og sende stederne ind med de rigtige koordinater til mig. Det er noget jeg vil værdsætte meget, hvis folk havde lyst til det. Mvh. Erik. "

#Står for liste over steder
LOS <- "Zwartgart 
Zlotha
Zienrika
Ziennawy 
Ziemiang
Zielony Dworzes 
Zchumowka
Zawewy
Zaszkor, Galizien
ZablockaWolka
Zablatowce
Wytstaete
Wyslawick
Woumess, Flandern
Wojiinica, Wolhynien
Wodola
Withius
Wischnew See
Wilna Kovno
Willesheim, Eifel
Willenborg, Ostpreusssen 
Wilkowischki
Wileitz
Wiclspole
Wevelghun
Westhock
Wenzelhoek, Flandern
Wangerie, Flandern
Walterskehmen
Wald Boneyle-Chateau
Vogensen
Vitzalmont
Visny-Neuville
Villers-Kretonneuse
Villers aux Evalles
Villa Scollaire
Vignenllis
Vesle, Fremette
Verloren- Lock, Flandern
Ved fronten
Vaurain Ferme, Vaudesson
Vatziers
Vandesincourt
Vailly-Colombe
Utratra
UsaimowStary
Ursowice
Urshum, Gouv. Wjatka
Udunburg
Twedt, Legan
Tulicze
Tschokstan
Tribarewo
Trawinka
Towanderie Ferme, Briquinay
Touquieres
Tombois-Fe, Lampierre
Tol Ferne 
Thierncourt
Tereszkowice
Tepavei
Tenthnille
Taragora
Tannapol
Tahure-Sonain
Tahura, ( Champagne )
Saagermünd
Söbjatin
Szuwyaski
Szumlang
Sztrusin
Szista Dombina
Szinnlazy, Galizien
Szanly
Syklo, Galizien
Swislotsch
Svistaw
Suiain
Stryj, Galizien
Stofsweier
Stochard
Stefaniwka Zalesczyki
Stankewitschi
Stallupönen, Ostpreussen
St. LouseTerviev
Srolck, Ostgalizien
SpillekenhofWarnelou
Sommelaus
Somme, Merval
Somme, Manietz Wald
Somme, Barleuz
Slobota-Zlota
Skrawdze
Skomorrchy Nowe, Galizien
Skobelev, Turkestan
Skawaböle
Skavanii
Skatowo
Skangel am Tirul-Sumpf
Sjeljona
SirocowoBeranje
Siedlee
Shamby
Shabin, Narew
Seradowo
Schtscharastellung
Schschara Serwetsck (Sagori)
Schratzmänn le, Elsas Lothringen
Schloß Louzyn
Schloss Chéchery
Schloss Nerft, Kurland
Schljachetsskoje
Schlachtelskoje
Schermizy, Kloster Vouckaus
Schallen, Ostpreussen
Schafraerzy
Satischje
Sarnki, Skrednie
Saminov
Saminov
Samichtna
Saluskje
Salsayville
Sallenmines
Rögewille
Rütsenkowo
Rvaatschew, Gouvermont Mohilew
Russiske front
Russ. Krattingen
Rumancourt
Rulljnki an der Düna
Rue Del ´Abbaye, Marne
Rudka-Tobaly
Roye, St. Aurin, Loucort
Rollegehem – Capelle, Flandern
Roiry
Roikitnow
Rodsjaly
Rocznicki
Rizezyra
Rigazehalben
Rienelle Schlucht
Richscourt
Rezekosy, Galizien
Reutelbach
Renvraignes
Rembische Raschelnojz
Rembische – Raschjelnoje
Releberg
RedultyJozki
Reczyn, Volhynien
Rauwin
Rattervalle, Flandern
Ratitschi
Rastacani
Quennevieres-Fe, Flandern
Kaniste 
Stariski
Benil
Tomaschi
Desby
Prunarn
Prontki, Narotsch
Pracutycze
Porytoje Jablou
Porakity
Ponzoy
Ponjat
Poniewig
Pomoscha
Polpponesvald
Poldes,
Poldehock, Flandern
Polawsky, Kurland
Polawley
Pokropowno, Galizien
Poilly Monligny
Plauvain, Artois
Plauvain
Pittski
Pistrokow
Pilkein
Peynze
Petrikan
Petit Chaffosse
Perthes les Hurles
Perowoloki
Pensy Duze ( Raiciones )
Pemper Slobato Zlata
Pemper Slobato Zlata
Pechand
Passynki
Passenka
Passchendach
Pamientna
Palahiere, Galizien
Ozdobyeze
Overdeward
Overdewaede
Overdecourt
Ossozojetz
Ossowjetz
Ortenil
Orle bei Griechischen Grenze
Oleanaska
Ogonwald
O. U. Chatel
Nurbuzischki
Nowe-Sohna 
Nonillon Pont
Nonart
Noechin
Njokraschi
Njekrasky
Njekanschi
Nivna, Kava, Ravka
Nisch, Grodskow
Nikolskusso Ruski, Sibiri- en
Nieppe Wald, Mervil- le
NavotschSee
Navarin-Stellung
Navajowka
NarotschSee, Blizniki
Narotin Søen
Nangiennes
Nampal
Naipn
Nagükikinda
Nagoschewo
Mulluch
Mt. Fortana Feéca
Morschies
Morouvillers
Moncevn in Neuf
Monasterzeo
Mokuppe, Narotsch- See
MokravaDubrowa
Moivosolna
Moerdyk – Thomont
MockowoHöhen
Mleielochowo
Misercy
Mirhalowschtsohisna
Minzschlucht, Verdun
MilnooSchwejki
Mierzyszczow, Galizien
Michalky
Michalki Lÿmica
Meerandré
MédéahFerme
Maydau-Stau
Matocoidy Skorinski
Masukowa
Mastagni
Marzagra
Maryanow
Maruhes
Marnefloden
Marienhaus, Schwerin
Marenil
Marcuil
Manchault
Mamsty Wald
Malpait
Msciweye
Male Cwaling
Magenville
Madzelowska, Ga- lizien
Madzclowka, Galizien
Lyneroka, Wolhynien
Lutschinow
Ludowa Höhe, Galizien
Luboez
Lublinertrasse
Lostajanse
Lopuezno
Lonicz
Longquern
Logischin
Ljudwigowo
Lipting, Düna
Lespida
Les Vaux Hordelle
Lerlnoe
Legaty, Stygowo
Le Onesnry
Le Cransloy
Lazarowka, Galizien
Lawna, Njemen
Lauvermont
Lasztynita
Lasebewitati (Ryra-Hutra Abschnitt)
Laschwitschi (Pyra-Kostra-Absch- nitt)
Laschwitschi
Laschewitschi ( Pyra- Kotra-Abschnitt )
Lanoweze
Lankanal
Lamotte Ferme, Gury
Laffux
Laffeux
Lacorture, Sainghin
La Waurille Kremont
La Grampe Freme, Vasseny
La Alleceur
Lawella
L. Econvillon
Kuwowo
Kulmiany
Krituly, Ruski
Kremari
Krasnostan
Krasmostow
Kranostow
Kozabka
Korytinin
Kortekeer Cabt
Koroscatyen, Galizien
Konkoje
Konjur
Koninszki
Kompinoer
Kologrino
Kolmar, Posen
Koledrowice
Koeknithoek
Kocknithoek
Kloster Kisch, Mangal
Kloster Kisch
Klienkopf, Metzeal
Klein Pasken
Kiderengwa
Keschitschew
Kattau-Kur- gan Gour, Ufa
Katerynowo
Katarinenhos, Mittau
Kasemat- tenschlucht, Bezonvaux
Kapilar Höhe
Kanatlarei
Kaluzem an der Aa
Kaluzem
Kalukowe
Kalmischki
Kaiserwald, Swirki

Jonaville
Jusowska, Gouverment Jekateri- nowslaw
Jurgeu Polski, Moskva
Junkershorn
Jllust
Jeskow, Galizien
Jermutovzy
Jawidze
Jarvacze
Jaroslan
Jarkan, Kurland
Jantschewo, Kurland
Janmica, Galizien
Jagdhaus der les Marquises Fuce an der Römerstras- se
Irviezna – Nowa
Illuxt, Rubeshina
Illutxt
ikke oplyst
Iastremna
HurtebiseFerme
Hundertbückeln
Hom
Honecaat
Holnou-Wald
Hoislains
Hockberg, Nanroy
Hochberg, West- champagne
Hochberg, Reims
Hnizdyezow
Hindeburgstütz- punkt
Hexensattel, Hochberg
Het Sas, Boesinghoe
Herris an der Lyhs
HerrenthagePark
Hermies Siegfried- front
Hentregiville
Havincurt
Haugard en Santerre
Hardaumout
Handzanie
Hampenhoit
Hameau de champ Sap- pey ( Isere )
Halbgut Ma- rienhof, Leye-Lindenberg
Gut Schlossberg, Illuxt
Gut Schlossberg, ( Osten )
Gut Pacewicze
Gut Migule
Gut David, Livenhof
Gut Baldon, Riga
Gumbinnen, Ost-Preus- sen
Guillemont, Montigny
Guebriant Saint Briene
Gruppe Perthes
Grosskessel
Gredlowki
Grand Manpas
Gozesowo, Masuren
Gouver- nement Ferme
GosliceTarnow
Goroolischtsche
Gongraucourt
Gondecaat
Goiorbelle Ferm
Glombie
Giessler Höhe, Artois
Gheluro, Flandern
Germa- nerhof, Kurland
Gawrilawke
Gawonski
Gamienna
Friedrichstadt, Kurland
Freónes
Fossi I de Drocourt
Forsani
Fosseswald
Fortequenne
Fort Liscum ?USA?
Forsthaus (Le Thou Bricot Mon)
ForeauxWäldchen
Feyen Hage
Fetanus
Ferme Tourvent
Ferme d´ Heamered, Aizy
Ferentardenvis
Fahnie
EsterneyNeuvy 
Ersden
Epily
Epichs
Ekau-Kekkau
Econvillon
Eckan, Kalkan
Daager
Dziki-LanyAbschnitt
Dünen vor Nienpert, Flandern
Dumblischki
Drococat, Donai
Drobin, Tapadly-Na- gorki
Drescourt
Dreifingerwalde, Di- llers aux Erables
Draise
Dragaulöti Tarnava
Dolke
Doager (Sareth), Balkan
Djenin
Disjukirchki
Dienssontal
Demecourt Estrees
Dauria, Translaikali- en
D`Ormului, Karpaterne
Czernabogen
Czerepkontz
Cwuilowa, Dniestr
Cvitowa, Dnjestr
Cvitowa, Dnjestr, Galizien
Culm a. W.
Cuey le Chateau
Cruicani
Cravaneon Ferme
Crapeaumeséril
Contxon (Aisne)
ConcieresEpinoy
Collinolenhock, Flan- dern
Clamangs
Civenshy
Cinslea
Cinrucn
Chioy, Aisne
Cheluve, Flandern
Chaulens
Chasseng
Chartaves, Marne
Chapitre Walde, Ver- dun
Carignau
Cappy, Amiens
Canas-Ferre, Crozat-Kanalen
Campurile
Campenhorst
Cambrai Arres-Grenap- pe-Bairÿ
Caine, Pacherauvill
Baagösund
ByszkowaWola
Bültehock, Flandern
Buzilischki
Bunztyn
Buffiars
Buddern, Doviaten
Buclare
Buchrischki
Buchi, Somme
Brzezany, Galizien
Bryggiel
Brule Schlucht, Fleury
Bres, Pinon
Brenwaizner
Bremwaigness
Bouinnes
Bouilon, Cambrai
Botzar Pass, Galizien
Borzümow Sokolow
Borzümow
Borrieswalde
Borge, Türol
Bordeaux Canolle Weg
Bonvincourt, Somme
Boncry-Notre-Dame
Bonchy
Bomhyd de Renos
Bolsinghe
Bojanowitsch
Boisbrüle
Bois de Glandon ( Agnolles )
Bodzar Pass
Bodza Pass
Bobry-Gruschewschina
Blugnen, Reims
Blisniki am Narotschsee
Birmbaum, Posen
Binkenhof a. d. Düna ( Kurland )
Bihmondt
Bienenhof, Wolhynien
Bielcza, Galizien
Bielawig
Bialgolje
Beuoraignes, Noyon
Beuoraignes
Beuguatze
Beugenux
Berthesam
Berleaux
Bergnase
Berazuni
Benvraignes
Benoraignes
Bellewaerde Ferme, Ypern
Bellenglice, Cambrai
Becela
Beaumonten-Artois
Baursies
Baurenilles
Basleur an der Somme
Barzy, Soissons
Bartosche
Barsy-Gripny-Verneuil
Barlosye
Banloye
BandburgStellung, Flandern
Bamdysie
Baldence
Bakalaschewo
Baillcul
Baclmuter
Azuzele
Ayannes
Aveluz, Albert
Avalaberg
Aubenheul
Aschoop
Aschny
Arelny
Ardon, Chemin des Dames
Ardenil
Archiel le Peti
Aprencourt
Annesnes
Anheim
Andignicourt
Ancre, Puisienx
Ancre, Somme, Aure
Ancienbille
Anbenchelt an Bac
Allyny, Karpaterne
Albenschweiler
Aisonvillers
Aironville, Bauchin- camp
Ainereville
Admina a/ Düna
Abrowenzewo
Yskyb
Vogennes
Sermonty
Sambrow
Pyra, Sztoupin
Prouwelle
Polawki
Passjcki
Mikielewszna
Lysa, Galizien
Langewaade
Krituli
Kamenucha
Jordanoff
Javincourt
Iwory
Irles, Grandcourt- Riegel
Imbres, Middelhavet
Hockleede
Haninel
Goradischtsche
Girbinenta
Garleasca
Friedri-chstadt, Kurland
Foureaux Wald
Espilly-Fe
Draasbank
Doviaten, Ostpreusse
Doaga am Serath
Damjany
Croisetty, Croix
Chirisy
Buddern, Ost-Preussen
Bellevaarde, Ypern
Skudre
Loretto-Höhe
Buddern, Kreis Angerburg
Houthulsterwald, Flandern
HouthoulsterWald, Flandern
AisneChampagne
Sztrupin
Schratzmänn le
Schabin"



