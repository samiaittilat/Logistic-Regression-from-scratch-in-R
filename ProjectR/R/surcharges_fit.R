#' print and summary
#'
#' print and summary overloaded
#'
#' Generic methods print and summary overloaded
#'
#' @param object Obj Reg Log is an S3 object provided by the fit Function.
#'
#' @author Sami Ait Tilat, Afaf Ben Haj, Marie Vachet
#'
#' @examples
#' \dontrun{
#' data(ionosphere)
#' model=fit(y~., data = iono_train,max_iter = 200, batch_size=100)
#' print(model)
#' summary(model)
#' }


#surcharge de print
print.Reg.Log <- function(object){
  #affichage de la liste des variables
  cat("Variables : ", colnames(object$X),"\n")
  #affichage de la liste de la variable cible
  cat("Modalites de la variable cible : ", object$labels,"\n")
}

#surcharge de summary
#approche simplifiee avec utilisation de print()
summary.Reg.Log <- function(object){
  #affichage de la liste des coefficients
  cat("Les coefficients sont : ", object$coeffs,"\n")
  #affichage du nombre d'iterations
  cat("Le nombre d'iterations : ",object$nb_iter)
  # affichage de la fonction cout :
  cat("La fonction cout : ",object$cout)
}
