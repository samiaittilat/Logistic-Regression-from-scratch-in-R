#' Fit model to train data
#'
#' Logistic regression on train data (classication)
#'
#' Function that trains your model via gradient descent and outputs the model
#' weights. This function comes with a bunch of parameters.
#'
#' @param formule an object of class "formula" (or one that can be coerced to that class):
#' a symbolic description of the model to be fitted. The details of model specification
#' are given under ‘Details’
#' @param data a dataframe containing the variables in the model.
#' @param mode  parameter is the way you feed your data to the model
#' ( online, mini-batch or batch). The mode is set to mini-batch by default.
#' @param batch_size the batch size when mode is mini-batch
#' @param alpha the learning rate in gradient descent
#' @param max_iter maximum number of iteration
#' @param tol tolerance for accepting a model :
#' @param ncores indicates the number of cores to use; if invalid (<= 0 or> number of cores available), the
#' maximum capacities of the host machine are used
#' @param parallel logical.Should we use parallel computing ? specifies whether you want to
#' perform a parallel or a sequential computing. The default value
#' is set to False ( meaning it's sequential). Note that parallel
#' computing is not performed in the case of online gradient descent.
#' @param plot logical. Should we plot the cost function while iterating ?
#' @param lambda parameter is set to zero by default if no regularization
#' is applied to the model. You may want to modify this value if your model is overfitting.
#' @param beta beta parameter which takes only two values
#' (beta = 1 by default: ridge regularization case) beta = 0 lasso case
#'
#' @author Marie Vachet, Afaf Ben Haj, Sami Ait Tilat
#'
#' @import modelr stats
#'
#' @return An object S3 of class Reg.Log
#' md$coeffs : Coefficients ( model weights)
#' md$nb_iter: Number of epochs
#' md$cost: cost function values at each epoch
#' md$mean_col= mean value of each feature
#' md$sd: Standard deviation value of each feature
#'
#' @export
#'
#' @examples
#' \dontrun{
#' modele = fit_grad(formule = y~., data=nos_data,max_iter = 300, mode='batch', parallel = TRUE )
#' }

