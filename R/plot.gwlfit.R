#' Plot method for gwlfit object
#'
#' @param x a gwlfit object returnes by [gwl_fit()]
#' @param ... ellipsis for S3 method compatibility
#'
#' @return a ggplot
#' @export
#' 
#' @importFrom rlang .data
#' @examples
plot.gwlfit <- function(x, ...){
  betacoef <- x$coefs
  colnames(betacoef) <- c("intercept", x$cols)
  
  # binarise the data
  betacoef.bin <- betacoef
  betacoef.bin[which(betacoef == 0)] <- 0
  betacoef.bin[which(betacoef != 0)] <- 1
  
  betacoef.bin.df <- as.data.frame(betacoef.bin)
  names <- colnames(betacoef.bin.df)
  
  tmp <- cbind(betacoef.bin.df, yvar=x$yvar) %>% 
    dplyr::arrange(.data$yvar) %>% 
    dplyr::mutate(number = 1:dplyr::n())
  
  tmp %>% 
    tidyr::pivot_longer(-c(.data$yvar, .data$number), names_to = "sp", values_to = "beta") %>% 
    ggplot2::ggplot() +
    ggplot2::geom_tile(mapping = ggplot2::aes(x = .data$number, y = .data$sp, fill = as.factor(beta))) +
    ggplot2::scale_fill_manual(values = c("lightgoldenrod1", "royalblue4"), name = "Beta coef", 
                      labels = c("NULL", "NON NULL")) +
    ggplot2::xlab("index")+
    ggside::geom_xsideline(ggplot2::aes(x = .data$number, y = .data$yvar)) +
    ggplot2::theme_bw() +
    ggplot2::ggtitle("Distribution of beta coefficients",
            "Top panel : y.var")
  
}