# Logistic Regression from Scratch in R

### _Batch / Mini-Batch/ Stochastic Gradient Descent_

The aim of the Rgrad package is to implement a binary logistic regression model from scratch using different variants of gradient descent ( batch, mini-batch, stochastic). With the help of this package, you can fit a logistic regression model to your dataset, make predictions and evaluate the performance of your model. It is also possible to apply different regularizations( Ridge L2, Lasso L1) for better predictions.

To process large datasets, the batch and mini-batch gradient descents are computed using parallel processing. 
The dataset you feed to the model is partionned into smaller data sets over CPU cores and processed simultaneously. The results are then communicated between the threads. 

In this demonstration, we'll walk you through a few steps to help you use the Rgrad package efficiently.


## Package Installation

#### - install devtools library if needed
#

```sh
install.packages("devtools") 

library(devtools)
```
#### -Install RegLog package from Github
#

```sh
devtools::install_github("mettre le lien du dossier/Rgrad")
```

#### -Load the RegLog package
#

```sh
library(Rgrad)
```
