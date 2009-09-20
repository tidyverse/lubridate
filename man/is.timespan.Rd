\name{is.timespan}
\title{Is x a length of time?}
\usage{is.timespan(x)}

\description{
  Is x a length of time?
}
\alias{is.timespan}
\alias{timespan}
\value{TRUE if x is a period, interval, or difftime object, FALSE otherwise.}
\seealso{\code{\link{is.instant}}, \code{\link{is.duration}}, \code{\link{is.difftime}}, \code{\link{is.period}}, \code{\link{is.interval}}}
\keyword{logic}
\keyword{chron}
\arguments{
  \item{x}{an R object}
}
\examples{is.timespan(as.Date("2009-08-03")) # FALSE
is.timespan(new_duration(second = 1)) # TRUE}
