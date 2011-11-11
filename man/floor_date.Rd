\name{floor_date}
\alias{floor_date}
\title{Round date-times down.}
\usage{
  floor_date(x,
    unit = c("second", "minute", "hour", "day", "week", "month", "year"))
}
\arguments{
  \item{x}{a vector of date-time objects}

  \item{unit}{a character string specifying the time unit
  to be rounded to. Should be one of
  "second","minute","hour","day", "week", "month", or
  "year."}
}
\value{
  x with the appropriate units floored
}
\description{
  floor_date takes a date-time object and rounds it down to
  the nearest integer value of the specified time unit.
  Users can specify whether to round down to the nearest
  second, minute, hour, day, week, month, or year.
}
\examples{
x <- as.POSIXct("2009-08-03 12:01:59.23")
floor_date(x, "second")
# "2009-08-03 12:01:59 CDT"
floor_date(x, "minute")
# "2009-08-03 12:01:00 CDT"
floor_date(x, "hour")
# "2009-08-03 12:00:00 CDT"
floor_date(x, "day")
# "2009-08-03 CDT"
floor_date(x, "week")
# "2009-08-02 CDT"
floor_date(x, "month")
# "2009-08-01 CDT"
floor_date(x, "year")
# "2009-01-01 CST"
}
\seealso{
  \code{\link{ceiling_date}}, \code{\link{round_date}}
}
\keyword{chron}
\keyword{manip}

