# Created by: drizzle
# Created on: 2021/5/30

source("sc_head.R")

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

repli(
  pdf_plot_raw(directory = "../visualization/obor_raw_plot/")
)

