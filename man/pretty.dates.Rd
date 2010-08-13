\name{pretty.dates}
\alias{pretty.dates}
\title{Computes attractive axis breaks for date-time data...}
\usage{pretty.dates(x, n, ...)}

\description{
  Computes attractive axis breaks for date-time data
}

\details{
  pretty.dates indentifies which unit of time the sub-intervals should
  be measured in to provide approximately n breaks. It then chooses a
  "pretty" length for the sub-intervals and sets start and endpoints
  that 1) span the entire range of the data, and 2) allow the breaks to
  occur on important date-times (i.e. on the hour, on the first of the
  month, etc.)
}
\value{a vector of date-times that can be used as axis tick marks or bin breaks}
\keyword{dplot}
\keyword{utilities}
\keyword{chron}
\arguments{
  \item{x}{a vector of POSIXct, POSIXlt, Date, or chron date-time objects}
  \item{n}{integer value of the desired number of breaks}
}
\examples{x <- seq.Date(as.Date("2009-08-02"), by = "year", length.out = 2)
# "2009-08-02" "2010-08-02"
pretty.dates(x, 12)
#"2009-08-01 GMT" "2009-09-01 GMT" "2009-10-01 GMT" "2009-11-01 GMT" "2009-12-01 GMT" "2010-01-01 GMT" "2010-02-01 GMT" "2010-03-01 GMT" "2010-04-01 GMT" "2010-05-01 GMT" "2010-06-01 GMT" "2010-07-01 GMT" "2010-08-01 GMT" "2010-09-01 GMT"}
