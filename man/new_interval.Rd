\name{new_interval}
\alias{new_interval}
\title{Create an interval object.}
\usage{
  new_interval(start, end)
}
\arguments{
  \item{date1}{a POSIXt or Date date-time object}

  \item{date2}{a POSIXt or Date date-time object}
}
\value{
  an interval object
}
\description{
  new_interval creates an interval object with the
  specified start and end dates. new_interval automatically
  assigns the date that occurs first in time as the start
  date and the date that occurs later as the end date. As a
  result, intervals are always positive.
}
\details{
  Intervals are time spans bound by two real date-times.
  Intervals can be accurately converted to either period or
  duration objects using \code{\link{as.period}},
  \code{\link{as.duration}}. Since an interval is anchored
  to a fixed history of time, both the exact number of
  seconds that passed and the number of variable length
  time units that occurred during the interval can be
  calculated.  Subtracting two date times automatically
  creates an interval object.
}
\examples{
new_interval(ymd(20090201), ymd(20090101))
# 2009-01-01 -- 2009-02-01

date1 <- as.POSIXct("2009-03-08 01:59:59")
date2 <- as.POSIXct("2000-02-29 12:00:00")
new_interval(date2, date1)
# 2000-02-29 12:00:00 -- 2009-03-08 01:59:59
new_interval(date1, date2)
# 2000-02-29 12:00:00 -- 2009-03-08 01:59:59

span <- new_interval(ymd(20090201), ymd(20090101))
# [1] 2009-01-01 -- 2009-02-01
span - days(30)
# 2009-01-01 -- 2009-01-02
span + months(6)
# 2009-01-01 -- 2009-08-01

start <- attr(span, "start")
# "2009-01-01 UTC"
end <- start + span
# "2009-02-01 UTC"
}
\seealso{
  \code{\link{interval}}, \code{\link{as.interval}}
}
\keyword{chron}
\keyword{classes}

