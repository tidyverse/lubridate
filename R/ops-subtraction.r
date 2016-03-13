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

#' @export
setMethod("-", signature(e1 = "Duration", e2 = "missing"),
    function(e1, e2) multiply_duration_by_number(e1, -1))

#' @export
setMethod("-", signature(e1 = "Interval", e2 = "missing"),
	function(e1, e2) multiply_interval_by_number(e1, -1))

#' @export
setMethod("-", signature(e1 = "Period", e2 = "missing"),
    function(e1, e2) multiply_period_by_number(e1, -1))


#' @export
setMethod("-", signature(e2 = "Duration"),
	function(e1, e2) e1  + (-1 * e2))

#' @export
setMethod("-", signature(e1 = "Interval", e2 = "Interval"), function(e1, e2){
	stop("- undefined for Interval class:\nConsider intersect(), union(), or setdiff()\nor change class with as.period() or as.duration()")
})

#' @export
setMethod("-", signature(e1 = "Duration", e2 = "Interval"), function(e1, e2) {
	stop("- undefined for Interval class:\n  manipulate with int_start(), int_end() and int_shift()\n  or change class with as.duration() or as.period()")
})

#' @export
setMethod("-", signature(e1 = "Period", e2 = "Interval"),function(e1, e2) {
	stop("- undefined for Interval class:\n  manipulate with int_start(), int_end() and int_shift()\n  or change class with as.duration() or as.period()")
})

#' @export
setMethod("-", signature(e2 = "Period"),
	function(e1, e2) e1  + (-1 * e2))

#' @export
setMethod("-", signature(e1 = "Date", e2 = "Interval"), function(e1, e2) {
	stop("- undefined for Interval class:\n  manipulate with int_start(), int_end() and int_shift()\n  or change class with as.duration() or as.period()")
})

#' @export
setMethod("-", signature(e1 = "Interval", e2 = "Date"), function(e1, e2) {
	stop("- undefined for Interval class:\n  manipulate with int_start(), int_end() and int_shift()\n  or change class with as.duration() or as.period()")
})

#' @export
setMethod("-", signature(e1 = "POSIXct", e2 = "Interval"), function(e1, e2) {
	stop("- undefined for Interval class:\n  manipulate with int_start(), int_end() and int_shift()\n  or change class with as.duration() or as.period()")
})

#' @export
setMethod("-", signature(e1 = "Interval", e2 = "POSIXct"), function(e1, e2) {
	stop("- undefined for Interval class:\n  manipulate with int_start(), int_end() and int_shift()\n  or change class with as.duration() or as.period()")
})

#' @export
setMethod("-", signature(e1 = "POSIXlt", e2 = "Interval"), function(e1, e2) {
	stop("- undefined for Interval class:\n  manipulate with int_start(), int_end() and int_shift()\n  or change class with as.duration() or as.period()")
})

#' @export
setMethod("-", signature(e1 = "Interval", e2 = "POSIXlt"), function(e1, e2) {
	stop("- undefined for Interval class:\n  manipulate with int_start(), int_end() and int_shift()\n  or change class with as.duration() or as.period()")
})

#' @export
setMethod("-", signature(e1 = "numeric", e2 = "Interval"), function(e1, e2) {
	stop("- undefined for Interval class:\n  manipulate with int_start(), int_end() and int_shift()\n  or change class with as.duration() or as.period()")
})

#' @export
setMethod("-", signature(e1 = "Interval", e2 = "numeric"), function(e1, e2) {
	stop("- undefined for Interval class:\n  manipulate with int_start(), int_end() and int_shift()\n  or change class with as.duration() or as.period()")
})
