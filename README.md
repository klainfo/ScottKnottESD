[![Build Status](https://travis-ci.org/klainfo/ScottKnottESD.svg?branch=master)](https://travis-ci.org/klainfo/ScottKnottESD) 


# ScottKnottESD
The Scott-Knott Effect Size Difference (ESD) Test.
An enhancement of the Scott-Knott test (which cluster distributions into statistically distinct ranks) that takes effect size into consideration.


### Install
with `devtools `:
```r
devtools::install_github('klainfo/ScottKnottESD')
```
### Usage
```r
library(ScottKnottESD)
sk <- SK.ESD(example)
sk$original  # Original Groups
sk$groups    # Corrected Groups with effect size wise
sk$reverse   # Reversed Groups
```

### Reference
```tex
@misc{ScottKnottESD,
title = {{ScottKnottESD: The Scott-Knott Effect Size Difference (ESD) test}},
author = {Chakkrit Tantithamthavorn},
year = {2015},
howpublished = {\url{http://github.com/klainfo/ScottKnottESD}}
}

@article{tantithamthavorn2016mvt,
  title={{An Empirical Comparison of Model Validation Techniques for Defect Prediction Model}},
  author={Tantithamthavorn, Chakkrit and McIntosh, Shane and Hassan, Ahmed E and Matsumoto, Kenichi},
  journal={IEEE Transactions on Software Engineering},
  year={2016}
}

```
