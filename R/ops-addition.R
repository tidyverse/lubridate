add_duration_to_date <- function(duration, date) {
  if(is.Date(date)){
    date <- as.POSIXct(date)
    ans <- with_tz(.base_add_POSIXt(date, as.numeric(duration)), "UTC")
    if (hour(ans) == 0 && minute(ans) == 0 && second(ans) == 0)
      return(as.Date(ans))
    return(ans)
  }
  new <- .base_add_POSIXt(date, as.numeric(duration))
  attr(new, "tzone") <- tz(date)
  reclass_date(new, date)
}

add_duration_to_duration <- function(dur2, dur1)
  structure(as.numeric(dur1) + as.numeric(dur2), class = c("duration", "numeric"))

add_duration_to_interval <- function(dur, int){
  start <- attr(int, "start")	
  span <- unclass(int) + as.numeric(dur, "secs")
  new_interval(start + span, start)
}

add_duration_to_period <- function(dur, per){
	message("duration converted to seconds")
	per + seconds(as.numeric(dur, "secs"))
}




add_interval_to_date <- function(interval, date){
	if (any(attr(interval, "start") != as.POSIXct(date)))
	   message("coercing interval to duration")
	   dur <- as.duration(interval)
	   attr(dur, "start") <- NULL
	add_duration_to_date(dur, date)
}

add_interval_to_interval <- function(int2, int1){
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
	dur <- as.duration(int1) + as.duration(int2)
	attr(dur, "start") <- NULL
	dur
}

add_number_to_duration <- function(num, dur){
	if (is.difftime(dur))
		return(make_difftime(num + as.double(dur, "secs")))
  	new_duration(num + unclass(dur))
}

add_number_to_interval <-function(num, int){
  message("numeric coerced to duration in seconds")
  add_duration_to_interval(as.duration(num), int)
}

add_number_to_period <- function(num, per){
  message("numeric coerced to seconds")
  per$second <- per$second + num
  per
}


add_period_to_date <- function(period, date){
	new <- update(as.POSIXlt(date), 
			years = year(date) + period$year,
			months = month(date) + period$month,
			days = mday(date) + period$day,
			hours = hour(date) + period$hour,
			minutes = minute(date) + period$minute,
			seconds = second(date) + period$second
			)
	if (is.Date(date) && sum(new$sec, new$min, new$hour, na.rm = TRUE) != 0)
	return(new)	
	
	reclass_date(new, date)
}

add_period_to_interval <- function(per, int){
  start <- attr(int, "start")
  end <- start + unclass(int)
  end2 <- end + per
  new_interval(end2, start)
}

add_period_to_period <- function(per2, per1){
  to.add <- suppressWarnings(cbind(per1,per2))
  structure(to.add[,1:6] + to.add[,7:12], class = c("period", "data.frame"))
}


#' RE-DOCUMENT!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#' Adding date-time objects
#'
#' add_dates adds two objects, both of which can be date-time 
#' objects. Lubridate is built so that you don't need to use 
#' add_dates but can use regular math expressions instead.
#' @param e1 a numeric or date-time object
#' @param e2 a numeric or date-time object
#' @export add_dates


setMethod("+", signature(e1 = "Interval", e2 = "Interval"),
	add_interval_to_interval(e2, e1))
	
setMethod("+", signature(e1 = "Interval", e2 = "Period"),
	add_period_to_interval(e2, e1)

setMethod("+", signature(e1 = "Interval", e2 = "Duration"),
	add_duration_to_interval(e2, e1)) 

setMethod("+", signature(e1 = "Interval", e2 = "POSIXt"),
	add_interval_to_date(e1, e2))
	
setMethod("+", signature(e1 = "Interval", e2 = "difftime"),
	add_duration_to_interval(as.duration(e2), e1))
 
setMethod("+", signature(e1 = "Interval", e2 = "numeric"), 
	add_number_to_interval(e2, e1))




setMethod("+", signature(e1 = "Period", e2 = "Interval"),
	add_period_to_interval(e1, e2))

setMethod("+", signature(e1 = "Period", e2 = "Period"), 
	add_period_to_period(e2, e1))

setMethod("+", signature(e1 = "Period", e2 = "Duration"),		
	add_duration_to_period(e2, e1))

setMethod("+", signature(e1 = "Period", e2 = "POSIXt"), 
	add_period_to_date(e1, e2))
		
setMethod("+", signature(e1 = "Period", e2 = "difftime"),	
	add_duration_to_period(as.duration(e2), e1))
	
setMethod("+", signature(e1 = "Period", e2 = "numeric"),		
	add_number_to_period(e2, e1))

	
	


setMethod("+", signature(e1 = "Duration", e2 = "Interval"),
	add_duration_to_interval(e1, e2))
	
setMethod("+", signature(e1 = "Duration", e2 = "Period"),
	add_duration_to_period(e1, e2))
	
setMethod("+", signature(e1 = "Duration", e2 = "Duration"),
	add_duration_to_duration(e2, e1))
  
setMethod("+", signature(e1 = "Duration", e2 = "POSIXt"), 
	add_duration_to_date(e1, e2)) 
	
setMethod("+", signature(e1 = "Duration", e2 = "difftime"),
	add_duration_to_duration(as.duration(e2), e1))
	
setMethod("+", signature(e1 = "Duration", e2 = "numeric"),
	add_number_to_duration(e2, e1))




setMethod("+", signature(e1 = "POSIXt", e2 = "Interval"),
	add_interval_to_date(e2, e1))
	
setMethod("+", signature(e1 = "POSIXt", e2 = "Period"), 
	add_period_to_date(e2, e1))
      
setMethod("+", signature(e1 = "POSIXt", e2 = "Duration"), 
	add_duration_to_date(e2, e1)) 


	

setMethod("+", signature(e1 = "difftime", e2 = "Interval"),
	add_duration_to_interval(e1, e2))

setMethod("+", signature(e1 = "difftime", e2 = "Period"), 
	add_duration_to_period(e1, e2))

setMethod("+", signature(e1 = "difftime", e2 = "Duration"), 
	add_difftime_to_difftime(as.difftime(e2, units = "secs"), e1))
	

  
	
setMethod("+", signature(e1 = "numeric", e2 = "Interval"),
	add_number_to_interval(e1, e2)) 

setMethod("+", signature(e1 = "numeric", e2 = "Period"),
	add_number_to_period(e1, e2))

setMethod("+", signature(e1 = "numeric", e2 = "Duration"),
	add_number_to_duration(e1, e2)) 