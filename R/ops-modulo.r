#' @include timespans.r
#' @include durations.r
#' @include intervals.r
#' @include periods.r
NULL

modulo_duration_by_duration <- function(dur, dur2)
	dur - dur %/% dur2 * dur2

modulo_interval_by_duration <- function(int, dur)
	interval(int@start + int@.Data %/% dur@.Data * dur, int_end(int))

modulo_interval_by_period <- function(int, per)
	interval(int@start + int %/% per * per, int_end(int))

modulo_period_by_period <- function(per, per2)
	per - per %/% per2 * per2

#' @export
setMethod("%%", signature(e1 = "Duration", e2 = "Duration"),
	function(e1, e2) modulo_duration_by_duration(e1, e2))

#' @export
setMethod("%%", signature(e1 = "Duration", e2 = "Interval"), function(e1, e2) {
	stop("Incompatible timespan classes:\n  change class with as.duration() or put interval in numerator.")
})

#' @export
setMethod("%%", signature(e1 = "Duration", e2 = "Period"), function(e1, e2) {
	stop("Incompatible timespan classes:\n  change class with as.duration() or as.period()")
})

#' @export
setMethod("%%", signature(e1 = "Interval", e2 = "Duration"),
	function(e1, e2) modulo_interval_by_duration(e1, e2))

#' @export
setMethod("%%", signature(e1 = "Interval", e2 = "Interval"),
	function(e1, e2) stop("%% not defined for Interval class\nConsider setdiff()"))

#' @export
setMethod("%%", signature(e1 = "Interval", e2 = "Period"),
	function(e1, e2) modulo_interval_by_period(e1, e2))

#' @export
setMethod("%%", signature(e1 = "Period", e2 = "Duration"), function(e1, e2) {
	stop("Incompatible timespan classes:\n  change class with as.duration() or as.period()")
})

#' @export
setMethod("%%", signature(e1 = "Period", e2 = "Interval"), function(e1, e2) {
	stop("Incompatible timespan classes:\n  change class with as.period() or put interval in numerator.")
})

#' @export
setMethod("%%", signature(e1 = "Period", e2 = "Period"),
	function(e1, e2) modulo_period_by_period(e1, e2))
