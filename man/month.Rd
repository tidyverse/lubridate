\name{month}
\alias{month}
\alias{month<-}
\title{Get/set months component of a date-time.}
\usage{
  month(x, label = FALSE, abbr = TRUE)
}
\arguments{
  \item{x}{a date-time object}

  \item{label}{logical. TRUE will display the month as a
  character string such as "January." FALSE will display
  the month as a number.}

  \item{abbr}{logical. FALSE will display the month as a
  character string #' label, such as #' "January". TRUE
  will display an abbreviated version of the label, such as
  "Jan". abbr is #' disregarded if label = FALSE.}
}
\value{
  the months element of x as a number (1-12) or character
  string. 1 = January.
}
\description{
  Date-time must be a POSIXct, POSIXlt, Date, Period,
  chron, yearmon, yearqtr, zoo, zooreg, timeDate, xts, its,
  ti, jul, timeSeries, and fts objects.
}
\examples{
x <- ymd("2012-03-26")
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
# "Jan" "Feb" "Mar" "Apr" "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov" "Dec"
}
\keyword{chron}
\keyword{manip}
\keyword{methods}
\keyword{utilities}

