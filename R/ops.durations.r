#' Addition for the duration (i.e, difftime), period, and interval classes. 
#'
#' @aliases +.duration +.interval +.period +.POSIXt +.difftime +.Date add_dates add_interval_to_date add_interval_to_interval add_number_to_date add_number_to_posix
#'  add_period_to_date add_duration_to_date add_number_to_duration
#'  add_number_to_period add_period_to_period add_duration_to_period
#'  add_duration_to_duration add_duration_to_interval add_period_to_interval
#'  add_number_to_interval
#' @param date a duration(i.e. difftime), period, interval, POSIXt, or Date object
#' @param period a duration(i.e. difftime), period, interval, POSIXt, or Date object
#' @return a new duration(i.e. difftime), period, interval, POSIXt, or Date object, depending on e1 
#'   and e2 
#' @keywords arith chron methods
#' @ examples
#' x <- new_duration(day = 1)
#' x + now()
#' today() + x
#' x + difftime(now() + 3600, now())
#' x + x
add_duration_to_date <- function(date, duration) {
  if(is.Date(date)){
    date <- as.POSIXct(date)
    ans <- with_tz(.base_add_POSIXt(date, duration), "UTC")
    if (hour(ans) == 0 && minute(ans) == 0 && second(ans) == 0)
      return(as.Date(ans))
    return(ans)
  }
  new <- .base_add_POSIXt(date, duration)
  attr(new, "tzone") <- tz(date)
  reclass_date(new, date)
}

add_duration_to_duration <- function(dur1, dur2)
  make_difftime(as.double(dur1, "secs") + as.double(dur2, "secs"))

add_duration_to_interval <- function(int, dur){
  start <- attr(int, "start")	
  span <- add_duration_to_duration(int, dur)
  new_interval(start + span, start)
}

add_duration_to_period <- function(per, dur){
	print("duration converted to seconds")
	per + seconds(as.numeric(dur, "secs"))
}



add_interval_to_date <- function(date, interval){
	if (any(attr(interval, "start") != date))
	   print("coercing interval to duration")
	add_duration_to_date(date, as.duration(interval))
}

add_interval_to_interval <- function(int1, int2){
	start1 <- attr(int1, "start")
	start2 <- attr(int2, "start")
	end1 <- start1 + int1
	end2 <- start2 + int2
	
	if(all(start2 == end1))
		return(new_interval(start1 + int1 + int2, start1))
	else if (all(start1 == end2))
		return(new_interval(start2 + int2 + int1, start2))
	else if (all(start1 == start2))
		return(as.interval(start1, pmax(end1, end2)))
	
	message("Intervals do not align: coercing to durations")
	as.duration(int1) + as.duration(int2)
}



add_number_to_date <- function(e1, e2)
      structure(unclass(e1) + e2, class = "Date")

add_number_to_duration <- function(dur, num)
  make_difftime(num + as.double(dur, "secs"))

add_number_to_interval <-function(int, num){
  message("numeric coerced to duration in seconds")
  add_duration_to_interval(int, as.duration(num))
}

add_number_to_period <- function(per, num){
  message("numeric coerced to seconds")
  per$second <- per$second + num
  per
}

add_number_to_posix <- function(e1, e2){
      if(is.POSIXct(e1)){
      	return(structure(unclass(as.POSIXct(e1)) + e2, class = 
      		class(e1)))
      }
      as.POSIXlt(structure(unclass(as.POSIXct(e1)) + e2, class = 		class(as.POSIXct(e1))))
}



add_period_to_date <- function(date, period){
	new <- update(as.POSIXlt(date), 
			years = year(date) + period$year,
			months = month(date) + period$month,
			days = mday(date) + period$day,
			hours = hour(date) + period$hour,
			minutes = minute(date) + period$minute,
			seconds = second(date) + period$second
			)
	if (is.Date(date) & sum(new$sec, new$min, new$hour, na.rm = TRUE) != 0)
	return(new)	
	
	reclass_date(new, date)
}

add_period_to_interval <- function(int, per){
  start <- attr(int, "start")
  end <- start + unclass(int)
  end2 <- end + per
  new_interval(end2, start)
}

add_period_to_period <- function(per1, per2){
  to.add <- suppressWarnings(cbind(per1,per2))
  structure(to.add[,1:6] + to.add[,7:12], class = c("period", "data.frame"))
}