fit<-function(formule, data, mode="mini_batch",batch_size=32,alpha=0.01,max_iter=500, tol=0.001,ncores=NA, parallel=FALSE, plot=FALSE,lambda=0,beta=1){

  #Preprocessing of the dataframe
  data_train=as.data.frame(lapply(data_train,process_na))
  nLignes = nrow(data_train)

  if ((batch_size <= 0) || (batch_size > nLignes)) {
    stop("batch_size must be greater than zero and less than the number of observations")
  }

  if (max_iter < 1) {
    stop("Maximum iteration must be greater than 0")
  }

  if (tol <= 0) {
    stop("Tolerance must be greater than 0 (tol)")
  }
  if (mode=='online' || mode=='mini-batch' ){
    stop("Cannot parallelize online and mini-batch gradient descent")
  }
  #Standardization of the features and storing the mean and standard deviation of each feature
  X_temp =  model_matrix(formula=formule,data=data_train)
  X_temp= X_temp[,2:ncol(X_temp)]
  mean_col = colMeans(X_temp)
  sd_col = apply(X_temp, 2, sd)
  X_norm <- matrix(unlist(apply(X_temp,2, scale_fonct)),ncol= ncol(X_temp))

  # Handle the intercept

  X <- cbind(1, X_norm)
  colnames(X) = c('Intercept',colnames(X_temp))

  #Creating Y factor and storing its labels
  Y=factor(model.frame(formule,data_train)[,1])
  labels=levels(Y)
  levels(Y)=c(0,1)
  labels_eq=cbind(labels,levels(Y))

  # Initialization
  nb_coef = ncol(X)
  set.seed(200)
  coef <- as.matrix(runif(nb_coef))
  oldCoef <- as.matrix(runif(nb_coef))
  iter = 0
  converge <- FALSE
  epoch = 0
  cost = c()

  # Shuffle our data
  set.seed(5)
  X= X[sample(1:nLignes, nLignes),]
  set.seed(5)
  Y=Y[sample(1:nLignes,nLignes)]

  if (plot==TRUE){
    plot(1 ,type="n", axes = TRUE, xlim=c(0,100),ylim=c(0,1), xlab = "iterations",
         ylab = "cost", main = "Cost function")
  }

  #Sequential gradient descent

  if (parallel==FALSE){

    if (mode=='online'){
      batch_size=1
    } else if (mode=='batch'){
      batch_size=nLignes
    }

    while ((epoch < max_iter) && (converge == FALSE)){
      iter=iter+batch_size
      iternew=iter-batch_size
      if(iter>nLignes){
        iter=nLignes
      }
      X_mini <- as.matrix(X[(iternew+1):(iter),])
      y_mini <- as.vector(as.character(Y[(iternew+1):(iter)]), mode= "integer")

      # Handle the error " Arguments uncomfortable" encountered in the Matrix products below

      if(is.null(dim(X_mini)) || dim(X_mini)[2]==1 ){
        X_mini=t(X_mini)
      }

      y_pred=sigmoid(X_mini %*% coef)

      # lambda=0 ( no regularization) /////   beta=1 (Ridge)/////// beta= 0 ( Lasso)

      gradient = (t(X_mini) %*% (y_pred-y_mini)+beta*lambda*coef)/(batch_size)
      condition <- ifelse(beta==1,TRUE,FALSE)

      # update the coef according to the value of beta

      coef <-switch(2-condition, coef-alpha*gradient, proximent((coef-alpha*gradient),alpha*lambda))

      if (iter%%nLignes==0){
        epoch = epoch + 1

        # We add 0.01 to avoid getting Inf values that comes from small values of variables inside the log function

        cout= 1/(batch_size)*(-sum((y_mini*log(y_pred+0.01)) + ((1-y_mini)*log(1-y_pred+0.01)))+lambda*(beta*0.5*sum(coef^(2))+(1-beta)*sum(abs(coef))))

        cost = c(cost, cout)
        if (plot==TRUE){
          fig(epoch,couts = cost, cout=cout)
        }
        if (sum(abs(coef-oldCoef)) < tol) {
          converge <- TRUE
        }
        if ((epoch==max_iter) && (converge==FALSE)){
          break('Max iterations reached and did not converge: Try increase the number of iterations')
        }
        oldCoef <- coef
        iter=0
      }
    }
  }

  #Parallel gradient descent
  else{
    if (mode=='batch'){
      batch_size=nLignes
    }

    # number of threads used
    nbcoeurs = detectCores(logical = TRUE)
    if ((ncores<= 0) || (ncores>nbcoeurs) || (is.na(ncores))){
      ncores = nbcoeurs -1
    }

    cl1 <- makeCluster(ncores)

    while ((epoch < max_iter) && (converge == FALSE)){
      iter=iter+batch_size
      iternew=iter-batch_size
      if(iter>nLignes){
        iter=nLignes
      }
      X_mini <- as.matrix(X[(iternew+1):(iter),])
      y_mini <- as.vector(as.character(Y[(iternew+1):(iter)]), mode= "integer")

      # Handle the error " Arguments uncomfortable" encountered in the Matrix products below

      if(is.null(dim(X_mini)) || dim(X_mini)[2]==1 ){
        X_mini=t(X_mini)
      }

      y_pred=sigmoid(matprod.par(cl1,X_mini,coef))

      # lambda=0 ( no regularization) /////   beta=1 (Ridge)/////// beta= 0 ( Lasso)
      gradient= matprod.par(cl1,t(X_mini),(y_pred-y_mini))/(batch_size) + beta*lambda*coef/(batch_size)

      condition <- ifelse(beta==1,TRUE,FALSE)

      # update the coef according to the value of beta

      coef <-switch(2-condition, coef-alpha*gradient, proximent((coef-alpha*gradient),alpha*lambda))

      if (iter%%nLignes==0){
        epoch = epoch + 1

        # We add 0.01 to avoid getting Inf values that comes from small values of variables inside the log function

        cout= 1/(batch_size)*(-sum((y_mini*log(y_pred+0.01)) + ((1-y_mini)*log(1-y_pred+0.01)))+lambda*(beta*0.5*sum(coef^(2))+(1-beta)*sum(abs(coef))))

        cost = c(cost, cout)
        if (plot==TRUE){
          fig(epoch,couts = cost, cout=cout)
        }
        if (sum(abs(coef-oldCoef)) < tol) {
          converge <- TRUE
        }
        if ((epoch==max_iter) && (converge==FALSE)){
          break('Max iterations reached and did not converge: Try increase the number of iterations')
        }
        oldCoef <- coef
        iter=0
      }
    }
    stopCluster(cl1)
  }

  objet = list(coeffs = coef,nb_iter = epoch,labels=labels_eq,cost_function=cost,mean_col= mean_col, sd_col = sd_col)
  class(objet) = "Reg.Log"
  return(objet)
}
