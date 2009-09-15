\name{update.Date}
\title{Changes the components of a date object...}
\usage{\method{update}{Date} (object, ...)}

\description{
  Changes the components of a date object
}

\details{
  update is a wrapper function for \code{\link{year}, \link{month},
  \link{week}, \link{yday}, \link{wday}, \link{mday}, \link{hour},
  \link{minute}, \link{second}} and \code{\link{tz}}. It returns a date
  with the specified elements updated. Elements not specified will be
  left unaltered. Update.Date does not add the specified values to the
  existing date, it substitutes them for the appropriate parts of the
  existing date.

  update implements changes in the order year, month, week, yday, wday,
  mday, hour, minute, second, tz.  If conflicting requests are set,
  requests that occur later in the order will overwrite those that
  occur earlier.  If a request causes spillover to another component
  (such as 13 months, which spills over to 1 year and 1 month) this
  spillover will be added to any requests inputed for the first
  category (see examples).

  If the seconds, minutes, or hours element is updated, a POSIXt object
  will be returned, even when object is a Date object.  Date objects do
  not support seconds, minutes, or hours. R recognizes Date objects as
  having an initial value of zero for hours, minutes, and seconds in
  the "UTC" time zone. Since Date objects are displayed in the "UTC"
  time zone and as.POSIXt objects are displayed in the preset system
  time zone of your computer, a change in clock time will normlly occur
  when the class of the object switches. Both clock times will still
  refer to the same instant of time, but in different time zones.

  A date-time element may be updated to a vector of numbers. update
  will return a vector of updated times, one for each element. If
  multiple elements are updated to vectors of numbers, update will
  return a vector of dates that reflects all combinations of the
  updated elements.
}
\alias{update.Date}
\alias{update.POSIXt}
\alias{update.POSIXct}
\alias{update.POSIXlt}
\value{a date object with the requested elements updated. The object will retain its original class unless an element is updated which the original class does not support. In this case, the date returned will be a POSIXlt date object.}
\keyword{manip}
\keyword{chron}
\arguments{
  \item{object}{a date-time object}
  \item{year}{a value to substitute for the date's year component}
  \item{month}{a value to substitute for the date's month component}
  \item{week}{a value to substitute for the date's week component}
  \item{yday}{a value to substitute for the date's yday component}
  \item{wday}{a value to substitute for the date's wday component}
  \item{mday}{a value to substitute for the date's mday component}
  \item{hour}{a value to substitute for the date's hour component}
  \item{minute}{a value to substitute for the date's minute component}
  \item{second}{a value to substitute for the date's second component}
  \item{tz}{a value to substitute for the date's tz component}
}
\examples{date <- as.POSIXlt("2009-02-10") 
update(date, year = 2010, month = 1, mday = 1)
# "2010-01-01 CST"

update(date, year =2010, month = 13, mday = 1)
# "2011-01-01 CST"

update(date, yday = 35, wday = 4, mday = 3) 
# "2009-02-03 CST"

update(date, minute = 10, second = 3)
# "2009-02-10 00:10:03 CST"}
