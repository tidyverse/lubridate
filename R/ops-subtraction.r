#' @include timespans.r
#' @include durations.r
#' @include intervals.r
#' @include periods.r
#' @include Dates.r
#' @include difftimes.r
#' @include POSIXt.r
NULL


subtract_interval_from_date <- function(int, date){
	end <- int@start + int@.Data
	if (any(end != as.POSIXct(date)))
	   message("interval does not align: coercing to duration")
	dur <- as.duration(int)
	add_duration_to_date(-dur, date)
}

#' Subtracting date-time objects
#'
#' subtract_dates subtracts two objects, both of which can be date-time 
#' objects. Lubridate is built so that you don't need to use 
#' subtract_dates but can use regular math expressions instead.
#' @param e1 a numeric or date-time object
#' @param e2 a numeric or date-time object
#' @export subtract_dates

setMethod("-", signature(e1 = "Duration", e2 = "missing"),
    function(e1, e2) multiply_duration_by_number(e1, -1))
    
setMethod("-", signature(e1 = "Interval", e2 = "missing"),
	function(e1, e2) multiply_interval_by_number(e1, -1))
    
setMethod("-", signature(e1 = "Period", e2 = "missing"),
    function(e1, e2) multiply_period_by_number(e1, -1))



setMethod("-", signature(e2 = "Duration"), 
	function(e1, e2) e1  + (-1 * e2))

setMethod("-", signature(e1 = "Interval", e2 = "Interval"),
	function(e1, e2) setdiff(e1, e2))
	
setMethod("-", signature(e2 = "Period"), 
	function(e1, e2) e1  + (-1 * e2))

setMethod("-", signature(e1 = "Date", e2 = "Interval"),
	function(e1, e2) subtract_interval_from_date(e2, e1))

setMethod("-", signature(e1 = "POSIXct", e2 = "Interval"),
	function(e1, e2) subtract_interval_from_date(e2, e1))
	
setMethod("-", signature(e1 = "POSIXlt", e2 = "Interval"),
	function(e1, e2) subtract_interval_from_date(e2, e1))
	