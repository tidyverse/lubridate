#' @include timespans.r

integer_divide_spans <- function(e1, e2){
	if (!is.timespan(e1) && !is.timespan(e2))
		stop("attempt to use an unrecognized timespan object with a timespan") 
	else trunc(suppressMessages(e1 / e2))
}

setMethod("%/%", signature(e1 = "Timespan", e2 = "Timespan"), integer_divide_spans(e1, e2))