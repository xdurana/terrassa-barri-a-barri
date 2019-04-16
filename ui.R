library(shiny)

navbarPage(
    "Terrassa barri a barri",
    id="nav",
    tabPanel(
        "Eleccions municipals",
        div(
            class="outer",
            tags$head(
                includeCSS("styles.css")
            ),
            h2("Eleccions municipals"),
            leafletOutput("map", width="100%", height="100%"),
            absolutePanel(
                id = "controls", class = "panel panel-default", fixed = TRUE,
                draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                width = 330, height = "auto",
                selectInput("year", "Any:", unique(municipals$ANY_VOTACIO)),
                selectInput("party", "Any:", unique(getElection(2007)$PARTIT))
            )
        )
    )
)