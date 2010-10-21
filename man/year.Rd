\name{year}
\alias{year}
\title{Get/set years component of a date-time.}
\usage{year(x)}

\description{
  Get/set years component of a date-time.
}

\details{
  Date-time must be a POSIXct, POSIXlt, Date, chron,
  yearmon, yearqtr, zoo, zooreg, timeDate, xts, its, ti,
  jul, timeSeries, and fts objects.

  year does not yet support years before 0 C.E.
}
\value{the years element of x as a decimal number}
\keyword{utilities}
\keyword{manip}
\keyword{chron}
\keyword{methods}
\arguments{
  \item{x}{a date-time object}
}
\examples{x <- now()
year(x) 
year(x) <- 2001  
year(x) > 1995}
