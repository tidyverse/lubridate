\name{\%within\%}
\alias{\%within\%}
\alias{\%within\%,ANY,Interval-method}
\alias{\%within\%,Interval,Interval-method}
\title{Tests whether a date or interval falls within an interval}
\usage{
  %within%(a, b)
}
\arguments{
  \item{a}{An interval or date-time object}

  \item{b}{An interval}
}
\value{
  A logical
}
\description{
  %within% returns TRUE is a falls within interval b, FALSE
  otherwise. If a is an interval, both its start and end
  dates must fall within b to return TRUE.
}

