# Created by: drizzle
# Created on: 2021/5/31

library(tidyverse)
library(jsonlite)

tidy_raw <- function(raw_df, varstr) {
  df <- raw_df %>%
    filter(Dim1 == "Both sexes") %>%
    separate(col = "First Tooltip", into = c(varstr, "Range"), sep = " ") %>%
    select(-Dim1, -Range, -Indicator) %>%
    rename(country = Location) %>%
    mutate(`年份` = Period, .keep = "unused", .before = 1)
}

en_zh <- function(en_df) {
  en_zh_dict <- read_json("../visualization/data/world_country.json")

  zh_df <- en_df %>%
    mutate(国家 = en_zh_dict[country], .before = country) %>%
    unnest(cols = "国家", keep_empty = TRUE)
}

# infantMortalityRate
raw <- read_csv("../data/world_health/infantMortalityRate.csv")

df <- raw %>% tidy_raw(varstr = "infantMortalityRate")
df %>% write_csv("../data/world_health/tidy/iMR_tidy.csv")

zh_df <- df %>% en_zh()
zh_df %>% write_csv("../data/world_health/tidy/iMR_tidy_zh.csv")

# under5MortalityRate
raw <- read_csv("../data/world_health/under5MortalityRate.csv")

zh_df <- raw %>%
  tidy_raw(varstr = "under5MortalityRate") %>%
  en_zh()

zh_df %>% write_csv("../data/world_health/tidy/5MR_tidy_zh.csv")
