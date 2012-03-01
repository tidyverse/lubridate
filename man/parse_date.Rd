\name{parse_date}
\alias{parse_date}
\title{Change dates into a POSIXct format}
\usage{
  parse_date(x, formats, quiet = FALSE,
    seps = find_separator(x), tz = "UTC")
}
\arguments{
  \item{x}{a character or numeric vector of suspected
  dates}

  \item{formats}{a vector of date-time format elements in
  the order they occur within the dates.  See
  \code{\link[base]{strptime}} for format elements.}

  \item{quiet}{logical. When TRUE function evalueates
  without displaying customary messages.}

  \item{seps}{a vector of possible characters used to
  separate elements within the dates.}

  \item{tz}{a character string that specifies the time zone
  with which to parse the dates}
}
\value{
  a vector of POSIXct date-time objects
}
\description{
  parse_date is an internal function for the
  \code{\link{ymd}} family of functions. Its recommended to
  use these functions instead. It transforms dates stored
  in character and numeric vectors to POSIXct objects. All
  inputed dates are considered to have the same order and
  to use the same separator.
}
\examples{
x <- c("09-01-01", "09-01-02", "09-01-03")
parse_date(x, c("\%y", "\%m", "\%d"), seps = "-")
#  "2009-01-01 UTC" "2009-01-02 UTC" "2009-01-03 UTC"
ymd(x)
#  "2009-01-01 UTC" "2009-01-02 UTC" "2009-01-03 UTC"
}
\seealso{
  \code{\link{ymd}}
}
\keyword{chron}

