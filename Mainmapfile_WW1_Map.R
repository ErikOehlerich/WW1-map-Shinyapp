
library(dplyr, warn.conflicts = FALSE)
library(htmltools)
library(htmlwidgets)
library(ggplot2)
library(leaflet)
library(leaflet.extras)
library(leaflet)
library(revgeo)
library(rlist)
library(readxl)
library(revgeo)
library(shiny)
library(shinydashboard)
library(readr)
library(tidygeocoder)


# Please note that im using the read_delim("") to read the csv.
# It is very important that you use this, if not and you use a regular csv you 
# will corrupt the data because the program cant handle special caracters from 
# German and Danish.

DD <- read_delim("Rstudio_files/data_file_5_post_fix_of_cause_of_death_csv.csv", 
                 delim = ";", escape_double = FALSE, trim_ws = TRUE)


view(DD)

#read file

#lets me see the names of the colums
colnames(DD)

#checking the class
class(DD)

#i need this for the geocoding, because here i pull out the places
#PD means place of death

PD <- DD$Place_of_death

PD

# I used the geocode function to get the longitude and latitude it take,
# roughly it will take around 48 minutes to run this command, so get some coffee

#using some magic from my github saviour Jessecambon
#some_addresses <- tibble::tibble(PD)

# Also i had to deactivate this line, after i got the cords 
# because i dont want to start it by mistake it takes around 45 minuts.

#lat_long <- some_addresses%>%
#geocode(PD, method = 'osm', lat = latitude , long = longitude)


#after getting the cords, save them in the data in the folder you work in 
# so you can get it again

# Here i combine my main file with the latitude and longitude 
# and assign it the value soldier
soldiers <- cbind(DD,lat_long)

#here i check what i just made
head(soldiers)

