# Created by: drizzle
# Created on: 2021/5/30

set.seed(seed = 12345)

source("raw_plot.R")

### Packages
library(xtable)
library(plotrix)

library(limSolve)

### Functions

# Difference-in-differences
did <- function(Y1, Y0) {
  u.hat <- Y1 - mean(Y1 - rowMeans(Y0)) - rowMeans(Y0)
  return(u.hat)
}

# Synthetic control (requires R-package limSolve)
sc <- function(Y1, Y0) {
  J <- dim(Y0)[2]
  e <- matrix(1, 1, J)
  f <- 1
  g <- diag(x = 1, J, J)
  h <- matrix(0, J, 1)
  w.hat <- lsei(A = Y0, B = Y1, E = e, F = f, G = g, H = h, type = 2)$X
  u.hat <- Y1 - Y0 %*% w.hat
  return(list(u.hat = u.hat, w.hat = w.hat))
}

# Moving block permutations
moving.block.q <- function(Y1, Y0, T0, T1, M, q) {
  T01 <- T0 + T1
  if (M == "sc") {
    u.hat <- sc(Y1, Y0)$u.hat
  }
  if (M == "did") {
    u.hat <- did(Y1, Y0)
  }
  sub.size <- T1
  u.hat.c <- c(u.hat, u.hat)
  S.vec <- matrix(NA, T01, 1)
  if (q == 1) {
    for (s in 1:(T01)) {
      S.vec[s, 1] <- sum(abs(u.hat.c[s:(s + sub.size - 1)]))
    }
  }
  if (q == 2) {
    for (s in 1:(T01)) {
      S.vec[s, 1] <- sqrt(sum((u.hat.c[s:(s + sub.size - 1)])^2))
    }
  }
  p <- mean(S.vec >= S.vec[T0 + 1])
  return(p)
}

# All/iid permutations (use random subsample of all permutations)
all.q <- function(Y1, Y0, T0, T1, M, nperm, q) {
  T01 <- T0 + T1
  if (M == "sc") {
    u.hat <- sc(Y1, Y0)$u.hat
  }
  if (M == "did") {
    u.hat <- did(Y1, Y0)
  }
  post.ind <- ((T0 + 1):T01)
  pre.ind <- (1:T0)
  S.vec <- matrix(NA, nperm, 1)
  if (q == 1) {
    Sq <- sum(abs(u.hat[post.ind]))
    for (r in 1:nperm) {
      u.hat.p <- u.hat[sample(1:T01, replace = F)]
      S.vec[r, 1] <- sum(abs(u.hat.p[post.ind]))
    }
  }
  if (q == 2) {
    Sq <- sqrt(sum((u.hat[post.ind])^2))
    for (r in 1:nperm) {
      u.hat.p <- u.hat[sample(1:T01, replace = F)]
      S.vec[r, 1] <- sqrt(sum((u.hat.p[post.ind])^2))
    }
  }
  p <- 1 / (nperm + 1) * (1 + sum(S.vec >= Sq))
  return(p)
}

# Confidence interval via test inversion
ci <- function(Y1, Y0, M, alpha, thetagrid) {
  T01 <- dim(Y0)[1]
  T0 <- T01 - 1
  p.vec <- rep(NA, length(thetagrid))
  for (ind in 1:length(thetagrid)) {
    Y1_0 <- Y1
    Y1_0[T01] <- Y1[T01] - thetagrid[ind]
    if (M == "sc") {
      u.hat <- sc(Y1_0, Y0)$u.hat
    }
    if (M == "did") {
      u.hat <- did(Y1_0, Y0)
    }
    p.vec[ind] <- mean(abs(u.hat) >= abs(u.hat[T01]))
  }
  ci <- thetagrid[p.vec > alpha]
  return(ci)
}

###########################################################################################################
# Analysis
###########################################################################################################

### Specify norm for test statistic

q_norm <- 1 # L_1 norm

### Data (obtained from Scott Cunningham and Manisha Shah)

logfemrate <- read.delim("./test/logfemrate.txt", header = T)

# First column: RI; columns 2-51: controls

Y1go <- as.matrix(logfemrate[, 1])
Y0go <- as.matrix(logfemrate[, 2:ncol(logfemrate)])

# Check I: comparison to Table 1 in Cunningham&Shah (2018)
# data19992009 <- as.matrix(logfemrate[15:25,])
# c(mean(data19992009),sd(data19992009))
# dim(data19992009)
# Check II: comparison to Table 9 in Cunningham&Shah (2018)
# cbind(1985:2009,Y1go)

pdf_plot1()

### Placebo specification tests

sens.sc.mb <- sens.did.mb <- sens.sc.all <- sens.did.all <- matrix(NA, 3, 1)

Y1pre <- Y1go[1:T0go]
Y0pre <- Y0go[1:T0go,]

perm = 200

for (t in 1:3) {
  sens.sc.mb[t, 1] <- moving.block.q(Y1pre, Y0pre, (T0go - t), t, "sc", q_norm)
  sens.sc.all[t, 1] <- all.q(Y1pre, Y0pre, (T0go - t), t, "sc", perm, q_norm)
  sens.did.mb[t, 1] <- moving.block.q(Y1pre, Y0pre, (T0go - t), t, "did", q_norm)
  sens.did.all[t, 1] <- all.q(Y1pre, Y0pre, (T0go - t), t, "did", perm, q_norm)
}

xtable(cbind(sens.did.mb[, 1], sens.sc.mb[, 1], sens.did.all[, 1], sens.sc.all[, 1]))

### Residual plots pre-treatment period

r.pre.sc <- sc(Y1pre, Y0pre)

u.hat.go.pre.did <- did(Y1pre, Y0pre)
u.hat.go.pre.sc <- r.pre.sc$u.hat

pdf_plot2()

### No effect

perm = 200

p.noeff.did.mb <- moving.block.q(Y1go, Y0go, T0go, T1go, "did", q_norm)
p.noeff.sc.mb <- moving.block.q(Y1go, Y0go, T0go, T1go, "sc", q_norm)

p.noeff.did.all <- all.q(Y1go, Y0go, T0go, T1go, "did", perm, q_norm)
p.noeff.sc.all <- all.q(Y1go, Y0go, T0go, T1go, "sc", perm, q_norm)

xtable(cbind(p.noeff.did.mb, p.noeff.sc.mb, p.noeff.did.all, p.noeff.sc.all))

### Pointwise CI

alpha <- 0.1
grid <- seq(-5, 2, 0.01)

vec.ci.sc <- vec.ci.did <- m.ci.sc <- m.ci.did <- NULL

for (t in 1:T1go) {
  indices <- c(1:T0go, T0go + t)
  Y1ci <- Y1go[indices]
  Y0ci <- Y0go[indices,]
  ci.sc <- ci(Y1ci, Y0ci, "sc", alpha, grid)
  vec.ci.sc <- rbind(vec.ci.sc, cbind((t + 2003), ci.sc))
  m.ci.sc <- cbind(m.ci.sc, mean(ci.sc))
  ci.did <- ci(Y1ci, Y0ci, "did", alpha, grid)
  vec.ci.did <- rbind(vec.ci.did, cbind((t + 2003), ci.did))
  m.ci.did <- cbind(m.ci.did, mean(ci.did))
}

time <- seq(2004, 2009, 1)

pdf_plot3()