add_dates <- function(e1, e2){
  
  if (is.instant(e1)) {
    if (is.instant(e2))
      stop("binary '+' not defined for adding dates together")
    if (is.period(e2))
      add_period_to_date(e1, e2)
    else if (is.interval(e2))
      add_interval_to_date(e1, e2)
    else if (is.difftime(e2)) 
      add_duration_to_date(e1, e2)
    else if (is.POSIXt(e1))
      add_number_to_posix(e1, e2)
    else if (is.Date(e1))
      add_number_to_date(e1, e2)
    else{
      base::'+'(e1,e2)
      }
  }

  else if (is.period(e1)) {
    if (is.instant(e2))
      add_period_to_date(e2, e1)
    else if (is.period(e2))
      add_period_to_period(e1, e2)
    else if (is.interval(e2))
      add_period_to_interval(e2, e1)
    else if (is.difftime(e2))
      add_duration_to_period(e1, e2)
    else
      add_number_to_period(e1, e2)
  }
  
  else if (is.interval(e1)){
    if (is.instant(e2))
      add_interval_to_date(e2, e1)
    else if (is.interval(e2))
      add_interval_to_interval(e1, e2)
    else if (is.period(e2))
      add_period_to_interval(e1, e2)
    else if (is.difftime(e2))
      add_duration_to_interval(e1, e2)  
    else
      add_number_to_interval(e1, e2)
  }

  else if (is.difftime(e1)) {
    if (is.instant(e2))
      add_duration_to_date(e2, e1)
    else if (is.period(e2))
      add_duration_to_period(e2, e1)
    else if (is.interval(e2))
      add_duration_to_interval(e2, e1)
    else if (is.difftime(e2))
      add_duration_to_duration(e1, e2)
    else
      add_number_to_duration(e1, e2)
  }
  
  else if (is.numeric(e1)) {
    if (is.POSIXt(e2))
      add_number_to_posix(e2, e1)
    else if (is.Date(e1))
      add_number_to_date(e2, e1)
    else if (is.period(e2))
      add_number_to_period(e2, e1)
    else if (is.interval(e2))
      add_number_to_interval(e2, e1) 
    else if (is.difftime(e2))
      add_number_to_duration(e2, e1) 
    else stop("Unknown object class")
  }
  else stop("Unknown object class")
}


#' Makes a difftime object from given number of seconds 
#'
#' @param x number value of seconds to be transformed into a difftime object
#' @return a difftime object corresponding to x seconds
#' @keywords chron
#' @examples
#' make_difftime(1)
#' make_difftime(60)
#' make_difftime(3600)
make_difftime <- function (x) {  
  seconds <- abs(x)
    if (any(seconds < 60)) 
        units <- "secs"
    else if (any(seconds < 3600))
        units <- "mins"
    else if (any(seconds < 86400))
        units <- "hours"
    else
        units <- "days"
    
    switch(units, secs = structure(x, units = "secs", class = "difftime"), 
      mins = structure(x/60, units = "mins", class = "difftime"), 
      hours = structure(x/3600, units = "hours", class = "difftime"), 
      days = structure(x/86400, units = "days", class = "difftime"))
}

#' Multiplication for period and interval classes. 
#'
#' @name multiply
#' @aliases *.period *.interval multiply_period_by_number multiply_interval_by_number 
#' @param per a period, interval or numeric object
#' @param num a period, interval or numeric object
#' @return a period or interval object
#' @seealso \code{\link{+.period}}, \code{\link{+.interval}},
#'   \code{\link{-.period}}, \code{\link{-.interval}},
#'   \code{\link{/.interval}}, \code{\link{/.period}}
#' @keywords arith chron methods
#' @examples
#' x <- new_period(day = 1)
#' x * 3
#' 3 * x
multiply_period_by_number <- function(per, num){
  new_period(
    year = per$year * num,
    month = per$month * num,
    day = per$day * num,
    hour = per$hour * num,
    minute = per$minute * num,
    second = per$second * num
  )
}

multiply_interval_by_number <- function(int, num){
	start <- attr(int, "start")
	span <- num * as.duration(int)
	
	new_interval(start + span, start)
}

