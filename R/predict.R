#' Predict function
#'
#' The predictions of the model
#'
#' Make predictions and evaluate the performance of the model
#'
#' @param regLog Obj. Reg.Log ”is an S3 object provided by the fit (.) Function.
#' @param newdata are the data to be processed
#' @param type indicates the type of prediction {"class", "posterior"}
#' (predicted class or probability belonging to the classes)
#'
#' @author Sami Ait Tilat, Afaf Ben Haj, Marie Vachet
#'
#' @export
#'
#' @examples
#' \dontrun{
#' data(ionosphere)
#' pred=predict(modele, iono_test)
#' }

predict <- function(regLog,newdata,type="class"){
  if ((class(regLog))!= "Reg.Log"){
    stop("param regLog must be a regLog object")
  }

  else if ((length(regLog$coeffs))!=ncol(newdata)+1) {
    stop("different number of columns between newdata and regLog coefficients")
  }
  else {
    coefs = regLog$coeffs
    labels_equi=regLog$labels

    X_stand= t((t(newdata) - regLog$mean_col) / regLog$sd_col)
    X_stand=as.matrix(cbind(1,X_stand))

    pred= sigmoid(X_stand %*% coefs)
    pred_final = ifelse(pred>0.5,1,0)
    label_pred=ifelse(pred_final==regLog$labels[1,2],regLog$labels[1,1],regLog$labels[2,1])

  }

  objet=list()
  if (type=="class") {
    objet$pred_final = pred_final

  } else if (type=="posterior"){
    objet$pred_post = pred
  }


  objet$labels= label_pred
  objet$pred=pred
  class(objet)='pred'
  return(objet)
}
