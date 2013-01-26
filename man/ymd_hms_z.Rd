\name{ymd_hms_z}
\alias{ymd_hms_z}
\title{ymd_hms_z}
\usage{
  ymd_hms_z(..., quiet = FALSE,
    locale = Sys.getlocale("LC_TIME"), truncated = 0)
}
\arguments{
  \item{...}{a character vector of dates in year, month,
  day, hour, minute, second format}

  \item{quiet}{logical. When TRUE function evaluates
  without displaying customary messages.}

  \item{locale}{locale to be used, see \link{locales}. On
  linux systems you can use \code{system("locale -a")} to
  list all the installed locales.}

  \item{truncated}{integer, indicating how many formats can
  be missing. See details.}
}
\value{
  a vector of POSIXct date-time objects
}
\description{
  Wrapper for \code{ymd_hms} function where there is a
  trailing Z.
}
\details{
  This is often found for strings in ISO-8601 format, where
  Z signifies "UTC". As such, the timezone option is not
  offered for this format.

  Note: the scope of lubridate does not include formatting
  to strings. The following format is suggested, first
  ensuring the instant is expressed as UTC:
  \code{"\%Y-\%m-\%dT\%H-\%M-\%SZ"}

  In the spirit of not writing code where code is not
  absolutely needed, this function may be redundant. The
  only thing it does is force the date-time to be parsed as
  UTC.

  Furthermore, the same thing might be accomplished by
  tweaking \code{.parse_xxx}, such that if it "sees" the
  trailing \code{"Z"}, it ignores the \code{tz} argument in
  favor of \code{"UTC"}. This author isn't confident enough
  to muck with \code{.parse_xxx}, so he punts instead.
}
\examples{
my_instant <- ymd_hms_z("2012-03-04T05:06:07Z")
format(my_instant, "\\\%Y-\\\%m-\\\%dT\\\%H:\\\%M:\\\%SZ")
}
\seealso{
  \code{\link{ymd}}, \code{\link{hms}}.
  \code{\link{parse_date_time}} for underlying mechanism.
}
\keyword{POSIXt}
\keyword{parse}

