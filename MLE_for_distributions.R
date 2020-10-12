estimate_gamma_parameters <- function(pixels, plot) {
  mean_of_log <- unname(summary(log(pixels)))[4]
  log_of_mean <- log(unname(summary(pixels))[4])
  mean_ <- unname(summary(pixels))[4]
  a_iterr <- c()
  a_hat = 1
  for(i in 1:50) {
    a_hat = 1/(1/a_hat + (mean_of_log - log_of_mean + log(a_hat) - digamma(a_hat))/(   (a_hat**2)*(1/a_hat - trigamma(a_hat)) ))
    a_iterr <- c(a_iterr, a_hat)
  }
  b_hat = mean_/a_hat
  if(plot == TRUE) {
    plot(a_iterr, type = 'l', ylab = 'Estimated gamma paramter', xlab = 'iteration')
  }
  return(c(a_hat, mean_/a_hat))
}

estimate_gaussian_params <- function(pixels) {
  return(c(mean(pixels), sd(pixels)))
}

estimate_poission_params <- function(pixels) {
  return(mean(pixels))
}