#' Description of the class "duration" representing time intervals.
#'
#' Durations record intervals of time.  Like real time intervals, they can be measured in either specific or relative time units. Seconds, minutes, hours, days, and weeks are all specific time units. They each last a set number of seconds no matter what time point they are measured from. Months and years are relative time units.  A month may last 28, 29, 30, or 31 days depending on the date it is measured from. A year may last 365 or 366 days. 
#'
#' Leap seconds provide an exception to these general rules.  They are announced randomly and expand every time interval they occur in. Lubridate does not handle leap seconds. 
#'
#' Duration objects can also combine both relative and specific time units. When added or subtracted to a date-time, a duration chooses the correct time length for its relative time units.  
#'
#' The internal structure of durations do not handle specific time intervals greater than 49999999999 seconds or less than -49999999999 seconds.  This is the equivalent of 578703 days, 16 hours, 53 minutes and 19 seconds. Time intervals longer than this should be approximated with relative time units. 126230400 seconds is frequently equal to 4 years, and 12622780800 seconds is more frequently equal to 400 years.
#'
#' Divisions less than a month in length should be precisely specified by using a specific time unit. Durations do not support partial months or fractions of a year that would result in partial months.
#'
#' The helper functions \code{link{years}, link{months}, link{weeks}, link{days}, link{hours}, link{minutes}, link{seconds}} create durations of standard lengths. These functions greatly simplify working with date-times by letting R behave like an object oriented programming language. 
#'
#' @seealso \code{link{new_duration}} for creating duration objects
#' @seealso \code{link{years}, link{months}, link{weeks}, link{days}, link{hours}, link{minutes}, link{seconds}} for easy methods of manipulating date-time objects with durations.
#' @seealso \code{link{as.duration}} for converting objects into durations
#' @seealso \code{link{is.duration}} for testing whether an object is of the "duration" class
#' @examples
#' new_duration(second = 90)
#' # 1 minute and 30 seconds
#' new_duration(minute = 1.5)
#' # 1 minute and 30 seconds
#' new_duration(second = 3, minute = 1.5, hour = -2, day = 6, week = 1, month = 3, year = 2)
#' # 2 years, 3 months, 1 week, 5 days, 22 hours, 1 minute and 33 seconds
#'
#' date <- as.POSIXct("2009-01-01 00:00:00")
#' date
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
roxygen()

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
#' @seealso \code{link{duration}, link{as.duration}}
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
new_duration <- function(second = 0, minute = 0, hour = 0, day = 0, week = 0, month = 0, year = 0){
		
	dur1 <- 50000000000 + second + minute * 60 + hour * 3600 + day * 86400 + week * 604800 
	
	if (any(dur1 >= 10^11) || any(dur1 < 0))
		stop("seconds overflow: see 'duration' documentation")
	
	dur2 <- 10 ^ 11 * month + 12* 10 ^ 11 * year
	
	if (any(dur2 %% 10^11 != 0))
		stop("durations do not support partial months")
	
	structure(dur1 + dur2, class = "duration")
}

#' Change an object to a duration class.
#'
#' as.duration changes numeric and difftime objects to duration objects. Numeric objects are changes to duration objects with the seconds unit equal to the numeric value. Because both numeric and difftime objects are exact measurements, as.duration will not use months or years units to create the new duration.  Months and years are not exact, but relative measurements.
#'
#' @param x a difftime or numeric object   
#' @seealso \code{link{duration}, link{new_duration}}
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
as.duration <- function (x, ...) UseMethod("as.duration")

as.duration.difftime <- function(x, ...){
  new_duration(second = as.numeric(x, units = "secs"))
}

as.duration.default <- function(x, ...){
  message("Numeric coerced to seconds")
  new_duration(second = x)
}

as.duration.duration <- function(x, ...) {
  x
}

#' Internal function.
#'
#' @keyword internal
as.POSIXt <- function(x) as.POSIXlt(x)

#' Internal function. Concatenates durations.
#'
#' @keywords internal
c.duration <- function(...) {
  structure(do.call(rbind, list(...)), class = "duration")
}

