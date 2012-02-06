\name{int_start}
\alias{int_start}
\alias{int_start<-}
\title{Access and change the start date of an interval}
\usage{
  int_start(x)
}
\arguments{
  \item{int}{An interval object}

  \item{value}{A date-time object that can be coerced to
  POSIXct}
}
\value{
  A POSIXct date object when used as an accessor. Nothing
  when used as a settor
}
\description{
  Note that changing the start date of an interval will
  change the length of the interval, since the end date
  will remain the same.
}
\examples{
int <- new_interval(ymd("2001-01-01"), ymd("2002-01-01"))
# 2001-01-01 -- 2002-01-01
int_start(int)
# "2001-01-01 UTC"
int_start(int) <- ymd("2001-06-01")
int
# 2001-06-01 -- 2002-06-01
}
\seealso{
  \code{\link{int_end}}, \code{\link{int_shift}},
  \code{\link{int_flip}}
}

