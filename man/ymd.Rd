\name{ymd}
\alias{dmy}
\alias{dym}
\alias{mdy}
\alias{myd}
\alias{ydm}
\alias{yearmonthdate}
\alias{ymd}
\title{Parse dates according to the order that year, month, and day elements appear
in the input vector.}
\usage{
  ymd(..., quiet = FALSE, tz = "UTC", missing = 0)
}
\arguments{
  \item{...}{a character or numeric vector of suspected
  dates}

  \item{quiet}{logical. When TRUE function evalueates
  without displaying customary messages.}

  \item{tz}{a character string that specifies which time
  zone to parse the date with. The string must be a time
  zone that is recognized by the user's OS.}

  \item{missing}{integer. Number of formats that can be
  missing.}
}
\value{
  a vector of class POSIXct
}
\description{
  Transforms dates stored in character and numeric vectors
  to POSIXct objects. These functions automatically
  recognize all non-alphanumeric separators as well as no
  separator. As long as the order of formats is correct,
  these functions will parse dates correctly even when
  dates have different formats or use different separators.
  For even more flexibility in treatment of heterogeneous
  formats see low level parser \code{\link{parseDateTime}}.
}
\details{
  \code{ymd} family of functions automatically assign the
  Universal Coordinated Time Zone (UTC) to the parsed
  dates. This time zone can be changed with
  \code{\link{force_tz}}.

  If \code{missing} parameter is non-zero \code{ymd}
  functions also check for truncated formats. For example
  \code{ymd} with \code{missing = 2} will also parse
  incomplete dates like \code{2012-06} and \code{2012}.

  NOTE: \code{ymd} family of functions are based on
  \code{\link{strptime}} which currently correctly parses
  "\%y" format, but fails to parse "\%y-\%m" format.
}
\examples{
x <- c("09-01-01", "09-01-02", "09-01-03")
ymd(x)
## "2009-01-01 UTC" "2009-01-02 UTC" "2009-01-03 UTC"
x <- c("2009-01-01", "2009-01-02", "2009-01-03")
ymd(x)
## "2009-01-01 UTC" "2009-01-02 UTC" "2009-01-03 UTC"
ymd(090101, 90102)
## "2009-01-01 UTC" "2009-01-02 UTC"
now() > ymd(20090101)
## TRUE
dmy(010210)
mdy(010210)

## heterogenuous formats in a single vector:
x <- c(20090101, "2009-01-02", "2009 01 03", "2009-1-4",
       "2009-1, 5", "2009....1--6", "200901-07", "200901-8")
ymd(x)
## "2009-01-01 UTC" "2009-01-02 UTC" "2009-01-03 UTC" "2009-01-04 UTC" "2009-01-05 UTC" "2009-01-06 UTC"

## What lubridate might not handle:

## 1) Extremely weird cases when one of the separators is "" and some of the
## formats are not in double digits might not be parsed correctly:
ymd("201002-01", "201002-1", "20102-1")
dmy("0312-2010", "312-2010")

## 2) \%y formats have precedence over \%Y:
ymd("10-02-01", "2010-02-02")
## gives "2010-02-01 UTC" "2010-02-02 UTC" and not "10-02-01 UTC" "2010-02-02 UTC"

## This is usually what is desired, as it's very unlikely that "10-02-01" means
## year 10. If not, then you should use parseDateTime or strptime and pass
## formats explicitly.
}
\seealso{
  \code{\link{parseDateTime}} for underlying mechanism.
}
\keyword{chron}

