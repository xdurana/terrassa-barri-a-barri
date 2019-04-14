library(shiny)
library(leaflet)
library(rgdal)
library(dplyr)

source('municipals.R')

pal <- scales::seq_gradient_pal(low = "#132B43", high = "#56B1F7", space = "Lab")(seq(0, 1, length.out = 12))
terrassa <- rgdal::readOGR("json/terrassa.geojson")
dades <- terrassa@data

shinyServer(function(input, output) {

    mymap <- reactive({
        terrassa@data <- dades %>%
            mutate(
                CODI_BARRI = as.integer(barri)
            ) %>%
            left_join(
                getElection(input$year)
            ) %>%
            filter(
                PARTIT == input$party
            )
        terrassa
    })
    
    output$map <- renderLeaflet({
        terrassa <- mymap()
        leaflet(terrassa) %>%
            setView(1.9940344, 41.560104, 12) %>%
            addTiles()
    })
    
    observe({
        leafletProxy("map", data = mymap()) %>%
            clearShapes() %>%
            addPolygons(
                color = "#000",
                weight = 1,
                opacity = 0.5,
                fillColor = ~colorNumeric(pal, VOTS)(VOTS),
                fillOpacity = 0.6
            )
    })    
})
