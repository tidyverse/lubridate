\name{minute}
\title{Get/set minutes component of a date-time.}
\usage{minute(x)}

\description{
  Get/set minutes component of a date-time.
}

\details{
  Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr,
  zoo, zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts
  objects.
}
\alias{minute.default}
\alias{minute.zoo}
\alias{minute.its}
\alias{minute.ti}
\alias{minute.timeseries}
\alias{minute.fts}
\alias{minute.irts}
\alias{#'}
\alias{minute}
\alias{minute<-}
\alias{minute<-.default}
\alias{minute<-.chron}
\alias{minute<-.zoo}
\alias{minute<-.its}
\alias{minute<-.ti}
\alias{minute<-.timeDate}
\alias{minute<-.jul}
\alias{minute<-.timeSeries}
\alias{minute<-.fts}
\alias{minute<-.irts}
\keyword{utilities}
\keyword{manip}
\keyword{chron}
\keyword{methods}
\value{the minutes element of x as a decimal number}
\arguments{
  \item{x}{a date-time object}
}
\examples{x <- now()
minute(x)
minute(x) <- 1
minute(x) <- 61 
minute(x) > 2}
