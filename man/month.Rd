\name{month}
\title{Get/set months component of a date-time.}
\usage{\method{month}{default} (x, label=FALSE, abbr=FALSE)}

\description{
  Get/set months component of a date-time.
}

\details{
  Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr,
  zoo, zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts
  objects.
}
\alias{month.default}
\alias{month.zoo}
\alias{month.its}
\alias{month.ti}
\alias{month.timeseries}
\alias{month.fts}
\alias{month.irts}
\alias{month}
\value{the months element of x as a number (1-12) or character string. 1 = January.}
\keyword{utilities}
\keyword{manip}
\keyword{chron}
\keyword{methods}
\arguments{
  \item{x}{a date-time object}
  \item{label}{logical. TRUE will display the month as a character string such as "January." FALSE will display the month as a number.}
  \item{abbr}{logical. FALSE will display the month as a character string label, such as "January". TRUE will display an abbreviated version of the label, such as "Jan". abbr is disregarded if label = FALSE.}
}
\examples{x <- now()
month(x) 
month(x) <- 1  
month(x) <- 13
month(x) > 3

month(ymd(080101))
# 1
month(ymd(080101), label = TRUE)
# "January"
month(ymd(080101), label = TRUE, abbr = TRUE)
# "Jan"
month(ymd(080101) + months(0:11), label = TRUE, abbr = TRUE)
# "Jan" "Feb" "Mar" "Apr" "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov" "Dec"}
