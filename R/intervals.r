#' Create an interval object.
#'
#' new_interval creates an interval object with the specified start and end 
#' dates. new_interval automatically assigns the date that occurs first as the 
#' start date and the date that occurs second as the end date.
#'
#' Intervals are time spans bound by two real date-times.  Intervals can be 
#' accurately converted to either period or duration objects using 
#' \code{\link{as.period}}, \code{\link{as.duration}}. Since an interval is
#' anchored to a fixed history of time, both the number of seconds that passed
#' as well as the length of common time units during that history can be
#' calculated.  Subtracting two date times automatically creates an interval
#' object. Intervals display as the difftime between the two dates paired 
#' with the earlier, or beginning date. 
#'
#' @param date1 a POSIXt or Date date-time object
#' @param date2 a POSIXt or Date date-time object
#' @return an interval object
#' @seealso \code{\link{interval}}, \code{\link{as.interval}}
#' @keywords chron classes
#' @examples
#' new_interval(ymd(20090101), ymd(20090201))
#' # 31 days beginning at 2009-01-01
#'
#' date1 <- as.POSIXct("2009-03-08 01:59:59")
#' date2 <- as.POSIXct("2000-02-29 12:00:00")
#' new_interval(date1, date2)
#' # 3294.583 days beginning at 2000-02-29 12:00:00
#' new_interval(date2, date1)
#' # 3294.583 days beginning at 2000-02-29 12:00:00
#' 
#' span <- new_interval(ymd(20090101), ymd(20090201))
#' # 31 days beginning at 2009-01-01
#' span * 2
#' # 62 days beginning at 2009-01-01
#' span / 2
#' # 15.5 days beginning at 2009-01-01
#' span - days(30)
#' # 1 days beginning at 2009-01-01
#' span + months(6)
#' # 211.9583 days beginning at 2009-01-01
#'
#' span$start
#' # "2009-01-01 CST"
#' span$end
#' # "2009-02-01 CST"
new_interval <- function(date1, date2){
  date1 <- as.POSIXct(date1)
  date2 <- as.POSIXct(date2)
    
  interval <- data.frame(start = pmin(date1, date2), end = pmax(date1, date2))
  structure(interval, class = c("interval", "data.frame"))
}

#' Internal function. Formats interval objects.
#'
#' @keywords internal print chron
#' @method format interval
format.interval <- function(int,...){
  x <- difftime(int$end, int$start)
  paste(format(unclass(x),...), units(x), "beginning at", int$start)
}

#' Internal function for printing interval objects.
#'
#' @keywords internal print chron
#' @method print interval
print.interval <- function(x, ...) {
  print(format(x), ..., quote = FALSE)
}


#' Change an object to an interval.
#'
#' as.interval changes duration (i.e. difftime), period and numeric objects to 
#' intervals that begin at the specified date-time. Numeric objects are first 
#' coerced to time spans equal to the numeric value in seconds. 
#'
#' as.interval can be used to create accurate transformations between period 
#' objects, which describe time spans in relative units, and duration objects, 
#' which describe timespans in exact units. To do this, however, an origin date-
#' time must be supplied from which to measure the period. See 
#' \code{\link{as.duration}}, \code{\link{as.period}}.
#'
#' @param x a duration (i.e. difftime), period, or numeric object that describes the length of the 
#'   interval
#' @param origin a POSIXt or Date object that describes when the interval begins   
#' @return an interval object
#' @seealso \code{\link{interval}}, \code{\link{new_interval}}
#' @keywords classes manip methods chron
#' @examples
#' diff <- new_duration(days = 31) #duration
#' as.interval(diff, as.POSIXct("2009-01-01"))
#' # 31 days beginning at 2009-01-01
#' as.interval(diff, as.POSIXct("2009-02-01"))
#' # 31 days beginning at 2009-02-01
#' 
#' per <- new_period(months = 1) #period
#' as.interval(per, as.POSIXct("2009-01-01"))
#' # 31 days beginning at 2009-01-01
#' as.interval(per, as.POSIXct("2009-02-01"))
#' # 28 days beginning at 2009-02-01
#' as.interval(3600, as.POSIXct("2009-01-01")) #numeric
#' # 1 hours beginning at 2009-01-01
as.interval <- function(x, origin){
  origin <- as.POSIXct(origin)
  new_interval(origin, origin + x)
}

  
