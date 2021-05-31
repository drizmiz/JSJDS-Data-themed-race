# Created by: drizzle
# Created on: 2021/5/30

### Packages
library(xtable)
library(plotrix)

library(limSolve)

# set.seed(seed = 12345)

source("sc_functions.R")
source("sc_head.R")
source("plot.R")

### Test head

country_name <<- country_list[1]
idx <- country_name %>% match(names(fdi_data))

Y1go <<- as.matrix(fdi_data[, idx])
Y0go <<- as.matrix(fdi_data[, (seq_along(fdi_data))[-idx]])

### Specify norm for test statistic

q_norm <- 1 # L_1 norm

### Placebo specification tests

sens.sc.mb <- sens.did.mb <- sens.sc.all <- sens.did.all <- matrix(NA, 3, 1)

Y1pre <- Y1go[1:T0go]
Y0pre <- Y0go[1:T0go,]

perm <- 200

for (t in 1:3) {
  sens.sc.mb[t, 1] <- moving_block_q(Y1pre, Y0pre, (T0go - t), t, "sc", q_norm)
  sens.sc.all[t, 1] <- all.q(Y1pre, Y0pre, (T0go - t), t, "sc", perm, q_norm)
  sens.did.mb[t, 1] <- moving_block_q(Y1pre, Y0pre, (T0go - t), t, "did", q_norm)
  sens.did.all[t, 1] <- all.q(Y1pre, Y0pre, (T0go - t), t, "did", perm, q_norm)
}

tibble(sens.did.mb[, 1], sens.sc.mb[, 1], sens.did.all[, 1], sens.sc.all[, 1]) %>%
  write_csv("./test/sens.csv")

### No effect

perm <- 1000

p.noeff.did.mb <- moving_block_q(Y1go, Y0go, T0go, T1go, "did", q_norm)
p.noeff.sc.mb <- moving_block_q(Y1go, Y0go, T0go, T1go, "sc", q_norm)

p.noeff.did.all <- all.q(Y1go, Y0go, T0go, T1go, "did", perm, q_norm)
p.noeff.sc.all <- all.q(Y1go, Y0go, T0go, T1go, "sc", perm, q_norm)

tibble(p.noeff.did.mb, p.noeff.sc.mb, p.noeff.did.all, p.noeff.sc.all) %>%
  write_csv("./test/p.noeff.csv")

### Pointwise CI

alpha <- 0.1
grid <- seq(-3, 2, 0.02)

vec.ci.sc <- vec.ci.did <- m.ci.sc <- m.ci.did <- NULL

for (t in 1:T1go) {
  indices <- c(1:T0go, T0go + t)
  Y1ci <- Y1go[indices]
  Y0ci <- Y0go[indices,]
  ci.sc <- ci(Y1ci, Y0ci, "sc", alpha, grid)
  vec.ci.sc <- rbind(vec.ci.sc, cbind((t + Tpre), ci.sc))
  m.ci.sc <- cbind(m.ci.sc, mean(ci.sc))
  ci.did <- ci(Y1ci, Y0ci, "did", alpha, grid)
  vec.ci.did <- rbind(vec.ci.did, cbind((t + Tpre), ci.did))
  m.ci.did <- cbind(m.ci.did, mean(ci.did))
}

time <- seq(Tobor, Tend, 1)

pdf_plot_confidence_interval("test/our_graphics/")
