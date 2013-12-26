\name{ms}
\alias{ms}
\title{Create a period with the specified number of minutes and seconds}
\usage{
  ms(..., quiet = FALSE)
}
\arguments{
  \item{...}{character or numeric vectors of minute second
  pairs}

  \item{quiet}{logical. When TRUE function evalueates
  without displaying customary messages.}
}
\value{
  a vector of class \code{Period}
}
\description{
  Transforms character or numeric vectors into a period
  object with the specified number of minutes and seconds.
  ms() Arbitrary text can separate minutes and seconds.
  Fractional separator is assumed to be ".". After minutes
  and seconds have been parsed, all numeric input is
  ignored.
}
\examples{
x <- c("09:10", "09:02", "1:10")
ms(x)
# [1] 9 minutes and 10 seconds   9 minutes and 2 seconds   1 minute and 10 seconds
ms("7 6")
# [1] 7 minutes and 6 seconds
ms("6,5")
# 6 minutes and 5 seconds
}
\seealso{
  \code{\link{hms}, \link{hm}}
}
\keyword{period}

