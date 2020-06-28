#' Animate bezier curves of any order
#'
#' @param cp_x the x-axis coordinate of the control points
#' @param cp_y the y-axis coordinate of the control points
#'
#' @return
#' @export
#'
#' @examples
animate_bezier <- function(cp_x, cp_y) {
 analyze_bezier(cp_x, cp_y)
    intr <- seq(0,1,0.01) # t value
    recursive <- make_recursive()
    tmp_dir <- tempdir()

    for (pn in 1:length(intr)) {
      a<-dev.copy(png, file =paste0(tmp_dir,"/",pn,"_snap.png"))
      recursive(xylist = list(x = cp_x, y = cp_y),ratio = intr[pn])
      dev.off(which= a)
    }
    list_files <- list.files(paste0(tmp_dir,"/"), pattern = "[0-9]+_snap.png", full.names = TRUE)
    inx <- gsub("[^0-9]", "", list_files) %>% as.numeric() %>% order()
    files <- list_files[inx]
    magick::image_read(files) %>%
    magick::image_write_gif(path = paste0(getwd(),"/output.gif"))
    unlink(tmp_dir)
  }


