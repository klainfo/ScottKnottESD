[![Build Status](https://travis-ci.org/klainfo/ScottKnottESD.svg?branch=master)](https://travis-ci.org/klainfo/ScottKnottESD) 
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/ScottKnottESD)](https://cran.r-project.org/package=ScottKnottESD)
[![Downloads](https://cranlogs.r-pkg.org/badges/grand-total/ScottKnottESD)]( https://cran.r-project.org/package=ScottKnottESD)
[![Downloads](http://cranlogs.r-pkg.org/badges/ScottKnottESD)]( https://cran.r-project.org/package=ScottKnottESD)
[![DOI](https://zenodo.org/badge/39927952.svg)](https://zenodo.org/badge/latestdoi/39927952)

# ScottKnottESD (v2.0.3) 
The Scott-Knott Effect Size Difference (ESD) test is a mean comparison approach that leverages a hierarchical clustering to partition the set of treatment means (e.g., means of variable importance scores, means of model performance) into statistically distinct groups with non-negligible difference [Tantithamthavorn et al., (2018) <http://dx.doi.org/10.1109/TSE.2018.2794977>].
It is an alternative approach of the Scott-Knott test that considers the magnitude of the difference (i.e., effect size) of treatment means with-in a group and between groups.
Therefore, the Scott-Knott ESD test (v2.x) produces the ranking of treatment means while ensuring that (1) the magnitude of the difference for all of the treatments in each group is negligible; and (2) the magnitude of the difference of treatments between groups is non-negligible.

The mechanism of the Scott-Knott ESD test (v2.0.3) is made up of 2 steps:

* **(Step 1) Find a partition that maximizes treatment means between groups.** We begin by sorting the treatment means. Then, following the original Scott-Knott test, we compute the sum of squares between groups (i.e., a dispersion measure of data points) to identify a partition that maximizes treatment means between groups. 
* **(Step 2) Splitting into two groups or merging into one group.** Instead of using a likelihood ratio test and a Chi-square distribution as a splitting and merging criterion (i.e., a hypothesis testing of the equality of all treatment means), we analyze the magnitude of the difference for each pair for all of the treatment means of the two groups. If there is any one pair of treatment means of two groups are non-negligible, we split into two groups. Otherwise, we merge into one group. We use the Cohen effect size --- an effect size estimate based on the difference between the two means divided by the standard deviation of the two treatment means (d = (mean(x_1) - mean(x_2))/s.d.).

Unlike the earlier version of the Scott-Knott ESD test (v1.x) that post-processes the groups that are produced by the Scott-Knott test, the Scott-Knott ESD test (v2.x) pre-processes the groups by merging pairs of statistically distinct groups that have a negligible difference.

### Example usage scenarios in software engineering domain.

#### (1) Ranking and identifying the most influential variables that are produced by random forests models or regression models.

- Kabinna et al. ["Examining the stability of logging statements."](https://users.encs.concordia.ca/~shang/pubs/SANER2016.pdf) Proceedings of the International Conference on Software Analysis, Evolution, and Reengineering (SANER), 2016.

- Li et al. ["Towards just-in-time suggestions for log changes."](https://users.encs.concordia.ca/~shang/pubs/EMSE2016_heng_logjit.pdf) Empirical Software Engineering (2016): 1-35.

- Tian et al. ["What are the characteristics of high-rated apps? a case study on free android applications."](http://sail.cs.queensu.ca/Downloads/ICSME2015_What-Are-the-Characteristics-of-High-Rated-Apps-A-Case-Study-on-Free-Android-Applications.pdf) Proceedings of the International Conference onSoftware Maintenance and Evolution (ICSME), 2015.

- Tantithamthavorn et al. ["The impact of mislabelling on the performance and interpretation of defect prediction models."](http://chakkrit.com/assets/papers/tantithamthavorn2015icse.pdf) Proceedings of the International Conference on Software Engineering (ICSE), 2015.

#### (2) Ranking and identifying the top-performing feature selection, classification, and model validation techniques for defect prediction models.

- Rajbahadur et al. ["The Impact Of Using Regression Models to Build Defect Classifiers."](http://sail.cs.queensu.ca/Downloads/MSR2017_TheImpactOfUsingRegressionModelsToBuildDefectClassifiers.pdf) Proceedings of the International Conference on Mining Software Repositories (MSR), 2017.

- Ghotra et al. ["A Large-Scale Study of the Impact of Feature Selection Techniques on Defect Classification Models"](http://sail.cs.queensu.ca/Downloads/MSR2017_ALarge-ScaleStudyOfTheImpactOfFeatureSelectionTechniquesOnDefectClassificationModels.pdf) Proceedings of the International Conference on Mining Software Repositories (MSR), 2017.

- Tantithamthavorn et al. ["An Empirical Comparison of Model Validation Techniques for Defect Prediction Models."](http://chakkrit.com/assets/papers/tantithamthavorn2016mvt.pdf) IEEE Transactions on Software Engineering (TSE), 2017.

- Tantithamthavorn et al. ["Automated parameter optimization of classification techniques for defect prediction models."](http://chakkrit.com/assets/papers/tantithamthavorn2016icse.pdf) Proceedings of the 38th International Conference on Software Engineering (ICSE), 2016.

- Ghotra et al. ["Revisiting the impact of classification techniques on the performance of defect prediction models."](http://sail.cs.queensu.ca/Downloads/ICSE2015_RevisitingTheImpactOfClassificationTechniquesOnThePerformanceOfDefectPredictionModels.pdf) Proceedings of the International Conference on Software Engineering (ICSE), 2015.

#### (3) Ranking and identifying the most frequent developer search tasks.

- Xia et al. ["What do developers search for on the web?"](http://sail.cs.queensu.ca/Downloads/EMSE2017_WhatDoDevelopersSearchForOnTheWeb.pdf) Empirical Software Engineering (2017): 1-37.

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
### Example Usage
```r
library(ScottKnottESD)

# An example dataset: The 1,000 variable importance scores of 9 software metrics. 
# The scores are generated by the Random Forests technique using 1,000 out-of-sample bootstrap.
example

sk <- sk_esd(example)
plot(sk)

sk <- sk_esd(maven)
plot(sk)
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
