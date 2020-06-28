#' Parseing svg file
#'
#' @param path the path for the SVG file.
#'
#' @return dataframe of the parsed SVG file
#'
#'
#' @examples
#' @export
#'
#'
#' @import magrittr
#' @import rvest
#' @importFrom  dplyr filter
#' @importFrom jsonlite fromJSON
#' @importFrom xml2 read_xml xml_children xml_attr
#'
parsed_svg <- function(path) {
  if(!file.exists(system.file("node/node_modules", package = "bezieR"))){
  install_parser()
  }
  obj_svg <-xml2::read_xml(path)
  svgs <- obj_svg %>% xml2::xml_children() %>% xml2::xml_children() %>% xml2::xml_attr("d")
  df <- data.frame(code = character(0),
                   command = character(0),
                   x = numeric(0),
                   y = numeric(0),
                   x0 = numeric(0),
                   y0 = numeric(0),
                   relative = logical(0),
                   x1 = numeric(0),
                   y1 = numeric(0),
                   x2 = numeric(0),
                   y2 = numeric(0))
  for(i in 2:length(svgs)){
    #node_call = paste0("node -e \"const {parseSVG, makeAbsolute} = require('./inst/node/node_modules/svg-path-parser'); var d='", svgs[i],
     #                  "'; console.log(JSON.stringify(makeAbsolute(parseSVG(d))));\"")
    #tmp_df <- system(node_call, intern = T) %>% jsonlite::fromJSON()
    tmp_df <- rparse_svg(svgs[i]) %>% jsonlite::fromJSON()
    df <- rbind(df,tmp_df)
  }
  df[is.na.data.frame(df)] <- 0
  df  <- df %>% filter(code== "C")
  df_xy <- df[,grep(pattern = '^[xy].*',value = TRUE,x =colnames(df) ,perl = TRUE)]
  return(df_xy)
}
