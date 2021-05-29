
# Created by: drizzle
# Created on: 2021/5/29

library(tidyverse)

raw_df <- read_csv("../data/FDI_untidy.csv")

simplified_df <- raw_df %>%
  filter(X1 %>% str_detect("^\\d")) %>%
  rename(时间 = X1)

fliped_df <- simplified_df %>%
  gather(key = "observation", value = "val", -时间)

stdize <- function (str) {
  str %>%
    str_replace(pattern = "(.*):(总计|一带一路)", replacement = "\\1/\\2/\\2") %>%
    str_replace(pattern = "::", replacement = ":") %>%
    str_replace(pattern = "(.*):(.*洲):*(.*)", replacement = "\\1/\\2/\\3")
}

sep_df <- fliped_df %>%
  mutate(observation = observation %>% stdize()) %>%
  separate(col = "observation", into = c("type", "地区", "国家"), sep = "/")

df <- sep_df %>% spread(key = "type", value = "val")

df %>% write_csv("../data/FDI_tidy.csv")