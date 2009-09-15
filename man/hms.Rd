\name{hms}
\alias{hms}
\title{Create a date-time with the specified hours, minutes, and seconds...}
\usage{hms(...)}

\description{
  Create a date-time with the specified hours, minutes, and seconds
}

\details{
  Transforms a numeric or character string into a POSIXct object with
  the current date and the specified number of hours, minutes, and
  seconds. hms recognizes ":" and "" (i.e., no separator) as
  separators. Hours, minutes, and seconds should be written as a two
  digit integers (00-23)(00-59)(00-59).
}
\value{a vector of POSIXct date-time objects}
\seealso{\code{link{hm}}}
\keyword{chron}
\arguments{
  \item{...}{a character or numeric vector of hour minute pairs}
}
\examples{x <- c("09:10:01", "09:10:02", "09:10:03")
hms(x)
# "2009-08-04 09:10:01 GMT" "2009-08-04 09:10:02 GMT" "2009-08-04 09:10:03 GMT"
hms("070605")
# "2009-08-04 07:06:05 GMT"
hms(070605)
# "2009-08-04 07:06:05 GMT"}
