\name{int_overlaps}
\alias{int_overlaps}
\title{Test if two intervals overlap}
\usage{
  int_overlaps(int1, int2)
}
\arguments{
  \item{int1}{an Interval object}

  \item{int2}{an Interval object}
}
\value{
  Logical. TRUE if int1 and int2 overlap by at least one
  second. FALSE otherwise.
}
\description{
  Test if two intervals overlap
}
\examples{
int1 <- new_interval(ymd("2001-01-01"), ymd("2002-01-01"))
# 2001-01-01 UTC--2002-01-01 UTC
int2 <- new_interval(ymd("2001-06-01"), ymd("2002-06-01"))
# 2001-06-01 UTC--2002-06-01 UTC
int3 <- new_interval(ymd("2003-01-01"), ymd("2004-01-01"))
# 2003-01-01 UTC--2004-01-01 UTC

int_overlaps(int1, int2) # TRUE
int_overlaps(int1, int3) # FALSE
}

