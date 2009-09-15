\name{make_difftime}
\alias{make_difftime}
\title{Makes a difftime object from given number of seconds...}
\usage{make_difftime(x)}

\description{
  Makes a difftime object from given number of seconds
}
\value{a difftime object corresponding to x seconds}
\keyword{chron}
\arguments{
  \item{x}{number value of seconds to be transformed into a difftime object}
}
\examples{make_difftime(1)
make_difftime(60)
make_difftime(3600)}
