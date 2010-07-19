\name{eseconds}
\title{Quickly create exact time spans.}
\usage{eseconds(x=1)}

\description{
  Quickly create exact time spans.
}

\details{
  Quickly create duration objects for easy date-time manipulation. The
  units of the duration created depend on the name of the function
  called. For duration objects, units are equal to their most common
  lengths in seconds (i.e.  minutes = 60 seconds, hours = 3600 seconds,
  days = 86400 seconds, weeks = 604800, years = 31536000).

  When paired with date-times, these functions allow date-times to be
  manipulated in a method similar to object oriented programming.
  Duration objects can be added to Date, POSIXt, and Interval objects.
}
\alias{eseconds}
\alias{eminutes}
\alias{ehours}
\alias{edays}
\alias{eweeks}
\alias{eyears}
\value{a duration object}
\seealso{\code{\link{duration}}, \code{\link{new_duration}}, \code{\link{days}}}
\keyword{chron}
\keyword{manip}
\arguments{
  \item{x}{numeric value of the number of units to be contained in the duration.}
}
\examples{eseconds(1) 
# Time difference of 1 secs
eminutes(3.5) 
# Time difference of 3.5 mins

x <- as.POSIXct("2009-08-03") 
# "2009-08-03 CDT"
x + edays(1) + ehours(6) + eminutes(30)
# "2009-08-04 06:30:00 CDT"
x + edays(100) - ehours(8) 
# "2009-11-10 15:00:00 CST"

class(as.Date("2009-08-09") + edays(1)) # retains Date class
# "Date"
as.Date("2009-08-09") + ehours(12) 
# "2009-08-09 12:00:00 UTC"
class(as.Date("2009-08-09") + ehours(12)) 
# "POSIXt"  "POSIXct"
# converts to POSIXt class to accomodate time units

eweeks(1) - edays(7) 
# Time difference of 0 secs
c(1:3) * ehours(1) 
# Time differences in hours
# [1] 1 2 3
#
# compare DST handling to durations
boundary <- as.POSIXct("2009-03-08 01:59:59")
# "2009-03-08 01:59:59 CST"
boundary + days(1) # period
# "2009-03-09 01:59:59 CDT" (clock time advances by a day)
boundary + edays(1) # duration
# "2009-03-09 02:59:59 CDT" (clock time corresponding to 86400 seconds later)}
