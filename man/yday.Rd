\name{yday}
\title{Get/set days component of a date-time.}
\usage{yday(x)}

\description{
  Get/set days component of a date-time.
}

\details{
  Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr,
  zoo, zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts
  objects.
}
\alias{yday.default}
\alias{yday.zoo}
\alias{yday.its}
\alias{yday.ti}
\alias{yday.timeseries}
\alias{yday.fts}
\alias{yday.irts}
\alias{wday.default}
\alias{wday.zoo}
\alias{wday.its}
\alias{wday.ti}
\alias{wday.timeseries}
\alias{wday.fts}
\alias{wday.irts}
\alias{mday.default}
\alias{mday.zoo}
\alias{mday.its}
\alias{mday.ti}
\alias{mday.timeseries}
\alias{mday.fts}
\alias{mday.irts}
\alias{yday}
\alias{mday}
\alias{wday}
\alias{day<-}
\alias{yday<-.default}
\alias{yday<-.Date}
\alias{yday<-.chron}
\alias{yday<-.zoo}
\alias{yday<-.its}
\alias{yday<-.ti}
\alias{yday<-.timeDate}
\alias{yday<-.jul}
\alias{yday<-.timeSeries}
\alias{yday<-.fts}
\alias{yday<-.irts}
\alias{wday<-}
\alias{wday<-.default}
\alias{wday<-.Date}
\alias{wday<-.chron}
\alias{wday<-.zoo}
\alias{wday<-.its}
\alias{wday<-.ti}
\alias{wday<-.timeDate}
\alias{wday<-.jul}
\alias{wday<-.timeSeries}
\alias{wday<-.fts}
\alias{wday<-.irts}
\alias{mday<-}
\alias{mday<-.default}
\alias{mday<-.Date}
\alias{mday<-.chron}
\alias{mday<-.zoo}
\alias{mday<-.its}
\alias{mday<-.ti}
\alias{mday<-.timeDate}
\alias{mday<-.jul}
\alias{mday<-.timeSeries}
\alias{mday<-.fts}
\alias{mday<-.irts}
\value{yday returns the day of the year as a decimal number (01-366). mday returns the day of 
the month as a decimal number (01-31). wday returns the day of the week as a decimal number 
(01-07, Sunday is 1).}
\keyword{utilities}
\keyword{manip}
\keyword{chron}
\keyword{methods}
\arguments{
  \item{x}{a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, zooreg, timeDate, xts, its, ti, 
jul, timeSeries, or fts object.}
  \item{label}{logical. Only available for wday. TRUE will display the day of the week as a 
character string label such as "Sunday." FALSE will display the day of the week as a number.}
  \item{abbr}{logical. Only available for wday. FALSE will display the day of the week as a 
character string label such as "Sunday." TRUE will display an abbreviated version of the 
label, such as "Sun". abbr is disregarded if label = FALSE.}
}
\examples{x <- as.Date("2009-09-02")
yday(x) #245
mday(x) #2
wday(x) #4
yday(x) <- 1  #"2009-01-01"
yday(x) <- 366 #"2010-01-01"
mday(x) > 3

wday(ymd(080101))
# 3
wday(ymd(080101), label = TRUE)
# "Tuesday"
wday(ymd(080101), label = TRUE, abbr = TRUE)
# "Tues"
wday(ymd(080101) + days(-2:4), label = TRUE, abbr = TRUE)
# "Sun"   "Mon"   "Tues"  "Wed"   "Thurs" "Fri"   "Sat"}
