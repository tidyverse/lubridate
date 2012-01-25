#' Create an interval object.
#'
#' new_interval creates an interval object with the specified start and end 
#' dates. new_interval automatically assigns the date that occurs first in time as the 
#' start date and the date that occurs later as the end date. As a result, intervals are always positive.
#'
#' Intervals are time spans bound by two real date-times.  Intervals can be 
#' accurately converted to either period or duration objects using 
#' \code{\link{as.period}}, \code{\link{as.duration}}. Since an interval is
#' anchored to a fixed history of time, both the exact number of seconds that passed
#' and the number of variable length time units that occurred during the interval can be
#' calculated.  Subtracting two date times automatically creates an interval
#' object. 
#'
#' @export new_interval
#' @S3method "%%" interval
#' @S3method "%/%" interval
#' @S3method "/" interval
#' @S3method "*" interval
#' @S3method "+" interval
#' @S3method "-" interval
#' @S3method rep interval
#' @S3method "[" interval
#' @S3method c interval
#' @S3method format interval
#' @S3method print interval
#' @param date1 a POSIXt or Date date-time object
#' @param date2 a POSIXt or Date date-time object
#' @return an interval object
#' @seealso \code{\link{interval}}, \code{\link{as.interval}}
#' @keywords chron classes
#' @examples
#' new_interval(ymd(20090201), ymd(20090101))
#' # 2009-01-01 -- 2009-02-01 
#'
#' date1 <- as.POSIXct("2009-03-08 01:59:59")
#' date2 <- as.POSIXct("2000-02-29 12:00:00")
#' new_interval(date2, date1)
#' # 2000-02-29 12:00:00 -- 2009-03-08 01:59:59
#' new_interval(date1, date2)
#' # 2000-02-29 12:00:00 -- 2009-03-08 01:59:59
#' 
#' span <- new_interval(ymd(20090201), ymd(20090101))
#' # [1] 2009-01-01 -- 2009-02-01 
#' span - days(30)
#' # 2009-01-01 -- 2009-01-02
#' span + months(6)
#' # 2009-01-01 -- 2009-08-01 
#'
#' start <- attr(span, "start")
#' # "2009-01-01 UTC"
#' end <- start + span
#' # "2009-02-01 UTC"
new_interval <- function(date2, date1){
  int <- data.frame(date2 = as.POSIXct(date2), 
                    date1 = as.POSIXct(date1))
  span <- abs(as.numeric(int$date2) - as.numeric(int$date1))
  structure(span, start = pmin(int$date1, int$date2), class = c("interval", "numeric"))
}


#' Is x an interval object?
#'
#' @export is.interval
#' @param x an R object   
#' @return TRUE if x is an interval object, FALSE otherwise.
#' @seealso \code{\link{is.instant}}, \code{\link{is.timespan}}, \code{\link{is.period}}, 
#'   \code{\link{is.duration}}, \code{\link{interval}}
#' @keywords logic chron
#' @examples
#' is.interval(new_period(months= 1, days = 15)) # FALSE
#' is.interval(new_interval(ymd(20090801), ymd(20090809))) # TRUE
is.interval <- function(x) is(x, c("Interval"))



format.interval <- function(x, ...){
  paste(attr(x, "start"), "--", attr(x, "start") + as.numeric(x), "")
}

print.interval <- function(x, ...) {
  print(format(x), ..., quote = FALSE)
}


#' Change an object to an interval.
#'
#' as.interval changes difftime, duration, period and numeric objects to 
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
#' @export as.interval
#' @param x a duration (i.e. difftime), period, or numeric object that describes the length of the 
#'   interval
#' @param start a POSIXt or Date object that describes when the interval begins   
#' @return an interval object
#' @seealso \code{\link{interval}}, \code{\link{new_interval}}
#' @keywords classes manip methods chron
#' @examples
#' diff <- new_difftime(days = 31) #difftime
#' as.interval(diff, ymd("2009-01-01"))
#' # 2009-01-01 -- 2009-02-01
#' as.interval(diff, ymd("2009-02-01"))
#' # 2009-02-01 -- 2009-03-04
#' 
#' dur <- new_duration(days = 31) #duration
#' as.interval(dur, ymd("2009-01-01"))
#' # 2009-01-01 -- 2009-02-01
#' as.interval(dur, ymd("2009-02-01"))
#' # 2009-02-01 -- 2009-03-04
#'
#' per <- new_period(months = 1) #period
#' as.interval(per, ymd("2009-01-01"))
#' # 2009-01-01 -- 2009-02-01 
#' as.interval(per, ymd("2009-02-01"))
#' # 2009-02-01 -- 2009-03-01
#'
#' as.interval(3600, ymd("2009-01-01")) #numeric
#' # 2009-01-01 -- 2009-01-01 01:00:00
as.interval <- function(x, start){
	stopifnot(is.instant(start))
	if (is.instant(x))
		return(new_interval(x, start))
	else
		new_interval(start + x, start)
}


c.interval <- function(..., recursive = F){
	intervals <- list(...)
	starts <- structure(c(unlist(lapply(intervals, attr, "start"))), class = c("POSIXt", "POSIXct"))
	durations <- unlist(lapply(intervals, as.vector))
	structure(durations, start = starts, class = c("interval", "numeric"))
}


"[.interval" <- function(x, i, ...){
	structure(unclass(x)[i], start = attr(x, "start")[i], class = c("interval", "numeric"))
} 

#' Access and change the start date of an interval
#'
#' Changing the start date of an interval does not change the length of 
#' the interval. It shifts when the interval occurs.
#'
#' @aliases int_start int_start<-
#' @export int_start "int_start<-"
#' @param x An interval object
#' @return A POSIXct date object when used as an accessor. Nothing when used as a settor
#' @examples
#' int <- new_interval(ymd("2001-01-01"), ymd("2002-01-01"))
#' # 2001-01-01 -- 2002-01-01
#' int_start(int)
#' # "2001-01-01 UTC"
#' int_start(int) <- ymd("2001-06-01")
#' int
#' # 2001-06-01 -- 2002-06-01
int_start <- function(x)
	attr(x, "start")
	
"int_start<-" <- function(interval, value){
	stopifnot(length(value) == length(interval))
	interval <- structure(as.numeric(interval), start = value, class = c("interval", "numeric"))
}	


	



#' Access and change the end date of an interval
#'
#' Changing the end date of an interval does not change the length of 
#' the interval. It shifts when the interval occurs.
#'
#' @aliases int_end int_end<-
#' @export int_end "int_end<-"
#' @param x An interval object
#' @return A POSIXct date object when used as an accessor. Nothing when used as a settor
#' @examples
#' int <- new_interval(ymd("2001-01-01"), ymd("2002-01-01"))
#' # 2001-01-01 -- 2002-01-01
#' int_end(int)
#' # "2002-01-01 UTC"
#' int_end(int) <- ymd("2002-06-01")
#' int
#' # 2001-06-01 -- 2002-06-01
int_end <- function(x)
	attr(x, "start") + as.numeric(x)

"int_end<-" <- function(interval, value){
	stopifnot(length(value) == length(interval))
	dur <- as.numeric(interval)
	interval <- structure(dur, start = value - dur , class = c("interval", "numeric"))
}

	
	

	

rep.interval <- function(x, ...){
	y <- rep(as.numeric(x), ...)
	attr(y, "start") <- rep(attr(x, "start"), ...)
	attr(y, "class") <- attr(x, "class")
	y
}