\name{ScottKnottESD-package}
\alias{ScottKnottESD-package}
\alias{ScottKnottESD}
\docType{package}
\title{
The Scott-Knott Effect Size Difference (ESD) Test
}
\description{
An enhancement of the Scott-Knott test (which cluster distributions into statistically distinct ranks) that takes effect size into consideration.
}
\details{
\tabular{ll}{
Package: \tab ScottKnottESD\cr
Type: \tab Package\cr
Version: \tab 1.2\cr
Date: \tab 2017-05-04\cr
License: \tab GPL (>= 2)\cr
}

}
\author{
Chakkrit (Kla) Tantithamthavorn

Maintainer: Chakkrit (Kla) Tantithamthavorn <kla@chakkrit.com>
}
\references{
Chakkrit Tantithamthavorn, Shane McIntosh, Ahmed E. Hassan, Kenichi Matsumoto:
An Empirical Comparison of Model Validation Techniques for Defect Prediction Models. IEEE Transactions on Software Engineering. 43(1): 1-18 (2017).
}

\keyword{ ScottKnottESD }
\seealso{
-
}
\examples{
sk <- sk_esd(example)
sk$original  # Original Groups
sk$groups    # Corrected Groups with effect size wise
sk$reverse   # Reversed Groups
}
