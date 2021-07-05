# Created by: drizzle
# Created on: 2021/5/30

library(tidyverse)
library(magrittr)

source("math.R")

# Reformat FDI data

dat1 <- read_csv("../data/investment/FDI_filled.csv")

dat1 <- dat1 %>%
  mutate(lg = robust_log(对外直接投资), .keep = "unused") %>%
  select(-地区) %>%
  filter(国家 != "马尔代夫", 国家 != "以色列") %T>%
  write_csv("../data/investment/FDI_filtered.csv") %>%
  pivot_wider(names_from = "国家", values_from = "lg") %>%
  arrange(年份) %>%
  select(-年份)

dat1 %>% write_csv("../data/investment/FDI_for_sc.csv")

# Reformat infant mortality data

dat2 <- read_csv("../data/world_health/tidy/iMR_tidy_zh.csv")

dat2 <- dat2 %>%
  mutate(lg = robust_log(infantMortalityRate), .keep = "unused") %>%
  select(-country) %>%
  filter(国家 %>% is.na() %>% `!`, 年份 >= 2001, 国家 != "苏丹")

dat2 %>% write_csv("../data/world_health/tidy/iMR_filtered.csv")

dat2 <- dat2 %>%
  filter(年份 >= 2003) %>%
  pivot_wider(names_from = "国家", values_from = "lg") %>%
  arrange(年份) %>%
  select(-年份)

dat2 %>% write_csv("../data/world_health/tidy/iMR_for_sc.csv")

# Reformat under5 mortality data

dat3 <- read_csv("../data/world_health/tidy/5MR_tidy_zh.csv")

dat3 <- dat3 %>%
  mutate(lg = robust_log(under5MortalityRate), .keep = "unused") %>%
  select(-country) %>%
  filter(国家 %>% is.na() %>% `!`, 年份 >= 2001, 国家 != "苏丹")

dat3 %>% write_csv("../data/world_health/tidy/5MR_filtered.csv")
