Goodness_of_fit <- function(obs, exp) {
  # Calculates Chi Square GOF values from observed and expected frequencies
  gof <- 0
  for(i in 1: length(obs)) {
    gof <- gof + ((obs[i]-exp[i])**2)/exp[i]
  }
  return(gof)
}

pixelCounter <- function(arr, size) {
  # returns frequency count of pixels in range [1, size]
  counter <- rep(0, times=size);
  for(i in 1:length(arr)) {
    counter[arr[i]-1]  = counter[arr[i]-1] + 1;
  }
  return(counter);
}

mergeBins <- function(arr, times) {
  # merges adjacents bins when fewer bins are required.
  if(times == 0) {
    result <- arr;
  } else {
    len = length(arr);
    new_arr <- c()
    v = 0;
    for(i in 1:len) {
      v = v + arr[i];
      if(i%%2 == 0) {
        new_arr <- c(new_arr, v)
        v = 0;  
      }
    }
    result <- mergeBins(new_arr, times-1);
  }
  return(result);
}