\name{as.period}
\alias{as.period}
\title{Change an object to a period.}
\usage{as.period(x)}

\description{
  Change an object to a period.
}

\details{
  as.period changes interval, duration (i.e., difftime)
  and numeric objects to period objects with the
  specified units.

  Users must specify which time units to measure the
  period in. The length of each time unit in a period
  depends on when it occurs. See \code{\link{periods}}.
  The choice of units is not trivial; units that are
  normally equal may differ in length depending on when
  the time period occurs. For example, when a leap second
  occurs one minute is longer than 60 seconds.

  Because periods do not have a fixed length, they can
  not be accurately converted to and from duration
  objects. Duration objects measure time spans in exact
  numbers of seconds, see \code{\link{duration}}. Hence,
  a one to one mapping does not exist between durations
  and periods. When used with a duration object,
  as.period provides an inexact estimate; the duration is
  broken into time units based on the most common lengths
  of time units, in seconds. Because the length of months
  are particularly variable, a period with a months unit
  can not be coerced from a duration object. For an exact
  transformation, first transform the duration to an
  interval with \code{\link{as.interval}}.
}
\value{a period object}
\seealso{\code{\link{period}}, \code{\link{new_period}}}
\keyword{classes}
\keyword{manip}
\keyword{methods}
\keyword{chron}
\arguments{
  \item{x}{an interval, difftime, or numeric object}
  \item{units}{a character vector. The names of the units to divide the
period among. Years, months, days, hours, minutes, and seconds are
supported, see \code{\link{standardise_date_names}} for more details. The
largest units should be listed first. As much of the period as possible
will be assigned to the first unit. As much of the remainder as possible
will be assigned to the second unit and so on until all listed units have
been handled. After the period has been distributed across all listed
units, any remaining time will be added to the period in seconds units.
If no units are provided, as.period will use all available units by
default.}
}
\examples{span <- new_interval(as.POSIXct("2009-01-01"), as.POSIXct("2010-02-02 01:01:01")) #interval
# 397.0424 days beginning at 2009-01-01
as.period(span)
# 1 year, 1 month, 1 day, 1 hour, 1 minute and 1 second
as.period(span, units = c("year")) 
# 1 year and 2768461 seconds
as.period(span, units = c("day", "minute")) 
# 1 day, 1 minute and 34218001 seconds}
