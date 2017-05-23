#' Timespan class
#'
#' Timespan is an S4 class with no slots. It is extended by the
#' [Interval-class], [Period-class], and [Duration-class]
#' classes.
#'
#' @export
#' @keywords internal
#' @aliases *,Timespan,Timespan-method %/%,Timespan,Timespan-method %/%,difftime,Timespan-method
setClass("Timespan")

#' Is x a length of time?
#'
#' @export is.timespan
#' @aliases is.timespan
#' @param x an R object
#' @return TRUE if x is a period, interval, duration, or difftime object, FALSE otherwise.
#' @seealso [is.instant()], [is.duration()], [is.difftime()], [is.period()], [is.interval()]
#' @keywords logic chron
#' @examples
#' is.timespan(as.Date("2009-08-03")) # FALSE
#' is.timespan(duration(second = 1)) # TRUE
is.timespan <- function(x) is(x, "Timespan")


#' Description of time span classes in lubridate
#'
#' A time span can be measured in three ways: as a duration, an interval, or a
#' period.
#'
#' Durations record the exact number of seconds in a time span. They measure the
#' exact passage of time but do not always align with measurements
#' made in larger units of time such as hours, months and years.
#' This is because the exact length of larger time units can be affected
#' by conventions such as leap years
#' and Daylight Savings Time. Base R measures durations with the
#' difftime class. \pkg{lubridate} provides an additional class, the duration class,
#' to facilitate working with durations.
#'
#' durations display as the number of seconds that occur during a time span. If the number is large, a duration object will also display the length in a more convenient unit, but these measurements are only estimates
#' given for convenience. The underlying object is always recorded as a fixed
#' number of seconds. For display and creation purposes, units are converted to
#' seconds using their most common lengths in seconds. Minutes = 60 seconds,
#' hours = 3600 seconds, days = 86400 seconds. Units larger than
#' days are not used due to their variability.
#'
#' duration objects can be easily created with the helper functions
#' [dweeks()], [ddays()], [dhours()], [dminutes()] and
#' [dseconds()]. These objects can be added to and subtracted from date-
#' times to create a user interface similar to object oriented programming.
#' Duration objects can be added to Date, POSIXct, and POSIXlt objects to return a
#' new date-time.
#'
#' Periods record the change in the clock time between two date-times. They are
#' measured in common time related units: years, months, days, hours, minutes,
#' and seconds. Each unit except for seconds must be expressed in integer
#' values. With the exception of seconds, none of these units have a fixed
#' length. Leap years, leap seconds, and Daylight Savings Time can expand or
#' contract a unit of time depending on when it occurs.  For this reason, periods
#' do not have a fixed length until they are paired with a start date. Periods
#' can be used to track changes in clock time. Because periods
#' have a variable length, they must be paired with a start date
#' as an interval ([as.interval()]) before they can be
#' accurately converted to and from durations.
#'
#' Period objects can be easily created with the helper functions
#' [years()], [months()], [weeks()],
#' [days()], [minutes()], [seconds()]. These objects
#' can be added to and subtracted to date-times to create a user interface
#' similar to object oriented programming. Period objects can be added to Date,
#' POSIXct, and POSIXlt objects to return a new date-time.
#'
#' Intervals are time spans bound by two real date-times.  Intervals can be
#' accurately converted to periods and durations. Since an interval is anchored
#' to a fixed moment of time, the exact length of all units of
#' time during the interval can be calculated. To
#' accurately convert between periods and durations, a period or duration should
#' first be converted to an interval with [as.interval()]. An interval displays as the start
#' and end points of the time span it represents.
#'
#' @aliases timespan timespans
#' @name timespan
#' @seealso [duration()] for creating duration objects and
#'   [period()] for creating period objects, and
#'   [interval()] for creating interval objects.
#' @keywords classes chron
#' @examples
#' duration(3690, "seconds")
#' period(3690, "seconds")
#' period(second = 30, minute = 1, hour = 1)
#' interval(ymd_hms("2009-08-09 13:01:30"), ymd_hms("2009-08-09 12:00:00"))
#'
#' date <- as.POSIXct("2009-03-08 01:59:59") # DST boundary
#' date + days(1)
#' date + ddays(1)
#'
#' date2 <- as.POSIXct("2000-02-29 12:00:00")
#' date2 + years(1)
#' # self corrects to next real day
#'
#' date3 <- as.POSIXct("2009-01-31 01:00:00")
#' date3 + c(0:11) * months(1)
#'
#' span <- date2 %--% date  #creates interval
#'
#' date <- as.POSIXct("2009-01-01 00:00:00")
#' date + years(1)
#' date - days(3) + hours(6)
#' date + 3 * seconds(10)
#'
#' months(6) + days(1)
NULL

#' Compute the exact length of a time span.
#'
#'
#' @param x a duration, period, difftime or interval
#' @param unit a character string that specifies with time units to use
#' @return the length of the interval in the specified unit. A negative number
#' connotes a negative interval or duration
#'
#' @details When `x` is an [Interval-class] object and
#' `unit` are years or months, `time_length()` takes into account
#' the fact that all months and years don't have the same number of days.
#'
#' When `x` is a [Duration-class], [Period-class]
#' or [difftime()] object, length in months or years is based on their
#' most common lengths in seconds (see [timespan()]).
#' @seealso [timespan()]
#' @keywords chron math period methods
#' @examples
#' int <- interval(ymd("1980-01-01"), ymd("2014-09-18"))
#' time_length(int, "week")
#'
#' # Exact age
#' time_length(int, "year")
#'
#' # Age at last anniversary
#' trunc(time_length(int, "year"))
#'
#' # Example of difference between intervals and durations
#' int <- interval(ymd("1900-01-01"), ymd("1999-12-31"))
#' time_length(int, "year")
#' time_length(as.duration(int), "year")
#' @export
setGeneric("time_length",
           useAsDefault =
             function(x, unit = "second") {
               as.duration(x) / duration(num = 1, units = unit)
             })