#' Quickly create duration objects.
#'
#' Quick create duration objects for easy date-time manipulation. The units of the duration created depend on the name of the function called.
#'
#' @param x numeric value of the number of units to be contained in the duration. For months(), x must be an integer value. For years(), x * 12 must be an integer value.
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
seconds <- function(x = 1) new_duration(x)
minutes <- function(x = 1) new_duration(minute = x)
hours <-   function(x = 1) new_duration(hour = x)
days <-    function(x = 1) new_duration(day = x)  
weeks <-   function(x = 1) new_duration(week = x)
months <-  function(x = 1) new_duration(month = x)
years <-   function(x = 1) new_duration(year = x)
y <- years(1)
m <- months(1)
w <- weeks(1)
d <- days(1)

#' Is x a date-time object?
#'
#' is.timepoint returns TRUE if x is a POSIXct, POSIXlt, or Date object. It returns FALSE otherwise. 
#'
#' @param x an R object   
#' @seealso \code{link{is.timeperiod}, link{is.duration}, link{is.difftime}, link{is.POSIXt}, link{is.Date}}
#' @examples
#' is.timepoint(as.Date("2009-08-03")) # TRUE
#' is.timepoint(5) # FALSE
is.timepoint <- function(x) inherits(x, c("POSIXt", "POSIXct", "POSIXlt", "Date"))

#' Is x a measure of a time length?
#'
#' is.timeperiod returns TRUE if x is a duration or difftime object. It returns FALSE otherwise. 
#'
#' @param x an R object   
#' @seealso \code{link{is.timepoint}, link{is.duration}, link{is.difftime}, link{is.POSIXt}, link{is.Date}}
#' @examples
#' is.timeperiod(as.Date("2009-08-03")) # FALSE
#' is.timeperiod(new_duration(second = 1)) # TRUE
is.timeperiod <- function(x) inherits(x, c("duration", "difftime"))

#' Is x a duration object?
#'
#' @param x an R object   
#' @seealso \code{link{is.timepoint}, link{is.timeperiod}, link{is.difftime}, link{is.POSIXt}, link{is.Date}}
#' @examples
#' is.duration(as.Date("2009-08-03")) # FALSE
#' is.duration(new_duration(second = 1)) # TRUE
is.duration <- function(x) inherits(x, "duration")

#' Is x a POSIXct or POSIXlt object?
#'
#' @param x an R object   
#' @seealso \code{link{is.timepoint}, link{is.timeperiod}, link{is.difftime}, link{is.duration}, link{is.Date}}
#' @examples
#' is.POSIXt(as.Date("2009-08-03")) # FALSE
#' is.POSIXt(as.POSIXct("2009-08-03")) # TRUE
is.POSIXt <- function(x) inherits(x, c("POSIXt", "POSIXct", "POSIXlt"))

#' Is x a difftime object?
#'
#' @param x an R object   
#' @seealso \code{link{is.timepoint}, link{is.timeperiod}, link{is.duration}, link{is.POSIXt}, link{is.Date}}
#' @examples
#' is.difftime(as.Date("2009-08-03")) # FALSE
#' is.difftime(difftime(Sys.time() + 5, Sys.time())) # TRUE
is.difftime <- function(x) inherits(x, "difftime")

#' Is x a Date object?
#'
#' @param x an R object   
#' @seealso \code{link{is.timepoint}, link{is.timeperiod}, link{is.duration}, link{is.POSIXt}, link{is.difftime}}
#' @examples
#' is.Date(as.Date("2009-08-03")) # TRUE
#' is.Date(difftime(Sys.time() + 5, Sys.time())) # FALSE
is.Date <- function(x) inherits(x, "Date")

#' Internal function. 
#'
#' @keywords internal
as.data.frame.duration <- function (x, row.names = NULL, optional = FALSE, ..., nm = paste(deparse(substitute(x), 
    width.cutoff = 500L), collapse = " ")) 
{
    force(nm)
    nrows <- length(x)
    if (is.null(row.names)) {
        if (nrows == 0L) 
            row.names <- character(0L)
        else if (length(row.names <- names(x)) == nrows && !any(duplicated(row.names))) {
        }
        else row.names <- .set_row_names(nrows)
    }
    names(x) <- NULL
    value <- list(x)
    if (!optional) 
        names(value) <- nm
    attr(value, "row.names") <- row.names
    class(value) <- "data.frame"
    value
}

	
