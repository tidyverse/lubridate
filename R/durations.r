#' Description of time span classes in lubridate.
#'
#' A time span can be measured in three ways: as a duration, an interval, or a 
#' period. 
#'
#' Durations record the exact number of seconds in a time span. They measure the 
#' exact passage of time and are not affected by conventions such as leap years 
#' and Daylight Savings Time. Base R measures durations with the 
#' difftime class. lubridate provides additional difftime methods 
#' to facilitate working with this class. 
#'
#' difftime displays durations in various units, but these units are estimates 
#' given for convenience. The underlying object is always recorded as a fixed 
#' number of seconds. For display and creation purposes, units are converted to 
#' seconds using their most common lengths in seconds. Minutes = 60 seconds, 
#' hours = 3600 seconds, days = 86400 seconds, weeks = 604800. Units larger than 
#' weeks are not used due to their variability.
#' 
#' difftime (i.e duration) objects can be easily created with the helper functions 
#' \code{\link{dweeks}}, \code{\link{ddays}}, \code{\link{dhours}}, \code{\link{dminutes}} and 
#' \code{\link{dseconds}}. These objects can be added to and subtracted from date-
#' times to create a user interface similar to object oriented programming. 
#' Duration objects can be added to Date, POSIXt, and Interval objects.
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
#' as an interval (\code{\link{as.interval}}) before they can be  
#' accurately converted to and from durations.
#'
#' Period objects can be easily created with the helper functions 
#' \code{\link{years}}, \code{\link{months}}, \code{\link{weeks}}, 
#' \code{\link{days}}, \code{\link{minutes}}, \code{\link{seconds}}. These objects 
#' can be added to and subtracted to date-times to create a user interface 
#' similar to object oriented programming. Period objects can be added to Date, 
#' POSIXt, and Interval objects.
#'
#' Intervals are time spans bound by two real date-times.  Intervals can be 
#' accurately converted to periods and durations. Since an interval is anchored 
#' to a fixed moment of time, the exact length of all units of 
#' time during the interval can be calculated. To 
#' accurately convert between periods and durations, a period or duration should 
#' first be converted to an interval with \code{\link{as.interval}}. Subtracting two date times automatically 
#' creates an interval object. Intervals display as the difftime between the two 
#' dates. 
#'
#' @aliases duration durations dur periods period interval intervals timespans
#' @name duration
#' @seealso \code{\link{new_duration}} for creating duration objects and
#'   \code{\link{as.duration}} for converting objects into durations, 
#'   \code{\link{new_interval}} for creating interval objects and
#'   \code{\link[lubridate]{as.interval}} for converting objects to intervals
#' @keywords classes chron
#' @examples
#' new_duration(second = 3690)
#' # Time difference of 1.025 hours
#' new_period(second = 3690)
#' # 3690 seconds
#' new_period(second = 30, minute = 1, hour = 1)
#' # 1 hour, 1 minute and 30 seconds
#' new_interval(ymd_hms("2009-08-09 13:01:30"), ymd_hms("2009-08-09 12:00:00"))
#' # [1] 1.025 hours beginning at 2009-08-09 12:00:00
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
#' span <- date2 - date  #creates interval 
#' # 3294.583 days beginning at 2000-02-29 12:00:00 
#' span - days(294)
#' # 3000.542 days beginning at 2000-02-29 12:00:00
#' span - ddays(294)
#' # 3000.583 days beginning at 2000-02-29 12:00:00
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
#' new_duration creates a difftime object with the specified values. Entries for 
#' different units are cumulative. difftime displays durations in various units, 
#' but these units are estimates given for convenience. The underlying object is 
#' always recorded as a fixed number of seconds. For display and creation 
#' purposes, units are converted to seconds using their most common lengths in 
#' seconds. Minutes = 60 seconds, hours = 3600 seconds, days = 86400 seconds, 
#' weeks = 604800. Units larger than weeks are not used due to their 
#' variability.
#'
#' difftime objects are durations. Durations record the exact number of seconds 
#' in a time span. They measure the exact passage of time and are not affected 
#' by conventions such as leap years and Daylight Savings Time. 
#'
#' duration objects can be easily created with the helper functions 
#' \code{\link{eweeks}}, \code{\link{edays}}, \code{\link{eminutes}}, 
#' \code{\link{eseconds}}. These objects can be added to and subtracted to date-
#' times to create a user interface similar to object oriented programming. 
#'
#' @param ... a list of time units to be included in the duration and their amounts. Seconds, 
#'   minutes, hours, days, and weeks are supported. See \code{\link{standardise_difftime_names}}.
#' @return a duration object
#' @aliases new_duration new_difftime
#' @seealso \code{\link{duration}}, \code{\link{as.duration}}
#' @keywords chron classes
#' @examples
#' new_duration(second = 90)
#' # Time difference of 1.5 mins
#' new_duration(minute = 1.5)
#' # Time difference of 1.5 mins
#' new_duration(second = 3, minute = 1.5, hour = 2, day = 6, week = 1)
#' # Time difference of 1.869201 weeks
#' new_duration(hour = 1, minute = -60)
#' # Time difference of 0 secs
#' new_duration(day = -1)
#' # Time difference of -1 days
new_duration <- new_difftime <- function(...){
  pieces <- list(...)
  names(pieces) <- standardise_difftime_names(names(pieces))
  
  defaults <- list(secs = 0, mins = 0, hours = 0, days = 0, weeks = 0)
  pieces <- c(pieces, defaults[setdiff(names(defaults), names(pieces))])
  
  x <- pieces$secs +
    pieces$mins * 60 +
    pieces$hours * 3600 +
    pieces$days * 86400 +
    pieces$weeks * 604800
  
  make_difftime(x)
}

