\name{end.interval}
\alias{end.interval}
\title{Access and change the end date of an interval...}
\usage{end<-(interval, value)}

\description{
  Access and change the end date of an interval
}

\details{
  Changing the end date of an interval does not change the
  length of the interval. It shifts when the interval
  occurs.
}
\value{A POSIXct date object when used as an accessor. Nothing when used as a settor}
\arguments{
  \item{x}{An interval object}
  \item{value}{A POSIXct date to set the end date to, if setting.}
}
\examples{int <- new_interval(ymd("2001-01-01"), ymd("2002-01-01"))
# 2001-01-01 -- 2002-01-01
end(int)
# "2002-01-01 UTC"
end(int) <- ymd("2002-06-01")
int
# 2001-06-01 -- 2002-06-01}
