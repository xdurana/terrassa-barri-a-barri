library(readr)
library(dplyr)
library(tidyr)

municipals <- read_csv('data/municipals_per_barris.csv')
participacio <- read_csv('data/municipals_per_participacio.csv')

getElection <- function(year) {

    participacio.barris <- participacio %>%
        filter(
            ANY_VOTACIO == year
        ) %>%
        select(
            DISTRICTE,
            CODI_BARRI,
            NOM_BARRI,
            NUM_ELECTORS,
            NUM_VOTANTS,
            VOTS_BLANCS,
            VOTS_NULS,
            VOTS_CANDIDATURES
        )
    
    municipals %>%
        filter(
            ANY_VOTACIO == year
        ) %>%
        select(
            DISTRICTE,
            CODI_BARRI,
            NOM_BARRI,
            PARTIT,
            VOTS
        ) %>%
        left_join(
            participacio.barris
        ) %>%
        mutate(
            VOTS = VOTS*100/NUM_VOTANTS
        )
}
