\name{hms}
\alias{hms}
\title{Create a period with the specified hours, minutes, and seconds}
\usage{
  hms(...)
}
\arguments{
  \item{...}{a character vector of hour minute second
  triples}
}
\value{
  a vector of period objects
}
\description{
  Transforms a character string into a period object with
  the specified number of hours, minutes, and seconds.
  hms() recognizes all non-alphanumeric separators of
  length 1 with the exception of ".".
}
\examples{
x <- c("09:10:01", "09:10:02", "09:10:03")
hms(x)
# [1] 9 hours, 10 minutes and 1 second   9 hours, 10 minutes and 2 seconds   9 hours, 10 minutes and 3 seconds
hms("7 6 5")
# [1] 7 hours, 6 minutes and 5 seconds
}
\seealso{
  \code{\link{hm}, \link{ms}}
}
\keyword{period}

