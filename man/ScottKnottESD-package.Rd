\name{ScottKnottESD-package}
\alias{ScottKnottESD-package}
\alias{ScottKnottESD}
\docType{package}
\title{
The Scott-Knott Effect Size Difference (ESD) Test
}
\description{
The Scott-Knott Effect Size Difference (ESD) test is a mean comparison approach that leverages a hierarchical clustering to partition the set of treatment means (e.g., means of variable importance scores, means of model performance) into statistically distinct groups with non-negligible difference [Tantithamthavorn et al., (2018) <doi:10.1109/TSE.2018.2794977>].
It is an alternative approach of the Scott-Knott test that considers the magnitude of the difference (i.e., effect size) of treatment means with-in a group and between groups.
Therefore, the Scott-Knott ESD test (v2.x) produces the ranking of treatment means while ensuring that (1) the magnitude of the difference for all of the treatments in each group is negligible; and (2) the magnitude of the difference of treatments between groups is non-negligible.

The mechanism of the Scott-Knott ESD test (v2.x) is made up of 2 steps:

(Step 1) Find a partition that maximizes treatment means between groups. We begin by sorting the treatment means. Then, following the original Scott-Knott test, we compute the sum of squares between groups (i.e., a dispersion measure of data points) to identify a partition that maximizes treatment means between groups. 

(Step 2) Splitting into two groups or merging into one group. Instead of using a likelihood ratio test and a Chi-square distribution as a splitting and merging criterion (i.e., a hypothesis testing of the equality of all treatment means), we analyze the magnitude of the difference for each pair for all of the treatment means of the two groups. If there is any one pair of treatment means of two groups are non-negligible, we split into two groups. Otherwise, we merge into one group. We use the Cohen effect size --- an effect size estimate based on the difference between the two means divided by the standard deviation of the two treatment means (d = (mean(x_1) - mean(x_2))/s.d.).

Unlike the earlier version of the Scott-Knott ESD test (v1.x) that post-processes the groups that are produced by the Scott-Knott test, the Scott-Knott ESD test (v2.x) pre-processes the groups by merging pairs of statistically distinct groups that have a negligible difference.
}
\details{
\tabular{ll}{
Package: \tab ScottKnottESD\cr
Type: \tab Package\cr
Version: \tab 2.0.3\cr
Date: \tab 2017-07-03\cr
License: \tab GPL (>= 2)\cr
}

}
\author{
Chakkrit (Kla) Tantithamthavorn

Maintainer: Chakkrit (Kla) Tantithamthavorn <kla@chakkrit.com>
}
\references{
Chakkrit Tantithamthavorn, Shane McIntosh, Ahmed E. Hassan, Kenichi Matsumoto,
An Empirical Comparison of Model Validation Techniques for Defect Prediction Models. IEEE Transactions on Software Engineering. 43(1): 1-18 (2017). <doi:10.1109/TSE.2016.2584050>

Chakkrit Tantithamthavorn, Shane McIntosh, Ahmed E. Hassan, Kenichi Matsumoto,
The Impact of Automated Parameter Optimization for Defect Prediction Models. IEEE Transactions on Software Engineering. Early Access. (2018). <doi:10.1109/TSE.2018.2794977>
}

\keyword{ ScottKnottESD }
\seealso{
-
}
\examples{
library(ScottKnottESD)

sk <- sk_esd(example)
plot(sk)
 
sk <- sk_esd(maven)
plot(sk)
}
