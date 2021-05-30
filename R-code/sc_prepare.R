# Created by: drizzle
# Created on: 2021/5/30

library(tidyverse)

# Reformat data

dat <- read_csv("../data/investment/FDI_filled.csv")

dat <- dat %>%
  mutate(lg = log(对外直接投资), .keep = "unused") %>%
  select(-地区) %>%
  pivot_wider(names_from = "国家", values_from = "lg") %>%
  select(-年份)

dat %>% write_csv("../data/investment/FDI_for_sc.csv")
