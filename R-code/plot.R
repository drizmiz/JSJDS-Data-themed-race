# Created by: drizzle
# Created on: 2021/5/30

# source("sc_head.R")

library(showtext)

pdf_plot_raw <- function(directory) {
  pdf(paste0(directory, country_name, "_investment_data_raw.pdf"), pointsize = 14, width = 8.0, height = 6.0)
  # for Unicode characters like CJK
  showtext_begin()
  plot(range(time), c(-2, 14), ylab = "Log FDI from China", xlab = "Time", main = "", type = "n")
  for (j in 1:dim(Y0go)[2]) lines(time, Y0go[, j], col = "darkgrey", lwd = 0.5, lty = 1)
  lines(time, Y1go, col = "black", lwd = 5)
  abline(v = time[T0go] + 0.5, col = "darkgrey", lty = 2, lwd = 1.5)
  legend("topleft", legend = c("其他国家", country_name), seg.len = 2, col = c("darkgrey", "black"),
         fill = NA, border = NA, lty = c(1, 1), lwd = c(0.5, 5), merge = T, bty = "n")
  showtext_end()
  graphics.off()
}

# repli(pdf_plot_raw(directory = "../visualization/obor_raw_plot/"))

pdf_plot2 <- function(directory) {
  pdf(paste0(directory, "_investment_resid_pre_did.pdf"), pointsize = 16, width = 6.0, height = 6.0)
  plot(range(seq(T0, Tpre, 1)), c(-1, 1), ylab = "Residuals Pre-One belt One Road", xlab = "Time", main = "Difference-in-Differences", type = "n")
  points(seq(T0, Tpre, 1), u.hat.go.pre.did, col = "black", pch = 20, lwd = 2)
  abline(h = 0, col = "grey", lty = 2, lwd = 1)
  graphics.off()

  pdf(paste0(directory, "_investment_resid_pre_sc.pdf"), pointsize = 16, width = 6.0, height = 6.0)
  plot(range(seq(T0, Tpre, 1)), c(-1, 1), ylab = "Residuals Pre-One belt One Road", xlab = "Time", main = "Synthetic Control", type = "n")
  points(seq(T0, Tpre, 1), u.hat.go.pre.sc, col = "black", pch = 20, lwd = 2)
  abline(h = 0, col = "grey", lty = 2, lwd = 1)
  graphics.off()
}

pdf_plot3 <- function(directory) {
  pdf(paste0(directory, "_ci_investment_sc.pdf"), pointsize = 16, width = 6.0, height = 6.0)
  plot(vec.ci.sc[, 1], vec.ci.sc[, 2], ylab = "Gap in Log FDI from China", xlab = "Years", main = "",
       col = "black", pch = "eda-doc", xlim = c(Tpre, Tend + 1), ylim = c(-3, 3))
  title("Synthetic Control")
  abline(h = 0, col = "grey", lty = 2, lwd = 2)
  points(time, m.ci.sc, pch = 16, cex = 0.8, col = "black")
  legend(Tpre, 2, legend = "90% Confidence Interval", col = "black", cex = 1, lty = 1, lwd = 2.25, bty = ("n"))
  legend(Tpre + 0.3, 2, legend = "", cex = 1, col = "black", pch = 16, bty = ("n"))
  graphics.off()

  pdf(paste0(directory, "_ci_investment_did.pdf"), pointsize = 16, width = 6.0, height = 6.0)
  plot(vec.ci.did[, 1], vec.ci.did[, 2], ylab = "Gap in Log FDI from China", xlab = "Years", main = "",
       col = "black", pch = "eda-doc", xlim = c(Tpre, Tend + 1), ylim = c(-3, 3))
  title("Difference-in-Differences")
  abline(h = 0, col = "grey", lty = 2, lwd = 2)
  points(time, m.ci.did, pch = 16, cex = 0.8, col = "black")
  legend(Tpre, 2, legend = "90% Confidence Interval", col = "black", cex = 1, lty = 1, lwd = 2.25, bty = ("n"))
  legend(Tpre + 0.3, 2, legend = "", cex = 1, col = "black", pch = 16, bty = ("n"))
  graphics.off()
}