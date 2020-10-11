

Synthetic Aperture Radar Images produce high quality terrain images of Earth by illuminating target objects with singals. Reflected signals on the aperture are used to form SAR Images.

One of the advantages of using SAR images is they're independent of weather & atmospheric effects.

(2 images here)

What we did

We will employ Chi-Square Goodness-of-Fit(GOF) tests to verify that SAR Images are best modeled with Gamma distribution. A comparative analysis with Normal and Poisson distribution has been conducted.

SAR Images are known to be affected by Speckle noise, which arises as a consequence
of the coherent illumination used by radar. Speckle noise estimation is an important challenge in SAR Imagery. Hence, we estimated the Speckle noise in SAR Images using Equivalent number of looks(ENL)

Implementation:
This repository contains the implementation in R, you can find the Python implementation here.

Results:

We performed Chi-Square GOF tests on six patches of homogeneous SAR Images, the results of which is shown below. The line chart clearly shows that SAR Images can best be modeled with Gamma distribution.

Further Steps:

