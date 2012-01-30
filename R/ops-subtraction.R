subtract_interval_from_date <- function(int, date){
	end <- int@start + int@.Data
	if (any(end != as.POSIXct(date)))
	   message("interval does not align: coercing to duration")
	dur <- as.duration(int)
	add_duration_to_date(-dur, date)
}

#' THIS HAS CHANGED
subtract_interval_from_interval <- function(int2, int1){
	holes <- int2@start > int1@start & int2@start + int2@.Data < int1@start + 
		int1@.Data
	if (any(holes)) {
		message("lubridate does not support discontinuous intervals")
		stop(paste("case," which(holes), "results in discontinuous interval"))
	} else if (any(!overlaps(int2, int1))) {
		message("Intervals do not overlap: coercing to durations")
		new("Duration", int1@.Data - int2@.Data)
	} else
		ifelse(int1@start < int2@start, 
			new_interval(int1@start, int2@start),
			new_interval(int2@start + int2@.Data, int1@start + int1@.Data))
}

#' Subtracting date-time objects
#'
#' subtract_dates subtracts two objects, both of which can be date-time 
#' objects. Lubridate is built so that you don't need to use 
#' subtract_dates but can use regular math expressions instead.
#' @param e1 a numeric or date-time object
#' @param e2 a numeric or date-time object
#' @export subtract_dates


setMethod("-", signature(e1 = "Interval", e2 = "missing"),
	multiply_interval_by_number(e1, -1))
 
setMethod("-", signature(e1 = "Duration", e2 = "missing"),
    multiply_duration_by_number(e1, -1))
    
setMethod("-", signature(e1 = "Period", e2 = "missing"),
    multiply_period_by_number(e1, -1))


# NOTE: Should I just change this to a warning message that tells users to switch to a duration or period if they want to subtract intervals?
setMethod("-", signature(e1 = "Interval", e2 = "Interval"),
	subtract_interval_from_interval(e2, e1))

setMethod("-", signature(e1 = "POSIXt", e2 = "Interval"),
	subtract_interval_from_date(e2, e1))
	
setMethod("-", signature(e1 = "Date", e2 = "Interval"),
	subtract_interval_from_date(e2, e1))

	
setMethod("-", signature(e2 = "Duration"), e1  + (-1 * e2))

setMethod("-", signature(e2 = "Period"), e1  + (-1 * e2))