\name{ymd}
\alias{dmy}
\alias{dym}
\alias{mdy}
\alias{myd}
\alias{ydm}
\alias{yearmonthdate}
\alias{ymd}
\title{Parse dates according to the order that year, month, and day elements appear}
\usage{
  ymd(..., quiet = FALSE, tz = "UTC")
}
\arguments{
  \item{...}{a character or numeric vector of suspected
  dates}

  \item{quiet}{logical. When TRUE function evalueates
  without displaying customary messages.}

  \item{tz}{a character string that specifies which time
  zone to parse the date with. The string must be a time
  zone that is recognized by the user's OS.}
}
\value{
  a vector of POSIXct date-time objects
}
\description{
  Transforms dates stored in character and numeric vectors
  to POSIXct objects. These functions automatically
  recognize the following separators: "-", "/", ".", and ""
  (i.e., no separators).
}
\details{
  Users should choose the function that models the order in
  which year(y), month(m), and date(d) appear in the dates.
  All inputed dates are considered to have the same order
  and the same separators.

  ymd() type functions automatically assign the Universal
  Coordinated Time Zone (UTC) to the parsed dates. This
  time zone can be changed with \code{\link{force_tz}}.
}
\examples{
x <- c("09-01-01", "09-01-02", "09-01-03")
ymd(x)
# "2009-01-01 UTC" "2009-01-02 UTC" "2009-01-03 UTC"
z <- c("2009-01-01", "2009-01-02", "2009-01-03")
ymd(z)
# "2009-01-01 UTC" "2009-01-02 UTC" "2009-01-03 UTC"
ymd(090101)
# "2009-01-01 UTC"
ymd(90101)
# "2009-01-01 UTC"
now() > ymd(20090101)
# TRUE
dmy(010210)
mdy(010210)
}
\seealso{
  \code{\link{parse_date}}
}
\keyword{chron}

