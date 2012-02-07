\name{as.duration}
\alias{as.duration}
\alias{as.duration,difftime-method}
\alias{as.duration,Duration-method}
\alias{as.duration,Interval-method}
\alias{as.duration,numeric-method}
\alias{as.duration,Period-method}
\title{Change an object to a duration.}
\usage{
  as.duration(x)
}
\arguments{
  \item{x}{Object to be coerced to a duration}
}
\value{
  A duration object
}
\description{
  as.duration changes interval, period and numeric objects
  to duration objects. Numeric objects are changed to
  duration objects with the seconds unit equal to the
  numeric value.
}
\details{
  Durations are exact time measurements, whereas periods
  are relative time measurements. See
  \code{\link{Period-class}}. The length of a period
  depends on when it occurs. Hence, a one to one mapping
  does not exist between durations and periods. When used
  with a period object, as.duration provides an inexact
  estimate of the length of the period; each time unit is
  assigned its most common number of seconds. Periods with
  a months unit cannot be coerced to durations because of
  the variability of month lengths. For an exact
  transformation, first transform the period to an interval
  with \code{\link{as.interval}}.
}
\examples{
span <- new_interval(ymd("2009-01-01"), ymd("2009-08-01")) #interval
# 2009-01-01 -- 2009-08-01
as.duration(span)
# 18316800s (212d)
as.duration(10) # numeric
# 10s
}
\seealso{
  \code{\link{Duration-class}}, \code{\link{new_duration}}
}
\keyword{chron}
\keyword{classes}
\keyword{manip}
\keyword{methods}

