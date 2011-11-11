\name{int_end}
\alias{int_end}
\alias{int_end<-}
\title{Access and change the end date of an interval}
\usage{
  int_end(x)
}
\arguments{
  \item{x}{An interval object}
}
\value{
  A POSIXct date object when used as an accessor. Nothing
  when used as a settor
}
\description{
  Changing the end date of an interval does not change the
  length of the interval. It shifts when the interval
  occurs.
}
\examples{
int <- new_interval(ymd("2001-01-01"), ymd("2002-01-01"))
# 2001-01-01 -- 2002-01-01
int_end(int)
# "2002-01-01 UTC"
int_end(int) <- ymd("2002-06-01")
int
# 2001-06-01 -- 2002-06-01
}

