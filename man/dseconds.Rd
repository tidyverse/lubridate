\name{dseconds}
\title{Quickly create exact time spans.}
\usage{dseconds(x=1)}

\description{
  Quickly create exact time spans.
}

\details{
  Quickly create duration objects for easy date-time
  manipulation. The units of the duration created depend on
  the name of the function called. For duration objects,
  units are equal to their most common lengths in seconds
  (i.e.  minutes = 60 seconds, hours = 3600 seconds, days =
  86400 seconds, weeks = 604800, years = 31536000).

  When paired with date-times, these functions allow
  date-times to be manipulated in a method similar to
  object oriented programming. Duration objects can be
  added to Date, POSIXt, and Interval objects.
}
\alias{eseconds}
\alias{eminutes}
\alias{ehours}
\alias{edays}
\alias{eweeks}
\alias{eyears}
\alias{dseconds}
\alias{dminutes}
\alias{dhours}
\alias{ddays}
\alias{dweeks}
\alias{dyears}
\alias{dmilliseconds}
\alias{emilliseconds}
\alias{dmicroseconds}
\alias{emicroseconds}
\alias{dnanoseconds}
\alias{enanoseconds}
\alias{dpicoseconds}
\alias{epicoseconds}
\value{a duration object}
\seealso{\code{\link{duration}}, \code{\link{new_duration}}, \code{\link{days}}}
\keyword{chron}
\keyword{manip}
\arguments{
  \item{x}{numeric value of the number of units to be contained in the duration.}
}
\examples{dseconds(1) 
# 1s
dminutes(3.5) 
# 210s

x <- as.POSIXct("2009-08-03") 
# "2009-08-03 CDT"
x + ddays(1) + dhours(6) + dminutes(30)
# "2009-08-04 06:30:00 CDT"
x + ddays(100) - dhours(8) 
# "2009-11-10 15:00:00 CST"

class(as.Date("2009-08-09") + ddays(1)) # retains Date class
# "Date"
as.Date("2009-08-09") + dhours(12) 
# "2009-08-09 12:00:00 UTC"
class(as.Date("2009-08-09") + dhours(12)) 
# "POSIXt"  "POSIXct"
# converts to POSIXt class to accomodate time units

dweeks(1) - ddays(7) 
# 0s
c(1:3) * dhours(1) 
# 3600s  7200s  10800s
#
# compare DST handling to durations
boundary <- as.POSIXct("2009-03-08 01:59:59")
# "2009-03-08 01:59:59 CST"
boundary + days(1) # period
# "2009-03-09 01:59:59 CDT" (clock time advances by a day)
boundary + ddays(1) # duration
# "2009-03-09 02:59:59 CDT" (clock time corresponding to 86400 seconds later)}
