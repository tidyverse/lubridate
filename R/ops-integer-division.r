#' @include timespans.r
NULL

integer_divide_spans <- function(e1, e2){
	trunc(suppressMessages(e1 / e2))
}

#' @export
setMethod("%/%", signature(e1 = "Timespan", e2 = "Timespan"),
	function(e1, e2) integer_divide_spans(e1, e2))

#' @export
setMethod("%/%", signature(e1 = "difftime", e2 = "Timespan"),
          function(e1, e2) integer_divide_spans(e1, e2))
