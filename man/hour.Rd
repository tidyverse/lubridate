\name{hour}
\title{Get/set hours component of a date-time.}
\usage{hour(x)}

\description{
  Get/set hours component of a date-time.
}

\details{
  Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr,
  zoo, zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts
  objects.
}
\alias{hour.default}
\alias{hour.zoo}
\alias{hour.its}
\alias{hour.ti}
\alias{hour.timeseries}
\alias{hour.fts}
\alias{hour.irts}
\alias{hour}
\alias{hour<-}
\alias{hour<-.default}
\alias{hour<-.chron}
\alias{hour<-.zoo}
\alias{hour<-.its}
\alias{hour<-.ti}
\alias{hour<-.timeDate}
\alias{hour<-.jul}
\alias{hour<-.timeSeries}
\alias{hour<-.fts}
\alias{hour<-.irts}
\keyword{utilities}
\keyword{manip}
\keyword{chron}
\keyword{methods}
\value{the hours element of x as a decimal number}
\arguments{
  \item{x}{a date-time object}
}
\examples{x <- now()
hour(x)
hour(x) <- 1
hour(x) <- 61 
hour(x) > 2}
