\name{is.difftime}
\title{Is x a duration (difftime) object?}
\usage{is.difftime(x)}

\description{
  Is x a duration (difftime) object?
}
\alias{is.difftime}
\alias{is.duration}
\value{TRUE if x is a difftime object, FALSE otherwise.}
\seealso{\code{link{is.instant}, link{is.timespan}, link{is.interval}, link{is.period}, link{duration}}}
\keyword{logic}
\keyword{chron}
\arguments{
  \item{x}{an R object}
}
\examples{is.difftime(as.Date("2009-08-03")) # FALSE
is.difftime(new_duration(days = 12.4)) # TRUE}
