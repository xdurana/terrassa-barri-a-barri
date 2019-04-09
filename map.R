library(shiny)
library(leaflet)
library(rgdal)
library(dplyr)

source('municipals.R')

terrassa <- rgdal::readOGR("json/terrassa.geojson")

terrassa@data <- terrassa@data %>%
    mutate(
        CODI_BARRI = as.integer(barri)
    ) %>%
    left_join(
        getElection(2015)
    )

field <- as.name('CUP - CAV - PA')

pal <- scales::seq_gradient_pal(low = "#132B43", high = "#56B1F7", space = "Lab")(seq(0, 1, length.out = 12))
leaflet(terrassa) %>%
    addTiles() %>%
    addPolygons(
        color = "#000",
        weight = 1,
        opacity = 0.5,
        fillColor = ~colorNumeric(pal, `CUP - CAV - PA`)(`CUP - CAV - PA`),
        fillOpacity = 0.6, 
        popup = with(terrassa@data, htmltools::htmlEscape(sprintf("%s: %0.2f", `NOM_BARRI`, `CUP - CAV - PA`)))
    )
