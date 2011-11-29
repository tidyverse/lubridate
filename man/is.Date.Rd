\name{is.Date}
\alias{is.Date}
\title{Is x a Date object?}
\usage{
  is.Date(x)
}
\arguments{
  \item{x}{an R object}
}
\value{
  TRUE if x is a Date object, FALSE otherwise.
}
\description{
  Is x a Date object?
}
\examples{
is.Date(as.Date("2009-08-03")) # TRUE
is.Date(difftime(now() + 5, now())) # FALSE
}
\seealso{
  \code{\link{is.instant}}, \code{\link{is.timespan}},
  \code{\link{is.POSIXt}}
}
\keyword{chron}
\keyword{logic}

