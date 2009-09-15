\name{subtraction}
\title{Subtraction for the duration (i...}
\usage{\method{-}{period} (e1, e2)}

\description{
  Subtraction for the duration (i.e, difftime), period, and interval
  classes.
}

\details{
  The subtraction methods returns an interval object when a POSIXt or
  Date object is subtracted from another POSIXt or Date object. To
  retrieve this difference as a difftime, use \code{link{as.duration}}.
  To retrieve it as a period use \code{link{as.period}}.

  Since a specific number of seconds exists between two dates, the
  duration returned will not include unspecific time units such as
  years and months. To get a nonspecific duration use
  \code{link{get_duration}}. See \code{link{duration}} for more
  details.
}
\alias{-.period}
\alias{-.POSIXt}
\alias{-.difftime}
\alias{-.Date}
\alias{-.interval}
\value{a new duration(i.e. difftime), period, interval, POSIXt, or Date object, depending on e1 and e2}
\keyword{arith}
\keyword{chron}
\keyword{methods}
\arguments{
  \item{e1}{a duration(i.e. difftime), period, interval, POSIXt, or Date object}
  \item{e2}{a duration(i.e. difftime), period, interval, POSIXt, or Date object}
}
\examples{x <- new_duration(day = 1)
now() - x
-x
x - x
as.Date("2009-08-02") - as.Date("2008-11-25")}
