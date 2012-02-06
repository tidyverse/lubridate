\name{Interval-class}
\alias{Interval-class}
\title{Interval class}
\description{
  Interval is an S4 class that extends the
  \code{\link{Timespan}} class. An Interval object records
  one or more spans of time. Intervals record these
  timespans as a sequence of seconds that begin at a
  specified date. Since intervals are anchored to a precise
  moment of time, they can accurately be converted to
  \code{\link{Period}} or \code{\link{Duration}} class
  objects. This is because we can observe the length in
  seconds of each period that begins on a specific date.
  Contrast this to a generalized period, which may not have
  a consistent length in seconds (e.g. the number of
  seconds in a year will change if it is a leap year).
}
\details{
  Intervals can be both negative and positive. Negative
  intervals progress backwards from the start date;
  positive intervals progress forwards.

  \details{Interval class objects have two slots

  \item{.Data}{A numeric object. The amount of seconds in
  the interval}

  \item{start}{A POSIXct object. The time when the interval
  starts.} }
}

