#' @include timespans.r
#' @include durations.r
#' @include intervals.r
#' @include periods.r
NULL

modulo_duration_by_duration <- function(dur, dur2)
	dur - dur %/% dur2 * dur2

modulo_duration_by_interval <- function(dur, int)
	stop("Incompatible timespan classes:\n  change class with as.duration()")

modulo_duration_by_period <- function(dur, per)
	stop("Incompatible timespan classes:\n  change class with as.duration() or as.period()")




modulo_interval_by_duration <- function(int, dur)
	interval(int@start + int@.Data %/% dur@.Data * dur, int_end(int))

modulo_interval_by_interval <- function(int, int2) {
		stop("undefined for Interval class:\n  manipulate with int_start(), int_end() and int_shift()\n  or change class with as.duration() or as.period()")
}

modulo_interval_by_period <- function(int, period)
	interval(int@start + int %/% per * per, int_end(int))


modulo_period_by_duration <- function(per, dur)
	stop("Incompatible timespan classes:\n  change class with as.duration() or as.period()")

modulo_period_by_interval <- function(per, int)
	stop("Incompatible timespan classes:\n  change class with as.period()")

modulo_period_by_period <- function(per, per2)
	per - per %/% per2 * per2



#' @export	
setMethod("%%", signature(e1 = "Duration", e2 = "Duration"), 
	function(e1, e2) e1 - e1 %/% e2 * e2)

#' @export		
setMethod("%%", signature(e1 = "Duration", e2 = "Interval"), 
	function(e1, e2) e1 - e1 %/% e2 * e2)

#' @export		
setMethod("%%", signature(e1 = "Duration", e2 = "Period"), 
	function(e1, e2) e1 - e1 %/% e2 * e2)	



#' @export	
setMethod("%%", signature(e1 = "Interval", e2 = "Duration"), 
	function(e1, e2) e1 - e1 %/% e2 * e2)

#' @export	
setMethod("%%", signature(e1 = "Interval", e2 = "Interval"), 
	function(e1, e2) e1 - e1 %/% e2 * e2)
	
#' @export	
setMethod("%%", signature(e1 = "Interval", e2 = "Period"), 
	function(e1, e2) e1 - e1 %/% e2 * e2)
	

#' @export	
setMethod("%%", signature(e1 = "Period", e2 = "Duration"), 
	function(e1, e2) e1 - e1 %/% e2 * e2)

#' @export	
setMethod("%%", signature(e1 = "Period", e2 = "Interval"), 
	function(e1, e2) e1 - e1 %/% e2 * e2)
	
#' @export	
setMethod("%%", signature(e1 = "Period", e2 = "Period"), 
	function(e1, e2) e1 - e1 %/% e2 * e2)

