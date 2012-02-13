\name{seconds}
\alias{days}
\alias{hours}
\alias{microseconds}
\alias{milliseconds}
\alias{minutes}
\alias{nanoseconds}
\alias{picoseconds}
\alias{seconds}
\alias{weeks}
\alias{years}
\title{Quickly create relative timespans.}
\usage{
  seconds(x = 1)
}
\arguments{
  \item{x}{numeric value of the number of units to be
  contained in the period. With the exception of seconds(),
  x must be an integer.}
}
\value{
  a period object
}
\description{
  Quickly create Period objects for easy date-time
  manipulation. The units of the period created depend on
  the name of the function called. For Period objects,
  units do not have a fixed length until they are added to
  a specific date time, contrast this with
  \code{\link{new_duration}}. This makes periods useful for
  manipulations with clock times because units expand or
  contract in length to accomodate conventions such as leap
  years, leap seconds, and Daylight Savings Time.
}
\details{
  When paired with date-times, these functions allow
  date-times to be manipulated in a method similar to
  object oriented programming. Period objects can be added
  to Date, POSIXct, and POSIXlt objects to calculate new
  date-times.
}
\examples{
x <- as.POSIXct("2009-08-03")
# "2009-08-03 CDT"
x + days(1) + hours(6) + minutes(30)
# "2009-08-04 06:30:00 CDT"
x + days(100) - hours(8)
# "2009-11-10 15:00:00 CST"

class(as.Date("2009-08-09") + days(1)) # retains Date class
# "Date"
as.Date("2009-08-09") + hours(12)
# "2009-08-09 12:00:00 UTC"
class(as.Date("2009-08-09") + hours(12))
# "POSIXt"  "POSIXct"
# converts to POSIXt class to accomodate time units

years(1) - months(7)
# 1 year and -7 months
c(1:3) * hours(1)
# 1 hour   2 hours   3 hours
hours(1:3)
# 1 hour   2 hours   3 hours

#sequencing
y <- ymd(090101) # "2009-01-01 CST"
y + months(0:11)
# [1] "2009-01-01 CST" "2009-02-01 CST" "2009-03-01 CST" "2009-04-01 CDT"
# [5] "2009-05-01 CDT" "2009-06-01 CDT" "2009-07-01 CDT" "2009-08-01 CDT"
# [9] "2009-09-01 CDT" "2009-10-01 CDT" "2009-11-01 CDT" "2009-12-01 CST"

# end of month handling
ymd(20090131) + months(0:11)
# Undefined date. Defaulting to last previous real day.
# [1] "2009-01-31 CST" "2009-02-28 CST" "2009-03-31 CDT" "2009-04-30 CDT"
# [5] "2009-05-31 CDT" "2009-06-30 CDT" "2009-07-31 CDT" "2009-08-31 CDT"
# [9] "2009-09-30 CDT" "2009-10-31 CDT" "2009-11-30 CST" "2009-12-31 CST"

# compare DST handling to durations
boundary <- as.POSIXct("2009-03-08 01:59:59")
# "2009-03-08 01:59:59 CST"
boundary + days(1) # period
# "2009-03-09 01:59:59 CDT" (clock time advances by a day)
boundary + edays(1) # duration
# "2009-03-09 02:59:59 CDT" (clock time corresponding to 86400 seconds later)
}
\seealso{
  \code{\link{Period-class}}, \code{\link{new_period}},
  \code{\link{ddays}}
}
\keyword{chron}
\keyword{manip}

