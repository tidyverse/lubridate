\name{is.Date}
\alias{is.Date}
\title{Is x a Date object?}
\usage{is.Date(x)}

\description{
  Is x a Date object?
}
\value{TRUE if x is a Date object, FALSE otherwise.}
\seealso{\code{link{is.instant}, link{is.timespan}, link{is.POSIXt}}}
\keyword{logic}
\keyword{chron}
\arguments{
  \item{x}{an R object}
}
\examples{is.Date(as.Date("2009-08-03")) # TRUE
is.Date(difftime(now() + 5, now())) # FALSE}
