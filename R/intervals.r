#' @include timespans.r
NULL


check_interval <- function(object){
	errors <- character()
	if (!is.numeric(object@.Data)) {
		msg <- "Span length must be numeric."
		errors <- c(errors, msg)
	}
	if (!is(object@start, "POSIXct")) {
		msg <- "Start date must be in POSIXct format."
		errors <- c(errors, msg)
	}
	if (length(object@.Data) != length(object@start)) {
		msg <- paste("Inconsistent lengths: spans = ", length(object@.Data), 
			", start dates = ", length(object@start), sep = "") 
		errors <- c(errors, msg)
	}
	if (length(errors) == 0) 
		TRUE
	else
		errors
}


#' Interval class
#'
#' Interval is an S4 class that extends the \code{\link{Timespan-class}} class. An 
#' Interval object records one or more spans of time. Intervals record these 
#' timespans as a sequence of seconds that begin at a specified date. Since 
#' intervals are anchored to a precise moment of time, they can accurately be 
#' converted to \code{\link{Period-class}} or \code{\link{Duration-class}} class objects. This 
#' is because we can observe the length in seconds of each period that begins on a
#' specific date. Contrast this to a generalized period, which may not have a 
#' consistent length in seconds (e.g. the number of seconds in a year will change 
#' if it is a leap year). 
#'
#' Intervals can be both negative and positive. Negative intervals progress 
#' backwards from the start date; positive intervals progress forwards.
#'
#' Interval class objects have two slots: .Data, a numeric object equal to the number 
#' of seconds in the interval; and start, a POSIXct object that specifies the time 
#' when the interval starts.
#'
#'
#' @name Interval-class
#' @rdname Interval-class
#' @exportClass Interval
#' @aliases intersect,Interval,Interval-method 
#' @aliases union,Interval,Interval-method 
#' @aliases setdiff,Interval,Interval-method 
#' @aliases as.numeric,Interval-method 
#' @aliases show,Interval-method
#' @aliases c,Interval-method
#' @aliases rep,Interval-method
#' @aliases [,Interval-method
#' @aliases [<-,Interval,ANY-method
#' @aliases $,Interval-method
#' @aliases $<-,Interval-method
#' @aliases as.difftime,Interval-method
#' @aliases +,Interval,Duration-method
#' @aliases +,Interval,Interval-method
#' @aliases +,Interval,Period-method
#' @aliases +,Interval,Date-method
#' @aliases +,Date,Interval-method
#' @aliases +,Interval,difftime-method
#' @aliases +,difftime,Interval-method
#' @aliases +,Interval,numeric-method
#' @aliases +,numeric,Interval-method
#' @aliases +,Interval,POSIXct-method
#' @aliases +,POSIXct,Interval-method
#' @aliases +,Interval,POSIXlt-method
#' @aliases +,POSIXlt,Interval-method
#' @aliases /,Interval,Duration-method
#' @aliases /,Interval,Interval-method
#' @aliases /,Interval,Period-method
#' @aliases /,Interval,difftime-method
#' @aliases /,difftime,Interval-method
#' @aliases /,Interval,numeric-method
#' @aliases *,Interval,ANY-method
#' @aliases *,ANY,Interval-method
#' @aliases -,Interval,missing-method
#' @aliases -,Interval,Interval-method
#' @aliases -,Date,Interval-method
#' @aliases -,POSIXct,Interval-method
#' @aliases -,POSIXlt,Interval-method
setClass("Interval", contains = c("Timespan", "numeric"), representation(start = "POSIXct", 	tzone = "character"), validity = check_interval)

#' @export
setMethod("show", signature(object = "Interval"), function(object){
	print(paste(format(object@start, tz = object@tzone, usetz = TRUE), "--", 
		format(object@start + object@.Data, tz = object@tzone, usetz = TRUE), sep = ""))
})

#' @S3method format Interval
format.Interval <- function(x,...){
	paste(format(x@start, tz = x@tzone, usetz = TRUE), "--", 
		format(x@start + x@.Data, tz = x@tzone, usetz = TRUE), sep = "")
}

