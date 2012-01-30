setGeneric("as.numeric")
setMethod("as.numeric", signature("Duration"), function(x, units = "secs", ...){
	units <- standardise_period_names(units)
	
	if (units == "month") stop("cannot map durations to months")
	num <- switch(units, 
		second = x@.Data, 
		minute = x@.Data / 60, 
		hour = x@.Data / (60 * 60),
		day = x@.Data / (60 * 60 * 24),
		week = x@.Data / (60 * 60 * 24 * 7),
		year = x@.Data / (60 * 60 * 24 * 365.25))
		
	as.numeric(num, ...)
})

setMethod("as.numeric", signature(x = "Interval"), function(x, units = "secs", ...){
	message("coercing interval to duration")
	as.numeric(as.duration(x), units, ...)
})

setMethod("as.numeric", signature(x = "Period"), function(x, units = "second", ...){
	units <- standardise_period_names(units)
	ifelse(units == "second") x@.Data
	else slot(x, units)
})