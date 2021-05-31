# Created by: drizzle
# Created on: 2021/5/30

library(tidyverse)

# Time periods

T0 <- 2003
Tact <- 2013
Tpre <- Tact - 1
Tend <- 2019

Tact_from_0 <- Tact - T0    # 10
T01go <- Tend - T0 + 1  # 17
T1go <- T01go - Tact_from_0  # 7

time <- seq(T0, Tend, 1)

# Parameters

q_norm <- 1 # L_1 norm
perm <- 200

# Data

fdi_data <- read_csv("../data/investment/FDI_for_sc.csv") %>% as.data.frame()
IMR_data <- read_csv("../data/world_health/tidy/iMR_for_sc.csv") %>% as.data.frame()
fdi_str <- "Log FDI from China"
IMR_str <- "Log Infant Mortality Rate"

# 更改此处以改变数据源
data <- IMR_data
legend_str <- IMR_str
directory <- "../results/results_IMR/"

country_list <- read_lines("../data/obor_list.txt")

country_list <- country_list[
  country_list %in% names(data) %>% which()
]


### Using lazy evaluation to replicate a func along country list
repli <- function(fun) {
  ex <- substitute(fun)

  for (i in seq_along(country_list)) {
    # Column i: trials (one-belt-one-road); other columns: controls
    country_name <<- country_list[i]
    idx <- country_name %>% match(names(data))

    Y1go <<- as.matrix(data[, idx])
    Y0go <<- as.matrix(data[, (seq_along(data))[-idx]])

    eval(ex, envir = globalenv())
  }
}
