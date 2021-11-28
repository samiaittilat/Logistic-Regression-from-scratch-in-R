#' Predict summary
#'
#' Display of prediction performance
#'
#' Display of a report of prediction performance, confusion matrix
#'
#' @param pred predition
#' @param yreel real distribution
#'
#' @author Sami Ait Tilat, Afaf Ben Haj, Marie Vachet
#'
#' @examples

predict.summary<-function(pred,yreel){
  print(pred$pred_final)
  xTab=table(pred$pred_final, yreel)
  clss <- as.character(sort(unique(pred$pred_final)))
  r <- matrix(NA, ncol = 7, nrow = 1,
              dimnames = list(c(),c('Acc',
                                    paste("Precision",clss[1],sep='_'),
                                    paste("Recall",clss[1],sep='_'),
                                    paste("F-score",clss[1],sep='_'),
                                    paste("Precision",clss[2],sep='_'),
                                    paste("Recall",clss[2],sep='_'),
                                    paste("F-score",clss[2],sep='_'))))
  r[1,1] <- sum(xTab[1,1],xTab[2,2])/sum(xTab) # Accuracy
  r[1,2] <- xTab[1,1]/sum(xTab[,1]) # Miss Precision
  r[1,3] <- xTab[1,1]/sum(xTab[1,]) # Miss Recall
  r[1,4] <- (2*r[1,2]*r[1,3])/sum(r[1,2],r[1,3]) # Miss Fscore
  r[1,5] <- xTab[2,2]/sum(xTab[,2]) # Hit Precision
  r[1,6] <- xTab[2,2]/sum(xTab[2,]) # Hit Recall
  r[1,7] <- (2*r[1,5]*r[1,6])/sum(r[1,5],r[1,6]) # Hit F score

  objet=list()
  objet$class_report= r
  objet$cf_matrix=xTab
  class(objet)='report'
  return(objet)
}

