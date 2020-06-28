
#' Parsing SVG internally
#'
#' @param svg
#'
#' @return
#' @export
#'
#' @examples
rparse_svg <- function(svg) {
  wd  <- system.file("node", package = "bezieR")
  node_call = paste0("node ",wd,"/app.js ","'",svg,"'")
  output <- system(node_call, intern = T)
  return(output)
}
