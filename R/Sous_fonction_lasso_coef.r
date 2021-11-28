#' Lasso subfunctions to calculate the coefficients
#'
#' Functions for lasso regularization to calculate the coefficients
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
#' coef_alpha(coef,alpha)
#' }
# returns alpha (if coef > alpha ) or - alpha ( if coef < (-alpha) ) or coef ( if coef between alpha et -alpha )
coef_alpha = function(coef,alpha){
  value=min(coef,alpha)
  value=max(value,-alpha)
  return(value)
}

