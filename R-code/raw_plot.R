# Created by: drizzle
# Created on: 2021/5/30

directory <- "test/graphics/"

pdf_plot1 <- function() {
  pdf(paste0(directory, "gonorrhoea_data_raw.pdf"), pointsize = 14, width = 8.0, height = 6.0)
  plot(range(time), c(0, 10), ylab = "Log Female Gonorrhea per 100,000", xlab = "Time", main = "", type = "n")
  for (j in 1:dim(Y0go)[2]) lines(time, Y0go[, j], col = "darkgrey", lwd = 0.5, lty = 1)
  lines(time, Y1go, col = "black", lwd = 5)
  abline(v = time[T0go] + 0.5, col = "darkgrey", lty = 2, lwd = 1.5)
  legend("topleft", legend = c("Other U.S. States", "Rhode Island"), seg.len = 2, col = c("darkgrey", "black"), fill = NA, border = NA, lty = c(1, 1), lwd = c(0.5, 5), merge = T, bty = "n")
  graphics.off()
}

pdf_plot2 <- function() {
  pdf(paste0(directory, "gonorrhoea_resid_pre_did.pdf"), pointsize = 16, width = 6.0, height = 6.0)
  plot(range(seq(1985, 2003, 1)), c(-1, 1), ylab = "Residuals Pre-Treatment Period", xlab = "Time", main = "Difference-in-Differences", type = "n")
  points(seq(1985, 2003, 1), u.hat.go.pre.did, col = "black", pch = 20, lwd = 2)
  abline(h = 0, col = "grey", lty = 2, lwd = 1)
  graphics.off()

  pdf(paste0(directory, "gonorrhoea_resid_pre_sc.pdf"), pointsize = 16, width = 6.0, height = 6.0)
  plot(range(seq(1985, 2003, 1)), c(-1, 1), ylab = "Residuals Pre-Treatment Period", xlab = "Time", main = "Synthetic Control", type = "n")
  points(seq(1985, 2003, 1), u.hat.go.pre.sc, col = "black", pch = 20, lwd = 2)
  abline(h = 0, col = "grey", lty = 2, lwd = 1)
  graphics.off()
}

pdf_plot3 <- function() {
  pdf(paste0(directory, "ci_gonorrhoea_sc.pdf"), pointsize = 16, width = 6.0, height = 6.0)
  plot(vec.ci.sc[, 1], vec.ci.sc[, 2], ylab = "Gap in Log Female Gonorrhea per 100,000", xlab = "Years", main = "", col = "black", pch = "eda-doc", xlim = c(2003, 2010), ylim = c(-2, 2))
  title("Synthetic Control")
  abline(h = 0, col = "grey", lty = 2, lwd = 2)
  points(time, m.ci.sc, pch = 16, cex = 0.8, col = "black")
  legend(2003, 2, legend = c("90% Confidence Interval"), col = "black", cex = 1, lty = c(1), lwd = c(2.25), bty = ("n"))
  legend(2003 + 0.3, 2, legend = c(""), cex = 1, col = c("black"), pch = 16, bty = ("n"))
  graphics.off()

  pdf(paste0(directory, "ci_gonorrhoea_did.pdf"), pointsize = 16, width = 6.0, height = 6.0)
  plot(vec.ci.did[, 1], vec.ci.did[, 2], ylab = "Gap in Log Female Gonorrhea per 100,000", xlab = "Years", main = "", col = "black", pch = "eda-doc", xlim = c(2003, 2010), ylim = c(-2, 2))
  title("Difference-in-Differences")
  abline(h = 0, col = "grey", lty = 2, lwd = 2)
  points(time, m.ci.did, pch = 16, cex = 0.8, col = "black")
  legend(2003, 2, legend = c("90% Confidence Interval"), col = "black", cex = 1, lty = c(1), lwd = c(2.25), bty = ("n"))
  legend(2003 + 0.3, 2, legend = c(""), cex = 1, col = c("black"), pch = 16, bty = ("n"))
  graphics.off()
}