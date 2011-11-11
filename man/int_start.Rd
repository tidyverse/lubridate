\name{int_start}
\alias{int_start}
\alias{int_start<-}
\title{Access and change the start date of an interval}
\usage{
  int_start(x)
}
\arguments{
  \item{x}{An interval object}
}
\value{
  A POSIXct date object when used as an accessor. Nothing
  when used as a settor
}
\description{
  Changing the start date of an interval does not change
  the length of the interval. It shifts when the interval
  occurs.
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

