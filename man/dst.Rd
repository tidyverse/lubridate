\name{dst}
\title{Get Daylight Savings Time indicator of a date-time.}
\usage{dst(x)}

\description{
  Get Daylight Savings Time indicator of a date-time.
}

\details{
  Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr,
  zoo, zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts
  objects.

  A date-time's daylight savings flag can not be set because it depends
  on the date-time's year, month, day, and hour values.
}
\alias{dst}
\alias{dst.default}
\alias{dst.zoo}
\alias{dst.its}
\alias{dst.ti}
\alias{dst.timeseries}
\alias{dst.fts}
\alias{dst.irts}
\value{Daylight savings time flag. Positive if in force, zero if not, negative if unknown.}
\keyword{utilities}
\keyword{chron}
\keyword{methods}
\arguments{
  \item{x}{a date-time object}
}
\examples{x <- now()
dst(x)}
