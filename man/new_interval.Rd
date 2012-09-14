\name{new_interval}
\alias{\%--\%}
\alias{interval}
\alias{new_interval}
\title{Create an interval object.}
\usage{
  new_interval(start, end, tzone = attr(start, "tzone"))
}
\arguments{
  \item{start}{a POSIXt or Date date-time object}

  \item{end}{a POSIXt or Date date-time object}

  \item{tzone}{a recognized timezone to display the
  interval in}
}
\value{
  an Interval object
}
\description{
  interval creates an \code{\link{Interval-class}} object
  with the specified start and end dates. If the start date
  occurs before the end date, the interval will be
  positive. Otherwise, it will be negative.
}
\details{
  Intervals are time spans bound by two real date-times.
  Intervals can be accurately converted to either period or
  duration objects using \code{\link{as.period}},
  \code{\link{as.duration}}. Since an interval is anchored
  to a fixed history of time, both the exact number of
  seconds that passed and the number of variable length
  time units that occurred during the interval can be
  calculated.

  \code{\%--\%} Creates an interval that covers the range
  spanned by two dates. It replaces the original behavior
  of lubridate, which created an interval by default
  whenever two date-times were subtracted.
}
\examples{
new_interval(ymd(20090201), ymd(20090101))
# 2009-02-01 UTC--2009-01-01 UTC

date1 <- as.POSIXct("2009-03-08 01:59:59")
date2 <- as.POSIXct("2000-02-29 12:00:00")
new_interval(date2, date1)
# 2000-02-29 12:00:00 CST--2009-03-08 01:59:59 CST
new_interval(date1, date2)
# 2009-03-08 01:59:59 CST--2000-02-29 12:00:00 CST

span <- new_interval(ymd(20090101), ymd(20090201))
# 2009-01-01 UTC--2009-02-01 UTC
}
\seealso{
  \code{\link{Interval-class}}, \code{\link{as.interval}}
}

