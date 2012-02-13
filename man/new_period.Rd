\name{new_period}
\alias{new_period}
\alias{period}
\title{Create a period object.}
\usage{
  new_period(...)
}
\arguments{
  \item{...}{a list of time units to be included in the
  period and their amounts. Seconds, minutes, hours, days,
  weeks, months, and years are supported.}
}
\value{
  a period object
}
\description{
  new_period creates a period object with the specified
  values. Within a Period object, time units do not have a
  fixed length (except for seconds) until they are added to
  a date-time. The length of each time unit will depend on
  the date-time to which it is added. For example, a year
  that begins on 2009-01-01 will be 365 days long.  A year
  that begins on 2012-01-01 will be 366 days long. When
  math is performed with a period object, each unit is
  applied separately. How the length of a period is
  distributed among its units is non-trivial. For example,
  when leap seconds occur 1 minute is longer than 60
  seconds.
}
\details{
  Periods track the change in the "clock time" between two
  date-times. They are measured in common time related
  units: years, months, days, hours, minutes, and seconds.
  Each unit except for seconds must be expressed in integer
  values.

  Period objects can be easily created with the helper
  functions \code{\link{years}}, \code{\link{months}},
  \code{\link{weeks}}, \code{\link{days}},
  \code{\link{minutes}}, \code{\link{seconds}}. These
  objects can be added to and subtracted to date-times to
  create a user interface similar to object oriented
  programming.
}
\examples{
new_period (second = 90, minute = 5)
#  5 minutes and 90 seconds
new_period(day = -1)
# -1 days
new_period(second = 3, minute = 1, hour = 2, day = 6, week = 1)
# 13 days, 2 hours, 1 minute and 3 seconds
new_period(hour = 1, minute = -60)
# 1 hour and -60 minutes
new_period(second = 0)
# 0 seconds
}
\seealso{
  \code{\link{period}}, \code{\link{as.period}}
}
\keyword{chron}
\keyword{classes}

