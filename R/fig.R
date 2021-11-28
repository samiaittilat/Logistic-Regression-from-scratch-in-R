#' Plot function
#'
#' Plot the cost function
#'
#' Plotting the cost function every 10 iterations
#'
#' @param iter number of iterations
#' @param couts a vector with all points of cost function
#' @param cout new point of cost function
#'
#' @author Sami Ait Tilat, Afaf Ben Haj, Marie Vachet
#' @examples
#' \dontrun{
#' fig(5,seq(1:5), 6)
#' }

fig <- function(iter,couts, cout){
  if (iter%%100==0) {
    plot(x=1:iter, y=couts, xlab = "Iteration", ylab = "Fonction de cout",
         main = "Evolution fonction de cout", type="b", xlim=c(1,100+iter), ylim=c(0,max(couts)))
  }
  if (iter%%10==0) {
    plot(x=1:iter, y=couts, xlab = "Iteration", ylab = "Fonction de cout",
         main = "Evolution fonction de cout", type="b", xlim=c(1,iter), ylim=c(0,max(couts)))
  }
}
