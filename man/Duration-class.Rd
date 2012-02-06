\name{Duration-class}
\alias{Duration-class}
\title{Duration class}
\description{
  Duration is an S4 class that extends the
  \code{\link{Timespan}} class. Durations record the exact
  number of seconds in a time span. They measure the exact
  passage of time but do not always align with measurements
  made in larger units of time such as hours, months and
  years. This is because the length of larger time units
  can be affected by conventions such as leap years and
  Daylight Savings Time.

  Duration is an S4 class that extends the
  \code{\link{Timespan}} class. Durations record the exact
  number of seconds in a time span. They measure the exact
  passage of time but do not always align with measurements
  made in larger units of time such as hours, months and
  years. This is because the length of larger time units
  can be affected by conventions such as leap years and
  Daylight Savings Time.
}
\details{
  Durations provide a method for measuring generalized
  timespans when we wish to treat time as a mathematical
  quantity that increases in a uniform, monotone manner
  along a continuous numberline. They allow exact
  comparisons with other durations. See
  \code{\link{Periods}} for an alternative way to measure
  timespans that better preserves clock times.

  Durations class objects have one slot

  \item{.Data}{A numeric object. The amount of seconds in
  the duration.}

  Durations provide a method for measuring generalized
  timespans when we wish to treat time as a mathematical
  quantity that increases in a uniform, monotone manner
  along a continuous numberline. They allow exact
  comparisons with other durations. See
  \code{\link{Periods}} for an alternative way to measure
  timespans that better preserves clock times.

  Durations class objects have one slot

  \item{.Data}{A numeric object. The amount of seconds in
  the duration.}
}