#' @export
setMethod("c", signature(x = "Interval"), function(x, ...){
	spans <- c(x@.Data, unlist(list(...)))
	starts <- c(x@start, unlist(lapply(list(...), int_start)))
	new("Interval", spans, start = starts, tzone = x@tzone)
})

#' @export
setMethod("rep", signature(x = "Interval"), function(x, ...){
	new("Interval", rep(x@.Data, ...), start = rep(x@start,...), tzone = x@tzone)
})

#' @export
setMethod("[", signature(x = "Interval"), 
	function(x, i, j, ..., drop = TRUE) {
    	new("Interval", x@.Data[i], start = x@start[i], tzone = x@tzone)
	}
)

#' @export
setMethod("[<-", signature(x = "Interval"), function(x, i, j, ..., value) {
  	if (is.interval(value)){
  		x@.Data[i] <- value@.Data
  		x@start[i] <- value@start 
  		new("Interval", x@.Data, start = x@start, tzone = x@tzone)
  	}
  	else {
  		x@.Data[i] <- value
		new("Interval", x@.Data, start = x@start, tzone = x@tzone)
	}
})


#' @export
setMethod("$", signature(x = "Interval"), function(x, name) {
	if(name == "span") name <- ".Data"
	slot(x, name)
})

#' @export
setMethod("$<-", signature(x = "Interval"), function(x, name, value) {
	if(name == "span") name <- ".Data"
	slot(x, name) <- value
	x
})

#' Create an interval object.
#'
#' interval creates an \code{\link{Interval-class}} object with the specified start and end 
#' dates. If the start date occurs before the end date, the interval will be positive. 
#' Otherwise, it will be negative.
#'
#' Intervals are time spans bound by two real date-times.  Intervals can be 
#' accurately converted to either period or duration objects using 
#' \code{\link{as.period}}, \code{\link{as.duration}}. Since an interval is
#' anchored to a fixed history of time, both the exact number of seconds that passed
#' and the number of variable length time units that occurred during the interval can be
#' calculated.  
#'
#' \%--\% Creates an interval that covers the range spanned 
#' by two dates. It replaces the 
#' original behavior of lubridate, which created an interval by default whenever 
#' two date-times were subtracted.
#'
#' @export new_interval interval "%--%"
#' @aliases interval new_interval %--%
#' @param start a POSIXt or Date date-time object
#' @param end a POSIXt or Date date-time object
#' @return an Interval object
#' @seealso \code{\link{Interval-class}}, \code{\link{as.interval}}
#' @examples
#' new_interval(ymd(20090201), ymd(20090101))
#' # 2009-01-01 -- 2009-02-01 
#'
#' date1 <- as.POSIXct("2009-03-08 01:59:59")
#' date2 <- as.POSIXct("2000-02-29 12:00:00")
#' new_interval(date2, date1)
#' # 2000-02-29 12:00:00 -- 2009-03-08 01:59:59
#' new_interval(date1, date2)
#' # 2000-02-29 12:00:00 -- 2009-03-08 01:59:59
#' 
#' span <- new_interval(ymd(20090201), ymd(20090101))
#' # [1] 2009-01-01 -- 2009-02-01 
#' span - days(30)
#' # 2009-01-01 -- 2009-01-02
#' span + months(6)
#' # 2009-01-01 -- 2009-08-01 
#'
#' start <- attr(span, "start")
#' # "2009-01-01 UTC"
#' end <- start + span
#' # "2009-02-01 UTC"
new_interval <- interval <- function(start, end){
	if (is.null(attr(start, "tzone"))) {
		if (is.null(attr(end, "tzone"))) {
			tzone <- ""
		} else {
			tzone <- attr(end, "tzone")
		}
	} else {
		tzone <- attr(start, "tzone")
	}
	
	span <- as.numeric(end) - as.numeric(start)
	new("Interval", span, start = start, tzone = tzone)
}

