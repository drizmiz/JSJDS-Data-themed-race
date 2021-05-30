# Created by: drizzle
# Created on: 2021/5/30

library(tidyverse)

source("sc_prepare.R")

# Time periods

T0 <- 2003
Tobor <- 2013
Tpre <- Tobor - 1
Tend <- 2019

T0go <- Tobor - T0    # 10
T01go <- Tend - T0 + 1  # 17
T1go <- T01go - T0go  # 7

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
