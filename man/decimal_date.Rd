\name{decimal_date}
\alias{decimal_date}
\title{Converts a date to a decimal of its year.}
\usage{
  decimal_date(date)
}
\arguments{
  \item{date}{a POSIXt or Date object}
}
\value{
  a numeric object where the date is expressed as a
  fraction of its year
}
\description{
  Converts a date to a decimal of its year.
}
\examples{
date <- ymd("2009-02-10")
decimal_date(date)  # 2009.11
}
\keyword{chron}
\keyword{manip}
\keyword{methods}

