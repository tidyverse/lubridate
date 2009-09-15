\name{second}
\title{Get/set seconds component of a date-time.}
\usage{\method{second}{default} (x)}

\description{
  Get/set seconds component of a date-time.
}

\details{
  Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr,
  zoo, zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts
  objects.
}
\alias{.default}
\alias{second.zoo}
\alias{second.its}
\alias{second.ti}
\alias{second.timeseries}
\alias{second.fts}
\alias{second.irts}
\alias{second}
\value{the seconds element of x as a decimal number}
\keyword{utilities}
\keyword{manip}
\keyword{chron}
\keyword{methods}
\arguments{
  \item{x}{a date-time object}
}
\examples{x <- now()
second(x)
second(x) <- 1
second(x) <- 61 
second(x) > 2}
