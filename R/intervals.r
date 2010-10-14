#' Create an interval object.
#'
#' new_interval creates an interval object with the specified start and end 
#' dates. Like difftime, new_interval automatically assigns the date that occurs first as the 
#' end date and the date that occurs second as the start date.
#'
#' Intervals are time spans bound by two real date-times.  Intervals can be 
#' accurately converted to either period or duration objects using 
#' \code{\link{as.period}}, \code{\link{as.duration}}. Since an interval is
#' anchored to a fixed history of time, both the exact number of seconds that passed
#' and the number of variable length time units that occurred can be
#' calculated.  Subtracting two date times automatically creates an interval
#' object. Intervals inherit from the difftime class. They behave 
#' exactly like difftimes, but they have an extra attribute which #' contains the start date-time of the interval. 
#'
#' @param date1 a POSIXt or Date date-time object
#' @param date2 a POSIXt or Date date-time object
#' @return an interval object
#' @seealso \code{\link{interval}}, \code{\link{as.interval}}
#' @keywords chron classes
#' @examples
#' new_interval(ymd(20090201), ymd(20090101))
#' # 31 days beginning at 2009-01-01
#'
#' date1 <- as.POSIXct("2009-03-08 01:59:59")
#' date2 <- as.POSIXct("2000-02-29 12:00:00")
#' new_interval(date2, date1)
#' # -3294.583 days beginning at 2009-03-08 01:59:59
#' new_interval(date1, date2)
#' # 3294.583 days beginning at 2000-02-29 12:00:00
#' 
#' span <- new_interval(ymd(20090201), ymd(20090101))
#' # 31 days beginning at 2009-01-01
#' span - days(30)
#' # 1 days beginning at 2009-01-01
#' span + months(6)
#' # 212 days beginning at 2009-01-01
#'
#' start <- attr(span, "start")
#' # "2009-01-01 UTC"
#' end <- start + span
#' # "2009-02-01 UTC"
#' @export
new_interval <- function(date2, date1){
  int <- data.frame(date2, date1)
  span <- difftime(int$date2, int$date1)
  structure(span, start = int$date1, class = c("interval", "difftime"))	
}


format.interval <- function(x, ...){
  paste(format(unclass(x),...), units(x), "beginning at", attr(x, "start"))
}

print.interval <- function(x, ...) {
  print(format(x), ..., quote = FALSE)
}


#' Change an object to an interval.
#'
#' as.interval changes difftime (i.e. duration), period and numeric objects to 
#' intervals that begin at the specified date-time. Numeric objects are first 
#' coerced to time spans equal to the numeric value in seconds. 
#'
#' as.interval can be used to create accurate transformations between period 
#' objects, which measure time spans in variable length units, and difftime objects, 
#' which measure timespans as an exact number of seconds. A start date-
#' time must be supplied to make the conversion. Lubridate uses 
#' this start date to look up how many seconds each variable 
#' length unit (e.g. month, year) lasted for during the time span 
#' described. See 
#' \code{\link{as.duration}}, \code{\link{as.period}}.
#'
#' @param x a duration (i.e. difftime), period, or numeric object that describes the length of the 
#'   interval
#' @param origin a POSIXt or Date object that describes when the interval begins   
#' @return an interval object
#' @seealso \code{\link{interval}}, \code{\link{new_interval}}
#' @keywords classes manip methods chron
#' @examples
#' diff <- new_difftime(days = 31) #duration
#' as.interval(diff, ymd("2009-01-01"))
#' # 31 days beginning at 2009-01-01
#' as.interval(diff, ymd("2009-02-01"))
#' # 31 days beginning at 2009-02-01
#' 
#' per <- new_period(months = 1) #period
#' as.interval(per, ymd("2009-01-01"))
#' # 31 days beginning at 2009-01-01
#' as.interval(per, ymd("2009-02-01"))
#' # 28 days beginning at 2009-02-01
#'
#' as.interval(3600, ymd("2009-01-01")) #numeric
#' # 1 hours beginning at 2009-01-01
#' @export
as.interval <- function(x, start){
	stopifnot(is.instant(start))
	if (is.instant(x))
		return(new_interval(x, start))
	else
		new_interval(start + x, start)
}

expand_interval <- function(int){
	start <- attr(int, "start")
	end <- start + int
	c(start, end)
}

c.interval <- function(...)
  
