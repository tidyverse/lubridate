#' @include timespans.r

modulo_spans <- function(e1, e2){
	if (!is.timespan(e1) && !is.timespan(e2))
		stop("attempt to use an unrecognized timespan object with a timespan") 
	if (class(e1)[1] != class(e2)[1])
	    e1 <- reclass_timespan(e1, e2)
	get_remainder(e1, e2)
}

get_remainder <- function(num, den){
	decimal <- suppressMessages(num / den)
	integ <- trunc(decimal)
	num - den * integ
}

setMethod("%%", signature(e1 = "Timespan", e2 = "Timespan"), modulo_spans(e1, e2))


