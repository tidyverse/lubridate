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

setClass("Interval", contains = c("Timespan", "numeric"), representation(start = "POSIXct", 	tzone = "character"), validity = check_interval)

setMethod("show", signature(object = "Interval"), function(object){
	print(paste(format(object@start, tz = object@tzone, usetz = TRUE), "--", 
		format(object@start + object@.Data, tz = object@tzone, usetz = TRUE), sep = ""))
})

format.Interval <- function(x,...){
	paste(format(x@start, tz = x@tzone, usetz = TRUE), "--", 
		format(x@start + x@.Data, tz = x@tzone, usetz = TRUE), sep = "")
}

setMethod("c", signature(x = "Interval"), function(x, ...){
	spans <- c(x@.Data, unlist(list(...)))
	starts <- c(x@start, unlist(lapply(list(...), int_start)))
	new("Interval", spans, start = starts, tzone = x@tzone)
})


setMethod("rep", signature(x = "Interval"), function(x, ...){
	new("Interval", rep(x@.Data, ...), start = rep(x@start,...), tzone = x@tzone)
})

setMethod("[", representation(x = "Interval"), 
	function(x, i, j, ..., drop = TRUE) {
    	new("Interval", x@.Data[i], start = x@start[i], tzone = x@tzone)
	}
)

setMethod("[<-", representation(x = "Interval"), function(x, i, j, ..., value) {
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

setMethod("$", representation(x = "Interval"), function(x, name) {
	if(name == "span") name <- ".Data"
	slot(x, name)
})

setMethod("$<-", representation(x = "Interval"), function(x, name, value) {
	if(name == "span") name <- ".Data"
	slot(x, name) <- value
	x
})

#' Create an interval object.
#'
#' new_interval creates an interval object with the specified start and end 
#' dates. new_interval automatically assigns the date that occurs first in time as the 
#' start date and the date that occurs later as the end date. As a result, intervals are always positive.
#'
#' Intervals are time spans bound by two real date-times.  Intervals can be 
#' accurately converted to either period or duration objects using 
#' \code{\link{as.period}}, \code{\link{as.duration}}. Since an interval is
#' anchored to a fixed history of time, both the exact number of seconds that passed
#' and the number of variable length time units that occurred during the interval can be
#' calculated.  Subtracting two date times automatically creates an interval
#' object. 
#'
#' @export new_interval
#' @S3method "%%" interval
#' @S3method "%/%" interval
#' @S3method "/" interval
#' @S3method "*" interval
#' @S3method "+" interval
#' @S3method "-" interval
#' @S3method rep interval
#' @S3method "[" interval
#' @S3method c interval
#' @S3method format interval
#' @S3method print interval
#' @param date1 a POSIXt or Date date-time object
#' @param date2 a POSIXt or Date date-time object
#' @return an interval object
#' @seealso \code{\link{interval}}, \code{\link{as.interval}}
#' @keywords chron classes
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


#' Is x an interval object?
#'
#' @export is.interval
#' @param x an R object   
#' @return TRUE if x is an interval object, FALSE otherwise.
#' @seealso \code{\link{is.instant}}, \code{\link{is.timespan}}, \code{\link{is.period}}, 
#'   \code{\link{is.duration}}, \code{\link{interval}}
#' @keywords logic chron
#' @examples
#' is.interval(new_period(months= 1, days = 15)) # FALSE
#' is.interval(new_interval(ymd(20090801), ymd(20090809))) # TRUE
is.interval <- function(x) is(x, c("Interval"))




#' Access and change the start date of an interval
#'
#' Changing the start date of an interval does not change the length of 
#' the interval. It shifts when the interval occurs.
#'
#' @aliases int_start int_start<-
#' @export int_start "int_start<-"
#' @param x An interval object
#' @return A POSIXct date object when used as an accessor. Nothing when used as a settor
#' @examples
#' int <- new_interval(ymd("2001-01-01"), ymd("2002-01-01"))
#' # 2001-01-01 -- 2002-01-01
#' int_start(int)
#' # "2001-01-01 UTC"
#' int_start(int) <- ymd("2001-06-01")
#' int
#' # 2001-06-01 -- 2002-06-01
int_start <- function(x) x@start
	
"int_start<-" <- function(int, value){
	equal.lengths <- data.frame(int, value)
	int <- new("Interval", int@.Data, start = equal.lengths$value, 
		tzone = int@tzone)
}	


	

# WHY DON"T THESE JUST DIRECTLY ALTER THE START AND END DATES?

#' Access and change the end date of an interval
#'
#' Changing the end date of an interval does not change the length of 
#' the interval. It shifts when the interval occurs.
#'
#' @aliases int_end int_end<-
#' @export int_end "int_end<-"
#' @param x An interval object
#' @return A POSIXct date object when used as an accessor. Nothing when used as a settor
#' @examples
#' int <- new_interval(ymd("2001-01-01"), ymd("2002-01-01"))
#' # 2001-01-01 -- 2002-01-01
#' int_end(int)
#' # "2002-01-01 UTC"
#' int_end(int) <- ymd("2002-06-01")
#' int
#' # 2001-06-01 -- 2002-06-01
int_end <- function(x) x@start + x@.Data

"int_end<-" <- function(int, value){
	equal.lengths <- data.frame(int, value)
	int <- new("Interval", int@.Data, start = value - int@.Data,
		tzone = int@tzone)
}


#' returns an interval with the same sign as the first interval
setGeneric("intersect")
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

setGeneric("union")
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

setGeneric("setdiff")
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


#' Shifts an interval up or down the timeline by a specified amount
#' note this may change the exact length of the interval
flip <- function(int){
	new("Interval", -int@.Data, start = int@start + int@.Data, tzone = int@tzone)
}


#' Shifts an interval up or down the timeline by a specified amount
#' note this may change the exact length of the interval
shift <- function(int, by){
	if(!is.timespan(by)) stop("by is not a recognized timespan object")
	if(is.interval(by)) stop("an interval cannot be shifted by another interval. 
		Convert second interval to a period or duration.")
	new_interval(int@start + by, int_end(int) + by)
}

#' Tests whether a date falls within a given interval
setGeneric("%within%", function(a,b) standardGeneric("%within%"))
setMethod("%within%", signature(b = "Interval"), function(a,b){
	if(!is.instant(a)) stop("Argument 1 is not a recognized date-time")
	a <- as.POSIXct(a)
	as.numeric(a) - as.numeric(b@start) <= b@.Data & as.numeric(a) - as.numeric(b@start) >= 0
})

setMethod("%within%", signature(a = "Interval", b = "Interval"), function(a,b){
	as.numeric(a@start) - as.numeric(b@start) <= b@.Data & as.numeric(a@start) - as.numeric(b@start) >= 0
})

#' Creates an interval from two dates
"%--%" <- function(e1, e2) interval(e1, e2)

#' detects if two intervals overlap
overlaps <- function(int1, int2){
	stopifnot(c(is.interval(int1), is.interval(int2)))
	int1@start <= int2@start + int2@.Data & int2@start <= int1@start + int1@.Data
}