#' Printing GWL objects
#'
#' @param x a gwlfit object
#' @param ... ellipsis for S3 method compatibility
#'
#' @return this function print key elements of a \code{gwlfit} object
#' @export
#'
#' @examples
print.gwlfit <- function(x, ...) {
  cat("Bandwidth :" , x$bw, "\n")
  cat("adaptive :" , x$adaptive, "\n")
  cat("Number of models :" , length(x$models), "\n")
  cat("RMSPE : ", x$rmspe, "\n")
  cat("Number of predictors :" , length(x$cols), "\n")
}