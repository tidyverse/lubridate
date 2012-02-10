#' @include timespans.r
NULL

modulo_spans <- function(e1, e2){
	if (!is.timespan(e1) && !is.timespan(e2))
		stop("attempt to use an unrecognized timespan object with a timespan") 
	if (is.interval(e1))
		int_remainder(e1, e2)
	else if (class(e1)[1] != class(e2)[1]) {
	    e1 <- reclass_timespan(e1, e2)
		get_remainder(e1, e2)
	}
}

# returns remainder as decimal
get_remainder <- function(num, den){
	decimal <- suppressMessages(num / den)
	integ <- trunc(decimal)
	num - den * integ
}

# returns remainder as an interval
int_remainder <- function(int, span){
	n <- int %/% span
	interval(int_start(int) + n * span, int_end(int))
}

#' @export	
setMethod("%%", signature(e1 = "Timespan", e2 = "Timespan"), 
	function(e1, e2) modulo_spans(e1, e2))


