\name{hm}
\alias{hm}
\title{Create a period with the specified number of hours and minutes...}
\usage{hm(...)}

\description{
  Create a period with the specified number of hours and minutes
}

\details{
  Transforms a character string into a period object with the specified
  number of hours and minutes. hm() recognizes all non-alphanumeric
  separators of length 1 with the exception of ".".
}
\value{a vector of period objects}
\seealso{\code{\link{hms}, \link{ms}}}
\keyword{period}
\arguments{
  \item{...}{a character vector of hour minute pairs}
}
\examples{x <- c("09:10", "09:02", "1:10")
hm(x)
# [1] 9 hours and 10 minutes   9 hours and 2 minutes   1 hour and 10 minutes
hm("7 6")
# [1] 7 hours and 6 minutes
hm("6,5")
# [1] 6 hours and 5 minutes}
