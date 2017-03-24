
double_hist <- function(v1, v2, bins = 20) {
  p1 <- hist(v1, breaks = bins)
  p2 <- hist(v2, breaks = bins)
  xlims <- c(min(c(p1$breaks, p2$breaks)), max(c(p1$breaks, p2$breaks)))
  ylims <- c(min(c(p1$counts, p2$counts)), max(c(p1$counts, p2$counts)))
  plot(p1, col = rgb(0,0,1,1/4), xlim = xlims, ylim = ylims)
  plot(p2, col = rgb(1,0,0,1/4), add = TRUE)
}

