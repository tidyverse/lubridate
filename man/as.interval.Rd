\name{as.interval}
\alias{as.interval}
\title{Change an object to an interval.}
\usage{as.interval(x, origin)}

\description{
  Change an object to an interval.
}

\details{
  as.interval changes duration (i.e. difftime), period and numeric
  objects to intervals that begin at the specified date-time. Numeric
  objects are first coerced to time spans equal to the numeric value in
  seconds.

  as.interval can be used to create accurate transformations between
  period objects, which describe time spans in relative units, and
  duration objects, which describe timespans in exact units. To do
  this, however, an origin date- time must be supplied from which to
  measure the period. See \code{\link{as.duration}},
  \code{\link{as.period}}.
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
\examples{diff <- new_duration(days = 31) #duration
as.interval(diff, as.POSIXct("2009-01-01"))
# 31 days beginning at 2009-01-01
as.interval(diff, as.POSIXct("2009-02-01"))
# 31 days beginning at 2009-02-01

per <- new_period(months = 1) #period
as.interval(per, as.POSIXct("2009-01-01"))
# 31 days beginning at 2009-01-01
as.interval(per, as.POSIXct("2009-02-01"))
# 28 days beginning at 2009-02-01
as.interval(3600, as.POSIXct("2009-01-01")) #numeric
# 1 hours beginning at 2009-01-01}
