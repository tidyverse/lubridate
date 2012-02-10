#' @include timespans.r
NULL

#' @export	
setMethod("%%", signature(e1 = "Timespan", e2 = "Timespan"), 
	function(e1, e2) e1 - e1 %/% e2 * e2)


