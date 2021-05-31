# Created by: drizzle
# Created on: 2021/5/30

library(limSolve)

# for reproducibility
set.seed(seed = 0)

source("sc_functions.R")
source("sc_head.R")
source("plot.R")

directory <- "../results/"

sens <- p.noeff <- c.i <- tibble()

placebo_specification_test <- function() {
  sens.sc.mb <- sens.did.mb <- sens.sc.all <- sens.did.all <- matrix(NA, 3, 1)

  Y1pre <- Y1go[1:Tact_from_0]
  Y0pre <- Y0go[1:Tact_from_0,]

  for (t in 1:3) {
    # moving block permutation
    sens.sc.mb[t, 1] <- moving_block_q(Y1pre, Y0pre, (Tact_from_0 - t), t, "sc", q_norm)
    sens.did.mb[t, 1] <- moving_block_q(Y1pre, Y0pre, (Tact_from_0 - t), t, "did", q_norm)

    # draw perm times iid. from all permutations
    sens.sc.all[t, 1] <- all_q(Y1pre, Y0pre, (Tact_from_0 - t), t, "sc", perm, q_norm)
    sens.did.all[t, 1] <- all_q(Y1pre, Y0pre, (Tact_from_0 - t), t, "did", perm, q_norm)
  }

  sens <<- sens %>% bind_rows(
    tibble(country_name, sens.did.mb[, 1], sens.sc.mb[, 1], sens.did.all[, 1], sens.sc.all[, 1])
  )
}

### Calculate p-value

p_calculator <- function() {
  p.noeff.did.mb <- moving_block_q(Y1go, Y0go, Tact_from_0, T1go, "did", q_norm)
  p.noeff.sc.mb <- moving_block_q(Y1go, Y0go, Tact_from_0, T1go, "sc", q_norm)

  p.noeff.did.all <- all_q(Y1go, Y0go, Tact_from_0, T1go, "did", perm, q_norm)
  p.noeff.sc.all <- all_q(Y1go, Y0go, Tact_from_0, T1go, "sc", perm, q_norm)

  p.noeff <<- p.noeff %>% bind_rows(
    tibble(country_name, p.noeff.did.mb, p.noeff.sc.mb, p.noeff.did.all, p.noeff.sc.all)
  )
}

### Pointwise Confidence Interval
ci_calculator <- function() {
  alpha <- 0.1
  grid <- seq(-3, 2, 0.02)
  vec.ci.sc <<- vec.ci.did <<- m.ci.sc <<- m.ci.did <<- NULL

  for (t in 1:T1go) {
    indices <- c(1:Tact_from_0, Tact_from_0 + t)
    Y1ci <- Y1go[indices]
    Y0ci <- Y0go[indices,]
    ci.sc <- ci(Y1ci, Y0ci, "sc", alpha, grid)
    vec.ci.sc <<- rbind(vec.ci.sc, cbind((t + Tpre), ci.sc))
    m.ci.sc <<- cbind(m.ci.sc, mean(ci.sc))
    ci.did <- ci(Y1ci, Y0ci, "did", alpha, grid)
    vec.ci.did <<- rbind(vec.ci.did, cbind((t + Tpre), ci.did))
    m.ci.did <<- cbind(m.ci.did, mean(ci.did))
  }

  tb_sc <- vec.ci.sc %>%
    as_tibble() %>%
    rename(年份 = V1)
  tb_sc <- tb_sc %>% group_by(年份) %>% summarise(min(ci.sc), max(ci.sc), median(ci.sc))

  tb_did <- vec.ci.did %>%
    as_tibble() %>%
    rename(年份 = V1)
  tb_did <- tb_did %>% group_by(年份) %>% summarise(min(ci.did), max(ci.did), median(ci.did))

  tb <- left_join(tb_sc, tb_did) %>%
    mutate(国家 = country_name, .after = 年份)

  c.i <<- c.i %>% bind_rows(tb)
  pdf_plot_confidence_interval_did(directory = directory)
}

repli(placebo_specification_test())
sens %>% write_csv(paste0(directory, "sens.csv"))

repli(p_calculator())
p.noeff %>% write_csv(paste0(directory, "p.noeff.csv"))

repli(ci_calculator())
c.i %>% write_csv(paste0(directory, "ci.csv"))
