\name{hm}
\alias{hm}
\title{Create a date-time with the specified hours and minutes...}
\usage{hm(...)}

\description{
  Create a date-time with the specified hours and minutes
}

\details{
  Transforms a numeric or character string into a POSIXct object with
  the current date and the specified number of hours and minutes. hm
  recognizes ":" and "" (i.e., no separator) as separators. Hours
  should be written as a two digit integer (00-23). Minutes should be
  written as a two digit integer (00-59).
}
\value{a vector of POSIXct date-time objects}
\seealso{\code{link{hms}}}
\keyword{chron}
\arguments{
  \item{...}{a character or numeric vector of hour minute pairs}
}
\examples{x <- c("09:01", "09:02", "09:03")
hm(x)
# "2009-08-04 09:01:00 GMT" "2009-08-04 09:02:00 GMT" "2009-08-04 09:03:00 GMT"
hm(0802)
# "2009-08-04 08:02:00 GMT"}
