\name{as.period}
\alias{as.period}
\alias{as.period-methods}
\title{Change an object to a period.}
\usage{
  as.period(x)

  as.period()
}
\arguments{
  \item{x}{an interval, difftime, or numeric object}
}
\value{
  a period object
}
\description{
  as.period changes interval, duration (i.e., difftime) and
  numeric objects to period objects with the specified
  units.
}
\details{
  Users must specify which time units to measure the period
  in. The length of each time unit in a period depends on
  when it occurs. See \code{\link{Period-class}} and
  \code{\link{new_period}}. The choice of units is not
  trivial; units that are normally equal may differ in
  length depending on when the time period occurs. For
  example, when a leap second occurs one minute is longer
  than 60 seconds.

  Because periods do not have a fixed length, they can not
  be accurately converted to and from duration objects.
  Duration objects measure time spans in exact numbers of
  seconds, see \code{\link{Duration-class}}. Hence, a one
  to one mapping does not exist between durations and
  periods. When used with a duration object, as.period
  provides an inexact estimate; the duration is broken into
  time units based on the most common lengths of time
  units, in seconds. Because the length of months are
  particularly variable, a period with a months unit can
  not be coerced from a duration object. For an exact
  transformation, first transform the duration to an
  interval with \code{\link{as.interval}}.
}
\examples{
span <- new_interval(as.POSIXct("2009-01-01"), as.POSIXct("2010-02-02 01:01:01")) #interval
# [1] 2009-01-01 -- 2010-02-02 01:01:01
as.period(span)
# 1 year, 1 month, 1 day, 1 hour, 1 minute and 1 second
}
\seealso{
  \code{\link{Period-class}}, \code{\link{new_period}}
}
\keyword{chron}
\keyword{classes}
\keyword{manip}
\keyword{methods}

