# Created by: drizzle
# Created on: 2021/7/4

if(!require(augsynth)) {
  devtools::install_github("ebenmichael/augsynth")
  library(augsynth)
}

library(tidyverse)

IMR_sc_data <- read_csv("../data/world_health/tidy/iMR_filtered.csv") %>% as.data.frame()

country_list <- read_lines("../data/obor_list.txt")

IMR_sc_data <- IMR_sc_data %>%
  mutate(OBOR = (国家 %in% country_list) & (年份 >= 2013))

ppool_syn <- multisynth(lg ~ OBOR, unit = 国家, time = 年份, data = IMR_sc_data)

ppool_syn %>% summary() -> ppsum

showtext_auto()

pdf("../results/pooled/pooled.pdf", width = 13.5, height = 24)
ppsum %>% plot()
graphics.off()

pdf("../results/pooled/pooled_average.pdf")
ppsum %>% plot(levels = "Average")
graphics.off()

