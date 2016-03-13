#' @include timespans.r
#' @include durations.r
#' @include intervals.r
#' @include periods.r
NULL


multiply_duration_by_number <- function(dur, num)
	new("Duration", dur@.Data * num)

multiply_interval_by_number <- function(int, num){
	new("Interval", int@.Data * num, start = int@start, tzone = int@tzone)
}

multiply_period_by_number <- function(per, num){
  new("Period", per@.Data * num,
    year = per@year * num,
    month = per@month * num,
    day = per@day * num,
    hour = per@hour * num,
    minute = per@minute * num)
}


#' @export
setMethod("*", signature(e1 = "Timespan", e2 = "Timespan"),
	function(e1, e2) stop("cannot multiply time span by time span"))

#' @export
setMethod("*", signature(e1 = "Duration"), function(e1, e2) multiply_duration_by_number(e1, e2))

#' @export
setMethod("*", signature(e2 = "Duration"), function(e1, e2) multiply_duration_by_number(e2, e1))

#' @export
setMethod("*", signature(e1 = "Interval"), function(e1, e2) multiply_interval_by_number(e1, e2))

#' @export
setMethod("*", signature(e2 = "Interval"), function(e1, e2) multiply_interval_by_number(e2, e1))

#' @export
setMethod("*", signature(e1 = "Period"), function(e1, e2) multiply_period_by_number(e1, e2))

#' @export
setMethod("*", signature(e2 = "Period"), function(e1, e2) multiply_period_by_number(e2, e1))
