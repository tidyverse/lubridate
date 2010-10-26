\name{new_duration}
\alias{new_duration}
\title{Create a duration object.}
\usage{new_duration(num=0, ...)}

\description{
  Create a duration object.
}

\details{
  new_duration creates a duration object with the specified
  values. Entries for different units are cumulative.
  durations display as the number of seconds in a time
  span. When this number is large, durations also display
  an estimate in larger units,; however, the underlying
  object is always recorded as a fixed number of seconds.
  For display and creation purposes, units are converted to
  seconds using their most common lengths in seconds.
  Minutes = 60 seconds, hours = 3600 seconds, days = 86400
  seconds, weeks = 604800. Units larger than weeks are not
  used due to their variability.

  Durations record the exact number of seconds in a time
  span. They measure the exact passage of time but do not
  always align with measurements made in larger units of
  time such as hours, months and years.  This is because
  the length of larger time units can be affected by
  conventions such as leap years and Daylight Savings Time.
  Base R provides a second class for measuring durations,
  the difftime class.

  duration objects can be easily created with the helper
  functions \code{\link{dweeks}}, \code{\link{ddays}},
  \code{\link{dminutes}}, \code{\link{dseconds}}. These
  objects can be added to and subtracted to date- times to
  create a user interface similar to object oriented
  programming.
}
\value{a duration object}
\seealso{\code{\link{duration}}, \code{\link{as.duration}}}
\keyword{chron}
\keyword{classes}
\arguments{
  \item{num}{the number of seconds to be included in the period (if not listing time units).}
  \item{...}{a list of time units to be included in the duration and their amounts. Seconds, 
minutes, hours, days, and weeks are supported.}
}
\examples{new_duration(second = 90)
# 90s
new_duration(minute = 1.5)
# 90s
new_duration(second = 3, minute = 1.5, hour = 2, day = 6, week = 1)
# 1130493s (13.08d)
new_duration(hour = 1, minute = -60)
# 0s
new_duration(day = -1)
# -86400s (-1d)}
