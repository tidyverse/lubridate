\name{decimal_date}
\alias{decimal_date}
\title{Converts a date to a decimal of its year.}
\usage{decimal_date(date)}

\description{
  Converts a date to a decimal of its year.
}
\value{a numeric object where the date is expressed as a fraction of its year}
\keyword{manip}
\keyword{chron}
\keyword{methods}
\arguments{
  \item{date}{a POSIXt or Date object}
}
\examples{date <- as.POSIXlt("2009-02-10")
decimal_date(date)  # 2009.109}
