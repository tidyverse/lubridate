#' Description of time span classes in lubridate.
#'
#' A time span can be measured in three ways: as a duration, an interval, or a period. 
#'
#' Durations record the exact number of seconds in a time span. They measure the exact passage of time and are not affected by conventions such as leap years and Daylight Savings Time. lubridate uses the difftime class from base::R for durations. Additional difftime methods have been created to facilitate this. #'
#' difftime displays durations in various units, but these units are estimates given for convenience. The underlying object is always recorded as a fixed number of seconds. For display and creation purposes, units are converted to seconds using their most common lengths in seconds. Minutes = 60 seconds, hours = 3600 seconds, days = 86400 seconds, weeks = 604800. Units larger than weeks are not used due to their variability.
#' 
#' duration objects can be easily created with the helper functions \code{link{eweeks}}, \code{link{edays}}, \code{link{eminutes}}, \code{link{eseconds}}. These objects can be added to and subtracted to date-times to create a user interface similar to object oriented programming.
#'
#' Periods record the change in the clock time between two date-times. They are measured in common time related units: years, months, days, hours, minutes, and seconds. Each unit except for seconds must be expressed in integer values. With the exception of seconds, none of these units have a fixed length. Leap years, leap seconds, and Daylight Savings Time can expand or contract a time unit depending on when it occurs.  For this reason, periods do not have a fixed length until they are paired with a start date. Periods can be used to track changes in clock time. Because they do not have a fixed length, they can not be accurately converted to and from durations.
#'
#' Period objects can be easily created with the helper functions \code{link{years}}, \code{link{months}}, \code{link{weeks}}, \code{link{days}}, \code{link{minutes}}, \code{link{seconds}}. These objects can be added to and subtracted to date-times to create a user interface similar to object oriented programming.
#'
#' Intervals are time spans bound by two real date-times.  Intervals can be accurately converted to periods and durations. Since an interval is anchored to a fixed history of time, both the number of seconds that passed as well as the length of common time units during that history can be calculated. To accurately convert between periods and durations, a period or duration should first be converted to an interval. Subtracting two date times automatically creates an interval object. Intervals as the difftime between the two dates paired with the earlier, or beginning date. 
#'
#' @alias timespan timespans duration durations dur periods period interval intervals
#' @seealso \code{link{new_duration}} for creating duration objects and \code{link{as.duration}} for converting objects into durations
#' @seealso \code{link{new_period}} for creating period objects and \code{link{as_period}} for converting objects to periods
#' @seealso \code{link{new_interval}} for creating interval objects and \code{link{as_interval}} for converting objects to intervals
#' @keywords classes chron
#' @examples
#' new_duration(second = 3690)
#' # Time difference of 1.025 hours
#' new_period(second = 3690)
#' # 3690 seconds
#' new_period(second = 30, minute = 1, hour = 1)
#' 1 hour, 1 minute and 30 seconds
#' new_interval(as.POSIXct("2009-08-09 12:00:00"), as.POSIXct("2009-08-09 13:01:30"))
#' [1] 1.025 hours beginning at 2009-08-09 12:00:00
#'
#' date <- as.POSIXct("2009-03-08 01:59:59") # DST boundary
#' # "2009-03-08 01:59:59 CST"
#' date + days(1)
#' # "2009-03-09 01:59:59 CDT" periods preserve clock time
#' date + edays(1)
#' # "2009-03-09 02:59:59 CDT" durations preserve exact passage of time
#'
#' date2 <- as.POSIXct("2000-02-29 12:00:00")
#' date2 + years(1)
#' # "2001-02-28 12:00:00 CST" 
#' # self corrects to most recent real day
#'
#' date3 <- as.POSIXct("2009-01-31 01:00:00")
#' date3 + c(0:11) * months(1)
#' # [1] "2009-01-31 01:00:00 CST" "2009-02-28 01:00:00 CST"
#' # [3] "2009-03-31 01:00:00 CDT" "2009-04-30 01:00:00 CDT"
#' # [5] "2009-05-31 01:00:00 CDT" "2009-06-30 01:00:00 CDT"
#' # [7] "2009-07-31 01:00:00 CDT" "2009-08-31 01:00:00 CDT"
#' # [9] "2009-09-30 01:00:00 CDT" "2009-10-31 01:00:00 CDT"
#' #[11] "2009-11-30 01:00:00 CST" "2009-12-31 01:00:00 CST"
#'
#' span <- date - date2  #creates interval 
#' # 3294.583 days beginning at 2000-02-29 12:00:00 
#' span - days(294)
#' # 3000.542 days beginning at 2000-02-29 12:00:00
#' span - edays(294.542)
#' # 3000 days beginning at 2000-02-29 12:00:00
#' span * 3
#' # 9883.75 days beginning at 2000-02-29 12:00:00
#' span / 2
#' # 1647.292 days beginning at 2000-02-29 12:00:00
#'
#' date <- as.POSIXct("2009-01-01 00:00:00") 
#' # "2009-01-01 GMT"
#' date + years(1)
#' # "2010-01-01 GMT"
#' date - days(3) + hours(6)
#' # "2008-12-29 06:00:00 GMT"
#' date + 3 * seconds(10)
#' # "2009-01-01 00:00:30 GMT"
#'
#' months(6) + days(1)
#' # 6 months and 1 day
NULL

