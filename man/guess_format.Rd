\name{guess_format}
\alias{guess_format}
\title{Guess the format of dates in a character or numeric vector...}
\usage{guess_format(x, formats, seps=c("-", "/", ""))}

\description{
  Guess the format of dates in a character or numeric vector
}

\details{
  Returns the format that successfully parses the most dates within a
  character or numeric vector to POSIXct objects. If multiple formats
  are equally successful, guess format will display the successful
  formats in a message and select the first format by default.
  guess_format assumes that each date only uses one type of separator
  and that all dates use the same separator.
}
\value{a character string of the most likely date-time format}
\seealso{\code{link{find_separator}}}
\keyword{chron}
\arguments{
  \item{x}{a character or numeric vector of suspected dates}
  \item{formats}{a list of formats to test. Each format should be a vector of
date-time format elements. To test an alternative order of elements, the
alternative order should be entered as an additional format. See
\code{link[base]{strptime}} for format elements.}
  \item{seps}{a vector of possible characters used to separate elements
within the dates.}
}
\examples{x <- c("2009/01/01", "2009/01/02", "2009/01/03")
guess_format(x, list(c("%y", "%m", "%d"), c("%Y", "%m", "%d")), seps = c("-", "", "/"))
# "%Y/%m/%d"
x <- c("20090101", "20090102", "20090103")
guess_format(x, list(c("%y", "%m", "%d"), c("%Y", "%m", "%d")), seps = c("-", "", "/"))
#  "%Y%m%d" 
x <- c("09-01-01", "09-01-02", "09-01-03")
guess_format(x, list(c("%y", "%m", "%d"), c("%Y", "%m", "%d")), seps = c("-", "", "/"))
#  Multiple format matches with 3 successes: %y-%m-%d, %Y-%m-%d.
#         1 
# "%y-%m-%d"}
