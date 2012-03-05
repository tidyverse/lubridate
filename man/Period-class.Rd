\name{Period-class}
\alias{-,ANY,Period-method}
\alias{-,Period,missing-method}
\alias{!=,Duration,Period-method}
\alias{!=,Period,Duration-method}
\alias{!=,Period,Period-method}
\alias{[,Period-method}
\alias{[<-,Period,Period-method}
\alias{*,ANY,Period-method}
\alias{*,Period,ANY-method}
\alias{/,difftime,Period-method}
\alias{/,numeric,Period-method}
\alias{/,Period,difftime-method}
\alias{/,Period,Duration-method}
\alias{/,Period,Interval-method}
\alias{/,Period,numeric-method}
\alias{/,Period,Period-method}
\alias{\%\%,Period,Duration-method}
\alias{\%\%,Period,Interval-method}
\alias{\%\%,Period,Period-method}
\alias{+,Date,Period-method}
\alias{+,difftime,Period-method}
\alias{+,numeric,Period-method}
\alias{+,Period,Date-method}
\alias{+,Period,difftime-method}
\alias{+,Period,Duration-method}
\alias{+,Period,Interval-method}
\alias{+,Period,numeric-method}
\alias{+,Period,Period-method}
\alias{+,Period,POSIXct-method}
\alias{+,Period,POSIXlt-method}
\alias{+,POSIXct,Period-method}
\alias{+,POSIXlt,Period-method}
\alias{<,Duration,Period-method}
\alias{<,Period,Duration-method}
\alias{<,Period,Period-method}
\alias{<=,Duration,Period-method}
\alias{<=,Period,Duration-method}
\alias{<=,Period,Period-method}
\alias{==,Duration,Period-method}
\alias{==,Period,Duration-method}
\alias{==,Period,Period-method}
\alias{>,Duration,Period-method}
\alias{>,Period,Duration-method}
\alias{>,Period,Period-method}
\alias{>=,Duration,Period-method}
\alias{>=,Period,Duration-method}
\alias{>=,Period,Period-method}
\alias{$,Period-method}
\alias{$<-,Period-method}
\alias{as.difftime,Period-method}
\alias{as.numeric,Period-method}
\alias{c,Period-method}
\alias{Period-class}
\alias{rep,Period-method}
\alias{show,Period-method}
\title{Period class}
\description{
  Period is an S4 class that extends the
  \code{\link{Timespan-class}} class. Periods track the
  change in the "clock time" between two date-times. They
  are measured in common time related units: years, months,
  days, hours, minutes, and seconds. Each unit except for
  seconds must be expressed in integer values.
}
\details{
  The exact length of a period is not defined until the
  period is placed at a specific moment of time. This is
  because the precise length of one year, month, day, etc.
  can change depending on when it occurs due to daylight
  savings, leap years, and other conventions. A period can
  be associated with a specific moment in time by coercing
  it to an \code{\link{Interval-class}} object with
  \code{\link{as.interval}} or by adding it to a date-time
  with "+".

  Periods provide a method for measuring generalized
  timespans when we wish to model clock times. Periods will
  attain intuitive results at this task even when leap
  years, leap seconds, gregorian days, daylight savings
  changes, and other events happen during the period. See
  \code{\link{Duration-class}} for an alternative way to
  measure timespans that allows precise comparisons between
  timespans.

  Period class objects have six slots. 1) .Data, a numeric
  object. The apparent amount of seconds to add to the
  period. 2) minute, a numeric object. The apparent amount
  of minutes to add to the period. 3) hour, a numeric
  object. The apparent amount of hours to add to the
  period.4) day, a numeric object. The apparent amount of
  days to add to the period.5) month, a numeric object. The
  apparent amount of months to add to the period. 6) year,
  a numeric object. The apparent amount of years to add to
  the period.
}

