#' NA processing
#'
#' Replace NA from a dataframe column
#'
#' The numeric features are replaced by the mean.
#'
#' @param x a dataframe column
#'
#' @author  Sami Ait Tilat, Afaf Ben Haj, Marie Vachet
#'
#' @examples
#' \dontrun{
#' data(airquality)
#' process_na(airquality$Ozone)
#' }
process_na <- function(x){
  y <- na.omit(x)
  #No missing value
  if (length(y) == length(x)){
    return(x)
  } else {
    print("NA detected and replaced, for more information look at process_na function")
    if (is.factor(y) == T){
      stop("NA founded in target value")
    } else {
      print("pas factor")
      moyenne <- mean(y)
      z <- x
      z[is.na(z)] <- moyenne
      return(z)
    }
  }
}
