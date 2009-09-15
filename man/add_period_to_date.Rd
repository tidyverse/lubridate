\name{add_period_to_date}
\title{Addition for the duration (i...}
\usage{add_period_to_date(date, period)}

\description{
  Addition for the duration (i.e, difftime), period, and interval
  classes.
}
\alias{+.duration}
\alias{+.interval}
\alias{+.period}
\alias{+.POSIXt}
\alias{+.difftime}
\alias{+.Date}
\alias{add_period_to_date}
\alias{add_duration_to_date}
\alias{add_number_to_duration}
\alias{add_number_to_period}
\alias{add_period_to_period}
\alias{add_duration_to_period}
\alias{add_duration_to_duration}
\alias{add_duration_to_interval}
\alias{add_period_to_interval}
\alias{add_number_to_interval}
\value{a new duration(i.e. difftime), period, interval, POSIXt, or Date object, depending on e1 and e2}
\keyword{arith}
\keyword{chron}
\keyword{methods}
\arguments{
  \item{date}{a duration(i.e. difftime), period, interval, POSIXt, or Date object}
  \item{period}{a duration(i.e. difftime), period, interval, POSIXt, or Date object}
}
\examples{x <- new_duration(day = 1)
x + now()
today() + x
x + difftime(now() + 3600, now())
x + x}
