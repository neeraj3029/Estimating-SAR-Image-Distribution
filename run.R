IMAGE_NAMES <- c("t59.tiff", "Image6.tiff", "Image2.tiff","Image4.tiff","Image5.tiff")

cat("Enter the Plot Type : \n 1: Estimated Distributions\n 2. ChiSq Values\n 3. ENL")
ptype <- as.integer(readline(prompt = ""))



gof_gamma <- c()
gof_gaussian <- c()
gof_lnorm <- c()
enl <- c()
if(ptype == 1) {
  par(mfrow=c(2,3))
}  
for(i in 1:length(IMAGE_NAMES)) {
  output <- main(IMAGE_NAMES[i])
  gof <- output$gof
  gof_gamma <- c(gof_gamma, gof[1])
  gof_gaussian <- c(gof_gaussian, gof[2])
  gof_lnorm <- c(gof_lnorm, gof[3])
  enl <- c(enl, output$ENL)
  #print(output)
  if(ptype==1) {
      plot(output$exp_values_gamma, type='l', col='blue', lwd=2, ylab="Pixel Count", xlab="Pixel Index")
      lines(output$exp_values_gaussian, type='l', col='orange', lwd=2)
      lines(output$exp_values_lnorm, type='l', col='red', lwd=2)
      lines(output$observed_counts, col = 'black', type='l',lwd=2)
      legend(150, 2500, legend=c("Est. Gamma Dist.", "Est. Gaussian Dist.", "Est Log-Normal Distribution"),
             col=c("blue", "orange", "red"), lty=1:1, cex=0.6)
  }
}

par(mfrow=c(1,1))
if(ptype==3) {
  plot(enl, type='l', col='magenta', lwd=2,ylab = 'Expected NUmber of Looks', main="ENL over different images", xlab = "Image Index")
}
if(ptype==2) {
  plot(gof_gaussian, type='l', col='green', lwd=2, ylim=c(0,50000),ylab = 'Chi Square Values', main="ChiSq values over different images", xlab = "Image Index")
  lines(gof_gamma,type='l', col='blue', lwd=2)
  lines(gof_lnorm,type='l', col='red', lwd=2)
  legend(3, 45000, legend=c("Chi Sq values when F=Gamma dist", "Chi Sq values when F=Gaussian dist"), col=c("blue", "green"), lty=1:1, cex=0.8)
}