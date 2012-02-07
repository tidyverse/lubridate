\name{is.interval}
\alias{is.interval}
\title{Is x an Interval object?}
\usage{
  is.interval(x)
}
\arguments{
  \item{x}{an R object}
}
\value{
  TRUE if x is an Interval object, FALSE otherwise.
}
\description{
  Is x an Interval object?
}
\examples{
is.interval(new_period(months= 1, days = 15)) # FALSE
is.interval(new_interval(ymd(20090801), ymd(20090809))) # TRUE
}
\seealso{
  \code{\link{is.instant}}, \code{\link{is.timespan}},
  \code{\link{is.period}}, \code{\link{is.duration}},
  \code{\link{Interval-class}}
}
\keyword{chron}
\keyword{logic}

