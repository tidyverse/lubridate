\name{yday}
\alias{day}
\alias{day<-}
\alias{mday}
\alias{mday<-}
\alias{yday}
\alias{yday<-}
\title{Get/set days component of a date-time.}
\usage{
  yday(x)
}
\arguments{
  \item{x}{a POSIXct, POSIXlt, Date, Period, chron,
  yearmon, yearqtr, zoo, zooreg, timeDate, xts, its, ti,
  jul, timeSeries, or fts object.}
}
\value{
  yday returns the day of the year as a decimal number
  (01-366). mday returns the day of the month as a decimal
  number (01-31).
}
\description{
  Date-time must be a POSIXct, POSIXlt, Date, chron,
  yearmon, yearqtr, zoo, zooreg, timeDate, xts, its, ti,
  jul, timeSeries, and fts objects.
}
\examples{
x <- as.Date("2009-09-02")
yday(x) #245
mday(x) #2
yday(x) <- 1  #"2009-01-01"
yday(x) <- 366 #"2010-01-01"
mday(x) > 3
}
\seealso{
  \code{\link{wday}}
}
\keyword{chron}
\keyword{manip}
\keyword{methods}
\keyword{utilities}

