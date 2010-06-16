\name{update.POSIXct}
\alias{update.POSIXct}
\title{Changes the components of a date object...}
\usage{\method{update}{Date} (object, years=year(object),
    months=month(object), days=mday(object), mdays=mday(object),
    ydays=yday(object), wdays=wday(object), hours=hour(object),
    minutes=minute(object), seconds=second(object), tzs=tz(object),
    ...)}

\description{
  Changes the components of a date object
}

\details{
  update.Date and update.POSIXt return a date with the specified
  elements updated.  Elements not specified will be left unaltered.
  update.Date and update.POSIXt do not add the specified values to the
  existing date, they substitute them for the appropriate parts of the
  existing date.
}
\value{a date object with the requested elements updated. The object will
retain its original class unless an element is updated which the original
class does not support. In this case, the date returned will be a POSIXlt
date object.}
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
