\name{yday}
\title{Get/set days component of a date-time.}
\usage{yday(x)}

\description{
  Get/set days component of a date-time.
}

\details{
  Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr,
  zoo, zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts
  objects.
}
\alias{yday.default}
\alias{yday.zoo}
\alias{yday.its}
\alias{yday.ti}
\alias{yday.timeseries}
\alias{yday.fts}
\alias{yday.irts}
\alias{mday.default}
\alias{mday.zoo}
\alias{mday.its}
\alias{day}
\alias{mday.ti}
\alias{mday.timeseries}
\alias{mday.fts}
\alias{mday.irts}
\alias{yday}
\alias{mday}
\alias{wday}
\alias{day<-}
\alias{yday<-.default}
\alias{yday<-.Date}
\alias{yday<-.chron}
\alias{yday<-.zoo}
\alias{yday<-.its}
\alias{yday<-.ti}
\alias{yday<-.timeDate}
\alias{yday<-.jul}
\alias{yday<-.timeSeries}
\alias{yday<-}
\alias{yday<-.fts}
\alias{yday<-.irts}
\alias{mday<-.default}
\alias{mday<-.Date}
\alias{mday<-.chron}
\alias{mday<-.zoo}
\alias{mday<-.its}
\alias{mday<-.ti}
\alias{mday<-.timeDate}
\alias{mday<-.jul}
\alias{mday<-.timeSeries}
\alias{mday<-.fts}
\alias{mday<-.irts}
\value{yday returns the day of the year as a decimal number (01-366). mday returns the day of 
the month as a decimal number (01-31).}
\seealso{\code{\link{wday}}}
\keyword{utilities}
\keyword{manip}
\keyword{chron}
\keyword{methods}
\arguments{
  \item{x}{a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, zooreg, timeDate, xts, its, ti, 
jul, timeSeries, or fts object.}
}
\examples{x <- as.Date("2009-09-02")
yday(x) #245
mday(x) #2
yday(x) <- 1  #"2009-01-01"
yday(x) <- 366 #"2010-01-01"
mday(x) > 3}
