IMAGE_NAMES <- c("t59.tiff", "Image6.tiff", "Image2.tiff","Image4.tiff","Image5.tiff")
gof_gamma <- c()
gof_gaussian <- c()
for(i in 1:length(IMAGE_NAMES)) {
  gof <- main(IMAGE_NAMES[i])
  gof_gamma <- c(gof_gamma, gof[1])
  gof_gaussian <- c(gof_gaussian, gof[2])
}


plot(gof_gaussian, type='l', col='green', lwd=2, ylim=c(0,50000),ylab = 'Chi Square Values')
lines(gof_gamma,type='l', col='blue', lwd=2)


