\name{hms}
\alias{hms}
\title{Create a period with the specified hours, minutes, and seconds}
\usage{
  hms(..., quiet = FALSE, truncated = 0)
}
\arguments{
  \item{...}{a character vector of hour minute second
  triples}

  \item{quiet}{logical. When TRUE function evalueates
  without displaying customary messages.}

  \item{truncated}{integer, number of formats that can be
  missing. See \code{\link{parse_date_time}}.}
}
\value{
  a vector of period objects
}
\description{
  Transforms a character or numeric vector into a period
  object with the specified number of hours, minutes, and
  seconds. hms() recognizes all non-alphanumeric
  separators, as well as no separator.
}
\examples{
x <- c("09:10:01", "09:10:02", "09:10:03", "Collided at 9:20:04 pm")
hms(x)
# [1] 9 hours, 10 minutes and 1 second   9 hours, 10 minutes and 2 seconds   9 hours, 10 minutes and 3 seconds
hms("7 6 5", "3-23---2", "2 : 23 : 33")
## 7 hours, 6 minutes and 5 seconds    3 hours, 23 minutes and 2 seconds  2 hours, 23 minutes and 33 seconds
}
\seealso{
  \code{\link{hm}, \link{ms}}
}
\keyword{period}

