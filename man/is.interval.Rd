\name{is.interval}
\alias{is.interval}
\title{Is x an interval object?}
\usage{is.interval(x)}

\description{
  Is x an interval object?
}
\value{TRUE if x is an interval object, FALSE otherwise.}
\seealso{\code{link{is.instant}, link{is.timespan}, link{is.period}, link{is.duration}, link{interval}}}
\keyword{logic}
\keyword{chron}
\arguments{
  \item{x}{an R object}
}
\examples{is.interval(new_period(months= 1, days = 15)) # FALSE
is.interval(new_interval(ymd(20090801), ymd(20090809)) # TRUE}
