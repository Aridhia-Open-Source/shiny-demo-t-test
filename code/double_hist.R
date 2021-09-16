double_hist <- function(v1, v2, bins = 20) {
  p1 <- hist(v1, breaks = bins)
  p2 <- hist(v2, breaks = bins)
  xlims <- c(min(c(p1$breaks, p2$breaks)), max(c(p1$breaks, p2$breaks)))
  ylims <- c(min(c(p1$counts, p2$counts)), max(c(p1$counts, p2$counts)))
  plot(p1, col = rgb(0,0,1,1/4), xlim = xlims, ylim = ylims)
  plot(p2, col = rgb(1,0,0,1/4), add = TRUE)
}

ggplot_double_hist <- function(v1, v2, group1 = "group1", group2 = "group2", bins = 20) {
  d <- data.frame(value = c(v1, v2), group = c(rep(group1, length(v1)), rep(group2, length(v2))))
  
  ggplot(d) +
    geom_histogram(aes(x = value, fill = group), 
                   bins = bins, position = "identity", alpha = 0.8,
                   colour = "black")
}


ggplot_hist <- function(values, groups, value_name = "value", group_name = "group", bins = 20) {
  d <- data.frame(value = values, group = groups)
  
  ggplot(d) +
    geom_histogram(aes(x = value, fill = group), 
                   bins = bins, position = "identity", alpha = 0.8,
                   colour = "black") +
    xlab(value_name) +
    theme_minimal()
}

