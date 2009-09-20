\name{as.duration}
\title{Change an object to a duration (difftime).}
\usage{as.duration(x)}

\description{
  Change an object to a duration (difftime).
}

\details{
  as.duration changes interval, period and numeric objects to duration
  objects, which are difftime objects. Numeric objects are changed to
  duration objects with the seconds unit equal to the numeric value.

  Durations are exact time measurements, but periods are relative time
  measurements. See \code{\link{periods}}. The length of a period
  depends on when it occurs. Hence, a one to one mapping does not exist
  between durations and periods. When used with a period object,
  as.duration provides an inexact estimate of the length of the period;
  each time unit is assigned its most common number of seconds. Periods
  with a months unit cannot be coerced to durations because of the
  variability of month lengths. For an exact transformation, first
  transform the period to an interval with \code{\link{as.interval}}.
}
\alias{as.duration}
\alias{as.duration.default}
\alias{as.duration.period}
\alias{as.duration.interval}
\value{a duration object}
\seealso{\code{\link{duration}}, \code{\link{new_duration}}}
\keyword{classes}
\keyword{manip}
\keyword{methods}
\keyword{chron}
\arguments{
  \item{x}{an interval, period, or numeric object}
}
\examples{span <- new_interval(as.POSIXct("2009-01-01"), as.POSIXct("2009-08-01")) #interval
# 211.9583 days beginning at 2009-01-01
as.duration(span)
# Time difference of 211.9583 days
as.duration(10) # numeric
# Time difference of 10 secs}
