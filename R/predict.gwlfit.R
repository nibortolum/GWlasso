#' Predict method for GWL fits
#'
#' @param object Object of class inheriting from "gwlfit"
#' @param newdata a data.frame or matrix with the same columns as the training dataset
#' @param newcoords adataframe or matrix of coordinates of the new data
#' @param type the type of response see [glmnet::predict.glmnet()]
#'
#' @return a vector of predicted values
#' @export 
#'
#' @examples
#' 
predict.gwlfit <- function(object, 
                           newdata, 
                           newcoords, 
                           type = "response"){
  
  stopifnot(methods::is(object,"gwlfit"),
            nrow(newcoords) == nrow(newdata))
  
  cat("Computing distance matrix\n")
  distance_matrix_whole <- compute_distance_matrix(rbind(object$coords, newcoords), 
                                                   method = object$dist.param$method,
                                                   add.noise = object$dist.param$add.noise)
  
  cat("finding neighbours \n")
  # vector of distance from test sample to train samples
  closest_neighbour <- vector(length = nrow(newcoords))
  
  
  for (i in 1:nrow(newcoords)){
    closest_neighbour[i] <- which.min(distance_matrix_whole$dist.mat[i+nrow(object$coords),1:nrow(object$coords)])
  }
  
  prediction_vector <-  vector(length = nrow(newcoords))
  
  cat("predicting \n")
  for(i in 1:nrow(newcoords)){
    prediction_vector[i] <- stats::predict(object$models[[closest_neighbour[i]]],
                                    newx = as.matrix(newdata[i,]),
                                    s = "lambda.min",
                                    type = type)
  }
  
  return(prediction_vector)
}

