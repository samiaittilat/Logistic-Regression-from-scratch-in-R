#' Lasso subfunctions proximent calculation
#'
#' Functions for lasso regularization proximent calculation
#'
#' Contains 2 essential functions for the computation of the gradient proximent.
#' We call on these two functions inside the fit to calculate the coefficients
#'
#' @param coef coefficient
#' @param alpha parameter
#'
#' @author Sami Ait Tilat, Afaf Ben Haj, Marie Vachet
#'
#' @examples
#' \dontrun{
#' proximent(coef,alpha)
#' }
# proximent calculation
proximent<-function(coef,alpha){
  prx=coef-coef_alpha(coef,alpha)
  prx[0]=coef[0]
  return(prx)
}
