\name{as.duration}
\alias{as.duration}
\title{Change an object to a duration (difftime).}
\usage{as.duration(x)}

\description{
  Change an object to a duration (difftime).
}

\details{
  as.duration changes interval, period and numeric
  objects to duration objects. Numeric objects are
  changed to duration objects with the seconds unit equal
  to the numeric value.

  Durations are exact time measurements, whereas periods
  are relative time measurements. See
  \code{\link{periods}}. The length of a period depends
  on when it occurs. Hence, a one to one mapping does not
  exist between durations and periods. When used with a
  period object, as.duration provides an inexact estimate
  of the length of the period; each time unit is assigned
  its most common number of seconds. Periods with a
  months unit cannot be coerced to durations because of
  the variability of month lengths. For an exact
  transformation, first transform the period to an
  interval with \code{\link{as.interval}}.
}
\value{a duration object}
\seealso{\code{\link{duration}}, \code{\link{new_duration}}}
\keyword{classes}
\keyword{manip}
\keyword{methods}
\keyword{chron}
\arguments{
  \item{x}{an interval, period, or numeric object}
}
\examples{span <- new_interval(ymd("2009-01-01"), ymd("2009-08-01")) #interval
# 2009-01-01 -- 2009-08-01 
as.duration(span)
# 18316800s (212d)
as.duration(10) # numeric
# 10s}
