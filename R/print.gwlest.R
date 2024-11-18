
#' Printing GWL objects
#'
#' @param x an object of class \code{gwlest}
#' @param ... ellipsis for S3 method compatibility
#'
#' @return this function print key elements of a \code{gwlest} object
#' @export
#'
#' @examples
#' 
#' #' predictors <- matrix(data = rnorm(20000), 200,100)
#' y_value <- sample(1:1000, 200)
#' coords <- data.frame("Lat" = rnorm(200), "Long" = rnorm(200))
#' distance_matrix <- compute_distance_matrix(coords)
#' 
#' if(interactive()){
#'   myst.est <- gwl_bw_estimation(x.var = predictors, 
#'                                 y.var = y_value,
#'                                 dist.mat = distance_matrix,
#'                                 adaptive = TRUE,
#'                                 adptbwd.thresh = 0.1,
#'                                 kernel = "bisquare",
#'                                 alpha = 1,
#'                                 progress = TRUE,
#'                                 n=10,
#'                                 nfolds = 5)
#'   
#'   
#'   myst.est
#'   
#' }

#' 

print.gwlest <- function(x, ...){
  cat("Optimalbw : ", x$bw, "\n")
  cat("kernel : ", x$kernel, "\n")
}