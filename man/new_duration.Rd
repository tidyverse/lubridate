\name{new_duration}
\alias{new_duration}
\title{Create a duration object.}
\usage{new_duration(...)}

\description{
  Create a duration object.
}

\details{
  new_duration creates a difftime object with the specified values.
  Entries for different units are cumulative. difftime displays
  durations in various units, but these units are estimates given for
  convenience. The underlying object is always recorded as a fixed
  number of seconds. For display and creation purposes, units are
  converted to seconds using their most common lengths in seconds.
  Minutes = 60 seconds, hours = 3600 seconds, days = 86400 seconds,
  weeks = 604800. Units larger than weeks are not used due to their
  variability.

  difftime objects are durations. Durations record the exact number of
  seconds in a time span. They measure the exact passage of time and
  are not affected by conventions such as leap years and Daylight
  Savings Time.

  duration objects can be easily created with the helper functions
  \code{link{eweeks}}, \code{link{edays}}, \code{link{eminutes}},
  \code{link{eseconds}}. These objects can be added to and subtracted
  to date- times to create a user interface similar to object oriented
  programming.
}
\value{a duration object}
\seealso{\code{link{duration}, link{as.duration}}}
\keyword{chron}
\keyword{classes}
\arguments{
  \item{...}{a list of time units to be included in the duration and their amounts. Seconds, minutes, hours, days, and weeks are supported. See \code{link{standardise_difftime_names}}.}
}
\examples{new_duration(second = 90)
# Time difference of 1.5 mins
new_duration(minute = 1.5)
# Time difference of 1.5 mins
new_duration(second = 3, minute = 1.5, hour = 2, day = 6, week = 1)
# Time difference of 1.869201 weeks
new_duration(hour = 1, minute = -60)
# Time difference of 0 secs
new_duration(day = -1)
# Time difference of -1 days}
