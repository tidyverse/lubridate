\name{as.interval}
\alias{as.interval}
\title{Change an object to an interval.}
\usage{as.interval(x, start)}

\description{
  Change an object to an interval.
}

\details{
  as.interval changes difftime, duration, period and
  numeric objects to intervals that begin at the
  specified date-time. Numeric objects are first coerced
  to time spans equal to the numeric value in seconds.

  as.interval can be used to create accurate
  transformations between period objects, which measure
  time spans in variable length units, and difftime
  objects, which measure timespans as an exact number of
  seconds. A start date- time must be supplied to make
  the conversion. Lubridate uses this start date to look
  up how many seconds each variable length unit (e.g.
  month, year) lasted for during the time span described.
  See \code{\link{as.duration}}, \code{\link{as.period}}.
}
\value{an interval object}
\seealso{\code{\link{interval}}, \code{\link{new_interval}}}
\keyword{classes}
\keyword{manip}
\keyword{methods}
\keyword{chron}
\arguments{
  \item{x}{a duration (i.e. difftime), period, or numeric object that describes the length of the 
interval}
  \item{origin}{a POSIXt or Date object that describes when the interval begins}
}
\examples{diff <- new_difftime(days = 31) #difftime
as.interval(diff, ymd("2009-01-01"))
# 2009-01-01 -- 2009-02-01
as.interval(diff, ymd("2009-02-01"))
# 2009-02-01 -- 2009-03-04

dur <- new_duration(days = 31) #duration
as.interval(dur, ymd("2009-01-01"))
# 2009-01-01 -- 2009-02-01
as.interval(dur, ymd("2009-02-01"))
# 2009-02-01 -- 2009-03-04

per <- new_period(months = 1) #period
as.interval(per, ymd("2009-01-01"))
# 2009-01-01 -- 2009-02-01 
as.interval(per, ymd("2009-02-01"))
# 2009-02-01 -- 2009-03-01

as.interval(3600, ymd("2009-01-01")) #numeric
# 2009-01-01 -- 2009-01-01 01:00:00}
