#This function is to make terms given a vector of controlled points for specific axis
#' This function creates the basis equation for the bezier curves for any order
#'
#' @param n the order of the basis equation
#' @param cp the coefficients
#'
#' @return
#' @export
#'
#' @examples
make_terms <- function (n,cp) {
  # Pascal trinagle
  # this is a pre-calculated terms for optmization purposes to reducing the factorial operation
  lut <- list(c(1), # n : 0
              c(1,1), # n : 1
              c(1,2,1), # n : 2
              c(1,3,3,1), # n : 3
              c(1,4,6,4,1), # n : 4
              c(1,5,10,10,5,1), # n : 5
              c(1,6,15,20,15,6,1)) # n : 6
  try(
    if(missing(cp) || length(cp)!= n )
    {
      stop(paset0("you must provide number of terms with their control points coordinates"))
    }
  )
  if(n > 6) lut[[n]] <- choose(n-1,0:(n-1))

  trms <- rep(NA, n)
  for (i in 1:n) {
    trms[i] <- paste0(cp[i],"*",lut[[n]][i],"*","(1-u)^",(n-i), "*u^",i-1," ")
  }
  eq_str <- paste0(trms,collapse = "+")

  function(u,equation = eq_str){
    if(!missing(u)){
      expr <- str2lang(eq_str)
      eval(expr)
    } else {
      print(equation)
    }
  }
}
