#' Parallel calculation
#'
#' Matrix calculation parallel execution
#'
#' The idea is that we will distribute the rows of a matrix A for example
#' on the cores and we will make the matrix product of each group of
#' rows with another matrix B
#'
#' @param cl integer, number of cluster
#' @param A Matrix
#' @param B Matrix
#'
#' @import parallel
#'
#' @author Sami Ait Tilat, Afaf Ben Haj, Marie Vachet
#'
#' @examples
#' \dontrun{
#' ncores=8
#' cl <- makeCluster(ncores)
#' A <- matrix(round(rnorm(16^2),1),16)
#' B <- t(A)+4
#' matprod.par(cl,A,B)
#' }
matprod.par <- function(cl, A, B){
  # Produit matriciel distribue sur ncores
  if (ncol(A) != nrow(B)) stop("Matrix are not conform")
  idx <- splitIndices(nrow(A), length(cl)) #  partitionne la matrice en lignes et distribue sur les noeuds
  Alist <- lapply(idx, function(ii) A[ii,,drop=FALSE])
  ans <- clusterApply(cl, Alist, get("%*%"), B)
  do.call(rbind, ans)
}
