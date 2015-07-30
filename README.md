# ScottKnottESD
The Scott-Knott Effect Size Difference (ESD) test.
An enhancement of the Scott-Knott test (which cluster distributions into statistically distinct ranks) that takes effect size into consideration.


### Install
with `devtools `:
```r
devtools::install_github('klainfo/ScottKnottESD')
```
### Usage
```r
library(ScottKnottESD)
sk <- ScottKnottESD(example)
sk$original  # Original Groups
sk$groups    # Corrected Groups with effect size wise
sk$reverse   # Reversed Groups
```
