\name{with_tz}
\alias{with_tz}
\title{Get date-time in a different time zone...}
\usage{with_tz(time, tzone="")}

\description{
  Get date-time in a different time zone
}

\details{
  with_tz returns a date-time as it would appear in a
  different time zone.  The actual moment of time
  measured does not change, just the time zone it is
  measured in. with_tz defaults to the Universal
  Coordinated time zone (UTC) when an unrecognized time
  zone is inputted. See \code{\link{Sys.timezone}} for
  more information on how R recognizes time zones.
}
\value{a POSIXct object in the updated time zone}
\keyword{chron}
\keyword{manip}
\seealso{\code{\link{force_tz}}}
\arguments{
  \item{time}{a POSIXct, POSIXlt, Date, or chron date-time object.}
  \item{tzone}{a character string containing the time zone to convert to. R must recognize the name 
contained in the string as a time zone on your system.}
}
\examples{x <- as.POSIXct("2009-08-07 00:00:01", tz = "America/New_york")
with_tz(x, "GMT")
# "2009-08-07 04:00:01 GMT"}
