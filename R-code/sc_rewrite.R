# Created by: drizzle
# Created on: 2021/5/30

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

