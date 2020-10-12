<h1 align = 'center'> SAR Image Modeling with Chi Square tests </h1>

SAR images are high quality terrain images of Earth, produced by illuminating target objects with singals. Reflected signals on the aperture are used to form SAR Images.

<div style="display:flex; flex-direction: row; justify-content: space-around;">
    <img src = "https://bit.ly/374vhfc" style="margin: 10px;"/>   
    <img src = "https://bit.ly/30Yx9lW" style="height: 200px; margin: 10px;"/> 
</div>

<center> <i> Figure: SAR images </i> </center>



One of the advantages of using SAR images is they're independent of weather & atmospheric effects.

### What we did

We employed Chi-Square Goodness-of-Fit (GOF) tests to verify that SAR Images are best modeled with Gamma distribution. A comparative analysis with Normal and Poisson distribution has been conducted.

 - Step 1: Maximum Likelihood Estimation of distribution parameters. For that, we use frequecy parameters from homogeneous patches of SAR Images

 - Step 2-ϵ: Before step 2, we merge bins with E(K) < 5 to make Chi Square test work

 - Step 2: We compute Chi-Square values, with `Obs` as observed distribution from image patches for different `Exp` arrays frm various estimated distribution


### Implementation:
This repository contains the implementation in R, you can find the Python implementation here.

Results:

We performed Chi-Square GOF tests on six patches of homogeneous SAR Images, the results of which is shown below. The line chart clearly shows that SAR Images can best be modeled with Gamma distribution.

### Since we were at it

SAR Images are known to be affected by Speckle noise, which arises as a consequence
of the coherent illumination used by radar. Speckle noise estimation is an important challenge in SAR Imagery. Hence, we estimated the Speckle noise in SAR Images using Equivalent number of looks(ENL)

Further Steps:

