\name{year}
\alias{year}
\alias{year<-}
\title{Get/set years component of a date-time.}
\usage{
  year(x)
}
\arguments{
  \item{x}{a date-time object}
}
\value{
  the years element of x as a decimal number
}
\description{
  Date-time must be a POSIXct, POSIXlt, Date, Period,
  chron, yearmon, yearqtr, zoo, zooreg, timeDate, xts, its,
  ti, jul, timeSeries, and fts objects.
}
\details{
  year does not yet support years before 0 C.E.
}
\examples{
x <- ymd("2012-03-26")
year(x)
year(x) <- 2001
year(x) > 1995
}
\keyword{chron}
\keyword{manip}
\keyword{methods}
\keyword{utilities}

