library('tiff')
library(EBImage)
library(raster)

main <- function(imageName) {
    img = raster(paste0("/Users/apple/labs/CS605/mproject/SARImages/", imageName))
    img[img == 0] = 1 
    
    #Step2: Parameter esimation using Maximum Likelihood Estimation. 
    #File estimate_params.R has implementation of MLE estimator functions.
    
    gamma_params <- estimate_gamma_parameters(img[], FALSE);
    gaussian_params <- estimate_gaussian_params(img[]);
    poisson_params <- estimate_poission_params(img[]);
    
    total_samples <- length(img);
    observed_counts <- pixelCounter(img[], 256);
    
    est_gamma_dist <- dgamma(x = seq(1, 256, by=1), shape = gamma_params[1], scale = gamma_params[2]);
    
    est_gaussian_dist <- dnorm(x = seq(1, 256, by=1), mean = gaussian_params[1], sd = gaussian_params[2]);
    
    
    exp_values_gamma <- c();
    exp_values_gaussian <- c();
    
    for(i in 1:length(observed_counts)) {
      e_k_gamma = est_gamma_dist[i] * total_samples;
      e_k_gaussian = est_gaussian_dist[i] * total_samples;
      exp_values_gamma <- c(exp_values_gamma, e_k_gamma);
      exp_values_gaussian <- c(exp_values_gaussian, e_k_gaussian);
    }
  
    #Next step would be to define a function that merges adjacent bins
    
    #Enforcing E(k) >= 5 from right end
    
    sumv_gamma = 0
    sumv_gaussian = 0
    sum2 = 0
    dim = length(exp_values_gamma)
    sum3_gamma = 0;
    sum3_gaussian = 0;
    for (i in seq(length(exp_values_gamma),1,by=-1)){
      if(exp_values_gamma[i] && exp_values_gaussian[i] >= 5){
        dim = i;
        break;
      }
      sumv_gamma = sumv_gamma + exp_values_gamma[i]; 
      sumv_gaussian = sumv_gaussian + exp_values_gaussian[i];
      sum2 = sum2 + observed_counts[i]; 
      sum3_gamma = sum3_gamma + est_gamma_dist[i];
      sum3_gaussian = sum3_gaussian + est_gaussian_dist[i];
    }
    
    if(sumv_gaussian > 0) {
      estimated_values_gamma_ = c(exp_values_gamma[1:dim], sumv_gamma);
      estimated_values_gaussian_ = c(exp_values_gaussian[1:dim], sumv_gaussian);
      est_gamma_dist_ = c(est_gamma_dist[1:dim], sum3_gamma);
      est_gaussian_dist_ = c(est_gaussian_dist[1:dim], sum3_gaussian);
      observed_counts_ = c(observed_counts[1:dim], sum2);
    } else {
      estimated_values_gamma_ = exp_values_gamma
      estimated_values_gaussian_ = exp_values_gaussian
      est_gamma_dist_ = est_gamma_dist
      est_gaussian_dist_ = est_gaussian_dist
      observed_counts_ = observed_counts
    }

    #Enforcing E(k) >= 5 from left end
    
    dim = 1;
    sumv_gamma = 0;
    sumv_gaussian = 0;
    sumv2 = 0;
    sumv3_gamma = 0;
    sumv3_gaussian = 0;
    while(estimated_values_gamma_[dim] < 5 && estimated_values_gaussian_[dim]) {
      dim = dim+1;
      sumv_gamma = sumv_gamma+estimated_values_gamma_[dim];
      sumv_gaussian = sumv_gaussian+estimated_values_gaussian_[dim];
      sumv2 = sumv2+observed_counts_[dim];
      sumv3_gamma = sumv3_gamma+est_gamma_dist_[dim];
      sumv3_gaussian = sumv3_gaussian+est_gaussian_dist_[dim];
    }
    
    curr_length = length(est_gaussian_dist_);
    
    if(sumv_gamma > 0) {
      estimated_values_gamma__ = c(sumv_gamma, estimated_values_gamma_[dim:curr_length]);
      estimated_values_gaussian__ = c(sumv_gaussian, estimated_values_gaussian_[dim:curr_length]);
      est_gamma_dist__ = c(sumv3_gamma, est_gamma_dist_[dim:curr_length]);
      est_gaussian_dist__ = c(sumv3_gaussian, est_gaussian_dist_[dim:curr_length]);
      observed_counts__ = c(sumv2, observed_counts_[dim:curr_length]);
    } else {
      estimated_values_gamma__ =  estimated_values_gamma_;
      estimated_values_gaussian__ = estimated_values_gaussian_;
      est_gamma_dist__ = est_gamma_dist_;
      est_gaussian_dist__ = est_gaussian_dist_;
      observed_counts__ = observed_counts_;
    }
    
    # Finally, Calculating Chi Square GOF values for different distributions based on observed data
    gof_gamma <- Goodness_of_fit(observed_counts__, estimated_values_gamma__)
    gof_gaussian <- Goodness_of_fit(observed_counts__, estimated_values_gaussian__)
    return(c(gof_gamma, gof_gaussian))
}