"*.period" <- "*.interval" <- function(e1, e2){
    if (is.timespan(e1) && is.timespan(e2)) 
      stop("cannot multiply time span by time span")
    else if (is.period(e1))
      multiply_period_by_number(e1, e2)
    else if (is.period(e2))
      multiply_period_by_number(e2, e1)
    else if (is.interval(e1))
      multiply_interval_by_number(e1, e2)
    else if (is.interval(e2))
      multiply_interval_by_number(e2, e1)
    else base::'*'(e1, e2)
}  




#' Division for period, and interval classes. 
#'
#' @name division
#' @aliases /.period /.interval divide_period_by_number divide_interval_by_number 
#' @param per a period, interval or numeric object
#' @param num a period, interval or numeric object
#' @return a period or interval object
#' @seealso \code{\link{+.period}}, \code{\link{+.interval}},
#'   \code{\link{-.period}}, \code{\link{-.interval}}, 
#'   \code{\link{*.interval}}, \code{\link{*.period}}
#' @keywords arith chron methods
#' @examples
#' x <- new_period(day = 2)
#' x / 2
divide_period_by_number <- function(per, num){
  new_period(
    year = per$year / num,
    month = per$month / num,
    day = per$day / num,
    hour = per$hour / num,
    minute = per$minute / num,
    second = per$second / num
  )
}

divide_interval_by_number <- function(int, num){
	start <- attr(int, "start")
	span <- as.duration(int) / num
	
	new_interval(start + span, start)
}

"/.period" <- "/.interval" <- function(e1, e2){
   if (is.timespan(e2)) 
      stop( "second argument of / cannot be a timespan")
    else if (is.period(e1))
      divide_period_by_number(e1, e2)
    else if (is.interval(e1))
      divide_interval_by_number(e1, e2)
    else base::'/'(e1, e2)
}  





  
#' Subtraction for the duration (i.e, difftime), period, and interval classes. 
#'
#' The subtraction methods returns an interval object when a POSIXt or Date 
#' object is subtracted from another POSIXt or Date object. To retrieve this 
#' difference as a duration, use \code{\link{as.duration}}. To retrieve it as a 
#' period use \code{\link{as.period}}. To retrieve it as a difftime, use \code{\link{difftime}} instead of subtraction.
#'
#' Since a specific number of seconds exists between two dates, the duration 
#' returned will not include unspecific time units such as years and months. See 
#' \code{\link{duration}} for more details.
#'
#' @aliases -.period -.POSIXt -.difftime -.Date -.interval subtract_dates
#' @param e1 a duration(i.e. difftime), period, interval, POSIXt, or Date object
#' @param e2 a duration(i.e. difftime), period, interval, POSIXt, or Date object
#' @return a new duration(i.e. difftime), period, interval, POSIXt, or Date object, depending on e1 
#'   and e2 
#' @keywords arith chron methods
#' @examples
#' x <- new_duration(day = 1)
#' now() - x
#' -x
#' x - x
#' as.Date("2009-08-02") - as.Date("2008-11-25")
subtract_interval_from_date <- function(date, int){
	end <- attr(int, "start") + unclass(int)
	if (any(end != date))
	   print("interval does not align: coercing to duration")
	add_duration_to_date(date, -as.duration(int))
}

subtract_interval_from_interval <- function(int2, int1){
	start1 <- attr(int1, "start")
	start2 <- attr(int2, "start")
	end1 <- start1 + int1
	end2 <- start2 + int2
	
	if(all(end2 == end1))
		return(new_interval(start2, start1))
	else 
	
	message("Intervals do not align: coercing to durations")
	as.duration(int1) - as.duration(int2)
}

subtract_dates <- function(e1, e2){
  if (missing(e2))
    -1 * e1
  else if(is.instant(e1) && is.instant(e2))
    new_interval(e2, e1)
  else if (is.POSIXct(e1) && !is.timespan(e2))
    structure(unclass(e1) - e2, class = class(e1))
  else if (is.POSIXlt(e1) && !is.timespan(e2)){
    as.POSIXlt(structure(unclass(as.POSIXct(e1)) - e2, 
    	class = class(as.POSIXct(e1))))
  } else if (is.interval(e1) && is.interval(e2))
  	subtract_interval_from_interval(e2, e1)
  else if (is.instant(e1) && is.interval(e2))
  	subtract_interval_from_date(e2, e1)
  else
    e1  + (-1 * e2)
}







