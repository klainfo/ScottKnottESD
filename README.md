[![Build Status](https://travis-ci.org/klainfo/ScottKnottESD.svg?branch=master)](https://travis-ci.org/klainfo/ScottKnottESD) 
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/ScottKnottESD)](http://cran.r-project.org/web/packages/ScottKnottESD)
[![Downloads](http://cranlogs.r-pkg.org/badges/ScottKnottESD)](http://cran.rstudio.com/package=ScottKnottESD)
[![DOI](https://zenodo.org/badge/39927952.svg)](https://zenodo.org/badge/latestdoi/39927952)

# ScottKnottESD
The Scott-Knott Effect Size Difference (ESD) Test.
An enhancement of the Scott-Knott test (which cluster distributions into statistically distinct ranks) that takes effect size into consideration.


### Installation
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

### Referencing ScottKnottESD
ScottKnottESD can be referenced as:
```tex
@misc{ScottKnottESD,
title = {{ScottKnottESD: The Scott-Knott Effect Size Difference (ESD) Test}},
author = {Chakkrit Tantithamthavorn},
year = {2016},
howpublished = {\url{https://cran.r-project.org/web/packages/ScottKnottESD/index.html}}
}
```
The detailed description of ScottKnottESD is described in:
```tex
@article{tantithamthavorn2017tse,
    Author={Tantithamthavorn, Chakkrit and McIntosh, Shane and Hassan, Ahmed E. and Matsumoto, Kenichi},
    Title = {An Empirical Comparison of Model Validation Techniques for Defect Prediction Models},
    Booktitle = {IEEE Transactions on Software Engineering (TSE)},
    Volumn = {43},
    Number = {1},
    page = {1–18},
    Year = {2017}
}
```

### ScottKnottESD is referenced by the following papers

- Tantithamthavorn et al. ["An Empirical Comparison of Model Validation Techniques for Defect Prediction Models."](http://chakkrit.com/assets/papers/tantithamthavorn2016mvt.pdf) IEEE Transactions on Software Engineering (TSE), 2017.
- Tantithamthavorn et al. ["Automated parameter optimization of classification techniques for defect prediction models."](http://chakkrit.com/assets/papers/tantithamthavorn2016icse.pdf) Proceedings of the 38th International Conference on Software Engineering (ICSE), 2016.
- Kabinna et al. ["Examining the stability of logging statements."](https://users.encs.concordia.ca/~shang/pubs/SANER2016.pdf) Proceedings of the IEEE 23rd International Conference on Software Analysis, Evolution, and Reengineering (SANER), 2016.
