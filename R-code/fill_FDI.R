# Created by: drizzle
# Created on: 2021/5/30

library(tidyverse)
library(mice)

source("math.R")

fdi <- read_csv(
  file = "../data/investment/FDI_useful.csv",
  col_types = cols(
    年份 = col_double(),
    国家 = col_factor()
  )
) %>% unite(col = 国家, 地区, 国家)

country_name <- fdi[["国家"]] %>% unique()

fdi_na <- fdi %>%
  tidyr::complete(年份, 国家) %>%
  rename(对外直接投资 = `对外直接投资:截至累计`)

fdi_lg <- fdi_na %>%
  mutate(lg = robust_log(对外直接投资), .keep = "unused")

fill_a_country <- function(.dt, .cn) {
  res <- .dt %>%
    filter(国家 == .cn) %>%
    mice(method = "norm.boot", m = 1, maxit = 3) %>%
    complete()
  if (any(is.na(res$lg))) {
    non_na <- !(res$lg %>% is.na())
    res$lg <- res$lg[non_na][1]
  }
  return(res)
}

fdi_filled <- country_name %>% map(~fill_a_country(fdi_lg, .x))

result <- fdi_filled %>%
  reduce(rbind) %>%
  mutate(对外直接投资 = robust_exp(lg), .keep = "unused") %>%
  separate(col = 国家, into = c("地区", "国家"), sep = "_")

result %>% write_csv("../data/investment/FDI_filled.csv")
