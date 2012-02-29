\name{ymd_hms}
\alias{dmy_h}
\alias{dmy_hm}
\alias{dmy_hms}
\alias{mdy_h}
\alias{mdy_hm}
\alias{mdy_hms}
\alias{ydm_h}
\alias{ydm_hm}
\alias{ydm_hms}
\alias{ymd_h}
\alias{ymd_hm}
\alias{ymd_hms}
\alias{ymdThms}
\title{Parse dates that have hours, minutes, or seconds elements}
\usage{
  ymd_hms(..., quiet = FALSE)
}
\arguments{
  \item{quiet}{logical. When TRUE function evalueates
  without displaying customary messages.}

  \item{...}{a character vector of dates in year, month,
  day, hour, minute, second format}
}
\value{
  a vector of POSIXct date-time objects
}
\description{
  Transforms dates stored as character vectors in year,
  month, day, hour, minute, second format to POSIXct
  objects. ymd_hms() type functions recognize all
  non-alphanumeric separators of length 1 with the
  exception of ".". ymd_hms() functions automatically
  assigns the Universal Coordinated Time Zone (UTC) to the
  parsed date. This time zone can be changed with
  \code{\link{force_tz}}. ymdThms() specifically handles
  combined dates and times written in the ISO 8601 format.
}
\examples{
x <- c("2010-04-14-04-35-59", "2010-04-01-12-00-00")
ymd_hms(x)
# [1] "2010-04-14 04:35:59 UTC" "2010-04-01 12:00:00 UTC"
y <- c("2011-12-31 12:59:59", "2010-01-01 12:00:00")
ymd_hms(y)
# [1] "2011-12-31 12:59:59 UTC" "2010-01-01 12:00:00 UTC"
}
\seealso{
  \code{\link{ymd}}, \code{\link{hms}}
}
\keyword{parse}
\keyword{POSIXt}

