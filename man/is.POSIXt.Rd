\name{is.POSIXt}
\title{Is x a POSIXct or POSIXlt object?}
\usage{is.POSIXt(x)}

\description{
  Is x a POSIXct or POSIXlt object?
}
\alias{is.POSIXt}
\alias{is.POSIXlt}
\alias{is.POSIXct}
\value{TRUE if x is a POSIXct or POSIXlt object, FALSE otherwise.}
\seealso{\code{\link{is.instant}}, \code{\link{is.timespan}}, \code{\link{is.Date}}}
\keyword{logic}
\keyword{chron}
\arguments{
  \item{x}{an R object}
}
\examples{is.POSIXt(as.Date("2009-08-03")) # FALSE
is.POSIXt(as.POSIXct("2009-08-03")) # TRUE}
