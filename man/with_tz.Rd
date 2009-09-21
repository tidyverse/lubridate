\name{with_tz}
\alias{with_tz}
\title{Get date-time in a different time zone...}
\usage{with_tz(time, tzone="")}

\description{
  Get date-time in a different time zone
}

\details{
  with_tz returns a date-time as it would appear in a different time
  zone.  The actual moment of time measured does not change, just the
  time zone it is measured in.
}
\value{a POSIXct object in the updated time zone}
\keyword{chron}
\keyword{manip}
\seealso{\code{\link{replace_tz}}}
\arguments{
  \item{time}{a POSIXct, POSIXlt, Date, or chron date-time object.}
  \item{tzone}{a character string containing the time zone to convert to. R must recognize the name 
contained in the string as a time zone on your system.}
}
\examples{x <- as.POSIXct("2009-08-07 00:00:00 CDT")
with_tz(x, "GMT")
# "2009-08-07 05:00:00 GMT"}
