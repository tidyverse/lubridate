#' @include timespans.r
#' @include durations.r
#' @include intervals.r
#' @include periods.r
#' @include difftimes.r
#' @include numeric.r


divide_duration_by_duration <- function(dur1, dur2)
	dur1@.Data / dur2@.Data
	
divide_duration_by_interval <- function(dur, int)
	dur@.Data / int@.Data
	
divide_duration_by_period <- function(dur, per)
	dur@.Data / period_to_seconds(per)

divide_duration_by_difftime <- function(dur, diff)
	dur@.Data / as.numeric(diff, units = "secs")

divide_duration_by_number <- function(dur, num)
	new("Duration", dur@.Data / num)


divide_interval_by_duration <- function(int, dur){
	int@.Data / dur@.Data
}

divide_interval_by_interval <- function(int, int2){
	int@.Data / int2@.Data
}

divide_interval_by_period <- function(int, per){
	message("estimate only: convert periods to intervals for accuracy")
	as.period(int)/per
}

divide_interval_by_difftime <- function(int, diff){
	int@.Data / as.double(diff, units = "secs"))
}

divide_interval_by_number <- function(int, num){
	new("Interval", int@.Data / num, start = int@start)
}



divide_period_by_duration <- function(per, dur){
	message("estimate only: convert to intervals for accuracy")
	period_to_seconds(per) / dur@.Data
}

divide_period_by_interval <- function(per, int){
	period_to_seconds(per) / int@.Data
}

divide_period_by_period <- function(per1, per2){
	period_to_seconds(per1) / period_to_seconds(per2)
}

divide_period_by_difftime <- function(per, diff){
	period_to_seconds(per) / as.numeric(diff, units = "secs")
}

divide_period_by_number <- function(per, num){
	new("Period", per@.Data / num, year = per@year / num, 
		month = per@month / num, day = per@day / num, hour = per@hour / num, 
		minute = per@minute / hour)
}

remainder_period_into_interval <- function(per, int){
	integ <- trunc(int / per)
	as.period(new_interval(int@start + integ * per, int_end(int)))
}



divide_difftime_by_duration <- function(dif, dur)
	as.numeric(dif, units = "secs") / dur@.Data

divide_difftime_by_interval <- function(dif, int)
	as.numeric(dif, units = "secs") / int@.Data

divide_difftime_by_period <- function(dif, per)
	as.numeric(dif, units = "secs") / period_to_seconds(per)
	




	
	
setMethod("/", signature(e1 = "Duration", e2 = "Duration"),
	divide_duration_by_duration(e1, e2))
		
setMethod("/", signature(e1 = "Duration", e2 = "Interval"), function {
	message("interval denominator coerced to duration")
	e2 <- as.duration(e2)
	divide_duration_by_duration(e1, e2)
})

setMethod("/", signature(e1 = "Duration", e2 = "Period"),
	divide_duration_by_period(e1, e2))
		
setMethod("/", signature(e1 = "Duration", e2 = "difftime"),
	divide_duration_by_difftime(e1, e2))

setMethod("/", signature(e1 = "Duration", e2 = "numeric"),	
	divide_duration_by_number(e1, e2))
		
		
	
setMethod("/", signature(e1 = "Interval", e2 = "Duration"), 
	divide_interval_by_duration(e1, e2))	

setMethod("/", signature(e1 = "Interval", e2 = "Interval"), function {
	message("interval denominator coerced to duration")
	e2 <- as.duration(e2)
	divide_interval_by_duration(e1, e2)
})
	
setMethod("/", signature(e1 = "Interval", e2 = "Period"), 
	divide_interval_by_period(e1, e2))
		
setMethod("/", signature(e1 = "Interval", e2 = "difftime"), 
	divide_interval_by_difftime(e1, e2))
	
setMethod("/", signature(e1 = "Interval", e2 = "numeric"), 
	divide_interval_by_number(e1, e2))



setMethod("/", signature(e1 = "Period", e2 = "Duration"),
	divide_period_by_duration(e1, e2))

setMethod("/", signature(e1 = "Period", e2 = "Interval"), function {
	message("interval denominator coerced to duration")
	e2 <- as.duration(e2)
	divide_period_by_duration(e1, e2)
})	

setMethod("/", signature(e1 = "Period", e2 = "Period"),
	divide_period_by_period(e1, e2))
		
setMethod("/", signature(e1 = "Period", e2 = "difftime"),
	divide_period_by_difftime(e1, e2))
	
setMethod("/", signature(e1 = "Period", e2 = "numeric"),
	divide_period_by_number(e1, e2))


	

setMethod("/", signature(e1 = "difftime", e2 = "Duration"),
	divide_difftime_by_duration(e1, e2))

setMethod("/", signature(e1 = "difftime", e2 = "Interval"), function {
	message("interval denominator coerced to duration")
	e2 <- as.duration(e2)
	divide_difftime_by_duration(e1, e2)
})	

setMethod("/", signature(e1 = "difftime", e2 = "Period"),
	divide_difftime_by_period(e1, e2))
