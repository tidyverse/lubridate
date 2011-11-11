\name{is.timespan}
\alias{is.timespan}
\title{Is x a length of time?}
\usage{
  is.timespan(x)
}
\arguments{
  \item{x}{an R object}
}
\value{
  TRUE if x is a period, interval, duration, or difftime
  object, FALSE otherwise.
}
\description{
  Is x a length of time?
}
\examples{
is.timespan(as.Date("2009-08-03")) # FALSE
is.timespan(new_duration(second = 1)) # TRUE
}
\seealso{
  \code{\link{is.instant}}, \code{\link{is.duration}},
  \code{\link{is.difftime}}, \code{\link{is.period}},
  \code{\link{is.interval}}
}
\keyword{chron}
\keyword{logic}

