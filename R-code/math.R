# Created by: drizzle
# Created on: 2021/5/31

robust_log <- function(x) {
  threshold <- 0.01   # the min investment data in this dataset
  if_else(
    0 <= x & x < threshold,
    true = log(threshold / 3),
    false = log(x)
  )
}

robust_exp <- function(x) {
  threshold <- 0.01   # the min investment data in this dataset
  y <- exp(x)
  if_else(
    0 <= y & y < threshold / 2,
    true = 0,
    false = y
  )
}
