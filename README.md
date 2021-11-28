# Logistic-Regression-from-scratch-in-R
The aim of the Rgrad package is to implement a binary logistic regression model from scratch using different variants of gradient descent ( batch, mini-batch, stochastic). With the help of this package, you can fit a logistic regression model to your dataset, make predictions  and evaluate the performance of your model. It is also possible to apply different regularizations( Ridge L2, Lasso L1) for better predictions.  
To process large datasets, the batch and mini-batch gradient descents are computed using parallel processing. The dataset you feed to the model is partionned into smaller data sets over CPU cores and processed simultaneously. The results are then communicated between the threads.
In this demonstration, we'll walk you through a few steps to help you use the Rgrad package efficiently.

# Package Installation

# install devtools library if needed
install.packages("devtools")
library(devtools)

# Install RegLog package from Github
devtools::install_github("mettre le lien du dossier/Rgrad")

# load package
library(Reglog)

# Functions provided by the Rgrad package

Now that you have everything settled, import your dataset and make sure that you store it into a dataframe. You may want to split your dataset into a training and a test dataset and start using Rgrad functions. 
Note that there is no need to standardize your dataset as the package takes care of this step.


# Fit function 
The package comes with a fit_grad function that trains your model via gradient descent and outputs the model weights. This function comes with a bunch of parameters. 
The mode parameter is the way you feed your data to the model ( online, mini-batch or batch). The mode is set to mini-batch by default.

#The Parallel parameter: specifies whether you want to perform a parallel or a sequential computing. The default value is set to False ( meaning it's sequential). Note that parallel computing is not performed in the case of online gradient descent.

The lambda parameter is set to zero by default if no regularization is applied to the model. You may want to modify this value if your model is overfitting.

You can access the function detailed description by typing this line of code : help(fit_grad)

Now that you have a clear idea about fit_grad parameters options, try to instantiate your model "md" using this example :
Here's an example on how you can use the fit_grad function ( Stochastic Gradient Descent)

The fit_grad function returns an object called"md" in this example that contains these values:
md$coeffs : Coefficients ( model weights)
md$nb_iter: Number of epochs 
md$cost: cost function values at each epoch
md$mean_col= mean value of each feature
md$sd: Standard deviation value of each feature

You can also use summary (fit_grad object) function  to display all the outputs listed above

The function provides a plot that shows the decreasing of the loss function with respect to each epoch. 

Prediction function 
Congratulations ! Your model is trained and it's time to make predictions. The predict function is quite simple and requires only 3 parameters. 
You need to specify the fit output object, the test set and the type of predictions. The type parameter is set to "class" by default which means that the function returns the categories or the classes of predictions. In case you want to display probabilities of belonging to a category, then you would go with the type "posterior"
Again, you don't need to standardize or scale your test set. Just make sure that your test set is a dataframe.
 

You can evaluate the performance of your model by using the summary(predict object)
