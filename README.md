<h1 align = 'center'> SAR Image Modeling with Chi Square tests </h1>

SAR images are high quality terrain images of Earth, produced by illuminating target objects with singals. Reflected signals on the aperture are used to form SAR Images.

<p align = 'center'>
    <img src = "https://bit.ly/374vhfc" margin="10px"/>   
    <img src = "https://bit.ly/30Yx9lW" height="200px" margin: "10px"/> 
     <img src = "https://user-images.githubusercontent.com/31539812/95768014-4c241d00-0cd3-11eb-8a23-261275d183ac.png" height="200px" margin: "10px"/> 
   
</p>

<p align='center'> <i> SAR images </i> </p>



One of the advantages of using SAR images is they're independent of weather & atmospheric effects.

### How it works

We employ Chi-Square Goodness-of-Fit (GOF) tests to verify that SAR Images are best modeled with Gamma distribution. A comparative analysis with Normal and Poisson distribution has been conducted.

Gamma distribution: 

 - <b>Step</b> 1: Maximum Likelihood Estimation of distribution parameters. For that, we use frequecy parameters from homogeneous patches of SAR Images

<br/>

<p align='center'>
<img src="https://user-images.githubusercontent.com/31539812/95762382-432f4d80-0ccb-11eb-9796-d2b1507cfe89.png" style="height: 250px;">
</p>

<br/>

 - <b>Step</b> 2<>-ϵ: Before step 2, we merge bins with E(K) < 5 to make Chi Square test works


 - <b>Step</b> 2: We compute Chi-Square values, with `Obs` as observed distribution from image patches for different `Exp` arrays frm various estimated distribution


### How to run:

- Compile `utility_functions.R` and `MLE_for_distributions.R` to load the functions in global enivronment,
- Place homogeneous patches of SAR Images in the `SARImages` directory.
- Update the IMAGE_NAMES list in run.R with the names of images on which you want to run tests.
- Run run.R

### Results:

We performed Chi-Square GOF tests on six patches of homogeneous SAR Images, the results of which is shown below. The line chart clearly shows that SAR Images can best be modeled with Gamma distribution.

<p align='center'>    
<img src="https://user-images.githubusercontent.com/31539812/95769119-02d4cd00-0cd5-11eb-8eca-85d54919a8f0.jpeg" style="height: 250px;">
</p>


### Additional work

SAR Images are known to be affected by Speckle noise, which arises as a consequence of the coherent illumination used by radar. Speckle noise estimation is an important challenge in SAR Imagery. Hence, we can estimate the Speckle noise in SAR Images in the terms Equivalent number of looks(ENL), which can be calculated using estimated parameters as <code>mean<sup>2</sup>/var</code>.

### Data Sources

[Alaska Satellite Facility](https://asf.alaska.edu/)

### Developers
- [Neeraj Rajpurohit](https://github.com/neeraj3029/)
- [Akshita Agarwalla](https://github.com/akshitaagarwa11a/)
