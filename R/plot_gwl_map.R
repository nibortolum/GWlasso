#' Plot a map of beta coefficient for gwlfit object
#' 
#' @description this function plot a map of the beta coefficient for a selected column (aka species). 
#' For this function to work, the coordinates supplied to [gwl_fit()] must be named "Long" and "Lat".
#' The function is not bulletproof yet but is added here to reproduce the maps from the original publication.
#' 
#'`r lifecycle::badge("experimental")`
#'
#' @param x a gwlfit object returned by [gwl_fit()]. 
#' @param column the name of a variable to be plotted on the map. Must be quotted. for instance "NEB.MIN"
#' @param crs the crs projection for the map (default is mercator WGS84)
#'
#' @return a ggplot object
#' @export
#'
#' @examples
#' 
#' 
#' if(interactive()){
#'   data(Amesbury)
#'   
#'   distance_matrix <- compute_distance_matrix(Amesbury$coords, add.noise = TRUE)
#'   
#'  
#'   my.gwl.fit <- gwl_fit(bw= 120,
#'                         x.var = Amesbury$spe.df,
#'                         y.var = Amesbury$WTD,
#'                         dist.mat = distance_matrix,
#'                         adaptive = TRUE,
#'                         kernel = "bisquare",
#'                         alpha = 1,
#'                         progress = TRUE)
#'   
#'   plot(my.gwl.fit)
#' }

#' 
plot_gwl_map <- function(x, column, crs = 4326){
  lifecycle::signal_stage("experimental", "plot_gwl_map()")
  stopifnot(methods::is(x, "gwlfit"),
            colnames(coords) == c("Long", "Lat"))
  
  coords <- x$coords
  
  betacoef <- x$coefs
  colnames(betacoef) <- c("intercept", x$cols)
  
  # make a spatial object to plot
  betamap.df <- as.data.frame(cbind(betacoef[ , -1], coords))
  
  sp = "NEB.MIN"
  
  beta_plot <- ggplot2::ggplot() + 
    ggplot2::borders(ylim= range(coords$Lat), xlim=range(coords$Long)) +
    ggplot2::geom_point(ggplot2::aes(x = .data$Long, y = .data$Lat, colour = .data[[sp]]), size = 3, data = betamap.df) +
    ggplot2::xlab("Longitude") +
    ggplot2::ylab("Latitude") +
    ggplot2::scale_colour_continuous("Beta coef", type = "viridis") +
    ggplot2::theme_minimal(base_size = 7) +
    ggplot2::ggtitle(paste("Geographical beta distribution for", sp))
  
  p <- beta_plot + ggplot2::coord_sf(ylim= range(coords[,1]) + c(-1,1), xlim=range(coords[,2]) + c(-1,1), crs = sf::st_crs(crs))
  
  p
}
