
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
        tabItem("Beskrivelseafudfordringer", div(p("Beskrivelse af udfordringerne"))),
        tabItem("Hvordan_jeg_behandlede_dataen", div(p("Hvordan jeg behandlede dataen"))),
        tabItem("Overvejelser_og_Konklusion", div(p("Mine overvejelser og min konklusion"))),
        tabItem("Link_til_original_data", div(p("https://denstorekrig1914-1918.dk/faldne-lister/liste-over-faldne-1914-1918/"))),
        tabItem("Kontakt_info", div(p("Email = eriklanuza@hotmail.com og link til min GitHub = https://github.com/ErikOehlerich/WW1-map-Shinyapp"))),
        tabItem("Projektet", div(p("Hvad projektet går ud på"))),
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
