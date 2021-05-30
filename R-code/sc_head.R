# Created by: drizzle
# Created on: 2021/5/30

library(tidyverse)

# Time periods

T0 <- 2003
Tobor <- 2013
Tend <- 2019

T0go <- Tobor - T0
T01go <- Tend - T0 + 1
T1go <- T01go - T0go

time <- seq(T0, Tend, 1)

### Data

fdi_data <- read_csv("../data/investment/FDI_for_sc.csv") %>% as.data.frame()
country_list <- read_lines("../data/obor_list.txt")

country_list <- country_list[
  country_list %in% names(fdi_data) %>% which()
]

### Using lazy evaluation to replicate a func along country list
repli <- function(fun) {
  ex <- substitute(fun)

  for (i in seq_along(country_list)) {
    # Column i: trials (one-belt-one-road); other columns: controls
    country_name <<- country_list[i]
    idx <- country_name %>% match(names(fdi_data))

    Y1go <<- as.matrix(fdi_data[, idx])
    Y0go <<- as.matrix(fdi_data[, (seq_along(fdi_data))[-idx]])

    eval(ex, envir = globalenv())
  }
}
