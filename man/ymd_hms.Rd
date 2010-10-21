\name{ymd_hms}
\alias{ymd_hms}
\title{Parse dates that appear in standard POSIXt order...}
\usage{ymd_hms(...)}

\description{
  Parse dates that appear in standard POSIXt order
}

\details{
  Transforms dates stored as character vectors in year,
  month, day, hour, minute, second format to POSIXct
  objects. ymd_hms() recognizes all non-alphanumeric
  separators of length 1 with the exception of ".".
  ymd_hms() automatically assigns the Universal
  Coordinated Time Zone (UTC) to the parsed date. This
  time zone can be changed with \code{\link{force_tz}}.
}
\value{a vector of POSIXct date-time objects}
\seealso{\code{\link{ymd}}, \code{\link{hms}}}
\keyword{POSIXt}
\keyword{parse}
\arguments{
  \item{...}{a character vector of dates in year, month, day, hour, minute, 
second format}
}
\examples{x <- c("2010-04-14-04-35-59", "2010-04-01-12-00-00")
ymd_hms(x)
# [1] "2010-04-14 04:35:59 UTC" "2010-04-01 12:00:00 UTC"
y <- c("2011-12-31 12:59:59", "2010-01-01 12:00:00")
ymd_hms(y)
# [1] "2011-12-31 12:59:59 UTC" "2010-01-01 12:00:00 UTC"}
