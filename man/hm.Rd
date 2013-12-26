\name{hm}
\alias{hm}
\title{Create a period with the specified number of hours and minutes}
\usage{
  hm(..., quiet = FALSE)
}
\arguments{
  \item{...}{character or numeric vectors of hour minute
  pairs}

  \item{quiet}{logical. When TRUE function evalueates
  without displaying customary messages.}
}
\value{
  a vector of class \code{Period}
}
\description{
  Transforms a character or numeric vectors into a period
  object with the specified number of hours and minutes.
  Arbitrary non-numeric text can separate hours and
  minutes.  After hours and minutes have been parsed, the
  remaining input is ignored.
}
\examples{
x <- c("09:10", "09:02", "1:10")
hm(x)
# [1] 9 hours and 10 minutes   9 hours and 2 minutes   1 hour and 10 minutes
hm("7 6")
# [1] 7 hours and 6 minutes
hm("6,5")
# [1] 6 hours and 5 minutes
}
\seealso{
  \code{\link{hms}, \link{ms}}
}
\keyword{period}

