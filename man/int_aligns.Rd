\name{int_aligns}
\alias{int_aligns}
\title{Test if two intervals share an endpoint}
\usage{
  int_aligns(int1, int2)
}
\arguments{
  \item{int1}{an Interval object}

  \item{int2}{an Interval object}
}
\value{
  Logical. TRUE if int1 and int2 at least one endpoint in
  any combination. FALSE otherwise.
}
\description{
  Test if two intervals share an endpoint
}

