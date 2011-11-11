\name{is.difftime}
\alias{is.difftime}
\title{Is x a difftime object?}
\usage{
  is.difftime(x)
}
\arguments{
  \item{x}{an R object}
}
\value{
  TRUE if x is a difftime object, FALSE otherwise.
}
\description{
  Is x a difftime object?
}
\examples{
is.difftime(as.Date("2009-08-03")) # FALSE
is.difftime(new_difftime(days = 12.4)) # TRUE
}
\seealso{
  \code{\link{is.instant}}, \code{\link{is.timespan}},
  \code{\link{is.interval}}, \code{\link{is.period}}.
}
\keyword{chron}
\keyword{logic}

