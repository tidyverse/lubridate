#' @include timespans.r
#' @include durations.r
#' @include intervals.r
#' @include periods.r
#' @include difftimes.r
#' @include numeric.r
NULL


divide_duration_by_duration <- function(dur1, dur2)
	dur1@.Data / dur2@.Data

divide_duration_by_difftime <- function(dur, diff)
	dur@.Data / as.numeric(diff, units = "secs")

divide_duration_by_number <- function(dur, num)
	new("Duration", dur@.Data / num)



divide_interval_by_duration <- function(int, dur){
	int@.Data / dur@.Data
}


adjust <- function(est, int, per) {
	start <- int_start(int)
	end <- int_end(int)
	
	while(any(start + est * per < end))
		est[start + est * per < end] <- est[start + est * per < end] + 1
	while(any(start + est * per > end))
		est[start + est * per > end] <- est[start + est * per > end] - 1
	
	est
}

divide_interval_by_period <- function(int, per){
    message("Remainder cannot be expressed as fraction of a period.\n  Performing %/%.")
	estimate <- ceiling(suppressMessages(int/as.duration(per)))
  nas <- is.na(estimate)
  if (any(nas)) {
    timespans <- match_lengths(int, per)
    int2 <- timespans[[1]][!nas]
    per2 <- timespans[[2]][!nas]
    estimate[!nas] <- adjust(estimate[!nas], int2, per2)
    estimate
  } else {
    adjust(estimate, int, per)
  }
}


divide_interval_by_difftime <- function(int, diff){
	int@.Data / as.double(diff, units = "secs")
}

divide_interval_by_number <- function(int, num){
	starts <- int@start + rep(0, length(num))
	new("Interval", int@.Data / num, start = starts, tzone = int@tzone)
}



divisible_period <- function(per, anchor){
	per@month <- per@month + 12* per@year
	per@year <- rep(0, length(per@year))

	secs.in.months <- as.numeric(anchor + months(per@month)) - as.numeric(anchor)
	days.in.months <- round(secs.in.months/86400)

	per@day <- per@day + days.in.months
	per@month <- 0

	per
}


divide_period_by_period <- function(per1, per2){
	message("estimate only: convert to intervals for accuracy")
	period_to_seconds(per1) / period_to_seconds(per2)
}

divide_period_by_number <- function(per, num){
	new("Period", per@.Data / num, year = per@year / num, 
		month = per@month / num, day = per@day / num, hour = per@hour / num, 
		minute = per@minute / num)
}



divide_difftime_by_duration <- function(dif, dur)
	as.numeric(dif, units = "secs") / dur@.Data

	




#' @export
setMethod("/", signature(e1 = "Duration", e2 = "Duration"),
	function(e1, e2) divide_duration_by_duration(e1, e2))

#' @export		
setMethod("/", signature(e1 = "Duration", e2 = "Interval"), function(e1, e2) {
	stop("Incompatible timespan classes:\n  change class with as.duration() or put interval in numerator.")
})

#' @export	
setMethod("/", signature(e1 = "Duration", e2 = "Period"), function(e1, e2) {
	stop("Incompatible timespan classes:\n  change class with as.duration() or as.period()")
})

#' @export			
setMethod("/", signature(e1 = "Duration", e2 = "difftime"),
	function(e1, e2) divide_duration_by_difftime(e1, e2))

#' @export	
setMethod("/", signature(e1 = "Duration", e2 = "numeric"),	
	function(e1, e2) divide_duration_by_number(e1, e2))
		
		
#' @export		
setMethod("/", signature(e1 = "Interval", e2 = "Duration"), 
	function(e1, e2) divide_interval_by_duration(e1, e2))	

#' @export	
setMethod("/", signature(e1 = "Interval", e2 = "Interval"), function(e1, e2) {
	stop("interval / interval not defined")
})

#' @export		
setMethod("/", signature(e1 = "Interval", e2 = "Period"), 
	function(e1, e2) divide_interval_by_period(e1, e2))

#' @export			
setMethod("/", signature(e1 = "Interval", e2 = "difftime"), 
	function(e1, e2) divide_interval_by_difftime(e1, e2))

#' @export		
setMethod("/", signature(e1 = "Interval", e2 = "numeric"), 
	function(e1, e2) divide_interval_by_number(e1, e2))


#' @export	
setMethod("/", signature(e1 = "Period", e2 = "Duration"), function(e1, e2) {
	stop("Incompatible timespan classes:\n  change class with as.duration() or as.period()")
})

#' @export	
setMethod("/", signature(e1 = "Period", e2 = "Interval"), function(e1, e2) {
	stop("Incompatible timespan classes:\n  change class with as.period() or put interval in numerator.")
})

#' @export	
setMethod("/", signature(e1 = "Period", e2 = "Period"),
	function(e1, e2) divide_period_by_period(e1, e2))

#' @export			
setMethod("/", signature(e1 = "Period", e2 = "difftime"), function(e1, e2) {
	stop("Incompatible timespan classes:\n  change class with as.duration() or as.period()")
})

#' @export		
setMethod("/", signature(e1 = "Period", e2 = "numeric"),
	function(e1, e2) divide_period_by_number(e1, e2))


	
#' @export	
setMethod("/", signature(e1 = "difftime", e2 = "Duration"),
	function(e1, e2) divide_difftime_by_duration(e1, e2))

#' @export	
setMethod("/", signature(e1 = "difftime", e2 = "Interval"), function(e1, e2) {
	stop("Incompatible timespan classes:\n  change class with as.duration() or put interval in numerator.")
})

#' @export	
setMethod("/", signature(e1 = "difftime", e2 = "Period"), function(e1, e2) {
	stop("Incompatible timespan classes:\n  change class with as.duration() or as.period()")
})
	


#' @export	
setMethod("/", signature(e1 = "numeric", e2 = "Duration"),
	function(e1, e2) stop("Cannot divide numeric by duration"))

#' @export	
setMethod("/", signature(e1 = "numeric", e2 = "Interval"), 
	function(e1, e2) stop("Cannot divide numeric by interval"))
#' @export	
setMethod("/", signature(e1 = "numeric", e2 = "Period"),
	function(e1, e2) stop("Cannot divide numeric by period"))
