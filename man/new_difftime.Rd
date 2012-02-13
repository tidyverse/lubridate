\name{new_difftime}
\alias{new_difftime}
\title{Create a difftime object.}
\usage{
  new_difftime(...)
}
\arguments{
  \item{...}{a list of time units to be included in the
  difftime and their amounts. Seconds, minutes, hours,
  days, and weeks are supported.}
}
\value{
  a difftime object
}
\description{
  new_difftime creates a difftime object with the specified
  number of units. Entries for different units are
  cumulative. difftime displays durations in various units,
  but these units are estimates given for convenience. The
  underlying object is always recorded as a fixed number of
  seconds. For display and creation purposes, units are
  converted to seconds using their most common lengths in
  seconds. Minutes = 60 seconds, hours = 3600 seconds, days
  = 86400 seconds, weeks = 604800. Units larger than weeks
  are not used due to their variability.
}
\details{
  Conceptually, difftime objects are a type of duration.
  They measure the exact passage of time but do not always
  align with measurements made in larger units of time such
  as hours, months and years. This is because the length of
  larger time units can be affected by conventions such as
  leap years and Daylight Savings Time. lubridate provides
  a second class for measuring durations, the Duration
  class.
}
\examples{
new_difftime(second = 90)
# Time difference of 1.5 mins
new_difftime(minute = 1.5)
# Time difference of 1.5 mins
new_difftime(second = 3, minute = 1.5, hour = 2, day = 6, week = 1)
# Time difference of 13.08441 days
new_difftime(hour = 1, minute = -60)
# Time difference of 0 secs
new_difftime(day = -1)
# Time difference of -1 days
}
\seealso{
  \code{\link{duration}}, \code{\link{as.duration}}
}
\keyword{chron}
\keyword{classes}

