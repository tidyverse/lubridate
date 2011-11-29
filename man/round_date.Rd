\name{round_date}
\alias{round_date}
\title{Rounding for date-times.}
\usage{
  round_date(x,
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
  x with the appropriate units rounded
}
\description{
  round_date takes a date-time object and rounds it to the
  nearest integer value of the specified time unit. Users
  can specify whether to round to the nearest second,
  minute, hour, day, week, month, or year.
}
\examples{
x <- as.POSIXct("2009-08-03 12:01:59.23")
round_date(x, "second")
# "2009-08-03 12:01:59 CDT"
round_date(x, "minute")
# "2009-08-03 12:02:00 CDT"
round_date(x, "hour")
# "2009-08-03 12:00:00 CDT"
round_date(x, "day")
# "2009-08-04 CDT"
round_date(x, "week")
# "2009-08-02 CDT"
round_date(x, "month")
# "2009-08-01 CDT"
round_date(x, "year")
# "2010-01-01 CST"
}
\seealso{
  \code{\link{floor_date}}, \code{\link{ceiling_date}}
}
\keyword{chron}
\keyword{manip}

