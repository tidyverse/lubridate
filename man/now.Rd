\name{now}
\alias{now}
\title{The current time...}
\usage{now(tzone="")}

\description{
  The current time
}
\value{the current date and time as a POSIXct object}
\keyword{chron}
\keyword{utilities}
\arguments{
  \item{tzone}{a character vector specifying which time zone you would like 
the current time in. tzone defaults to the system time zone set on your 
computer.}
}
\examples{now()
now("GMT")
now() == now() # would be true if computer processed both at the same instant
now() < now() # TRUE
now() > now() # FALSE}
