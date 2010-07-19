\name{multiply}
\title{Multiplication for period and interval classes.}
\usage{*.period(e1, e2)}

\description{
  Multiplication for period and interval classes.
}
\alias{*.period}
\alias{*.interval}
\alias{multiply_period_by_number}
\alias{multiply_interval_by_number}
\value{a period or interval object}
\seealso{\code{\link{+.period}}, \code{\link{+.interval}}, \code{\link{-.period}}, 
\code{\link{-.interval}}, \code{\link{/.interval}}, \code{\link{/.period}}}
\keyword{arith}
\keyword{chron}
\keyword{methods}
\arguments{
  \item{e1}{a period, interval or numeric object}
  \item{e2}{a period, interval or numeric object}
}
\examples{x <- new_period(day = 1)
x * 3
3 * x}
