
<!-- README.md is generated from README.Rmd. Please edit that file -->

# GWlasso

<!-- badges: start -->

[![R-CMD-check](https://github.com/nibortolum/GWlasso/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/nibortolum/GWlasso/actions/workflows/R-CMD-check.yaml)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![CRAN
status](https://www.r-pkg.org/badges/version/GWlasso)](https://CRAN.R-project.org/package=GWlasso)
<!-- badges: end -->

The goal of GWlasso is to provides a set of functions to perform
Geographically weighted lasso. It was originally thought to be used in
palaeoecological settings but can be used to other extents.

The package has been submitted to CRAN and is awaiting evaluation

## Installation

You can install the development version of GWlasso from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("nibortolum/GWlasso")
```

## Example

This is a basic example on how to run a GWlasso pipeline:

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
