\name{just_seconds}
\alias{just_seconds}
\title{Returns just the seconds component of a duration.}
\usage{just_seconds(dur)}

\description{
  Returns just the seconds component of a duration.
}
\value{the number of weeks, days, hours, minutes, and seconds in a duration as seconds. See 
\code{\link{duration}} for further details.}
\seealso{\code{\link{just_months}}}
\keyword{utilities}
\keyword{chron}
\arguments{
  \item{dur}{a duration object}
}
\examples{x <- new_duration(year = 1, month = 4, day = 30, hour = 2, second = 1)
x # 1 year, 4 months, 4 weeks, 2 days, 2 hours and 1 second
just_seconds(x)  # 2599201}
