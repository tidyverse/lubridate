\name{int_shift}
\alias{int_shift}
\title{Shift an interval along the timeline}
\usage{
  int_shift(int, by)
}
\arguments{
  \item{int}{An interval object}
}
\value{
  An interval object
}
\description{
  Shifts the start and end dates of an interval up or down
  the timeline by a specified amount. Note that this may
  change the exact length of the interval.
}
\seealso{
  \code{\link{int_flip}}, \code{\link{int_start}},
  \code{\link{int_end}}
}

