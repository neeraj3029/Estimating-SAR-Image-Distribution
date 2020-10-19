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

merge_from_left <- function(exp1, obs1) {
  dim = 1;
  sume = 0;
  obs_sum=0;
  while(exp1[dim] < 5) {
    obs_sum=obs_sum+obs1[dim];
    sume=sume+exp1[dim];
    dim=dim+1;
  }
  return(c(dim, sume, obs_sum));
}

merge_from_right <- function(exp1, obs1) {
  sume = 0;
  obs_sum = 0;
  dim = length(exp)
  for(i in seq(length(exp1), 1, by=-1)) {
    dim = i;
    if(exp1[i] >= 5) {
      break;
    }
    sume = sume+exp1[i];
    obs_sum = obs_sum+obs1[i];
    #print(i)
  }
  
  return(c(dim,sume,obs_sum));
}

shrink <- function(exp1, obs1) {
  mfr_gamma = merge_from_right(exp1, obs1)
  dim_right = mfr_gamma[1]
  sume_right = mfr_gamma[2]
  obs_sum_right = mfr_gamma[3]
  
  mlf_gamma = merge_from_left(exp1, obs1);
  dim_left = mlf_gamma[1]
  sume_left = mlf_gamma[2]
  obs_sum_left = mlf_gamma[3]
  
  new_exp <- exp1[dim_left: dim_right]
  new_obs <- obs1[dim_left: dim_right]
  if(dim_left > 1) {
    new_exp = c(sume_left, new_exp)
    new_obs = c(obs_sum_left, new_obs)
  }
  if(sume_right > 0) {
    new_exp = c(new_exp, sume_right)
    new_obs = c(new_obs, obs_sum_right)
  }
  return(list("exp" = new_exp, "obs" = new_obs))
}

ENL <- function(pixels) {
  enl <- (mean(pixels)**2)/var(pixels)
  return(enl)
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