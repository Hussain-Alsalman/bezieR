#' Analyze bezier curves of any order
#'
#' @param cp_x the x-axis coordinate of the control points
#' @param cp_y the y-axis coordinate of the control points
#'
#' @return
#' @export
#'
#' @examples
analyze_bezier <- function(cp_x,cp_y)
  {
xmax<-max(cp_x)
xmin <- min(cp_x)
ymax <- max(cp_y)
ymin <- min(cp_y)

vp <-pre_drawing(x_min =xmin, x_max=xmax, y_min = ymin, y_max = ymax)
draw_base(x_p = cp_x, y_p = cp_y, vp = vp)
}
