#' Sigmoid function
#'
#' calculate the sigmoid function
#'
#' It represents the x value in the distribution function of the logistic law.
#'
#' @param x numeric value
#'
#' @author Sami Ait Tilat, Afaf Ben Haj, Marie Vachet
#'
#' @examples
#' \dontrun{
#' sigmoid(15)
#' }


sigmoid<-function(x){
  g<-1/(1+exp(-x))
  return(g)
}
