\name{Duration-class}
\alias{$,Duration-method}
\alias{$<-,Duration-method}
\alias{*,ANY,Duration-method}
\alias{*,Duration,ANY-method}
\alias{+,Date,Duration-method}
\alias{+,Duration,Date-method}
\alias{+,Duration,Duration-method}
\alias{+,Duration,Interval-method}
\alias{+,Duration,POSIXct-method}
\alias{+,Duration,POSIXlt-method}
\alias{+,Duration,Period-method}
\alias{+,Duration,difftime-method}
\alias{+,Duration,numeric-method}
\alias{+,POSIXct,Duration-method}
\alias{+,POSIXlt,Duration-method}
\alias{+,difftime,Duration-method}
\alias{+,numeric,Duration-method}
\alias{-,ANY,Duration-method}
\alias{-,Duration,missing-method}
\alias{/,Duration,Duration-method}
\alias{/,Duration,Interval-method}
\alias{/,Duration,Period-method}
\alias{/,Duration,difftime-method}
\alias{/,Duration,numeric-method}
\alias{/,difftime,Duration-method}
\alias{/,numeric,Duration-method}
\alias{Duration-class}
\alias{[,Duration-method}
\alias{[<-,Duration,ANY,ANY,ANY-method}
\alias{[[,Duration-method}
\alias{[[<-,Duration,ANY,ANY,ANY-method}
\alias{\%\%,Duration,Duration-method}
\alias{\%\%,Duration,Interval-method}
\alias{\%\%,Duration,Period-method}
\alias{as.character,Duration-method}
\alias{as.difftime,Duration-method}
\alias{as.numeric,Duration-method}
\alias{c,Duration-method}
\alias{rep,Duration-method}
\alias{show,Duration-method}
\title{Duration class}
\description{
  Duration is an S4 class that extends the
  \code{\link{Timespan-class}} class. Durations record the
  exact number of seconds in a time span. They measure the
  exact passage of time but do not always align with
  measurements made in larger units of time such as hours,
  months and years. This is because the exact length of
  larger time units can be affected by conventions such as
  leap years and Daylight Savings Time.
}
\details{
  Durations provide a method for measuring generalized
  timespans when we wish to treat time as a mathematical
  quantity that increases in a uniform, monotone manner
  along a continuous numberline. They allow exact
  comparisons with other durations. See
  \code{\link{Period-class}} for an alternative way to
  measure timespans that better preserves clock times.

  Durations class objects have one slot: .Data, a numeric
  object equal to the number of seconds in the duration.
}