#' Change an object to a duration (difftime).
#'
#' as.duration changes interval, period and numeric objects to duration objects, 
#' which are difftime objects. Numeric objects are changed to duration objects 
#' with the seconds unit equal to the numeric value. 
#'
#' Durations are exact time measurements, but periods are relative time 
#' measurements. See \code{\link{periods}}. The length of a period depends on 
#' when it occurs. Hence, a one to one mapping does not exist between durations 
#' and periods. When used with a period object, as.duration provides an inexact 
#' estimate of the length of the period; each time unit is assigned its most 
#' common number of seconds. Periods with a months unit cannot be coerced to 
#' durations because of the variability of month lengths. For an exact 
#' transformation, first transform the period to an interval with 
#' \code{\link{as.interval}}.
#'
#' @aliases as.duration as.duration.default as.duration.period as.duration.interval as.duration.difftime
#' @param x an interval, period, or numeric object   
#' @return a duration object
#' @seealso \code{\link{duration}}, \code{\link{new_duration}}
#' @keywords classes manip methods chron
#' @examples
#' span <- new_interval(as.POSIXct("2009-01-01"), as.POSIXct("2009-08-01")) #interval
#' # 211.9583 days beginning at 2009-01-01
#' as.duration(span)
#' # Time difference of 211.9583 days
#' as.duration(10) # numeric
#' # Time difference of 10 secs
as.duration <- function(x)
  UseMethod("as.duration")
  

as.duration.period <- function(x){
  if (any(x$month != 0))
    stop("durations cannot estimate month length")
  all <- x$second +
    x$minute * 60 +
    x$hour * 3600 + 
    x$day * 3600 * 24 + 
    x$year * 3600 * 24 * 365
  
  make_difftime(all)
}

as.duration.difftime <- function(x)
  make_difftime(as.numeric(x, "secs"))
  
as.duration.interval <- function(x){
  attr(x, "start") <- NULL
  class(x) <- c("difftime")
  x
}

as.duration.default <- function(x)
  make_difftime(x)

#' Internal function.
#'
#' @keywords internal manip classes
as.POSIXt <- function(x) as.POSIXlt(x)

#' Quickly create exact time spans.
#'
#' Quickly create duration objects for easy date-time manipulation. The units of 
#' the duration created depend on the name of the function called. For duration 
#' objects, units are equal to their most common lengths in seconds (i.e. 
#' minutes = 60 seconds, hours = 3600 seconds, days = 86400 seconds, weeks = 
#' 604800, years = 31536000).
#'
#' When paired with date-times, these functions allow date-times to be 
#' manipulated in a method similar to object oriented programming. Duration 
#' objects can be added to Date, POSIXt, and Interval objects.
#'
#' @aliases eseconds eminutes ehours edays eweeks eyears dseconds dminutes dhours ddays dweeks dyears
#' @param x numeric value of the number of units to be contained in the duration. 
#' @return a duration object
#' @seealso \code{\link{duration}}, \code{\link{new_duration}}, \code{\link{days}}
#' @keywords chron manip
#' @examples
#' eseconds(1) 
#' # Time difference of 1 secs
#' eminutes(3.5) 
#' # Time difference of 3.5 mins
#'
#' x <- as.POSIXct("2009-08-03") 
#' # "2009-08-03 CDT"
#' x + edays(1) + ehours(6) + eminutes(30)
#' # "2009-08-04 06:30:00 CDT"
#' x + edays(100) - ehours(8) 
#' # "2009-11-10 15:00:00 CST"
#' 
#' class(as.Date("2009-08-09") + edays(1)) # retains Date class
#' # "Date"
#' as.Date("2009-08-09") + ehours(12) 
#' # "2009-08-09 12:00:00 UTC"
#' class(as.Date("2009-08-09") + ehours(12)) 
#' # "POSIXt"  "POSIXct"
#' # converts to POSIXt class to accomodate time units
#' 
#' eweeks(1) - edays(7) 
#' # Time difference of 0 secs
#' c(1:3) * ehours(1) 
#' # Time differences in hours
#' # [1] 1 2 3
#' #
#' # compare DST handling to durations
#' boundary <- as.POSIXct("2009-03-08 01:59:59")
#' # "2009-03-08 01:59:59 CST"
#' boundary + days(1) # period
#' # "2009-03-09 01:59:59 CDT" (clock time advances by a day)
#' boundary + edays(1) # duration
#' # "2009-03-09 02:59:59 CDT" (clock time corresponding to 86400 seconds later)
dseconds <- eseconds <- function(x = 1) new_duration(second = x)
dminutes <- eminutes <- function(x = 1) new_duration(minute = x)
dhours <- ehours <-   function(x = 1) new_duration(hour = x)
ddays <- edays <-    function(x = 1) new_duration(day = x)  
dweeks <- eweeks <-   function(x = 1) new_duration(week = x)
dyears <- eyears <- function(x = 1) new_duration(second = x * 31536000)