#' Create a duration object.
#'
#' new_duration creates a duration object with the specified values. Entries for different units are cumulative. The duration class supports decimal entries for all units except month and year.  Months must be in integer values. Years are collections of twelve months and only support numbers that are integers when multiplied by 12. See \code{link{duration}}.
#'
#' @param second number value of seconds to include in the duration  
#' @param minute number value of minutess to include in the duration 
#' @param hour number value of hours to include in the duration 
#' @param day number value of days to include in the duration 
#' @param week number value of weeks to include in the duration 
#' @param month integer value of seconds to include in the duration 
#' @param year number value of years to include in the duration 
#' @return a duration object
#' @seealso \code{link{duration}, link{as.duration}}
#' @keywords chron classes
#' @examples
#' new_duration(second = 90)
#' # 1 minute and 30 seconds
#' new_duration(minute = 1.5)
#' # 1 minute and 30 seconds
#' new_duration(second = 3, minute = 1.5, hour = 2, day = 6, week = 1, month = 3, year = 2)
#' # 2 years, 3 months, 1 week, 6 days, 2 hours, 1 minute and 33 seconds
#' new_duration(hour = 1, minute = -60)
#' # 0 seconds
#' new_duration(year = -1)
#' # -1 years
#' new_duration(year = 0.5)
#' # 6 months
new_duration <- function(...)
	as.duration(new_period(...))

#' Change an object to a duration class.
#'
#' as.duration changes numeric and difftime objects to duration objects. Numeric objects are changes to duration objects with the seconds unit equal to the numeric value. Because both numeric and difftime objects are exact measurements, as.duration will not use months or years units to create the new duration.  Months and years are not exact, but relative measurements.
#' @method as.duration difftime
#' @method as.duration default
#' @method as.duration duration
#' @aliases as.duration as.duration.default as.duration.difftime as.duration.duration
#' @param x a difftime or numeric object   
#' @return a duration object
#' @seealso \code{link{duration}, link{new_duration}}
#' @keywords classes manip methods chron
#' @examples
#' y <- Sys.time()
#' (x <- difftime(y + 3655, y))
#' # Time difference of 1.015278 hours
#' as.duration(x)
#' # 1 hour and 55 seconds
#' as.duration(10)
#' # 10 seconds
#' as.duration(3670)
#' # 1 hour, 1 minute and 10 seconds
#' as.duration(60*60*24*366)
#' # 52 weeks and 2 days
as.duration <- function(x)
	UseMethod("as.duration")
	
	
as.duration.period <- function(per){
	if (per$month != 0)
		stop("durations cannot estimate month length")
	all <- per$second +
		per$minute * 60 +
		per$hour * 3600 + 
		per$day * 3600 * 24 + 
		per$year * 3600 * 24 * 365
	
	make_difftime(all)
}
	
as.duration.interval <- function(x)
	difftime(x$end, x$start)

as.duration.default <- function(x)
	make_difftime(x)

#' Internal function.
#'
#' @keyword internal manip classes
as.POSIXt <- function(x) as.POSIXlt(x)

