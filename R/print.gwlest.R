
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
#' 

print.gwlest <- function(x, ...){
  cat("Optimalbw : ", x$bw, "\n")
  cat("kernel : ", x$kernel, "\n")
  cat("RMSE : ", x$rmse, "\n")
}