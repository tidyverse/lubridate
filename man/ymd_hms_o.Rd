\name{ymd_hms_o}
\alias{ymd_hms_o}
\title{ymd_hms_o}
\usage{
  ymd_hms_o(..., quiet = FALSE,
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
  a vector of POSIXct date-time objects, expressed as UTC
}
\description{
  Wrapper for \code{ymd_hms} function where there is a
  trailing offset
}
\details{
  Examples of acceptable formats for the offset are:
  \code{"+00:00"}, \code{"-05:00"}, \code{"+0100"},
  \code{"-06"}.

  The same thing might be accomplished by tweaking
  \code{.parse_xxx}, such that if it "sees" a trailing
  \code{"-05:00"}, ignores the \code{tz} argument in favor
  of \code{"UTC"} and applies the offset. This author isn't
  confident enough to muck with \code{.parse_xxx}, so he
  punts instead.
}
\examples{
my_instant <- ymd_hms_o("2012-03-04T05:06:07-05:00")
my_offset <- helper_offset(with_tz(my_instant, tz="America/New_York"), sep=":")
paste(format(my_instant, "\\\%Y-\\\%m-\\\%dT\\\%H:\\\%M:\\\%S"), my_offset, sep="")
}
\seealso{
  \code{\link{ymd}}, \code{\link{hms}}.
  \code{\link{parse_date_time}} for underlying mechanism.
}
\keyword{POSIXt}
\keyword{parse}

