\name{is.duration}
\alias{is.duration}
\title{Is x a duration object?}
\usage{is.duration(x)}

\description{
  Is x a duration object?
}
\value{TRUE if x is a duration object, FALSE otherwise.}
\seealso{\code{\link{is.instant}}, \code{\link{is.timespan}}, \code{\link{is.interval}}, 
\code{\link{is.period}}, \code{\link{duration}}}
\keyword{logic}
\keyword{chron}
\arguments{
  \item{x}{an R object}
}
\examples{is.duration(as.Date("2009-08-03")) # FALSE
is.duration(new_duration(days = 12.4)) # TRUE}
