# ScottKnottESD
The Scott-Knott Effect Size Difference (ESD) test.
An enhancement of the Scott-Knott test (which cluster distributions into statistically distinct ranks) that takes effect size into consideration.


### Install
with `devtools `:
```r
devtools::install_github('klainfo/ScottKnottESD')
devtools::install_github('klainfo/ScottKnottESD',auth_token="19f8254e31570edab7415ce0ead4cdc885de8cbf")
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
```
