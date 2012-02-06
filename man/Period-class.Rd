\name{Period-class}
\alias{Period-class}
\title{Period class}
\description{
  Period is an S4 class that extends the
  \code{\link{Timespan}} class. Periods track the change in
  the "clock time" between two date-times. They are
  measured in common time related units: years, months,
  days, hours, minutes, and seconds. Each unit except for
  seconds must be expressed in integer values.

  Period is an S4 class that extends the
  \code{\link{Timespan}} class. Periods track the change in
  the "clock time" between two date-times. They are
  measured in common time related units: years, months,
  days, hours, minutes, and seconds. Each unit except for
  seconds must be expressed in integer values.
}
\details{
  The exact length of a period is not defined until the
  period is placed at a specific moment of time. This is
  because the precise length of one year, month, day, etc.
  can change depending on when it occurs. A period can be
  associated with a specific moment in time by coercing it
  to an \code{\link{Interval}} object with
  \code{\link{as.interval}} or by adding it to a date-time
  with "+".

  Periods provide a method for measuring generalized
  timespans when we wish to model clock times. Periods will
  attain intuitive results at this task even when leap
  years, leap seconds, gregorian days, daylight savings
  changes, and other events happen uring the period. See
  \code{\link{Durations}} for an alternative way to measure
  timespans that allows precise comparisons between
  timespans.

  Period class objects have six slots

  \item{.Data}{A numeric object. The apparent amount of
  seconds to add to the period.}

  \item{minute}{A numeric object. The apparent amount of
  minutes to add to the period.}

  \item{hour}{A numeric object. The apparent amount of
  hours to add to the period.}

  \item{day}{A numeric object. The apparent amount of days
  to add to the period.}

  \item{month}{A numeric object. The apparent amount of
  months to add to the period.}

  \item{year}{A numeric object. The apparent amount of
  years to add to the period.}

  The exact length of a period is not defined until the
  period is placed at a specific moment of time. This is
  because the precise length of one year, month, day, etc.
  can change depending on when it occurs. A period can be
  associated with a specific moment in time by coercing it
  to an \code{\link{Interval}} object with
  \code{\link{as.interval}} or by adding it to a date-time
  with "+".

  Periods provide a method for measuring generalized
  timespans when we wish to model clock times. Periods will
  attain intuitive results at this task even when leap
  years, leap seconds, gregorian days, daylight savings
  changes, and other events happen uring the period. See
  \code{\link{Durations}} for an alternative way to measure
  timespans that allows precise comparisons between
  timespans.

  Period class objects have six slots

  \item{.Data}{A numeric object. The apparent amount of
  seconds to add to the period.}

  \item{minute}{A numeric object. The apparent amount of
  minutes to add to the period.}

  \item{hour}{A numeric object. The apparent amount of
  hours to add to the period.}

  \item{day}{A numeric object. The apparent amount of days
  to add to the period.}

  \item{month}{A numeric object. The apparent amount of
  months to add to the period.}

  \item{year}{A numeric object. The apparent amount of
  years to add to the period.}
}

