subtract_interval_from_date <- function(int, date){
	end <- attr(int, "start") + unclass(int)
	if (any(end != as.POSIXct(date)))
	   message("interval does not align: coercing to duration")
	dur <- as.duration(int)
	attr(dur, "start") <- NULL
	add_duration_to_date(-dur, date)
}

subtract_interval_from_interval <- function(int2, int1){
	start1 <- attr(int1, "start")
	start2 <- attr(int2, "start")
	end1 <- start1 + int1
	end2 <- start2 + int2
	
	if (all(end1 >= end2)){
		if (all(end2 == end1))
			return(new_interval(start2, start1))
		else if (all(start2 == start1))
			return(new_interval(end2, end1))
	}
	
	message("Intervals do not align: coercing to durations")
	dur <- as.duration(int1) - as.duration(int2)
	attr(dur, "start") <- NULL
	dur
}

#' Subtracting date-time objects
#'
#' subtract_dates subtracts two objects, both of which can be date-time 
#' objects. Lubridate is built so that you don't need to use 
#' subtract_dates but can use regular math expressions instead.
#' @param e1 a numeric or date-time object
#' @param e2 a numeric or date-time object
#' @export subtract_dates


# THIS NEEDS A SOLUTION S4 METHODS WILL NOT WORK
  else if(is.instant(e1) && is.instant(e2))
    new_interval(e2, e1)


setMethod("-", signature(e1 = "Interval", e2 = "missing"),
	multiply_interval_by_number(e1, -1))
 
setMethod("-", signature(e1 = "Duration", e2 = "missing"),
    multiply_duration_by_number(e1, -1))
    
setMethod("-", signature(e1 = "Period", e2 = "missing"),
    multiply_period_by_number(e1, -1))
    
setMethod("-", signature(e1 = "POSIXct", e2 = "Timespan"),
	structure(unclass(e1) - e2, class = class(e1))


# NOTE: Should I just change this to a warning message that tells users to switch to a duration or period if they want to subtract intervals?
setMethod("-", signature(e1 = "Interval", e2 = "Interval"),
	subtract_interval_from_interval(e2, e1))

setMethod("-", signature(e1 = "POSIXt", e2 = "Interval"),
	subtract_interval_from_date(e2, e1))
	
setMethod("-", signature(e1 = "Date", e2 = "Interval"),
	subtract_interval_from_date(e2, e1))

	
setMethod("-", signature(e2 = "Duration"), e1  + (-1 * e2))

setMethod("-", signature(e2 = "Period"), e1  + (-1 * e2))