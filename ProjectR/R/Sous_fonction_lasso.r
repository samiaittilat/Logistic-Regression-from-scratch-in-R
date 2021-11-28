#' Lasso subfunctions
#'
#' Functions for lasso regularization
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
#' proximent(coef,alpha)
#' }

# returns alpha (if coef > alpha ) or - alpha ( if coef < (-alpha) ) or coef ( if coef between alpha et -alpha )

coef_alpha = function(coef,alpha){
  value=min(coef,alpha)
  value=max(value,-alpha)
  return(value)
}

# proximent calculation

proximent<-function(coef,alpha){
  prx=coef-coef_alpha(coef,alpha)
  prx[0]=coef[0]
  return(prx)
}
