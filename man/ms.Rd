\name{ms}
\alias{ms}
\title{Create a period with the specified number of minutes and seconds...}
\usage{ms(...)}

\description{
  Create a period with the specified number of minutes and
  seconds
}

\details{
  Transforms a character string into a period object with
  the specified number of minutes and seconds. ms()
  recognizes all non-alphanumeric separators of length 1
  with the exception of ".".
}
\value{a vector of period objects}
\seealso{\code{\link{hms}, \link{hm}}}
\keyword{period}
\arguments{
  \item{...}{a character vector of minute second pairs}
}
\examples{x <- c("09:10", "09:02", "1:10")
ms(x)
# [1] 9 minutes and 10 seconds   9 minutes and 2 seconds   1 minute and 10 seconds
ms("7 6")
# [1] 7 minutes and 6 seconds
ms("6,5")
# 6 minutes and 5 seconds}