"%--%" <- function(start, end) interval(start, end)


#' Is x an Interval object?
#'
#' @export is.interval
#' @param x an R object   
#' @return TRUE if x is an Interval object, FALSE otherwise.
#' @seealso \code{\link{is.instant}}, \code{\link{is.timespan}}, \code{\link{is.period}}, 
#'   \code{\link{is.duration}}, \code{\link{Interval-class}}
#' @keywords logic chron
#' @examples
#' is.interval(new_period(months= 1, days = 15)) # FALSE
#' is.interval(new_interval(ymd(20090801), ymd(20090809))) # TRUE
is.interval <- function(x) is(x, c("Interval"))


#' Access and change the start date of an interval
#'
#' Note that changing the start date of an interval will change the length of 
#' the interval, since the end date will remain the same.
#'
#' @aliases int_start int_start<-
#' @export int_start "int_start<-"
#' @param int An interval object
#' @return A POSIXct date object when used as an accessor. Nothing when used as a settor
#' @seealso \code{\link{int_end}}, \code{\link{int_shift}}, \code{\link{int_flip}}
#' @examples
#' int <- new_interval(ymd("2001-01-01"), ymd("2002-01-01"))
#' # 2001-01-01 -- 2002-01-01
#' int_start(int)
#' # "2001-01-01 UTC"
#' int_start(int) <- ymd("2001-06-01")
#' int
#' # 2001-06-01 -- 2002-06-01
int_start <- function(int) int@start

"int_start<-" <- function(int, value){
	value <- as.POSIXct(value)
	span <- int@start + int@.Data - value
	equal.lengths <- data.frame(span, value)
	int <- new("Interval", span, start = equal.lengths$value, 
		tzone = int@tzone)

}


#' Access and change the end date of an interval
#'
#' Note that changing the end date of an interval will change the length of 
#' the interval, since the start date will remain the same.
#'
#' @aliases int_end int_end<-
#' @export int_end "int_end<-"
#' @param int An interval object
#' @return A POSIXct date object when used as an accessor. Nothing when used as a settor
#' @seealso \code{\link{int_start}}, \code{\link{int_shift}}, \code{\link{int_flip}}
#' @examples
#' int <- new_interval(ymd("2001-01-01"), ymd("2002-01-01"))
#' # 2001-01-01 -- 2002-01-01
#' int_end(int)
#' # "2002-01-01 UTC"
#' int_end(int) <- ymd("2002-06-01")
#' int
#' # 2001-06-01 -- 2002-06-01
int_end <- function(int) x@start + x@.Data

"int_end<-" <- function(int, value){
	value <- as.POSIXct(value)
	span <- value - int@start
	int <- new("Interval", span, start = int@start,
		tzone = int@tzone)
}

#' Flip the direction of an interval
#'
#' Reverses the order of the start date and end date in an interval. The 
#' new interval takes place during the same timespan as the original interval, 
#' but has the opposite direction.
#'
#' @export int_flip
#' @param int An interval object
#' @return An interval object
#' @seealso \code{\link{int_shift}},  \code{\link{int_start}}, \code{\link{int_end}}
int_flip <- function(int){
	new("Interval", -int@.Data, start = int@start + int@.Data, tzone = int@tzone)
}

