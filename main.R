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
    lnorm_params <- estimate_lnorm_params(img[]);
    
    total_samples <- length(img);
    observed_counts <- pixelCounter(img[], 256);
    
    est_gamma_dist <- dgamma(x = seq(1, 256, by=1), shape = gamma_params[1], scale = gamma_params[2]);
    est_gaussian_dist <- dnorm(x = seq(1, 256, by=1), mean = gaussian_params[1], sd = gaussian_params[2]);
    est_lnorm_dist <- dlnorm(x = seq(1, 256, by=1), mean = lnorm_params[1], sd = lnorm_params[2]);
    
    exp_values_gamma <- c();
    exp_values_gaussian <- c();
    exp_values_lnorm <- c();
    
    for(i in 1:length(observed_counts)) {
      e_k_gamma = est_gamma_dist[i] * total_samples;
      e_k_gaussian = est_gaussian_dist[i] * total_samples;
      e_k_lnorm = est_lnorm_dist[i] * total_samples;
      exp_values_gamma <- c(exp_values_gamma, e_k_gamma);
      exp_values_gaussian <- c(exp_values_gaussian, e_k_gaussian);
      exp_values_lnorm <- c(exp_values_lnorm, e_k_lnorm);
    }
  
    gof_gamma_input = shrink(exp_values_gamma, observed_counts)
    gof_gaussian_input = shrink(exp_values_gaussian, observed_counts)
    gof_lnorm_input = shrink(exp_values_lnorm, observed_counts)
    
    # Finally, Calculating Chi Square GOF values for different distributions based on observed data
    gof_gamma <- Goodness_of_fit(gof_gamma_input$obs, gof_gamma_input$exp)
    gof_gaussian <- Goodness_of_fit(gof_gaussian_input$obs, gof_gaussian_input$exp)
    gof_lnorm <- Goodness_of_fit(gof_lnorm_input$obs, gof_lnorm_input$exp)
    return(list("ENL" = ENL(img[]),"observed_counts"=observed_counts ,"exp_values_lnorm"=exp_values_lnorm, "exp_values_gamma" = exp_values_gamma, "exp_values_gaussian" = exp_values_gaussian, "gof" = c(gof_gamma, gof_gaussian, gof_lnorm)))
}



