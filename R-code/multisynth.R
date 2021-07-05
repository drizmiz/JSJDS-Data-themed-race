# Created by: drizzle
# Created on: 2021/7/4

if (!require(augsynth)) {
  devtools::install_github("ebenmichael/augsynth")
  library(augsynth)
}

library(tidyverse)
library(showtext)

perform_multisynth <- function(file) {
  sc_data <- read_csv(file) %>% as.data.frame()

  country_list <- read_lines("../data/obor_list.txt")

  sc_data <- sc_data %>%
    mutate(OBOR = (国家 %in% country_list) & (年份 >= 2013))

  ppool_syn <- multisynth(
    lg ~ OBOR, unit = 国家, time = 年份, data = sc_data
  )

  ppool_syn %>% summary() -> ppsum
}

showtext_auto()

ppsum <- perform_multisynth(file = "../data/world_health/tidy/iMR_filtered.csv")

pdf("../results/IMR/pooled/pooled_average.pdf")
ppsum %>% plot(levels = "Average")
graphics.off()

ppsum <- perform_multisynth(file = "../data/world_health/tidy/5MR_filtered.csv")

pdf("../results/5MR/pooled/pooled_average.pdf")
ppsum %>% plot(levels = "Average")
graphics.off()
