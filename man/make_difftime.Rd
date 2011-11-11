\name{make_difftime}
\alias{make_difftime}
\title{Makes a difftime object from a given number of seconds}
\usage{
  make_difftime(x)
}
\arguments{
  \item{x}{number value of seconds to be transformed into a
  difftime object}
}
\value{
  a difftime object corresponding to x seconds
}
\description{
  Makes a difftime object from a given number of seconds
}
\examples{
make_difftime(1)
make_difftime(60)
make_difftime(3600)
}
\keyword{chron}

