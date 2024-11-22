#' Compute distance matrix
#' 
#' `compute_distance_matrix()` is a small helper function to help you compute a distance matrix.
#' For the geographically method to work, is is important that distances between points are not zero. This function allows to add a small random noise to avoid zero distances.
#'
#' @param data A dataframe or matrix containing at least two numerical columns.
#' @param method method to compute the distance matrix. Ultimately passed to [stats::dist()]. Can be `euclidean`, `maximum`, `manhattan`, `canberra`, `binary` or `minkowski`.
#' @param add.noise TRUE/FALSE set to TRUE to add a small noise to the distance matrix. Noise \eqn{U} is generated as \eqn{ U \sim (1\times 10^{-6}, 5\times 10^{-6})}. 
#' Noise is added only for pairs for which distance is zero.
#'
#' @return a distance matrix, usable in [gwl_bw_estimation()]
#' @export
#'
#' @examples 
#' coords <- data.frame("Lat" = rnorm(200), "Long" = rnorm(200))
#' distance_matrix <- compute_distance_matrix(coords)
#'
compute_distance_matrix <- function(data, method = "euclidean", add.noise = FALSE) {
  # coerce to matrix
  if(!(is.data.frame(data) | is.matrix(data))) {
    stop("Data must be either a dataframe or a matrix")
  }

  if(is.data.frame(data)) {
    non_numeric <- apply(data, 2, is.numeric)
    if(sum(!non_numeric) >0) {
      stop("Column(s) ", paste(which(!non_numeric), collapse = ", "), " are not numeric")
    }
  }

  coords <- as.matrix(data)

  # calculate the geographical distances, both methods are equivalent, we prefer the 2nd for homogeneity with the bioclim matrix
  # dist_gw <- gw.dist(dp.locat = coords, focus = 0)
  geo.mat <- as.matrix(stats::dist(coords, method = method))

  zeroes <- sum(round(geo.mat, 6) == 0)

  if(zeroes > nrow(data) & !add.noise) {
    warning("The distance matrix has ",(zeroes-nrow(data))/2, " values set to 0. Consider using add.noise = TRUE to avoid that.\n",
            "Geographically Weighted methods require distances not to be zero")
  }

  # add a very small noise to the distances that are not on the diagonal and that are = 0
  if(add.noise){
    n <- 1:nrow(geo.mat)

    for (i in n) {
      for (j in 1:i) {
        if (i != j && geo.mat[i, j] == 0) {
          geo.mat[i, j] <- geo.mat[j, i] <- geo.mat[i, j] + stats::runif(n = 1, min = 0.000001, max = 0.000005)
        }
        else {

        }
      }
    }
  }
  out <- list(dist.mat = geo.mat, coords = data, method = method, noise = add.noise)
  class(out) <- "gwl.dist"

  return(out)
}
