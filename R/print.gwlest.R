#' Printing gwlest objects
#'
#' @param x an object of class \code{gwlest}
#' @param ... ellipsis for S3 method compatibility
#'
#' @return this function print key elements of a \code{gwlest} object
#' @export
#'
#' @examples
#' 
#' predictors <- matrix(data = rnorm(2500), 50,50)
#' y_value <- sample(1:1000, 50)
#' coords <- data.frame("Lat" = rnorm(50), "Long" = rnorm(50))
#' distance_matrix <- compute_distance_matrix(coords)
#' 
#' \donttest{
#' myst.est <- gwl_bw_estimation(x.var = predictors, 
#'                               y.var = y_value,
#'                               dist.mat = distance_matrix,
#'                               adaptive = TRUE,
#'                               adptbwd.thresh = 0.5,
#'                               kernel = "bisquare",
#'                               alpha = 1,
#'                               progress = TRUE,
#'                               n=10,
#'                               nfolds = 5)
#'   
#' myst.est
#'  } 
#' 

print.gwlest <- function(x, ...){
  cat("Optimalbw : ", x$bw, "\n")
  cat("kernel : ", x$kernel, "\n")
  cat("adaptive : ", x$adaptive, "\n")
}