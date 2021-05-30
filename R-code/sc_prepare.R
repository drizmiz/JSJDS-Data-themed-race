# Created by: drizzle
# Created on: 2021/5/30

library(tidyverse)
library(showtext)

# Reformat data

dat <- read_csv("../data/investment/FDI_filled.csv")

dat <- dat %>%
  mutate(lg = log(对外直接投资), .keep = "unused") %>%
  select(-地区) %>%
  pivot_wider(names_from = "国家", values_from = "lg") %>%
  select(-年份)

dat %>% write_csv("../data/investment/FDI_for_sc.csv")

# Time periods

T0 <- 2003
Tobor <- 2013
Tend <- 2019

T0go <- Tobor - T0
T01go <- Tend - T0 + 1
T1go <- T01go - T0go

time <- seq(T0, Tend, 1)

### Data (obtained from Scott Cunningham and Manisha Shah)

logfemrate <- read_csv("../data/investment/FDI_for_sc.csv") %>% as.data.frame()
country_list <- read_lines("../data/obor_list.txt")

# First column: trials (one-belt-one-road); columns 2-51: controls

kp <- country_list %in% names(logfemrate) %>% which()
country_list <- country_list[kp]


for (i in seq_along(country_list %>% head(10))) {
  cty <- country_list[i]
  idx <- cty %>% match(names(logfemrate))

  Y1go <- as.matrix(logfemrate[, idx])
  Y0go <- as.matrix(logfemrate[, (1:ncol(logfemrate))[-idx]])

  directory <- "test/our_graphics/"

  pdf_plot_raw()
}


pdf_plot_raw <- function() {
  pdf(paste0(directory, cty, "_investment_data_raw.pdf"), pointsize = 14, width = 8.0, height = 6.0)
  # for Unicode characters like CJK
  showtext_begin()
  plot(range(time), c(-2, 14), ylab = "Log FDI from China", xlab = "Time", main = "", type = "n")
  for (j in 1:dim(Y0go)[2]) lines(time, Y0go[, j], col = "darkgrey", lwd = 0.5, lty = 1)
  lines(time, Y1go, col = "black", lwd = 5)
  abline(v = time[T0go] + 0.5, col = "darkgrey", lty = 2, lwd = 1.5)
  legend("topleft", legend = c("其他国家", logfemrate %>% names() %>% .[idx]), seg.len = 2, col = c("darkgrey", "black"),
         fill = NA, border = NA, lty = c(1, 1), lwd = c(0.5, 5), merge = T, bty = "n")
  showtext_end()
  graphics.off()
}