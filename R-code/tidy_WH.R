# Created by: drizzle
# Created on: 2021/5/31

library(tidyverse)
library(jsonlite)

raw_df <- read_csv("../data/world_health/infantMortalityRate.csv")

df <- raw_df %>%
  filter(Dim1 == "Both sexes") %>%
  separate(col = "First Tooltip", into = c("infantMortalityRate", "Range"), sep = " ") %>%
  select(-Dim1, -Range, -Indicator) %>%
  rename(country = Location) %>%
  mutate(`年份` = Period, .keep = "unused", .before = 1)

df %>% write_csv("../data/world_health/tidy/iMR_tidy.csv")

en_zh <- read_json("../visualization/data/world_country.json")

zh_df <- df %>%
  mutate(国家 = en_zh[country], .before = country) %>%
  unnest(cols = "国家", keep_empty = TRUE)

zh_df %>% write_csv("../data/world_health/tidy/iMR_tidy_zh.csv")
