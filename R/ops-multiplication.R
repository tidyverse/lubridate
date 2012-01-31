multiply_duration_by_number <- function(dur, num)
	new("Duration", dur@.Data * num)


multiply_period_by_number <- function(per, num){
  new("Period", per@.Data * num,
    year = per@year * num,
    month = per@month * num,
    day = per@day * num,
    hour = per@hour * num,
    minute = per@minute * num)
}

multiply_interval_by_number <- function(int, num){
	new("Interval", int@.Data * num, start = int@start, tzone = int@tzone)
}



setMethod("*", signature(e1 = "Timespan", e2 = "Timespan"),
	stop("cannot multiply time span by time span"))

setMethod("*", signature(e1 = "Period"), multiply_period_by_number(e1, e2))
	
setMethod("*", signature(e2 = "Period"), multiply_period_by_number(e2, e1))

setMethod("*", signature(e1 = "Interval"), multiply_interval_by_number(e1, e2))

setMethod("*", signature(e2 = "Interval"), multiply_interval_by_number(e2, e1))

setMethod("*", signature(e1 = "Duration"), multiply_duration_by_number(e1, e2))

setMethod("*", signature(e2 = "Duration"), multiply_duration_by_number(e2, e1))
