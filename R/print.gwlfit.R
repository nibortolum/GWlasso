#' Printing gwlfit objects
#'
#' @param x a `gwlfit` object
#' @param ... ellipsis for S3 method compatibility
#'
#' @return this function print key elements of a \code{gwlfit} object
#' @export
#'
#' @examples
#' predictors <- matrix(data = rnorm(2500), 50,50)
#' y_value <- sample(1:1000, 50)
#' coords <- data.frame("Lat" = rnorm(50), "Long" = rnorm(50))
#' distance_matrix <- compute_distance_matrix(coords)
#' 
#' my.gwl.fit <- gwl_fit(bw = 20,
#'                       x.var = predictors, 
#'                       y.var = y_value,
#'                       kernel = "bisquare",
#'                       dist.mat = distance_matrix, 
#'                       alpha = 1, 
#'                       adaptive = TRUE, 
#'                       progress = TRUE,
#'                       nfolds = 5)
#' 
#' my.gwl.fit
#' 
#'
print.gwlfit <- function(x, ...) {
  cat("Bandwidth :" , x$bw, "\n")
  cat("adaptive :" , x$adaptive, "\n")
  cat("Number of models :" , length(x$models), "\n")
  cat("RMSPE : ", x$rmspe, "\n")
  cat("Number of predictors :" , length(x$cols), "\n")
}