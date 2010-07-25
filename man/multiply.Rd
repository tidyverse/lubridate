\name{multiply}
\title{Multiplication for period and interval classes.}
\usage{multiply_period_by_number(per, num)}

\description{
  Multiplication for period and interval classes.
}
\alias{*.period}
\alias{*.interval}
\alias{multiply_period_by_number}
\alias{multiply_interval_by_number}
\value{a period or interval object}
\seealso{\code{\link{+.period}}, \code{\link{+.interval}},
\code{\link{-.period}}, \code{\link{-.interval}},
\code{\link{/.interval}}, \code{\link{/.period}}}
\keyword{arith}
\keyword{chron}
\keyword{methods}
\arguments{
  \item{per}{a period, interval or numeric object}
  \item{num}{a period, interval or numeric object}
}
\examples{x <- new_period(day = 1)
x * 3
3 * x}
