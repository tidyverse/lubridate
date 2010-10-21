\name{hour}
\alias{hour}
\title{Get/set hours component of a date-time.}
\usage{hour(x)}

\description{
  Get/set hours component of a date-time.
}

\details{
  Date-time must be a POSIXct, POSIXlt, Date, chron,
  yearmon, yearqtr, zoo, zooreg, timeDate, xts, its, ti,
  jul, timeSeries, and fts objects.
}
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
