# Created by: drizzle
# Created on: 2021/5/29

library(tidyverse)
library(lubridate)

raw_df <- read_csv(
  file = "../data/investment/FDI_tidy_cont.csv",
  col_types = cols(
    时间 = col_date(format = "%m/%Y")
  ),
  guess_max = 50000
)

df0 <- raw_df %>%
  filter(!is.na(国家))

# 对外直接投资:非金融类:累计 为一带一路数据所特有
OBOR_col <- "对外直接投资:非金融类:累计"

df <- df0 %>%
  filter(国家 != "一带一路" & 国家 != "总计") %>%
  select(-all_of(OBOR_col))

df <- df %>%
  filter(month(时间) == 12) %>%
  mutate(年份 = as.integer(year(时间)), .keep = "unused", .before = 1) %>%
  filter(年份 >= 2002)

df <- df %>%
  select(names(df) %>% str_subset(pattern = "投资(和其他)*$", negate = TRUE)) %>%
  filter(!is.na(`对外直接投资:截至累计`))

df %>% write_csv(file = "../data/investment/FDI_useful.csv")

df1 <- df0 %>%
  filter(国家 == "一带一路" & !is.na(.[OBOR_col])) %>%
  select(c("时间", OBOR_col)) %>%
  mutate(
    年份 = as.integer(year(时间)),
    月份 = as.integer(month(时间)),
    .keep = "unused", .before = 1) %>%
  arrange(年份, 月份)

df1 %>% write_csv(file = "../data/investment/FDI_OBOR.csv")
