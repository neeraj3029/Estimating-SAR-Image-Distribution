Goodness_of_fit <- function(obs, exp) {
  gof <- 0
  for(i in 1: length(obs)) {
    gof <- gof + ((obs[i]-exp[i])**2)/exp[i]
  }
  return(gof)
}

pixelCounter <- function(arr, size) {
  counter <- rep(0, times=size);
  for(i in 1:length(arr)) {
    counter[arr[i]-1]  = counter[arr[i]-1] + 1;
  }
  return(counter);
}