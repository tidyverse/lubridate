\name{force_tz}
\alias{force_tz}
\title{Replace time zone to create new date-time...}
\usage{force_tz(time, tz="")}

\description{
  Replace time zone to create new date-time
}

\details{
  force_tz returns a the date-time that has the same clock time as x in
  the new time zone.  Although the new date-time has the same clock
  time (e.g. the same values in the year, month, days, etc. elements)
  it is a different moment of time than the input date-time.
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
\examples{x <- as.POSIXct("2009-08-07 00:00:00 CDT")
force_tz(x, "GMT")
# "2009-08-07 00:00:00 GMT"}
