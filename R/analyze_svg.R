#' This will take any svg file and show the control point skeleton.
#'
#' @param svg_path svg file path
#'
#' @return
#' @export
#'
#' @examples
analyze_svg <- function(svg_path) {

  df_xy <- parsed_svg(svg_path)
  xmax<-max(c(df_xy$x0,df_xy$x1,df_xy$x2,df_xy$x))
  xmin <- min(c(df_xy$x0,df_xy$x1,df_xy$x2,df_xy$x))
  ymax <- max(c(df_xy$y0,df_xy$y1,df_xy$y2, df_xy$y))
  ymin <- min(c(df_xy$y0,df_xy$y1,df_xy$y2, df_xy$y))

  vp <-pre_drawing(x_min =xmin, x_max=xmax, y_min = ymin, y_max = ymax)
  n <- dim(df_xy)[1]
  for(i in 1:n){
    x_p <- c(df_xy$x0[i],df_xy$x1[i],df_xy$x2[i],df_xy$x[i])
    y_p <- c(df_xy$y0[i],df_xy$y1[i],df_xy$y2[i], df_xy$y[i])
    draw_base(x_p = x_p, y_p = y_p, vp = vp)
  }

}
