\name{is.duration}
\alias{is.duration}
\title{Is x a duration object?}
\usage{
  is.duration(x)
}
\arguments{
  \item{x}{an R object}
}
\value{
  TRUE if x is a duration object, FALSE otherwise.
}
\description{
  Is x a duration object?
}
\examples{
is.duration(as.Date("2009-08-03")) # FALSE
is.duration(new_duration(days = 12.4)) # TRUE
}
\seealso{
  \code{\link{is.instant}}, \code{\link{is.timespan}},
  \code{\link{is.interval}}, \code{\link{is.period}},
  \code{\link{duration}}
}
\keyword{chron}
\keyword{logic}

