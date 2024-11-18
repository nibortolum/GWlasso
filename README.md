
<!-- README.md is generated from README.Rmd. Please edit that file -->

# GWlasso

<!-- badges: start -->
<!-- badges: end -->

The goal of GWlasso is to provides a set of function to perform
Geographically weighted lasso. It was originally thought to bu used in
palaeoecological settings but can be used to other extents.

## Installation

You can install the development version of GWlasso from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("nibortolum/GWlasso")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(GWlasso)

## compute a distance matrix from a set of coordinates
distance_matrix <- compute_distance_matrix <- function(coords, method = "euclidean", add.noise = FALSE)

## compute the optimal bandwidth 
  myst.est <- gwl_bw_estimation(x.var = predictors_df, 
                              y.var = y_vector,
                              dist.mat = distance_matrix,
                              adaptive = TRUE,
                              adptbwd.thresh = 0.1,
                              kernel = "bisquare",
                              alpha = 1,
                              progress = TRUE,
                              n=40,
                              nfolds = 5)

## Compute the optimal model
my.gwl.fit <- gwl_fit(myst.est$bw,
                      x.var = data.sample[,-1], 
                      y.var = data.sample$WTD,
                      kernel = "bisquare",
                      dist.mat = distance_matrix, 
                      alpha = 1, 
                      adaptive = TRUE, progress = T)

## make predictions 

predicted_values <- predict(my.gwl.fit, newdata = new_data, newcoords = new_coords)
```
