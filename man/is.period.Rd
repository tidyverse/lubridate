\name{is.period}
\alias{is.period}
\title{Is x a period object?}
\usage{is.period(x)}

\description{
  Is x a period object?
}
\value{TRUE if x is a period object, FALSE otherwise.}
\seealso{\code{\link{is.instant}}, \code{\link{is.timespan}}, \code{\link{is.interval}}, 
\code{\link{is.duration}}, \code{\link{period}}}
\keyword{logic}
\keyword{chron}
\arguments{
  \item{x}{an R object}
}
\examples{is.period(as.Date("2009-08-03")) # FALSE
is.period(new_period(months= 1, days = 15)) # TRUE}
