# Logistic Regression from Scratch in R
### _Batch / Mini-Batch/ Stochastic Gradient Descent_

 The aim of the Rgrad package is to implement a binary logistic regression model from scratch using different variants of gradient descent ( batch, mini-batch, stochastic). With the help of this package, you can fit a logistic regression model to your dataset, make predictions and evaluate the performance of your model. It is also possible to apply different regularizations( Ridge L2, Lasso L1) for better predictions.

To process large datasets, the batch and mini-batch gradient descents are computed using parallel processing. 
The dataset you feed to the model is partionned into smaller data sets over CPU cores and processed simultaneously. The results are then communicated between the threads. 

In this demonstration, we'll walk you through a few steps to help you use the Rgrad package efficiently.


## Package Installation

###### - **`install devtools library if needed`**
#

```sh
install.packages("devtools") 

library(devtools)
```
###### -**`Install RegLog package from Github`**
#

```sh
devtools::install_github("mettre le lien du dossier/Rgrad")
```

###### -**`Load the Rgrad package`**
#

```sh
library(Rgrad)
```

## Functions provided by the Rgrad package

Now that you have everything settled, import your dataset and make sure that you store it into a dataframe.
You may want to split your dataset into a training and a test dataset and start using Rgrad functions.
**Note that there is no need to standardize your dataset as the package takes care of this step.**

#### - **`Fit function` **

The package comes with a fit function that trains your model via gradient descent and outputs the model weights. This function comes with a bunch of parameters: 

- **_`The mode parameter`_** : is the way you feed your data to the model ( online, mini-batch or batch). The mode is set to mini-batch by default. 
- **_`The Parallel parameter`_** : specifies whether you want to perform a parallel or a sequential computing. The default value is set to False ( meaning it's sequential). Note that parallel computing is not performed in the case of online gradient descent. 
- **_`The lambda parameter`_** : is set to zero by default if no regularization is applied to the model. You may want to modify this value if your model is overfitting.

You can access the function detailed description by typing this line of code : **_`help(fit)`_**
Now that you have a clear idea about _fit function_ parameters options, try to instantiate your model "md" using this example :
<p align="center">
  <img src="‪C:\Users\Sami\OneDrive\Bureau\loss function.PNG" width="350" title="hover text">
  <img src="C:\Users\Sami\OneDrive\Bureau\loss function.PNG" width="350" alt="accessibility text">
</p>

Here's an example on how you can use the fit function ( Stochastic Gradient Descent)
 
The fit_grad function returns an object called "md" in this example that contains these values:
- _`md$coeffs`_ : Coefficients ( model weights)
- `md$nb_iter`: Number of epochs 
- `md$cost`: cost function values at each epoch
- `md$mean_col`: mean value of each feature
- `md$sd`: Standard deviation value of each feature

You can also use _`summary (fit)`_ function  to display all the outputs listed above

The function provides a plot that shows the decreasing of the loss function with respect to each epoch. 

#### - **`Predict function`** 

Congratulations ! Your model is trained and it's time to make predictions. 
The predict function is quite simple and requires only 3 parameters. 
You need to specify the _`fit output object`_, _`the test set`_ and the _`type of predictions`_. The type parameter is set to _"class"_ by default which means that the function returns the categories or the classes of predictions. In case you want to display probabilities of belonging to a category, then you would go with the type _"posterior"_
Again, you don't need to standardize or scale your test set. Just make sure that your test set is a dataframe.
