\name{second}
\alias{second}
\title{Get/set seconds component of a date-time.}
\usage{second(x)}

\description{
  Get/set seconds component of a date-time.
}

\details{
  Date-time must be a POSIXct, POSIXlt, Date, chron,
  yearmon, yearqtr, zoo, zooreg, timeDate, xts, its, ti,
  jul, timeSeries, and fts objects.
}
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
