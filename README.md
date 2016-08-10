[![Build Status](https://travis-ci.org/klainfo/ScottKnottESD.svg?branch=master)](https://travis-ci.org/klainfo/ScottKnottESD) 
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/ScottKnottESD)](http://cran.r-project.org/web/packages/ScottKnottESD)
[![Downloads](http://cranlogs.r-pkg.org/badges/ScottKnottESD)](http://cran.rstudio.com/package=ScottKnottESD)

# ScottKnottESD
The Scott-Knott Effect Size Difference (ESD) Test.
An enhancement of the Scott-Knott test (which cluster distributions into statistically distinct ranks) that takes effect size into consideration.


### Install
######  Install the current release from CRAN::
```r
install.packages("ScottKnottESD")
```

###### Install the development version from GitHub:
```r
install.packages("devtools")
devtools::install_github("klainfo/ScottKnottESD")
```
### Usage
```r
library(ScottKnottESD)
sk <- sk_esd(example)
sk$original  # Original Groups
sk$groups    # Corrected Groups with effect size wise
sk$reverse   # Reversed Groups
```

### References
```tex
@misc{ScottKnottESD,
title = {{ScottKnottESD: The Scott-Knott Effect Size Difference (ESD) Test}},
author = {Chakkrit Tantithamthavorn},
year = {2016},
howpublished = {\url{https://cran.r-project.org/web/packages/ScottKnottESD/index.html}}
}

@article{tantithamthavorn2016mvt,
  title={{An Empirical Comparison of Model Validation Techniques for Defect Prediction Model}},
  author={Tantithamthavorn, Chakkrit and McIntosh, Shane and Hassan, Ahmed E and Matsumoto, Kenichi},
  journal={IEEE Transactions on Software Engineering (TSE)},
  year={2016}
}

```
