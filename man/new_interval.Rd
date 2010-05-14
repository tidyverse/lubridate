\name{new_interval}
\alias{new_interval}
\title{Create an interval object.}
\usage{new_interval(date1, date2)}

\description{
  Create an interval object.
}

\details{
  new_interval creates an interval object with the specified start and
  end dates. new_interval automatically assigns the date that occurs
  first as the start date and the date that occurs second as the end
  date.

  Intervals are time spans bound by two real date-times.  Intervals can
  be accurately converted to either period or duration objects using
  \code{\link{as.period}}, \code{\link{as.duration}}. Since an interval
  is anchored to a fixed history of time, both the number of seconds
  that passed as well as the length of common time units during that
  history can be calculated.  Subtracting two date times automatically
  creates an interval object. Intervals display as the difftime between
  the two dates paired with the earlier, or beginning date.
}
\value{an interval object}
\seealso{\code{\link{interval}}, \code{\link{as.interval}}}
\keyword{chron}
\keyword{classes}
\arguments{
  \item{date1}{a POSIXt or Date date-time object}
  \item{date2}{a POSIXt or Date date-time object}
}
\examples{new_interval(ymd(20090101), ymd(20090201))
# 31 days beginning at 2009-01-01

date1 <- as.POSIXct("2009-03-08 01:59:59")
date2 <- as.POSIXct("2000-02-29 12:00:00")
new_interval(date1, date2)
# 3294.583 days beginning at 2000-02-29 12:00:00
new_interval(date2, date1)
# 3294.583 days beginning at 2000-02-29 12:00:00

span <- new_interval(ymd(20090101), ymd(20090201))
# 31 days beginning at 2009-01-01
span * 2
# 62 days beginning at 2009-01-01
span / 2
# 15.5 days beginning at 2009-01-01
span - days(30)
# 1 days beginning at 2009-01-01
span + months(6)
# 211.9583 days beginning at 2009-01-01

span$start
# "2009-01-01 CST"make
span$end
# "2009-02-01 CST"}
