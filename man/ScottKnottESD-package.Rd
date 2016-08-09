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
Version: \tab 1.1\cr
Date: \tab 2016-08-08\cr
License: \tab MIT\cr
}

}
\author{
Chakkrit (Kla) Tantithamthavorn

Maintainer: Chakkrit (Kla) Tantithamthavorn <kla@chakkrit.com>
}
\references{
-
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