#' Is x a date-time object?
#'
#' An instant is a specific moment in time. Most common date-time 
#' objects (e.g, POSIXct, POSIXlt, and Date objects) are instants.
#'
#' @aliases is.timepoint timepoint is.instant instant instants
#' @param x an R object   
#' @return TRUE if x is a POSIXct, POSIXlt, or Date object, FALSE otherwise.
#' @seealso \code{\link{is.timespan}}, \code{\link{is.POSIXt}}, \code{\link{is.Date}}
#' @keywords logic chron
#' @examples
#' is.instant(as.Date("2009-08-03")) # TRUE
#' is.timepoint(5) # FALSE
is.instant <- is.timepoint <- function(x) inherits(x, c("POSIXt", "POSIXct", "POSIXlt", "Date"))

#' Is x a length of time?
#'
#' @aliases is.timespan timespan
#' @param x an R object   
#' @return TRUE if x is a period, interval, or difftime object, FALSE otherwise.
#' @seealso \code{\link{is.instant}}, \code{\link{is.duration}}, \code{\link{is.difftime}}, \code{\link{is.period}}, \code{\link{is.interval}}
#' @keywords logic chron
#' @examples
#' is.timespan(as.Date("2009-08-03")) # FALSE
#' is.timespan(new_duration(second = 1)) # TRUE
is.timespan <- function(x) inherits(x,c("period", "difftime", "interval"))

#' Is x a POSIXct or POSIXlt object?
#'
#' @aliases is.POSIXt is.POSIXlt is.POSIXct
#' @param x an R object   
#' @return TRUE if x is a POSIXct or POSIXlt object, FALSE otherwise.
#' @seealso \code{\link{is.instant}}, \code{\link{is.timespan}}, \code{\link{is.Date}}
#' @keywords logic chron
#' @examples
#' is.POSIXt(as.Date("2009-08-03")) # FALSE
#' is.POSIXt(as.POSIXct("2009-08-03")) # TRUE
is.POSIXt <- function(x) inherits(x, c("POSIXt", "POSIXct", "POSIXlt"))
is.POSIXlt <- function(x) inherits(x, "POSIXlt")
is.POSIXct <- function(x) inherits(x, "POSIXct")

#' Is x a duration (difftime) object?
#'
#' @aliases is.difftime is.duration
#' @param x an R object   
#' @return TRUE if x is a difftime object, FALSE otherwise.
#' @seealso \code{\link{is.instant}}, \code{\link{is.timespan}}, \code{\link{is.interval}}, 
#'   \code{\link{is.period}}, \code{\link{duration}}
#' @keywords logic chron
#' @examples
#' is.difftime(as.Date("2009-08-03")) # FALSE
#' is.difftime(new_duration(days = 12.4)) # TRUE
is.difftime <- is.duration <- function(x) inherits(x, "difftime")

#' Is x a Date object?
#'
#' @param x an R object   
#' @return TRUE if x is a Date object, FALSE otherwise.
#' @seealso \code{\link{is.instant}}, \code{\link{is.timespan}}, \code{\link{is.POSIXt}}
#' @keywords logic chron
#' @examples
#' is.Date(as.Date("2009-08-03")) # TRUE
#' is.Date(difftime(now() + 5, now())) # FALSE
is.Date <- function(x) inherits(x, "Date")


#' Is x a period object?
#'
#' @param x an R object   
#' @return TRUE if x is a period object, FALSE otherwise.
#' @seealso \code{\link{is.instant}}, \code{\link{is.timespan}}, \code{\link{is.interval}}, 
#'   \code{\link{is.duration}}, \code{\link{period}}
#' @keywords logic chron
#' @examples
#' is.period(as.Date("2009-08-03")) # FALSE
#' is.period(new_period(months= 1, days = 15)) # TRUE
is.period <- function(x) inherits(x,"period")

#' Is x an interval object?
#'
#' @param x an R object   
#' @return TRUE if x is an interval object, FALSE otherwise.
#' @seealso \code{\link{is.instant}}, \code{\link{is.timespan}}, \code{\link{is.period}}, 
#'   \code{\link{is.duration}}, \code{\link{interval}}
#' @keywords logic chron
#' @examples
#' is.interval(new_period(months= 1, days = 15)) # FALSE
#' is.interval(new_interval(ymd(20090801), ymd(20090809))) # TRUE
is.interval <- function(x) inherits(x, c("interval"))

#' Internal function. Matches input with recognized difftime unit names (i.e. 
#' "secs", "mins", "hours", "days", and "weeks").
#'
#' @keywords internal
#' @examples
#' standardise_difftime_names(c("seconds", "minute"))
#' # "secs" "mins"
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


