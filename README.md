[![Build Status](https://travis-ci.org/klainfo/ScottKnottESD.svg?branch=master)](https://travis-ci.org/klainfo/ScottKnottESD) 
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/ScottKnottESD)](https://cran.r-project.org/package=ScottKnottESD)
[![Downloads](https://cranlogs.r-pkg.org/badges/grand-total/ScottKnottESD)]( https://cran.r-project.org/package=ScottKnottESD)
[![Downloads](http://cranlogs.r-pkg.org/badges/ScottKnottESD)]( https://cran.r-project.org/package=ScottKnottESD)
[![DOI](https://zenodo.org/badge/39927952.svg)](https://zenodo.org/badge/latestdoi/39927952)
[![License: GPL v2](https://img.shields.io/badge/License-GPL%20v2-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)
# The ScottKnott Effect Size Difference (ESD) test (Version 3.0, the development branch) 
The Scott-Knott Effect Size Difference (ESD) test is a multiple comparison approach that leverages a hierarchical clustering to partition the set of treatment averages (e.g., means) into statistically distinct groups with non-negligible difference [Tantithamthavorn et al., (2018) <https://doi.org/10.1109/TSE.2018.2794977>].
It is an alternative approach of the Scott-Knott test that considers the magnitude of the difference (i.e., effect size) of treatment means with-in a group and between groups.
Therefore, the Scott-Knott ESD test (v2+) produces the ranking of treatment means while ensuring that (1) the magnitude of the difference for all of the treatments in each group is negligible; and (2) the magnitude of the difference of treatments between groups is non-negligible.
The Scott-Knott ESD test is recommended than other multiple comparison tests, since it does not produce overlapping groups like other post-hoc tests (e.g., Nemenyi’s test).

## The Parametric ScottKnott ESD test (available in Version 2.0+)
The Parametric Scott-Knott ESD test is a mean comparison approach that leverages a hierarchical clustering to partition the set of treatment _means_.
This Parametric ScottKnott ESD test is based on the ANOVA assumptions of the original ScottKnott test (e.g., the assumptions of normal distributions, homogeneous distributions, and the minimum sample size). The mechanism of the Scott-Knott ESD test is made up of 2 steps:

* **(Step 1) Find a partition that maximizes treatment means between groups.** We begin by sorting the treatment means. Then, following the original Scott-Knott test, we compute the sum of squares between groups (i.e., a dispersion measure of data points) to identify a partition that maximizes treatment means between groups. 
* **(Step 2) Splitting into two groups or merging into one group.** Instead of using a likelihood ratio test and a Chi-square distribution as a splitting and merging criterion (i.e., a hypothesis testing of the equality of all treatment means), we analyze the magnitude of the difference for each pair for all of the treatment means of the two groups. If there is any one pair of treatment means of two groups are non-negligible, we split into two groups. Otherwise, we merge into one group. We use the Cohen effect size --- an effect size estimate based on the difference between the two means divided by the standard deviation of the two treatment means (d = (mean(x_1) - mean(x_2))/s.d.).

Unlike the earlier version of the Scott-Knott ESD test (v1.x) that post-processes the groups that are produced by the Scott-Knott test, the Scott-Knott ESD test (v2.x) pre-processes the groups by merging pairs of statistically distinct groups that have a negligible difference.


## The Non-Parametric ScottKnott ESD test (available in Version 3.0, the development branch) 
The Non-Parametric ScottKnott ESD (NPSK) test is a multiple comparison approach that leverages a hierarchical clustering to partition the set of median values of techniques (e.g., medians of variable importance scores, medians of model performance) into statistically distinct groups with non-negligible difference.
The Non-Parametric ScottKnott ESD (NPSK) does not require the assumptions of normal distributions, homogeneous distributions, and the minimum sample size.
The mechanism of the Non-Parametric Scott-Knott ESD test is made up of 2 steps:

* **(Step 1) Find a partition that maximizes treatment medians between groups.** We begin by sorting the median value of the distributions. Then, we compute the Kruskal Chisq statistics to identify a partition that maximizes the median values between groups. The Kruskal Chisq test is a non-parametric test, which does not require data normality and data heterogeneity assumptions.
* **(Step 2) Splitting into two groups or merging into one group.** We analyze the magnitude of the difference for each pair for all of the treatment medians of the two groups. If there is any one pair of treatment medians of two groups are non-negligible, we split into two groups. Otherwise, we merge into one group. We use the Cliff $|\delta|$ effect size to estimate the effect size of the difference between the two medians.


# Release Notes

V3.0.0 - Supporting the Non-Parametric ScottKnott ESD test. (Pending approval to be available in CRAN)

```r
install.packages("devtools")
devtools::install_github("klainfo/ScottKnottESD", ref="development")
# Using Non-Parametric ScottKnott ESD test
sk <- sk_esd(example, version="np")
```

V2.0.3 - The Parametric ScottKnott ESD test (v2.x) produces the ranking of treatment means while ensuring that (1) the magnitude of the difference for all of the treatments in each group is negligible; and (2) the magnitude of the difference of treatments between groups is non-negligible. [Tantithamthavorn et al., (2018) <https://doi.org/10.1109/TSE.2018.2794977>]


```r
install.packages("devtools")
devtools::install_github("klainfo/ScottKnottESD", ref="development")
# Using the Parametric ScottKnott ESD test
sk <- sk_esd(example, version="p")
```

### Example usage scenarios in software engineering domain.

(1) Ranking and identifying the most influential variables that are produced by random forests models or regression models.

(2) Ranking and identifying the top-performing feature selection, classification, and model validation techniques for defect prediction models.

### Installation
######  Install the current release from CRAN::
```r
install.packages("ScottKnottESD")
```

###### Install the development version from GitHub:
```r
install.packages("devtools")
devtools::install_github("klainfo/ScottKnottESD", ref="development")
```
### Example R Usage
```r
library(ScottKnottESD)

# An example dataset: The 1,000 variable importance scores of 9 software metrics. 
# The scores are generated by the Random Forests technique using 1,000 out-of-sample bootstrap.
example

# Using Non-Parametric ScottKnott ESD test
sk <- sk_esd(example, version="np")
plot(sk)

sk <- sk_esd(maven)
plot(sk)
```

### Example Python Usage (by calling R package via rpy2)
```
# For Linux
pip install rpy2

# For Mac OS X
env ARCHFLAGS="-arch i386 -arch x86_64" pip install rpy2
```

```python
from rpy2.robjects.packages import importr
from rpy2.robjects import r, pandas2ri
pandas2ri.activate()
import pandas as pd

sk = importr('ScottKnottESD')
data = pd.DataFrame(
    {
        "TechniqueA": [5, 1, 4],
        "TechniqueB": [6, 8, 3],
        "TechniqueC": [7, 10, 15],
        "TechniqueD": [7, 10.1, 15],
    }
)
display(data)
r_sk = sk.sk_esd(data)
column_order = list(r_sk[3] - 1)
ranking = pd.DataFrame(
    {
        "technique": [data.columns[i] for i in column_order],
        "rank": r_sk[1].astype("int"),
    }
) # long format
ranking = pd.DataFrame(
    [r_sk[1].astype("int")], columns=[data.columns[i] for i in column_order]
) # wide format
```
### Referencing ScottKnottESD
ScottKnottESD can be referenced as:
```tex
@article{tantithamthavorn2017mvt,
    Author={Tantithamthavorn, Chakkrit and McIntosh, Shane and Hassan, Ahmed E. and Matsumoto, Kenichi},
    Title = {An Empirical Comparison of Model Validation Techniques for Defect Prediction Models},
    Booktitle = {IEEE Transactions on Software Engineering (TSE)},
    Volumn = {43},
    Number = {1},
    page = {1-18},
    Year = {2017}
}
@article{tantithamthavorn2018optimization,
    Author={Tantithamthavorn, Chakkrit and McIntosh, Shane and Hassan, Ahmed E. and Matsumoto, Kenichi},
    Title = {The Impact of Automated Parameter Optimization for Defect Prediction Models},
    Booktitle = {IEEE Transactions on Software Engineering (TSE)},
    page = {Early Access},
    Year = {2018}
}
```
