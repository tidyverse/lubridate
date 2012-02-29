\name{duration}
\alias{duration}
\title{Create a duration object.}
\usage{
  duration(num = 0, units = "seconds")
}
\arguments{
  \item{num}{the number of time units to include in the
  duration}

  \item{units}{a character string that specifies the type
  of units that num refers to.}
}
\value{
  a duration object
}
\description{
  duration creates a duration object with the specified
  values. duration provides the behavior of
  \code{\link{new_duration}} in a way that is more suitable
  for automating within a function.
}
\details{
  Durations display as the number of seconds in a time
  span. When this number is large, durations also display
  an estimate in larger units,; however, the underlying
  object is always recorded as a fixed number of seconds.
  For display and creation purposes, units are converted to
  seconds using their most common lengths in seconds.
  Minutes = 60 seconds, hours = 3600 seconds, days = 86400
  seconds, weeks = 604800.

  Durations record the exact number of seconds in a time
  span. They measure the exact passage of time but do not
  always align with measurements made in larger units of
  time such as hours, months and years. This is because the
  length of larger time units can be affected by
  conventions such as leap years and Daylight Savings Time.
  Base R provides a second class for measuring durations,
  the difftime class.

  Duration objects can be easily created with the helper
  functions \code{\link{dweeks}}, \code{\link{ddays}},
  \code{\link{dminutes}}, \code{\link{dseconds}}. These
  objects can be added to and subtracted to date- times to
  create a user interface similar to object oriented
  programming.
}
\examples{
duration(90, "seconds")
# 90s
duration(1.5, "minutes")
# 90s
duration(-1, "days")
# -86400s (~-1 days)
}
\seealso{
  \code{\link{new_duration}}, \code{\link{as.duration}}
}
\keyword{chron}
\keyword{classes}

