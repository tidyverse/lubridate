\name{int_flip}
\alias{int_flip}
\title{Flip the direction of an interval}
\usage{
  int_flip(int)
}
\arguments{
  \item{int}{An interval object}
}
\value{
  An interval object
}
\description{
  Reverses the order of the start date and end date in an
  interval. The new interval takes place during the same
  timespan as the original interval, but has the opposite
  direction.
}
\seealso{
  \code{\link{int_shift}}, \code{\link{int_start}},
  \code{\link{int_end}}
}

