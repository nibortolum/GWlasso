#' Predict method for gwlfit objects
#' 
#' @param object Object of class inheriting from "gwlfit"
#' @param newdata a data.frame or matrix with the same columns as the training dataset
#' @param newcoords a dataframe or matrix of coordinates of the new data
#' @param type the type of response. see [glmnet::predict.glmnet()]
#' @param verbose `TRUE` to print info about the execution of the function (useful for very large predictions)
#' @param ... ellipsis for S3 compatibility. Not used in this function.
#'
#' @return a vector of predicted values
#' @export 
#' @examples
#' 
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
#' new_predictors <- matrix(data = rnorm(500), 10,50)
#' new_coords <- data.frame("Lat" = rnorm(10), "Long" = rnorm(10))
#' 
#' predicted_values <- predict(my.gwl.fit,
#'                              newdata = new_predictors, 
#'                              newcoords = new_coords)
#' 
predict.gwlfit <- function(object, 
                           newdata, 
                           newcoords, 
                           type = "response",
                           verbose = FALSE,
                           ...){
  
  stopifnot(methods::is(object,"gwlfit"),
            nrow(newcoords) == nrow(newdata))
  
  if(is.data.frame(newdata)){
    if(!identical(object$cols, colnames(newdata))){
      stop("newdata must have the same column as the original training set")
    }
  }
  
  newdata <- as.matrix(newdata)
  if(verbose) {
    cat("Computing distance matrix\n")
  }
  distance_matrix_whole <- compute_distance_matrix(rbind(object$coords, newcoords), 
                                                   method = object$dist.param$method,
                                                   add.noise = object$dist.param$add.noise)
  
  if(verbose){
    cat("finding neighbours \n")
  }
  # vector of distance from test sample to train samples
  closest_neighbour <- vector(length = nrow(newcoords))
  
  
  for (i in 1:nrow(newcoords)){
    closest_neighbour[i] <- which.min(distance_matrix_whole$dist.mat[i+nrow(object$coords),1:nrow(object$coords)])
  }
  
  prediction_vector <-  vector(length = nrow(newcoords))
  
  if(verbose){
    cat("predicting \n")
  }
  for(i in 1:nrow(newcoords)){
    prediction_vector[i] <- stats::predict(object$models[[closest_neighbour[i]]],
                                    newx = newdata[i,],
                                    s = "lambda.min",
                                    type = type)
  }
  
  return(prediction_vector)
}

