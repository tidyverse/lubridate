\name{c.POSIXct}
\alias{c.POSIXct}
\title{Combine POSIXct instants into a single vector or list}
\usage{
  c.POSIXct(..., recursive = FALSE)
}
\arguments{
  \item{...}{POSIXct instants to be concatenated.}

  \item{recursive}{ogical. If recursive = TRUE, the
  function recursively descends through lists (and
  pairlists) combining all their elements into a vector.}
}
\value{
  \code{NULL} or an expression or a vector of an
  appropriate mode. (With no arguments the value is
  \code{NULL}.)
}
\description{
  This is a specific method for POSIXct instants defined by
  \code{lubridate}.
}

