#' summary overloaded
#'
#' summary of Reg.Log overloaded
#'
#' Generic methods print and summary overloaded
#'
#' @param object Obj Reg Log is an S3 object provided by the fit Function.
#' @param ... other param
#' @author Sami Ait Tilat, Afaf Ben Haj, Marie Vachet
#'
#' @import utils
#'
#' @examples
#' \dontrun{
#' data(ionosphere)
#' model=fit(y~., data = iono_train,max_iter = 200, batch_size=100)
#' print(model)
#' summary(model)
#' }
#' @export
#surcharge de summary
#approche simplifiee avec utilisation de print()
summary.Reg.Log <- function(object,...){
  #affichage de la liste des coefficients
  cat("Les coefficients sont : ", object$coeffs,"\n")
  #affichage du nombre d'iterations
  cat("Le nombre d'iterations : ",object$nb_iter,"\n")
  # affichage de la fonction cout :
  cat("5 premieres valeurs de la fonction cout : ",head(object$cost_function,5),"\n")
  cat("5 dernieres valeurs de la fonction cout : ",tail(object$cost_function,5),"\n")
}