#' Quickly create duration objects.
#'
#' Quick create duration objects for easy date-time manipulation. The units of the duration created depend on the name of the function called.
#'
#' @aliases seconds minutes hours days weeks months years y m d w
#' @param x numeric value of the number of units to be contained in the duration. For months(), x must be an integer value. For years(), x * 12 must be an integer value.
#' @return a duration object
#' @seealso \code{\link{duration}}, \code{\link{new_duration}}
#' @keywords chron 
#' @examples
#' seconds(1) 
#' # 1 second
#' minutes(3.5) 
#' # 3 minutes and 30 seconds
#' x <- as.Date("2009-08-03") 
#' # "2009-08-03"
#' x + years(1) + months(1) + days(1)
#' # "2010-09-04"
#' x + days(100) - years(1) 
#' # "2008-11-11" 
#' class(x + days(100) - years(1)) 
#' # retains Date class
#' x + hours(12) 
#' # "2009-08-03 12:00:00 GMT"
#' class(x + hours(12)) 
#' # converts to POSIXt class to accomodate time units
#' months(1) + days(15) 
#' # 1 month, 2 weeks and 1 day
#' weeks(1) - days(7) 
#' # 0 seconds
#' 3 * hours(1) 
#' # 3 hours
#' hours(1) / 60  
#' # 1 minute
#' 
#' # Using default variables
#' x + 3*y + d
#' # "2012-08-04"
#' y - m
#' # 11 months
eseconds <- function(x = 1) new_duration(second = x)
eminutes <- function(x = 1) new_duration(minute = x)
ehours <-   function(x = 1) new_duration(hour = x)
edays <-    function(x = 1) new_duration(day = x)  
eweeks <-   function(x = 1) new_duration(week = x)

#' Is x a date-time object?
#'
#' @aliases is.timepoint timepoint
#' @param x an R object   
#' @return TRUE if x is a POSIXct, POSIXlt, or Date object, FALSE otherwise.
#' @seealso \code{link{is.timeperiod}, link{is.duration}, link{is.difftime}, link{is.POSIXt}, link{is.Date}}
#' @keywords logic chron
#' @examples
#' is.timepoint(as.Date("2009-08-03")) # TRUE
#' is.timepoint(5) # FALSE
is.timepoint <- function(x) inherits(x, c("POSIXt", "POSIXct", "POSIXlt", "Date"))

#' Is x a measure of a time length?
#'
#' @aliases is.timeperiod timeperiod
#' @param x an R object   
#' @return TRUE if x is a duration or difftime object, FALSE otherwise.
#' @seealso \code{link{is.timepoint}, link{is.duration}, link{is.difftime}, link{is.POSIXt}, link{is.Date}}
#' @keywords logic chron
#' @examples
#' is.timeperiod(as.Date("2009-08-03")) # FALSE
#' is.timeperiod(new_duration(second = 1)) # TRUE
is.timespan <- function(x) inherits(x,c("period", "difftime", "interval"))



#' Is x a POSIXct or POSIXlt object?
#'
#' @aliases is.POSIXt is.POSIXlt is.POSIXct
#' @param x an R object   
#' @return TRUE if x is a POSIXct or POSIXlt object, FALSE otherwise.
#' @seealso \code{link{is.timepoint}, link{is.timeperiod}, link{is.difftime}, link{is.duration}, link{is.Date}}
#' @keywords logic chron
#' @examples
#' is.POSIXt(as.Date("2009-08-03")) # FALSE
#' is.POSIXt(as.POSIXct("2009-08-03")) # TRUE
is.POSIXt <- function(x) inherits(x, c("POSIXt", "POSIXct", "POSIXlt"))

#' Is x a duration (difftime) object?
#'
#' @param x an R object   
#' @return TRUE if x is a difftime object, FALSE otherwise.
#' @seealso \code{link{is.timepoint}, link{is.timeperiod}, link{is.duration}, link{is.POSIXt}, link{is.Date}}
#' @examples
#' @keywords logic chron
#' is.difftime(as.Date("2009-08-03")) # FALSE
#' is.difftime(difftime(Sys.time() + 5, Sys.time())) # TRUE
is.difftime <- is.duration <- function(x) inherits(x, "difftime")

#' Is x a Date object?
#'
#' @param x an R object   
#' @return TRUE if x is a Date object, FALSE otherwise.
#' @seealso \code{link{is.timepoint}, link{is.timeperiod}, link{is.duration}, link{is.POSIXt}, link{is.difftime}}
#' @examples
#' @keywords logic chron
#' is.Date(as.Date("2009-08-03")) # TRUE
#' is.Date(difftime(Sys.time() + 5, Sys.time())) # FALSE
is.Date <- function(x) inherits(x, "Date")

is.period <- function(x) inherits(x,"period")
is.instant <- function(x) inherits(x, c("POSIXt", "POSIXct", "POSIXlt", "Date"))
is.interval <- function(x) inherits(x, c("interval"))


standardise_difftime_names <- function(x) {
  dates <- c("secs", "mins", "hours", "days", "weeks")
  y <- gsub("(.)s$", "\\1", x)
  y <- substr(y, 1, 3)
  res <- dates[pmatch(y, dates)]
  if (any(is.na(res))) {
    stop("Invalid difftime name: ", paste(x[is.na(res)], collapse = ", "), 
      call. = FALSE)
  }
  res
}


