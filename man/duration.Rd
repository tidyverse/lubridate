\name{duration}
\title{Description of time span classes in lubridate.}

\description{
  Description of time span classes in lubridate.
}

\details{
  A time span can be measured in three ways: as a duration, an
  interval, or a period.

  Durations record the exact number of seconds in a time span. They
  measure the exact passage of time and are not affected by conventions
  such as leap years and Daylight Savings Time. lubridate uses the
  difftime class from base::R for durations. Additional difftime
  methods have been created to facilitate this.

  difftime displays durations in various units, but these units are
  estimates given for convenience. The underlying object is always
  recorded as a fixed number of seconds. For display and creation
  purposes, units are converted to seconds using their most common
  lengths in seconds. Minutes = 60 seconds, hours = 3600 seconds, days
  = 86400 seconds, weeks = 604800. Units larger than weeks are not used
  due to their variability.

  duration objects can be easily created with the helper functions
  \code{\link{eweeks}}, \code{\link{edays}}, \code{\link{eminutes}},
  \code{\link{eseconds}}. These objects can be added to and subtracted
  to date- times to create a user interface similar to object oriented
  programming.  Duration objects can be added to Date, POSIXt, and
  Interval objects.

  Periods record the change in the clock time between two date-times.
  They are measured in common time related units: years, months, days,
  hours, minutes, and seconds. Each unit except for seconds must be
  expressed in integer values. With the exception of seconds, none of
  these units have a fixed length. Leap years, leap seconds, and
  Daylight Savings Time can expand or contract a time unit depending on
  when it occurs.  For this reason, periods do not have a fixed length
  until they are paired with a start date. Periods can be used to track
  changes in clock time. Because they do not have a fixed length, they
  can not be accurately converted to and from durations.

  Period objects can be easily created with the helper functions
  \code{\link{years}}, \code{\link{months}}, \code{\link{weeks}},
  \code{\link{days}}, \code{\link{minutes}}, \code{\link{seconds}}.
  These objects can be added to and subtracted to date-times to create
  a user interface similar to object oriented programming. Period
  objects can be added to Date, POSIXt, and Interval objects.

  Intervals are time spans bound by two real date-times.  Intervals can
  be accurately converted to periods and durations. Since an interval
  is anchored to a fixed history of time, both the number of seconds
  that passed as well as the length of common time units during that
  history can be calculated. To accurately convert between periods and
  durations, a period or duration should first be converted to an
  interval. Subtracting two date times automatically creates an
  interval object. Intervals display as the difftime between the two
  dates paired with the earlier, or beginning date.
}
\alias{timespan}
\alias{timespans}
\alias{duration}
\alias{durations}
\alias{dur}
\alias{periods}
\alias{period}
\alias{interval}
\alias{intervals}
\seealso{\code{\link{new_duration}} for creating duration objects and \code{\link{as.duration}} 
for converting objects into durations}
\seealso{\code{\link{new_period}} for creating period objects and \code{\link{as_period}} for 
converting objects to periods}
\seealso{\code{\link{new_interval}} for creating interval objects and \code{\link{as_interval}} 
for converting objects to intervals}
\keyword{classes}
\keyword{chron}
\examples{new_duration(second = 3690)
# Time difference of 1.025 hours
new_period(second = 3690)
# 3690 seconds
new_period(second = 30, minute = 1, hour = 1)
1 hour, 1 minute and 30 seconds
new_interval(as.POSIXct("2009-08-09 12:00:00"), as.POSIXct("2009-08-09 13:01:30"))
[1] 1.025 hours beginning at 2009-08-09 12:00:00

date <- as.POSIXct("2009-03-08 01:59:59") # DST boundary
# "2009-03-08 01:59:59 CST"
date + days(1)
# "2009-03-09 01:59:59 CDT" periods preserve clock time
date + edays(1)
# "2009-03-09 02:59:59 CDT" durations preserve exact passage of time

date2 <- as.POSIXct("2000-02-29 12:00:00")
date2 + years(1)
# "2001-02-28 12:00:00 CST" 
# self corrects to most recent real day

date3 <- as.POSIXct("2009-01-31 01:00:00")
date3 + c(0:11) * months(1)
# [1] "2009-01-31 01:00:00 CST" "2009-02-28 01:00:00 CST"
# [3] "2009-03-31 01:00:00 CDT" "2009-04-30 01:00:00 CDT"
# [5] "2009-05-31 01:00:00 CDT" "2009-06-30 01:00:00 CDT"
# [7] "2009-07-31 01:00:00 CDT" "2009-08-31 01:00:00 CDT"
# [9] "2009-09-30 01:00:00 CDT" "2009-10-31 01:00:00 CDT"
#[11] "2009-11-30 01:00:00 CST" "2009-12-31 01:00:00 CST"

span <- date - date2  #creates interval 
# 3294.583 days beginning at 2000-02-29 12:00:00 
span - days(294)
# 3000.542 days beginning at 2000-02-29 12:00:00
span - edays(294.542)
# 3000 days beginning at 2000-02-29 12:00:00
span * 3
# 9883.75 days beginning at 2000-02-29 12:00:00
span / 2
# 1647.292 days beginning at 2000-02-29 12:00:00

date <- as.POSIXct("2009-01-01 00:00:00") 
# "2009-01-01 GMT"
date + years(1)
# "2010-01-01 GMT"
date - days(3) + hours(6)
# "2008-12-29 06:00:00 GMT"
date + 3 * seconds(10)
# "2009-01-01 00:00:30 GMT"

months(6) + days(1)
# 6 months and 1 day}
