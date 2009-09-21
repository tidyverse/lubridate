\name{is.instant}
\title{Is x a date-time object?}
\usage{is.instant(x)}

\description{
  Is x a date-time object?
}

\details{
  date-time object denote instants in time.
}
\alias{is.timepoint}
\alias{timepoint}
\alias{is.instant}
\alias{instant}
\value{TRUE if x is a POSIXct, POSIXlt, or Date object, FALSE otherwise.}
\seealso{\code{\link{is.timespan}}, \code{\link{is.POSIXt}}, \code{\link{is.Date}}}
\keyword{logic}
\keyword{chron}
\arguments{
  \item{x}{an R object}
}
\examples{is.instant(as.Date("2009-08-03")) # TRUE
is.timepoint(5) # FALSE}
