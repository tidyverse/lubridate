\name{today}
\alias{today}
\title{The current date...}

\description{
  The current date
}
\value{the current date as a Date object}
\keyword{chron}
\keyword{utilities}
\arguments{
  \item{tzone}{a character vector specifying which time zone you would like to 
find the current date of. tzone defaults to the system time zone set on your 
computer.}
}
\examples{today()
today("GMT")
today() == today("GMT") # not always true
today() < as.Date("2999-01-01") # TRUE  (so far)}
