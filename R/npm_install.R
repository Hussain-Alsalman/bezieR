#' install_parser
#'
#' @param force
#'
#' @return
#'
#' @examples
#'
#' @importFrom yesno yesno
#' @importFrom processx run
install_parser <- function(force = FALSE) {
  if(!force) {
    ok <- yesno::yesno("Using this function will require to install an app from node, is it ok?")
  }else{
    ok <- TRUE
  }
  if(ok){
    processx::run(
      command = "npm",
      args= c("install"),
      wd = system.file("node",package = "bezieR")
  )}
}
