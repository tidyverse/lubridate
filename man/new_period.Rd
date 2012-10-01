\name{new_period}
\alias{new_period}
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

  new_period is meant to be used interactively on the
  command line. See \code{\link{period}}, for a version
  that is better suited to automating within a function.
}
\examples{
new_period (second = 90, minute = 5)
# "5M 90S"
new_period(day = -1)
# "-1d 0H 0M 0S"
new_period(second = 3, minute = 1, hour = 2, day = 13, week = 1)
# "20d 2H 1M 3S"
new_period(hour = 1, minute = -60)
# "1H -60M 0S"
new_period(second = 0)
# "0S"
}
\seealso{
  \code{\link{period}}, \code{\link{as.period}}
}
\keyword{chron}
\keyword{classes}

