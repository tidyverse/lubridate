\name{wday}
\alias{wday}
\alias{wday<-}
\title{Get/set days component of a date-time.}
\usage{
  wday(x, label = FALSE, abbr = TRUE)
}
\arguments{
  \item{x}{a POSIXct, POSIXlt, Date, chron, yearmon,
  yearqtr, zoo, zooreg, timeDate, xts, its, ti, jul,
  timeSeries, or fts object.}

  \item{label}{logical. Only available for wday. TRUE will
  display the day of the week as a character string label
  such as "Sunday." FALSE will display the day of the week
  as a number.}

  \item{abbr}{logical. Only available for wday. FALSE will
  display the day of the week as a character string label
  such as "Sunday." TRUE will display an abbreviated
  version of the label, such as "Sun". abbr is disregarded
  if label = FALSE.}
}
\value{
  wday returns the day of the week as a decimal number
  (01-07, Sunday is 1).
}
\description{
  Date-time must be a POSIXct, POSIXlt, Date, chron,
  yearmon, yearqtr, zoo, zooreg, timeDate, xts, its, ti,
  jul, timeSeries, and fts objects.
}
\examples{
x <- as.Date("2009-09-02")
wday(x) #4

wday(ymd(080101))
# 3
wday(ymd(080101), label = TRUE)
# "Tuesday"
wday(ymd(080101), label = TRUE, abbr = TRUE)
# "Tues"
wday(ymd(080101) + days(-2:4), label = TRUE, abbr = TRUE)
# "Sun"   "Mon"   "Tues"  "Wed"   "Thurs" "Fri"   "Sat"
}
\seealso{
  \code{\link{yday}}, \code{\link{mday}}
}
\keyword{chron}
\keyword{manip}
\keyword{methods}
\keyword{utilities}

