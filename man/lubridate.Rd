\docType{package}
\name{lubridate}
\alias{lubridate}
\alias{lubridate-package}
\title{Dates and times made easy with lubridate}
\description{
  Lubridate provides tools that make it easier to parse and
  manipulate dates. These tools are grouped below by common
  purpose. More information about each function can be
  found in #' its help documentation.
}
\details{
  Parsing dates

  Lubridate's parsing functions read strings into R as
  POSIXct date-time objects. Users should choose the
  function whose name models the order in which the year
  ('y'), month ('m') and day ('d') elements appear the
  string to be parsed: \code{\link{dmy}},
  \code{\link{myd}}, \code{\link{ymd}}, \code{\link{ydm}},
  \code{\link{dym}}, \code{\link{mdy}},
  \code{\link{ymd_hms}}).

  Lubridate can also parse partial dates from strings into
  \code{\link{period}} objects with the functions
  \code{\link{hm}}, \code{\link{hms}} and \code{\link{ms}}.

  Manipulating dates

  Lubridate distinguishes between moments in time (known as
  \code{\link{instants}}) and spans of time (known as
  \code{\link{Timespan-class}}). Time spans are further
  separated into \code{\link{Duration-class}},
  \code{\link{Period-class}} and
  \code{\link{Interval-class}}.

  Instants

  Instants are specific moments of time. Date, POSIXct, and
  POSIXlt are the three object classes Base R recognizes as
  instants. \code{\link{is.Date}} tests whether an object
  inherits from the Date class. \code{\link{is.POSIXt}}
  tests whether an object inherits from the POSIXlt or
  POSIXct classes. \code{\link{is.instant}} tests whether
  an object inherits from any of the three classes.

  \code{\link{now}} returns the current system time as a
  POSIXct object. \code{\link{today}} returns the current
  system date. For convenience, 1970-01-01 00:00:00 is
  saved to \code{\link{origin}}. This is the instant from
  which POSIXct times are calculated from.

  Instants are a combination of measurements on different
  units (i.e, years, months, days, etc.). The individual
  values for these units can be extracted from an instant
  and set with the accessor functions \code{\link{second}},
  \code{\link{minute}}, \code{\link{hour}},
  \code{\link{day}}, \code{\link{yday}},
  \code{\link{mday}}, \code{\link{wday}},
  \code{\link{week}}, \code{\link{month}},
  \code{\link{year}}, \code{\link{tz}}, and
  \code{\link{dst}}. Note: the accessor functions are named
  after the singular form of an element. They shouldn't be
  confused with the period helper functions that have the
  plural form of the units as a name (e.g,
  \code{\link{seconds}}).

  Rounding dates

  Instants can be rounded to a convenient unit using the
  functions \code{\link{ceiling_date}},
  \code{\link{floor_date}} and\code{\link{round_date}}.

  Time zones

  Lubridate provides two helper functions for working with
  time zones. \code{\link{with_tz}} changes the time zone
  in which an instant is displayed. The clock time
  displayed for the instant changes, but the moment of time
  described remains the same. \code{\link{force_tz}}
  changes only the time zone element of an instant. The
  clock time displayed remains the same, but the resulting
  instant describes a new moment of time.

  Timespans

  A timespan is a length of time that may or not be
  connected to a particular instant. For example, three
  months or an hour and a half. Base R uses difftime class
  objects to record timespans. Lubridate creates three more
  timespan classes, \code{\link{Interval-class}},
  \code{\link{Period-class}} and
  \code{\link{Duration-class}}, to better navigate the
  nuances of time. \code{\link{is.difftime}} tests whether
  an object inherits from the difftime class.
  \code{\link{is.timespan}} tests whether an object
  inherits from any of the four timespan classes.

  Durations

  Durations measure the exact time of span that occurs
  between two instants. This can create unexpected results
  if a leap second, leap year, or change in daylight
  savings time (DST) occurs in the interval. Duration
  objects also inherit from the difftime class.

  Functions for working with durations include
  \code{\link{is.duration}}, \code{\link{as.duration}} and
  \code{\link{new_duration}}. \code{\link{dseconds}},
  \code{\link{dminutes}}, \code{\link{dhours}},
  \code{\link{ddays}}, \code{\link{dweeks}},
  \code{\link{dyears}} and \code{\link{new_duration}}
  quickly create durations of convenient lengths.

  Periods

  Periods measure the change in clock time that occurs
  between two instants. Periods provide robust predictions
  of clock time in the presence of leap seconds, leap
  years, and changes in DST.

  Functions for working with periods include
  \code{\link{is.period}}, \code{\link{as.period}} and
  \code{\link{new_period}}. \code{\link{seconds}},
  \code{\link{minutes}}, \code{\link{hours}},
  \code{\link{days}}, \code{\link{weeks}},
  \code{\link{months}} and \code{\link{years}} quickly
  create periods of convenient lengths.

  Intervals

  Intervals are timespans that begin at a specific instant.
  Intervals provide the only reliable way to convert
  between periods and durations. Intervals inherit from
  both difftime and duration object classes. They can be
  used as a difftime but contain an extra attribute which
  records the start time of the interval. When lubridate is
  loaded, subtracting two dates creates an interval by
  default.

  Functions for working with intervals include
  \code{\link{is.interval}}, \code{\link{as.interval}} and
  \code{\link{new_interval}}.

  Miscellaneous

  \code{\link{decimal_date}} converts an instant to a
  decimal of its year. \code{\link{leap_year}} tests
  whether an instant occurs during a leap year.
  \code{\link{pretty.dates}} provides a method of making
  pretty breaks for date-times \code{\link{lakers}} is a
  data set that contains information about the Los Angeles
  Lakers 2008-2009 basketball season.
}
\references{
  Garrett Grolemund, Hadley Wickham (2011). Dates and Times
  Made Easy with lubridate. Journal of Statistical
  Software, 40(3), 1-25.
  \url{http://www.jstatsoft.org/v40/i03/}.
}