#' Shift an interval along the timeline
#'
#' Shifts the start and end dates of an interval up or down the timeline 
#' by a specified amount. Note that this may change the exact length of the interval.
#'
#' @export int_shift
#' @param int An interval object
#' @param by A period or duration object
#' @return An interval object
#' @seealso \code{\link{int_flip}},  \code{\link{int_start}}, \code{\link{int_end}}
int_shift <- function(int, by){
	if(!is.timespan(by)) stop("by is not a recognized timespan object")
	if(is.interval(by)) stop("an interval cannot be shifted by another interval. 
		Convert second interval to a period or duration.")
	new_interval(int@start + by, int_end(int) + by)
}


#' Test if two intervals overlap
#'
#' @export "int_overlaps"
#' @param int1 an Interval object
#' @param int2 an Interval object
#' @return Logical. TRUE if int1 and int2 overlap by at least one second. FALSE otherwise.
int_overlaps <- function(int1, int2){
	stopifnot(c(is.interval(int1), is.interval(int2)))
	int1@start <= int2@start + int2@.Data & int2@start <= int1@start + int1@.Data
}

#' @export
setGeneric("intersect")

#' @export
setMethod("intersect", signature(x = "Interval", y = "Interval"), function(x,y){
	first.x <- pmin(x@start, x@start + x@.Data)
	first.y <- pmin(y@start, y@start + y@.Data)
	last.x <- pmax(x@start, x@start + x@.Data)
	last.y <- pmax(y@start, y@start + y@.Data)
	
	starts <- pmax(x@start, y@start)
	ends <- pmin(x@start + x@.Data, y@start + y@.Data)
	spans <- as.numeric(ends) - as.numeric(starts) 
	
	no.int <- ends < starts
	spans[no.int] <- NA
	starts[no.int] <- NA
	
	new("Interval", spans, start = starts, tzone = x@tzone) * sign(x@.Data)
})

#' @export
setGeneric("union")

#' @export
setMethod("union", signature(x = "Interval", y = "Interval"), function(x,y){
	first.x <- pmin(x@start, x@start + x@.Data)
	first.y <- pmin(y@start, y@start + y@.Data)
	last.x <- pmax(x@start, x@start + x@.Data)
	last.y <- pmax(y@start, y@start + y@.Data)
	
	starts <- pmin(first.x, first.y)
	ends <- pmax(last.x, last.y)

	spans <- as.numeric(ends) - as.numeric(starts) 
	
	no.overlap <- spans > (x@.Data + y@.Data)
	if(any(no.overlap[!is.na(no.overlap)])) 
		message("Union includes intervening time between intervals.")
	
	new("Interval", spans, start = starts, tzone = x@tzone) * sign(x@.Data)
})

#' @export
setGeneric("setdiff")

#' @export
setMethod("setdiff", signature(x = "Interval", y = "Interval"), function(x,y){
	if (any(y %within% x)) {
		stop(paste("Cases", which(y %within% x), 
			"result in discontinuous intervals."))
	}
	
	first.x <- pmin(x@start, x@start + x@.Data)
	first.y <- pmin(y@start, y@start + y@.Data)
	last.x <- pmax(x@start, x@start + x@.Data)
	last.y <- pmax(y@start, y@start + y@.Data)
	
	start <- first.x
	start[last.y %within% x] <- last.y[last.y %within% x]

	end <- last.x
	end[first.y %within% x] <- first.y[first.y %within% x]
	
	spans <- as.numeric(ends) - as.numeric(starts)
	
	new("Interval", spans, start = starts, tzone = x@tzone) * sign(x@.Data)
})


#' Tests whether a date or interval falls within an interval
#'
#' %within% returns TRUE is a falls within interval b, FALSE otherwise. 
#' If a is an interval, both its start and end dates must fall within b 
#' to return TRUE.
#'
#' @export "%within%"
#' @rdname within-interval
#' @aliases %within%,Interval,Interval-method
#' @aliases %within%,ANY,Interval-method
#' @param a An interval or date-time object
#' @param b An interval
#' @return A logical
setGeneric("%within%", function(a,b) standardGeneric("%within%"))

#' @export
setMethod("%within%", signature(b = "Interval"), function(a,b){
	if(!is.instant(a)) stop("Argument 1 is not a recognized date-time")
	a <- as.POSIXct(a)
	as.numeric(a) - as.numeric(b@start) <= b@.Data & as.numeric(a) - as.numeric(b@start) >= 0
})

#' @export
setMethod("%within%", signature(a = "Interval", b = "Interval"), function(a,b){
	as.numeric(a@start) - as.numeric(b@start) <= b@.Data & as.numeric(a@start) - as.numeric(b@start) >= 0
})
