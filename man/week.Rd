\name{week}
\alias{isoweek}
\alias{week}
\alias{week<-}
\title{Get/set weeks component of a date-time.}
\usage{
  week(x)
}
\arguments{
  \item{x}{a date-time object}
}
\value{
  the weeks element of x as an integer number
}
\description{
  Date-time must be a POSIXct, POSIXlt, Date, chron,
  yearmon, yearqtr, zoo, zooreg, timeDate, xts, its, ti,
  jul, timeSeries, and fts objects. Weeks is the number of
  complete seven day periods that have occured between the
  date and January 1st, plus one. isoweek returns the week
  as it would appear in the ISO 8601 system, which uses a
  reoccuring leap week.
}
\examples{
x <- ymd("2012-03-26")
week(x)
week(x) <- 1
week(x) <- 54
week(x) > 3
}
\keyword{chron}
\keyword{manip}
\keyword{utilities}

