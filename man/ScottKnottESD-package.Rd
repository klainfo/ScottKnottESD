\name{ScottKnottESD-package}
\alias{ScottKnottESD-package}
\alias{ScottKnottESD}
\docType{package}
\title{
The Scott-Knott Effect Size Difference (ESD) Test
}
\description{
An enhancement of the Scott-Knott test (which clusters distributions into statistically distinct ranks) that takes effect size into consideration
[Tantithamthavorn et al., (2017) <http://dx.doi.org/10.1109/TSE.2016.2584050>].
}
\details{
\tabular{ll}{
Package: \tab ScottKnottESD\cr
Type: \tab Package\cr
Version: \tab 1.2.2\cr
Date: \tab 2017-05-07\cr
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
}

\keyword{ ScottKnottESD }
\seealso{
-
}
\examples{
library(ScottKnottESD)

# Example dataset
example

# Convert data from long format to wide format
long <- melt(example, id.vars=0)
wide <- long2wide(long) # A wide-format data frame

# Check basic ANOVA assumptions
check.ANOVA.assumptions(example)

sk <- sk_esd(example)
sk$original  # Original Groups
sk$groups    # Corrected Groups with effect size wise
sk$reverse   # Reversed Groups
}
