#' Draw a bezier curve given any number of control points
#'
#' @param x_p control points for the x-axis
#' @param y_p control points for the y-axis
#' @param vp  viewport passed to plot the drawing
#'
#'
#' @export
#'

draw_base <- function(x_p, y_p, vp) {
  # Creating a view port (i.e our canvas to draw at)
  grid::pushViewport(vp)
  x <- x_p
  y <- y_p
  if(length(x_p) > 4 || length(y_p) > 4 ) {
    # setting t values
    intr <- seq(0,1,0.01) # t value

    #making the coordinate equation for the provided control points
    x_cord <- make_terms(length(x_p), cp = x_p )
    y_cord <- make_terms(length(y_p), cp = y_p )

    # Creating the data
    x_d <-x_cord(intr)
    y_d <- y_cord(intr)
    grid::grid.draw(grid::linesGrob(x =grid::unit(x_d, "native"), y = grid::unit(y_d, "native")))
  } else {
    grid::grid.bezier(x=grid::unit(x,"native"), y=grid::unit(y,"native"))
    grid::grid.draw(grid::pointsGrob(x = grid::unit(x, "native"),
                               y = grid::unit(y, "native") , gp = grid::gpar(col = "lightgray")))
  }

  for(v in 1:(length(x)-1))
  {
    grid::grid.draw(grid::segmentsGrob(x0 = grid::unit(x[v], "native"),
                                 x1 = grid::unit(x[v+1],"native"),
                                 y0 = grid::unit(y[v],"native"),
                                 y1 = grid::unit(y[v+1], "native"),
                                 gp = grid::gpar(lty="solid",lwd = 2 ,col = "lightgray")))
  }
}


#' Set up the drawing area for the bezier curve
#'
#' @param x_min the minimum value for all points on x-axis
#' @param x_max the maximum value for all points on x-axis
#' @param y_min the minimum value for all points on y-axis
#' @param y_max the maximum value for all points on y-axis
#'
#' @return
#' @export
#'
#' @examples
pre_drawing <- function(x_min, x_max,y_min,y_max){

  grid::grid.newpage()
  vp <- grid::viewport(x = 0.5, y = 0.5,
                       just = c("center", "center"),
                       height = 0.9, width = 0.9,
                       xscale = c(x_min, x_max), yscale =c(y_min,y_max))
  return(vp)
}

