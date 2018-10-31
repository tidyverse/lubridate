#' Dates and times made easy with lubridate
#'
#' Lubridate provides tools that make it easier to parse and
#' manipulate dates. These tools are grouped below by common
#' purpose. More information about each function can be found in
#' its help documentation.
#'
#' @section Parsing dates:
#'
#' Lubridate's parsing functions read strings into R as POSIXct
#' date-time objects. Users should choose the function whose name
#' models the order in which the year ('y'), month ('m') and day
#' ('d') elements appear the string to be parsed:
#' [dmy()], [myd()], [ymd()],
#' [ydm()], [dym()], [mdy()],
#' [ymd_hms()]). A very flexible and user friendly parser
#' is provided by [parse_date_time()].
#'
#' Lubridate can also parse partial dates from strings into
#' [Period-class] objects with the functions
#' [hm()], [hms()] and [ms()].
#'
#' Lubridate has an inbuilt very fast POSIX parser. Most of the [strptime()]
#' formats and various extensions are supported for English locales. See
#' [parse_date_time()] for more details.
#'
#' @section Manipulating dates:
#'
#' Lubridate distinguishes between moments in time (known as
#' [instants()]) and spans of time (known as time spans, see
#' [Timespan-class]). Time spans are further separated into
#' [Duration-class], [Period-class] and
#' [Interval-class] objects.
#'
#' @section Instants:
#'
#' Instants are specific moments of time. Date, POSIXct, and
#' POSIXlt are the three object classes Base R recognizes as
#' instants. [is.Date()] tests whether an object
#' inherits from the Date class. [is.POSIXt()] tests
#' whether an object inherits from the POSIXlt or POSIXct classes.
#' [is.instant()] tests whether an object inherits from
#' any of the three classes.
#'
#' [now()] returns the current system time as a POSIXct
#' object. [today()] returns the current system date.
#' For convenience, 1970-01-01 00:00:00 is saved to
#' [origin]. This is the instant from which POSIXct
#' times are calculated. Try `unclass(now())` to see the numeric structure that
#' underlies POSIXct objects. Each POSIXct object is saved as the number of seconds
#' it occurred after 1970-01-01 00:00:00.
#'
#' Conceptually, instants are a combination of measurements on different units
#' (i.e, years, months, days, etc.). The individual values for
#' these units can be extracted from an instant and set with the
#' accessor functions [second()], [minute()],
#' [hour()], [day()], [yday()],
#' [mday()], [wday()], [week()],
#' [month()], [year()], [tz()],
#' and [dst()].
#' Note: the accessor functions are named after the singular form
#' of an element. They shouldn't be confused with the period
#' helper functions that have the plural form of the units as a
#' name (e.g, [seconds()]).
#'
#' @section Rounding dates:
#'
#' Instants can be rounded to a convenient unit using the
#' functions [ceiling_date()], [floor_date()]
#' and [round_date()].
#'
#' @section Time zones:
#'
#' Lubridate provides two helper functions for working with time
#' zones. [with_tz()] changes the time zone in which an
#' instant is displayed. The clock time displayed for the instant
#' changes, but the moment of time described remains the same.
#' [force_tz()] changes only the time zone element of an
#' instant. The clock time displayed remains the same, but the
#' resulting instant describes a new moment of time.
#'
#' @section Timespans:
#'
#' A timespan is a length of time that may or may not be connected to
#' a particular instant. For example, three months is a timespan. So is an hour and
#' a half. Base R uses difftime class objects to record timespans.
#' However, people are not always consistent in how they expect time to behave.
#' Sometimes the passage of time is a monotone progression of instants that should
#' be as mathematically reliable as the number line. On other occasions time must
#' follow complex conventions and rules so that the clock times we see reflect what
#' we expect to observe in terms of daylight, season, and congruence with the
#' atomic clock. To better navigate the nuances of time, \pkg{lubridate} creates three
#' additional timespan classes, each with its own specific and consistent behavior:
#' [Interval-class], [Period-class] and
#' [Duration-class].
#'
#' [is.difftime()] tests whether an object
#' inherits from the difftime class. [is.timespan()]
#' tests whether an object inherits from any of the four timespan
#' classes.
#'
#' @section Durations:
#'
#' Durations measure the exact amount of time that occurs between two
#' instants. This can create unexpected results in relation to clock times if a
#' leap second, leap year, or change in daylight savings time (DST) occurs in
#' the interval.
#'
#' Functions for working with durations include [is.duration()],
#' [as.duration()] and [duration()]. [dseconds()],
#' [dminutes()], [dhours()],  [ddays()],
#' [dweeks()] and [dyears()] convenient lengths.
#'
#' @section Periods:
#'
#' Periods measure the change in clock time that occurs between two
#' instants. Periods provide robust predictions of clock time in the presence of
#' leap seconds, leap years, and changes in DST.
#'
#' Functions for working with periods include
#' [is.period()], [as.period()] and
#' [period()]. [seconds()],
#' [minutes()], [hours()], [days()],
#' [weeks()], [months()] and
#' [years()] quickly create periods of convenient
#' lengths.
#'
#' @section Intervals:
#'
#' Intervals are timespans that begin at a specific instant and
#' end at a specific instant. Intervals retain complete information about a
#' timespan. They provide the only reliable way to convert between
#' periods and durations.
#'
#' Functions for working with intervals include
#' [is.interval()], [as.interval()],
#' [interval()], [int_shift()],
#' [int_flip()], [int_aligns()],
#' [int_overlaps()], and
#' \code{\link{\%within\%}}. Intervals can also be manipulated with
#' intersect, union, and setdiff().
#'
#' @section Miscellaneous:
#'
#' [decimal_date()] converts an instant to a decimal of
#' its year.
#' [leap_year()] tests whether an instant occurs during
#' a leap year.
#' [pretty_dates()] provides a method of making pretty
#' breaks for date-times.
#' [lakers] is a data set that contains information
#' about the Los Angeles Lakers 2008-2009 basketball season.
#'
#' @references Garrett Grolemund, Hadley Wickham (2011). Dates and Times Made
#'   Easy with lubridate. Journal of Statistical Software, 40(3), 1-25.
#'   \url{http://www.jstatsoft.org/v40/i03/}.
#' @importFrom methods setClass setGeneric new show allNames callGeneric is slot slot<- slotNames validObject Compare Arith initialize coerce<-
#' @importFrom utils packageVersion read.delim
#' @importFrom stats na.omit setNames update
#' @importFrom Rcpp sourceCpp
#' @useDynLib lubridate, .registration=TRUE
#' @keywords internal
"_PACKAGE"


## NOTE ON EXPORTS: `useDynLib` from above exports all registered functions (see
## ../src/RcppExports.cpp). _lubridate_C_xyz in there are Rcpp functions. All
## other `C_xyz` functions, are from plain .C files and are added manually with
## the help of tools::package_native_routine_registration_skeleton(".", character_only = FALSE).
