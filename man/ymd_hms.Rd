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
\title{Parse dates that have hours, minutes, or seconds elements.}
\usage{
  ymd_hms(..., quiet = FALSE, tz = "UTC", missing = 0,
    frac = FALSE)
}
\arguments{
  \item{...}{a character vector of dates in year, month,
  day, hour, minute, second format}

  \item{quiet}{logical. When TRUE function evalueates
  without displaying customary messages.}

  \item{tz}{a character string that specifies which time
  zone to parse the date with. The string must be a time
  zone that is recognized by the user's OS.}

  \item{missing}{integer, indicating how many formats can
  be missing. See details.}

  \item{frac}{If \code{TRUE}, fractional seconds are
  allowed. It is assumed that fractional seconds are
  separated by ".". In this case "." cannot be used as a
  separator between other fields.}
}
\value{
  a vector of POSIXct date-time objects
}
\description{
  Transform dates stored as character or numeric vectors to
  POSIXct objects. ymd_hms family of functions recognize
  all non-alphanumeric separators (with the exception of
  "." if \code{frac = TRUE}) and correctly handle
  heterogeneous date-time representations. For more
  flexibility in treatment of heterogeneous formats, see
  low level parser \code{\link{parseDateTime}}.
}
\details{
  ymd_hms() functions automatically assigns the Universal
  Coordinated Time Zone (UTC) to the parsed date. This time
  zone can be changed with \code{\link{force_tz}}.

  The most common type of irregularity in date-time data is
  the truncation due to rounding or unavailability of the
  time stamp. If \code{missing} parameter is non-zero
  \code{ymd_hms} functions also check for truncated
  formats. For example \code{ymd_hms} with \code{missing =
  3} will also parse incomplete dates like \code{2012-06-01
  12:23}, \code{2012-06-01 12} and \code{2012-06-01}. NOTE:
  \code{ymd} family of functions are based on
  \code{strptime} which currently fails to parse
  \code{\%y-\%m} formats.

  ymdThms() specifically handles combined dates and times
  written in the ISO 8601 format.
}
\examples{
x <- c("2010-04-14-04-35-59", "2010-04-01-12-00-00")
ymd_hms(x)
# [1] "2010-04-14 04:35:59 UTC" "2010-04-01 12:00:00 UTC"
x <- c("2011-12-31 12:59:59", "2010-01-01 12:00:00")
ymd_hms(x)
# [1] "2011-12-31 12:59:59 UTC" "2010-01-01 12:00:00 UTC"

## ** heterogenuous formats **
x <- c(20100101120101, "2009-01-02 12-01-02", "2009.01.03 12:01:03", "2009-1-4 12-1-4",
       "2009-1, 5 12:1, 5", "2009....1--6 - 12::1:6", "20090107 120107", "200901-08 1201-8",
       "10-01-09 12:01:09", "10-01-10 10:01:10 AM", "10-01-11 10:01:11 PM")
ymd_hms(x)
## "2009-01-01 UTC" "2009-01-02 UTC" "2009-01-03 UTC" "2009-01-04 UTC" "2009-01-05 UTC" "2009-01-06 UTC"

## ** truncated time-dates **
x <- c("2011-12-31 12:59:59", "2010-01-01 12:11", "2010-01-01 12", "2010-01-01")
ymd_hms(x, missing = 3)
## "2011-12-31 12:59:59 UTC" "2010-01-01 12:11:00 UTC" "2010-01-01 12:00:00 UTC" "2010-01-01 00:00:00 UTC"
x <- c("2011-12-31 12:59", "2010-01-01 12", "2010-01-01")
ymd_hm(x, missing = 2)
## "2011-12-31 12:59:00 UTC" "2010-01-01 12:00:00 UTC" "2010-01-01 00:00:00 UTC"

## ** fractional seconds **
options(digits.secs = 3)
x <- c("2011-12-31 12:59:59.23", "2010-01-01 12:11:10")
ymd_hms(x, frac = TRUE)
## "2011-12-31 12:59:59.23 UTC" "2010-01-01 12:11:10.00 UTC"

## ** What lubridate might not handle **
## 1) Extremely weird cases when one of the separators is "" and some of the
## formats are not in double digits might not be parsed correctly:
ymd_hm("20100201 07-01", "20100201 07-1", "20100201 7-01")
## "2010-02-01 07:01:00 UTC" "2010-02-01 07:01:00 UTC"   NA

## 2) \%y formats have precedence over \%Y:
ymd_h("10-02-01 02", "2010-02-02 02")
## gives "2010-02-01 02:00:00 UTC" "2010-02-02 02:00:00 UTC"
## and not  "10-02-01 UTC" "2010-02-02 UTC"

## This is usually what is desired, as it's very unlikely that "10-02-01" means
## year 10. If not, then you should use parseDateTime or strptime and pass
## formats explicitly.
}
\seealso{
  \code{\link{ymd}}, \code{\link{hms}}.
  \code{\link{parseDateTime}} for underlying mechanism.
}
\keyword{parse}
\keyword{POSIXt}

