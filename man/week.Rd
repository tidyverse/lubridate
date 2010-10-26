\name{week}
\title{Get/set weeks component of a date-time.}
\usage{week(x)}

\description{
  Get/set weeks component of a date-time.
}

\details{
  Date-time must be a POSIXct, POSIXlt, Date, chron,
  yearmon, yearqtr, zoo, zooreg, timeDate, xts, its, ti,
  jul, timeSeries, and fts objects. Weeks is the number of
  complete seven day periods that have occured between the
  date and January 1st, plus one.
}
\alias{week}
\alias{week<-}
\value{the weeks element of x as an integer number}
\keyword{utilities}
\keyword{manip}
\keyword{chron}
\arguments{
  \item{x}{a date-time object}
}
\examples{x <- now()
week(x) 
week(x) <- 1  
week(x) <- 54
week(x) > 3}
