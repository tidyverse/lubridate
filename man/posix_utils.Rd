% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/POSIXt.r
\docType{data}
\name{is.POSIXt}
\alias{is.POSIXt}
\alias{is.POSIXlt}
\alias{is.POSIXct}
\alias{POSIXct}
\alias{NA_POSIXct_}
\title{Various POSIX utilities}
\format{
An object of class \code{POSIXct} (inherits from \code{POSIXt}) of length 1.
}
\usage{
is.POSIXt(x)

is.POSIXlt(x)

is.POSIXct(x)

POSIXct(length = 0L, tz = "UTC")

NA_POSIXct_
}
\arguments{
\item{x}{an R object}

\item{length}{A non-negative number specifying the desired length. Supplying
an argument of length other than one is an error.}

\item{tz}{a timezone (defaults to "utc")}
}
\value{
TRUE if x is a POSIXct or POSIXlt object, FALSE otherwise.
}
\description{
\code{\link[=POSIXct]{POSIXct()}} mirrors primitive constructors in base R (\code{\link[=double]{double()}},
\code{\link[=character]{character()}} etc.)
}
\examples{
is.POSIXt(as.Date("2009-08-03"))
is.POSIXt(as.POSIXct("2009-08-03"))
}
\seealso{
\code{\link[=is.instant]{is.instant()}}, \code{\link[=is.timespan]{is.timespan()}}, \code{\link[=is.Date]{is.Date()}}
}
\keyword{chron}
\keyword{datasets}
\keyword{logic}
