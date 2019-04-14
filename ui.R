library(shiny)

navbarPage(
    "Terrassa barri a barri",
    id="nav",
    tabPanel(
        "Mapa interactiu",
        div(
            class="outer",
            tags$head(
                includeCSS("styles.css")
            ),
            
            leafletOutput("map", width="100%", height="100%"),            
            
            absolutePanel(
                id = "controls", class = "panel panel-default", fixed = TRUE,
                draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                width = 330, height = "auto",
                selectInput("party", "Partit:", unique(municipals$PARTIT)),
                selectInput("year", "Any:", unique(municipals$ANY_VOTACIO))
            )
        )
    )
)