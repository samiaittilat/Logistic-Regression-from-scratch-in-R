#' Standardization
#'
#' Standardize data
#'
#' For each values in x, subtract x with the mean and divide by the standard deviation
#'
#' @param x a dataframe column
#'
#' @author Sami Ait Tilat, Afaf Ben Haj, Marie Vachet
#'
#' @examples
#' \dontrun{
#' data(airquality)
#' scale_fonct(airquality$Temp)
#' }

scale_fonct <- function(x) {
  return((x-mean(x))/sqrt(var(x)))
}
