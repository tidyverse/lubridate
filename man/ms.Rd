\name{ms}
\alias{ms}
\title{Create a period with the specified number of minutes and seconds}
\usage{
  ms(..., frac = FALSE)
}
\arguments{
  \item{...}{character or numeric vectors of minute second
  pairs}

  \item{frac}{If \code{TRUE}, fractional seconds are
  allowed. It is assumed that fractional seconds are
  separated by ".". If \code{TRUE}, "." cannot be used as a
  separator between minutes and seconds.}
}
\value{
  a vector of class \code{Period}
}
\description{
  Transforms character or numeric vectors into a period
  object with the specified number of minutes and seconds.
  ms() recognizes all non-alphanumeric separators as well
  as no separator.
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

