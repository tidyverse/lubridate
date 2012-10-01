\name{period}
\alias{period}
\title{Create a period object.}
\usage{
  period(num, units = "second")
}
\arguments{
  \item{num}{a numeric vector that lists the number of time
  units to be included in the period}

  \item{units}{a character vector that lists the type of
  units to be used. The units in units are matched to the
  values in num according to their order.}
}
\value{
  a period object
}
\description{
  period creates a period object with the specified values.
  period provides the behaviour of \code{\link{new_period}}
  in a way that is more suitable for automating within a
  function.
}
\details{
  Within a Period object, time units do not have a fixed
  length (except for seconds) until they are added to a
  date-time. The length of each time unit will depend on
  the date-time to which it is added. For example, a year
  that begins on 2009-01-01 will be 365 days long.  A year
  that begins on 2012-01-01 will be 366 days long. When
  math is performed with a period object, each unit is
  applied separately. How the length of a period is
  distributed among its units is non-trivial. For example,
  when leap seconds occur 1 minute is longer than 60
  seconds.

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
period(c(90, 5), c("second", "minute"))
#  "5M 90S"
period(-1, "days")
# "-1d 0H 0M 0S"
period(c(3, 1, 2, 13, 1), c("second", "minute", "hour", "day", "week"))
# "20d 2H 1M 3S"
period(c(1, -60), c("hour", "minute"))
# "1H -60M 0S"
period(0, "second")
# "0S"
}
\seealso{
  \code{\link{new_period}}, \code{\link{as.period}}
}
\keyword{chron}
\keyword{classes}

