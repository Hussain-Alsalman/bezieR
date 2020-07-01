
get_dis <- function(xs, ys, ratio) {
  x_point <- rep(NA, length(xs)-1)
  y_point <- rep(NA, length(ys)-1)

  for (n in 1:length(xs)-1) {
    x_point[n]  <- xs[n+1]+(xs[n]-xs[n+1])*ratio
    y_point[n] <- ys[n+1]+(ys[n]-ys[n+1])*ratio
  }
  return(list("x" = x_point,"y"= y_point))
}


make_recursive <- function() {
  function(xylist,ratio) {
    if (length(xylist[[1]]) <= 1) {
    } else {
      tmp_list <- get_dis(xs = xylist$x, ys = xylist$y, ratio)

      if(length(tmp_list$x) > 1){
        s <- 1:length(tmp_list$x)
        s0 <- seq(length(tmp_list$x)-1)
        s1 <- s[-1]
        colr <- colors()[(length(tmp_list$x)+1)*10]

        grid::grid.draw(grid::segmentsGrob(x0=grid::unit(tmp_list$x[s0], "native"),
                                     y0=grid::unit(tmp_list$y[s0],"native"),
                                     x1=grid::unit(tmp_list$x[s1],"native"),
                                     y1=grid::unit(tmp_list$y[s1],"native"),
                                     gp= grid::gpar(col = colr)))
        grid::grid.draw(grid::pointsGrob(x= grid::unit(tmp_list$x[c(s0,s1)], "native"),
                                         y = grid::unit(tmp_list$y[c(s0,s1)],"native"),
                                         gp = grid::gpar(col = colr), pch = 20))
        Recall(tmp_list,ratio)} else
        {
          grid::grid.draw(grid::pointsGrob(x = grid::unit(tmp_list$x, "native"),
                                     y = grid::unit(tmp_list$y,"native"),
                                     gp = grid::gpar(col = "red"), pch = 19))
        }
    }
  }
}
