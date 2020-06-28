#' This function analyzes and animate svg files.
#'
#' @param svg_path the path for the svg file
#'
#' @return
#' @export
#'
#' @examples
animate_svg <- function(svg_path, des_path) {
  intr <- seq(0,1,0.01) # t value
  df_xy <- parsed_svg(svg_path)
  analyze_svg(svg_path)
  recursive <- make_recursive()
  tmp_dir <- tempdir()

  for (pn in 1:length(intr)) {
    a<-dev.copy(png, file =paste0(tmp_dir,"/",pn,"_snap.png"))

    for (i in 1:dim(df_xy)[1]){
      recursive(xylist = list(x = c(df_xy$x0[i],df_xy$x1[i],df_xy$x2[i],df_xy$x[i]), y = c(df_xy$y0[i],df_xy$y1[i],df_xy$y2[i],df_xy$y[i])),ratio = intr[pn])
    }
    dev.off(which= a)
  }
  list_files <- list.files(paste0(tmp_dir,"/"), pattern = "[0-9]+_snap.png", full.names = TRUE)
  inx <- gsub("[^0-9]", "", list_files) %>% as.numeric() %>% order()
  files <- list_files[inx]
  magick::image_read(files) %>%
  magick::image_write_gif(path = paste0(des_path,"/output.gif"))
  #system("rm *_snap.png")
  unlink(tmp_dir)
}
