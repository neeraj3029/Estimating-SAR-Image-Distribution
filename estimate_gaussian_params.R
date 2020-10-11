estimate_gaussian_params <- function(pixels) {
  return(c(mean(pixels), sd(pixels)))
}