\name{DateUpdate}
\alias{DateUpdate}
\title{Changes the components of a date object}
\arguments{
  \item{object}{a date-time object}

  \item{years}{a value to substitute for the date's year
  component}

  \item{months}{a value to substitute for the date's month
  component}

  \item{ydays}{a value to substitute for the date's yday
  component}

  \item{wdays}{a value to substitute for the date's wday
  component}

  \item{mdays}{a value to substitute for the date's mday
  component}

  \item{days}{a value to substitute for the date's mday
  component}

  \item{hours}{a value to substitute for the date's hour
  component}

  \item{minutes}{a value to substitute for the date's
  minute component}

  \item{seconds}{a value to substitute for the date's
  second component}

  \item{tzs}{a value to substitute for the date's tz
  component}

  \item{...}{...}
}
\value{
  a date object with the requested elements updated. The
  object will retain its original class unless an element
  is updated which the original class does not support. In
  this case, the date returned will be a POSIXlt date
  object.
}
\description{
  update.Date and update.POSIXt return a date with the
  specified elements updated. Elements not specified will
  be left unaltered. update.Date and update.POSIXt do not
  add the specified values to the existing date, they
  substitute them for the appropriate parts of the existing
  date.
}
\examples{
date <- as.POSIXlt("2009-02-10")
update(date, year = 2010, month = 1, mday = 1)
# "2010-01-01 CST"

update(date, year =2010, month = 13, mday = 1)
# "2011-01-01 CST"

update(date, minute = 10, second = 3)
# "2009-02-10 00:10:03 CST"
}
\keyword{chron}
\keyword{manip}

