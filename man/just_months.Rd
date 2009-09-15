\name{just_months}
\alias{just_months}
\title{Returns just the months component of a duration.}
\usage{just_months(dur)}

\description{
  Returns just the months component of a duration.
}
\value{the number of months as well as the number of years (as months) contained in a duration. See \code{link{duration}} for further details.}
\seealso{\code{link{just_seconds}}}
\keyword{utilities}
\keyword{chron}
\arguments{
  \item{dur}{a duration object}
}
\examples{x <- new_duration(year = 1, month = 4, day = 30, hour = 2, second = 1)
x # 1 year, 4 months, 4 weeks, 2 days, 2 hours and 1 second
just_months(x)  # 16}
