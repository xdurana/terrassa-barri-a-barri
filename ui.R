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
            leafletOutput("map", width="100%", height="100%")
        )
    )
)