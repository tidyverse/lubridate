\name{division}
\title{Division for period, and interval classes.}
\usage{\method{/}{period} (e1, e2)}

\description{
  Division for period, and interval classes.
}
\alias{/.period}
\alias{/.interval}
\alias{divide_period_by_number}
\alias{divide_interval_by_number}
\value{a period or interval object}
\seealso{\code{link{"+.period"}, link{"+.interval"}, link{"-.period"}, link{"-.interval"}, link{"*.interval"}, link{"*.period"}}}
\keyword{arith}
\keyword{chron}
\keyword{methods}
\arguments{
  \item{e1}{a period, interval or numeric object}
  \item{e2}{a period, interval or numeric object}
}
\examples{x <- new_period(day = 1)
x / 2
2 / x}
