#' print overloaded
#'
#' print overloaded
#'
#' Generic methods print and summary overloaded
#'
#' @param x Obj Reg Log is an S3 object provided by the fit Function.
#' @param ... Other parameters
#'
#' @author Sami Ait Tilat, Afaf Ben Haj, Marie Vachet
#'
#' @import utils
#'
#' @examples
#' \dontrun{
#' data(ionosphere)
#' model=fit(y~., data = iono_train,max_iter = 200, batch_size=100)
#' print(model)
#' }
#' @export
#surcharge de print
print.Reg.Log <- function(x,...){
  #affichage de la liste des variables
  cat("Variables : ", colnames(x$X),"\n")
  #affichage de la liste de la variable cible
  cat("Modalites de la variable cible : ", x$labels,"\n")
}
