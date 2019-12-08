#' Timespan class
#'
#' Timespan is an S4 class with no slots. It is extended by the
#' [Interval-class], [Period-class], and [Duration-class]
#' classes.
#'
#' @export
#' @keywords internal
#' @aliases *,Timespan,Timespan-method
#' @aliases %/%,Timespan,Timespan-method
#' @aliases %/%,difftime,Timespan-method
#' @aliases %/%,Interval,Interval-method
#' @aliases %/%,Period,Period-method
#' @aliases %/%,Interval,Duration-method
#' @aliases %/%,Duration,Interval-method
#' @aliases %/%,Interval,Period-method
#' @aliases %/%,Period,Interval-method
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
#' @description
#' A time span can be measured in three ways: as a duration, an interval, or a
#' period.
#'
#' * [duration]s record the exact number of seconds in a time span.
#'   They measure the exact passage of time but do not always align with
#'   human measurements like hours, months and years.
#'
#' * [period]s record the change in the clock time between two date-times.
#'   They are measured in human units: years, months, days, hours, minutes,
#'   and seconds.
#'
#' * [intervals] are time spans bound by two real date-times. Intervals can be
#'   accurately converted to periods and durations.
#'
#' @aliases timespans
#' @keywords classes chron
#' @examples
#' duration(3690, "seconds")
#' period(3690, "seconds")
#' period(second = 30, minute = 1, hour = 1)
#' interval(ymd_hms("2009-08-09 13:01:30"), ymd_hms("2009-08-09 12:00:00"))
#'
#' date <- ymd_hms("2009-03-08 01:59:59") # DST boundary
#' date + days(1)
#' date + ddays(1)
#'
#' date2 <- ymd_hms("2000-02-29 12:00:00")
#' date2 + years(1)
#' # self corrects to next real day
#'
#' date3 <- ymd_hms("2009-01-31 01:00:00")
#' date3 + c(0:11) * months(1)
#'
#' span <- date2 %--% date  #creates interval
#'
#' date <- ymd_hms("2009-01-01 00:00:00")
#' date + years(1)
#' date - days(3) + hours(6)
#' date + 3 * seconds(10)
#'
#' months(6) + days(1)
#' @name timespan
NULL

#' Compute the exact length of a time span
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