# My mainmap code:
# im creating a function for my app
# i took all the code for mainmap 5 and put it into a function 
# because i need it for getting the server to work. 
createMyLeaflet <- function (soldiers) {
  mainmap5 <-leaflet(lat_long) %>% 
    addTiles() %>% 
    addCircleMarkers(lng = soldiers$longitude, 
                     lat = soldiers$latitude,
                     popup = paste(
                       "<strong>Name: </strong>",soldiers$Name_of_deceased,
                       "<br><strong>Last Name: </strong>",soldiers$Last_name_of_deceased,
                       "<br><strong>Location: </strong>",soldiers$Place_of_death,
                       "<br><strong>Age of death: </strong>",soldiers$Age_of_death,
                       "<br><strong>Date : </strong>",soldiers$Date_of_death,
                       "<br><strong>Cause of death : </strong>",soldiers$Cause_of_death,
                       "<br><strong>Rank: </strong>",soldiers$Military_rang,
                       "<br><strong>Place of birth: </strong>",soldiers$Place_of_origen,
                       "<br><strong>Typers comment: </strong>",soldiers$typers_coments),
                     color = "red",
                     weight = 10,
                     radius = 8,
                     clusterOptions = markerClusterOptions( spiderfyOnMaxZoom = TRUE)
    ) %>%
    addMeasure(
      position = "bottomleft",
      primaryLengthUnit = "meters",
      primaryAreaUnit = "sqmeters",
      activeColor = "#3D535D",
      completedColor = "#7D4479") %>% 
    htmlwidgets::onRender("
                        function(el, x) {
                        var myMap = this;
                        myMap.on('baselayerchange',
                        function (e) {
                        myMap.minimap.changeLayer(L.tileLayer.provider(e.name));
                        })
                        }") %>% 
    addProviderTiles("Esri.WorldPhysical", group = "Physical") %>% 
    addProviderTiles("Esri.WorldImagery", group = "Aerial") %>% 
    addProviderTiles("MtbMap", group = "Geo") %>% 
    addProviderTiles("OpenRailwayMap", group = "Railway") %>% 
    addLayersControl(
      baseGroups = c("CartoDB.DarkMatter","Aerial", "Physical","Geo", "Railway"),
      options = layersControlOptions(collapsed = T)) %>%
    setView(lng = 7.6393248, lat = 50.7551004, zoom = 5) %>%
    leaflet.extras::addSearchOSM(options = searchOptions(collapsed = TRUE, minLength = 2)) %>%
    addFullscreenControl()
}


# From here starts the shiny app
# This part is the UI or user interface,
# its the part the user interact with. It get complicated quickly here im not
# fully done here yet, i still need to make the sidebar interactive and put the
# map into one of the sidebar tabs.


#here i make some shortcuts, for my tabitems im not 100% sure yet of how to make this work but im trying diffrent things from here.

tt <- "Det her projekt startede i vinteren 2021 da jeg skulle finde et projekt at arbejde på til mit fag som hed Digitale Metoder oppe på Uni. Da jeg blev færdig i januar 2022 havde jeg skabt et basic kort, som der havde mange mangler ved, men som dog var et ”proof of concept” der illustrerede min ide. 
Kortet havde dengang ikke nogen muligheder for at filtrere og det kunne heller ikke finde ud af at vise Æ-Ø-Å samt de tyske bogstaver som fx Ü og Ö. 	
Derfor blev dele af teksten ødelagt og jeg var tvunget til at bruge Regex til at manuelt erstatte alle de bogstaver som der udgjorde et problem. Det går imod mine principper som historiker, da jeg ikke kan lide at skulle pille ved brødteksten, men jeg var tvunget til at rense den sådan, at Å blev til Aa osv.
Nu har jeg taget projektet op igen her i min påskeferie, hvor jeg har løst problemet med de særlige karakterer sådan, at jeg nu kan få programmet til at læse Æ-Ø-Å. Det vil sige, at jeg ikke ændrer i teksten og bare får programmet til at læse min csv fil med de rå data, som ikke er blevet renset.
Det står også klart og tydeligt på hjemmesiden Denstorekrig.dk, at de ikke har tjekket deres tekst for fejl hvilket udgør et muligt problem. Dog har jeg i forbindelse med mine filtre været nødt til at systematisere og rense dataene i kategorien ”Cause of death” det kommer jeg mere ind på senere.
Jeg har videre udviklet kortet til en Shinyapp sådan at jeg vil kunne få programmet op og køre på en server og dermed sende et link ud til folk som skulle virke uden problemer.	
Selve programmet er ment som et redskab, som folk kan bruge til at undersøge nærmere hvor de danske soldater i tysk tjeneste faldt. Kortet skulle være bruger venligt sådan at både skoleelever, historieinteresserede, pensionister og andre kan få glæde af kortet. Jeg håber, at mit projekt kan inspirere andre og hjælpe dem med deres egne projekter, da min kode er opensource så længe man husker at kreditere mig som jeg har beskrevet inden på min GitHub.
Mvh. Erik Luis Lanuza Oehlerich"    	

ll <- "Beskrivelser af udfordringer:	
Jeg har før beskrevet nogle af de udfordringer som der har været i forbindelse med kortet i den del med Projektet, men det var problemer som der var i fortiden og som jeg har formået at klare.
Den her del vil snakke om mine problemer som jeg har med programmet på nuværende tidspunkt.
Geokodningen:
Geokoding er at kunne tage et navn på et sted og placere det på et kort med koordinaterne, når man skal til at geokode så er udfordringen, at det er som en sort box. Man har dataene med stednavne og kan smide det ind i boxen, ud får man en masse længde og breddegrader, men jeg kan ikke følge med i hvordan programmet geokoder fordi jeg bruger en tilføjelse i RStudio. Yderligere bruger jeg ikke google maps API til geokodningen men OPS = Openstreetmap som er en gratis og tilgængelig kort leverandør til opensource projekter men deres kort og software er ikke 100% lige så god som Googles hvilket resultere i at der er steder som ikke bliver geokodet eller som får den forkerte lokalitet.
Det er hvad jeg kalder den indre og ydre udfordring, den indre er alle de steder som allerede er geokodet, men som er blevet placeret forkert og den ydre er de steder som programmet ikke kan finde ud af at placere.  Dette er to problemer som jeg har tænkt mig at løse men som kommer til at tage lang tid og jeg tror jeg nok vil starte med at løse den ydre udfordring og få dem placeret inde på kortet, hvorefter jeg vil gå i gang med at rense kortet for steder som er blevet placeret forkert. En tommelfingerregel er, hvis det er uden for Europa, så skal man være ekstra forsigtigt med stederne. 
Når man kører mit program i R så vil man se at programmet ignorer ca. 2400 personer, det er naturligt  og det skyldes flere faktorer fx er der nogen som slet ikke har et dødssted noteret, der er i alt 6665 personer i dataene men ca. 840 af dem har ikke nogen lokalitet så der er ca. 1600 personer af de 2400 som der skal tilføjes til kortet. Da jeg kiggede på de 1600 personer i Openrefine kunne jeg se at der var ca. 1200 steder til de 1600 personer. Så af en liste på 2400 jeg mangler så har jeg reelt omkring de 1200 som jeg skal ind og rette på. Det er stadigt et kedeligt og monotont arbejde som nok reelt kommer til at tage ca. 20 + timer inden jeg bliver færdig hvilket også er grunden til at jeg har udskudt det så længe fordi jeg heller ville arbejde på koden og scriptet til mit program.  	
Skabe en WW1 baggrund til mit kort: 
Jeg har længe ville have en baggrund til kortet som havde grænser som i 1914, men det har været en jagt uden gevinst, der er ikke nogen kort tilgængelige på nuværende tidspunkt. Jeg kender til et enkelt projekt, et som også er i Shiny som forsøger at opnå noget lignede og det heder Operation 44, men det er for WW2. Generelt er det her en niche, som der ikke er særligt mange som der arbejder på og det er også derfor der ikke er nogen nuværende kort med WW1 & WW2 som er interaktive med koordinater hvor i man kan plotte på dem.  	
Det er dog et punkt som jeg har fokus på og som jeg prøver at se om jeg ikke selv kan lave, men det er et projekt som bliver svært, jeg har allerede kigget på forskellige kort programmer som fx QGIS og ArcGis men det er programmer som jeg føler har en høj indlæringskurve og er rimeligt avanceret selv for en som mig der har kodet et lille program som det her. Jeg får ikke tid til at kigge på programmerne før sommerferien da det er noget som kommer til at tage lang tid."

BB <- "Hvordan jeg behandlede dataene:
Som jeg tidligere har beskrevet, så kan jeg ikke lide at pille ved dataene, men når det kommer til filterne så har jeg set mig selv nødsaget til at gå ind og rense sådan at jeg kunne lave en liste over dødsårsager. 
Til det projekt brugte jeg et program ved navn Openrefine, som gør at hvis der er flere der har den samme kategori, så kan jeg samle dem og navngive dem til noget tredje. Takket været det som kaldes text facets i programmet.
Fx ”Selv mord”, ”Selvmord”, ”Selv-mord” = bliver så bare til Selvmord, jeg gjorde lidt det samme ved alderen ved de døde, der tog jeg de blanke celler og gav dem beskrivelse NA fordi det betyder not available.	
Men derudover har jeg ikke rørt dataene siden jeg fandt ud at hvordan jeg fik programmet til at læse Æ, Ø, Å.
Jeg kommer dog nok til at ændre i dataene når det gælder stederne hvor de døde sådan at jeg kan få programmet til at læse det ordentligt."

CC <- "Overvejelser og Konklusion
Det er er bare mine egne overvejelser i forhold til projektet, hvis det er jeg får løst mine problemer med geokodningen så ville det her næsten være færdigt og hvis jeg så får lavet en kort pakke som indeholder et kort med grænser fra første verdenskrig så ville jeg nok kunne sige jeg har opnået alle mine mål med det her projekt. Selve projektet har været ambitiøs især fordi da jeg startede sidste vinter havde jeg aldrig kodet før, men gennem stædighed og vedholdenhed fik jeg løst de forskellige udfordringer som dukkede op undervejs en efter en. 	
Projektet har været utroligt lærerigt og til tider frustrerende (det værste er ikke at kunne få noget til fungere i fire dage og finde ud af at et ord i koden skulle starte med stort hvorefter alt virkede, true story), men jeg har fået utroligt meget ud af det her projekt.	
Til sidst vil jeg gerne konkludere, at kortet er et lille værktøj som stadig mangler at blive finpudset, men når det er blevet fixet, håber jeg at det bliver et værktøj til folk der interesserer sig for emnet. "


ui <- fluidPage(
  titlePanel("Danskere i tysk tjeneste under WW1"),
  dashboardPage(
    dashboardHeader(title = "1.Verdenskrig - Kort"),
    dashboardSidebar(
      sidebarMenu(
        id="tabs",
        menuItem("WW1 Kort", tabName = "map1"),
        menuItem("Projektet", tabName = "Projektet"),
        menuItem("Beskrivelse af udfordringer", tabName = "Beskrivelseafudfordringer"),
        menuItem("Hvordan jeg behandlede dataen", tabName = "Hvordan_jeg_behandlede_dataen"),
        menuItem("Overvejelser og Konklusion", tabName = "Overvejelser_og_Konklusion"),
        menuItem("Link til original data", tabName = "Link_til_original_data"),
        menuItem("Kontakt info", tabName = "Kontakt_info")
      )),
    dashboardBody(
      tabItems(
        tabItem("Beskrivelseafudfordringer", div(p("Beskrivelse af udfordringerne"),
                                                 fluidRow(box(ll),
                                                     column(width = 12)))),
        tabItem("Hvordan_jeg_behandlede_dataen", div(p("Hvordan jeg behandlede dataene"),
                                                     fluidRow(box(BB),
                                                              column(width = 12)))),
        tabItem("Overvejelser_og_Konklusion", div(p("Mine overvejelser og min konklusion"),
                                                  fluidRow(box(CC),
                                                           column(width = 12)))),
        tabItem("Link_til_original_data", div(p("https://denstorekrig1914-1918.dk/faldne-lister/liste-over-faldne-1914-1918/"))),
        tabItem("Kontakt_info", div(p("Email: eriklanuza@hotmail.com og link til min GitHub: https://github.com/ErikOehlerich/WW1-map-Shinyapp"))),
        tabItem("Projektet", div(p("Hvad projektet går ud på"),
                                 fluidRow(box(tt),
                                          column(width = 12)))),
        tabItem("map1", leafletOutput("mainmap5"),
                fluidRow(
                  box(
                    column(width = 12),
                    checkboxGroupInput("box1", h3("Cause of death"),
                                       choices = list("Faldet" = "Faldet",
                                                      "Kvæstelser" = "Kvæstelser",
                                                      "ikke kendt" = "ikke kendt",
                                                      "Savnet" = "Savnet",
                                                      "Sygdom" = "Sygdom",
                                                      "Forlist" = "Forlist",
                                                      "Verschüttet" = "Verschüttet",
                                                      "Ulykke" = "Ulykke",
                                                      "Druknet" = "Druknet",
                                                      "Gasforgiftning" = "Gasforgiftning",
                                                      "Selvmord" = "Selvmord",
                                                      "Fejlagtigt meldt død i DBR" = "Fejlagtigt meldt død i DBR",
                                                      "Fundet død" = "Fundet død",
                                                      "Flystyrt" = "Flystyrt",
                                                      "Blodforgiftning" = "Blodforgiftning",
                                                      "Eksplosion" = "Eksplosion",
                                                      "Fliegerbombe" = "Fliegerbombe",
                                                      "Flyverangreb" = "Flyverangreb",
                                                      "Flyveulykke" = "Flyveulykke",
                                                      "Gewehrschuss" = "Gewehrschuss",
                                                      "Herzschlag" = "Herzschlag",
                                                      "Krigsfange" = "Krigsfange",
                                                      "Lungebetændelse" = "Lungebetændelse",
                                                      "Minedetonation" = "Minedetonation",
                                                      "Mine-explosion" = "Mine-explosion",
                                                      "Nedstyrtning" = "Nedstyrtning",
                                                      "Savnet, erklæret død" = "Savnet, erklæret død",
                                                      "Savnet, men lever 1922 i Tyskland" = "Savnet, men lever 1922 i Tyskland",
                                                      "Skudt" = "Skudt",
                                                      "Såret, savnet" = "Såret, savnet",
                                                      "Togulykke" = "Togulykke",
                                                      "Tuberkulose" = "Tuberkulose",
                                                      "Ukendt" = "Ukendt",
                                                      "Ulykke, druknet" = "Ulykke, druknet",
                                                      "Verschüttet, Sygdom" = "Verschüttet, Sygdom"
                                       ))),
                  fluidRow(
                    box(
                      column(12,
                             checkboxGroupInput("box2", h3("Age of death"),
                                                choices = list("16" = "16",
                                                               "17" = "17",
                                                               "18" = "18",
                                                               "19" = "19",
                                                               "20" = "20",
                                                               "21" = "21",
                                                               "22" = "22",
                                                               "23" = "23",
                                                               "24" = "24",
                                                               "25" = "25",
                                                               "26" = "26",
                                                               "27" = "27",
                                                               "28" = "28",
                                                               "29" = "29",
                                                               "30" = "30",
                                                               "31" = "31",
                                                               "32" = "32",
                                                               "33" = "33",
                                                               "34" = "34",
                                                               "35" = "35",
                                                               "36" = "36",
                                                               "37" = "37",
                                                               "38" = "38",
                                                               "39" = "39",
                                                               "40" = "40",
                                                               "41" = "41",
                                                               "42" = "42",
                                                               "43" = "43",
                                                               "44" = "44",
                                                               "45" = "45",
                                                               "46" = "46",
                                                               "47" = "47",
                                                               "48" = "48",
                                                               "49" = "49",
                                                               "50" = "50",
                                                               "51" = "51",
                                                               "52" = "52",
                                                               "53" = "53",
                                                               "54" = "54",
                                                               "55" = "55",
                                                               "56" = "56",
                                                               "57" = "57",
                                                               "58" = "58",
                                                               "59" = "59",
                                                               "60" = "60",
                                                               "61" = "61",
                                                               "62" = "62",
                                                               "63" = "63",
                                                               "64" = "64",
                                                               "65" = "65",
                                                               "66" = "66",
                                                               "67" = "67",
                                                               "68" = "68",
                                                               "NA" = "Na")))),
                    leafletOutput("box1")
                  )))))
  )
)


# Server part, this is where i made the filters able to react to each other 
# on the map. Just run the server and ignore the lines i # out of function.
# I tried to use the mainmap 5 as a function so i could get the diffrent 
# categories for my filters but i failed for now, so i have to use this method.
# It is not a good piece of code but it works for now. 

server <- function(input, output, session) {
  map_data_react <- reactive({
    if (is.null(input$box1)) {
      soldiers
    }
    else {
      soldiers %>% dplyr::filter(Cause_of_death %in% input$box1)
    }
  })
  map_data_react1 <- reactive({
    if (is.null(input$box2)) {
      map_data_react()
    }
    else {
      map_data_react() %>% dplyr::filter(Age_of_death %in% input$box2)
    }
  })
  
  #print(isolate(map_data_react()))
  
  output$mainmap5 <-renderLeaflet({createMyLeaflet(map_data_react1())})
}





# Starting the server up
shinyApp(ui, server)

# here i extract the lat and long to an excel 
# so i can work in openrefine with them

#export(lat_long, "Test_lat_long_main_1.xlsx")

#here i make it to a html file you can open in the browser
#save_html(mainmap5,"worldwar1.html") 
