#' @include timespans.r
#' @include util.r
#' @include durations.r
NULL

check_period <- function(object){
	errors <- character()
	if (!is.numeric(object@.Data)) {
		msg <- "seconds (.Data) value must be numeric."
		errors <- c(errors, msg)
	} 
	if (!is.numeric(object@year)) {
		msg <- "year value must be numeric."
		errors <- c(errors, msg)
	}
	if (!is.numeric(object@month)) {
		msg <- "year value must be numeric."
		errors <- c(errors, msg)
	}	
	if (!is.numeric(object@day)) {
		msg <- "year value must be numeric."
		errors <- c(errors, msg)
	}		
	if (!is.numeric(object@hour)) {
		msg <- "year value must be numeric."
		errors <- c(errors, msg)
	}		
	if (!is.numeric(object@minute)) {
		msg <- "year value must be numeric."
		errors <- c(errors, msg)		
	}	
	
	length(object@.Data) -> n
	lengths <- c(length(object@year), length(object@month), 
		length(object@day), length(object@hour), length(object@minute))
		
	if (any(lengths != n)) {
		msg <- paste("Inconsistent lengths: year = ", lengths[1], 
			", month = ", lengths[2], 
			", day = ", lengths[3], 
			", hour = ", lengths[4],
			", minute = ", lengths[5], 
			", second = ", n, 
			sep = "") 
		errors <- c(errors, msg)
	}
	
	values <- c(object@year, object@month, object@day, object@hour, object@minute, 
		object@.Data)
	if (sum(values - trunc(values))) {
		msg <- "periods must have integer values"
		errors <- c(errors, msg)
	}
	
	if (length(errors) == 0) 
		TRUE
	else
		errors
}

#' Period class
#'
#' Period is an S4 class that extends the \code{\link{Timespan-class}} class. 
#' Periods track the change in the "clock time" between two date-times. They 
#' are measured in common time related units: years, months, days, hours, 
#' minutes, and seconds. Each unit except for seconds must be expressed in 
#' integer values. 
#'
#' The exact length of a period is not defined until the period is placed at a 
#' specific moment of time. This is because the precise length of one year, 
#' month, day, etc. can change depending on when it occurs due to daylight savings,
#' leap years, and other conventions. A period can be 
#' associated with a specific moment in time by coercing it to an 
#' \code{\link{Interval-class}} object with \code{\link{as.interval}} or by adding 
#' it to a date-time with "+".
#'
#' Periods provide a method for measuring generalized timespans when we wish 
#' to model clock times. Periods will attain intuitive results at this task 
#' even when leap years, leap seconds, gregorian days, daylight savings 
#' changes, and other events happen uring the period. See 
#' \code{\link{Duration-class}} for an alternative way to measure timespans that 
#' allows precise comparisons between timespans. 
#'
#' Period class objects have six slots. 1) .Data, a numeric object. The 
#' apparent amount of seconds to add to the period. 2) minute, a numeric object. 
#' The apparent amount of minutes to add to the period. 3) hour, a numeric object. 
#' The apparent amount of hours to add to the period.4) day, a numeric object. 
#' The apparent amount of days to add to the period.5) month, a numeric object. 
#' The apparent amount of months to add to the period. 6) year, a numeric object. 
#' The apparent amount of years to add to the period.
#'
#'
#'
#' @name Period-class
#' @rdname Period-class
#' @exportClass Period
#' @aliases as.numeric,Period-method
#' @aliases show,Period-method
#' @aliases c,Period-method
#' @aliases rep,Period-method
#' @aliases [,Period-method
#' @aliases [<-,Period,Period-method
#' @aliases $,Period-method
#' @aliases $<-,Period-method
#' @aliases as.difftime,Period-method
#' @aliases +,Period,Duration-method
#' @aliases +,Period,Interval-method
#' @aliases +,Period,Period-method
#' @aliases +,Period,Date-method
#' @aliases +,Date,Period-method
#' @aliases +,Period,difftime-method
#' @aliases +,difftime,Period-method
#' @aliases +,Period,numeric-method
#' @aliases +,numeric,Period-method
#' @aliases +,Period,POSIXct-method
#' @aliases +,POSIXct,Period-method
#' @aliases +,Period,POSIXlt-method
#' @aliases +,POSIXlt,Period-method
#' @aliases /,Period,Duration-method
#' @aliases /,Period,Interval-method
#' @aliases /,Period,Period-method
#' @aliases /,Period,difftime-method
#' @aliases /,difftime,Period-method
#' @aliases /,Period,numeric-method
#' @aliases /,numeric,Period-method
#' @aliases *,Period,ANY-method
#' @aliases *,ANY,Period-method
#' @aliases -,Period,missing-method
#' @aliases -,ANY,Period-method
#' @aliases %%,Period,Duration-method
#' @aliases %%,Period,Interval-method
#' @aliases %%,Period,Period-method
#' @aliases >,Period,Period-method
#' @aliases >=,Period,Period-method
#' @aliases ==,Period,Period-method
#' @aliases !=,Period,Period-method
#' @aliases <=,Period,Period-method
#' @aliases <,Period,Period-method
#' @aliases >,Period,Duration-method
#' @aliases >=,Period,Duration-method
#' @aliases ==,Period,Duration-method
#' @aliases !=,Period,Duration-method
#' @aliases <=,Period,Duration-method
#' @aliases <,Period,Duration-method
#' @aliases >,Duration,Period-method
#' @aliases >=,Duration,Period-method
#' @aliases ==,Duration,Period-method
#' @aliases !=,Duration,Period-method
#' @aliases <=,Duration,Period-method
#' @aliases <,Duration,Period-method
setClass("Period", contains = c("Timespan", "numeric"), 
	representation(year = "numeric", month = "numeric", day = "numeric", 
		hour = "numeric", minute = "numeric"), 
	prototype(year = 0, month = 0, day = 0, hour = 0, minute = 0), 
	validity = check_period)

#' @export
setMethod("show", signature(object = "Period"), function(object){
	show <- vector(mode = "character")
	per.mat <- matrix(c(object@year, object@month, object@day, object@hour, 
		object@minute, object@.Data), ncol = 6) 
	colnames(per.mat) <- c("year", "month", "day", "hour", "minute", "second")
	
	for (i in 1:nrow(per.mat)){
		per <- per.mat[i,]
		per <- per[which(per != 0)]
		
		if (length(per) == 0) {
			show[i] <- "0 seconds"
		} else {
			singular <- names(per)
			plural <- paste(singular, "s", sep = "")
			IDs <- paste(per, ifelse(!is.na(per) & per == 1, singular, plural))
			
			if(length(IDs) == 1) {
				show[i] <- IDs
			} else {
				show[i] <- paste(paste(paste(IDs[-length(IDs)], collapse = ", "),
					IDs[length(IDs)], sep = " and "), "")  
			}
		}
	}
	print(show, quote = FALSE)
})

#' @S3method format Period
format.Period <- function(x, ...){
	show <- vector(mode = "character")
	per.mat <- matrix(c(x@year, x@month, x@day, x@hour, 
		x@minute, x@.Data), ncol = 6) 
	colnames(per.mat) <- c("year", "month", "day", "hour", "minute", "second")
	
	for (i in 1:nrow(per.mat)){
		per <- per.mat[i,]
		per <- per[which(per != 0)]
		
		if (length(per) == 0) {
			show[i] <- "0 seconds"
		} else {
			singular <- names(per)
			plural <- paste(singular, "s", sep = "")
			IDs <- paste(per, ifelse(!is.na(per) & per == 1, singular, plural))
			
			if(length(IDs) == 1) {
				show[i] <- IDs
			} else {
				show[i] <- paste(paste(paste(IDs[-length(IDs)], collapse = ", "),
					IDs[length(IDs)], sep = " and "), "")  
			}
		}
	}
	show
}

#' @export
setMethod("c", signature(x = "Period"), function(x, ...){
	seconds <- c(x@.Data, unlist(list(...)))
	years <- c(x@year, unlist(lapply(list(...), slot, "year")))
	months <- c(x@month, unlist(lapply(list(...), slot, "month"))) 
	days <- c(x@day, unlist(lapply(list(...), slot, "day")))
	hours <- c(x@month, unlist(lapply(list(...), slot, "hour")))
	minutes <- c(x@month, unlist(lapply(list(...), slot, "minute")))
	new("Period", seconds, year = years, month = months, day = days, 
		hour = hours, minute = minutes)
})

#' @export
setMethod("rep", signature(x = "Period"), function(x, ...){
	new("Period", rep(x@.Data, ...), year = rep(x@year, ...), 
		month = rep(x@month, ...), day = rep(x@day, ...), 
		hour = rep(x@hour, ...), minute = rep(x@minute, ...))
})

#' @export
setMethod("[", signature(x = "Period"), 
  function(x, i, j, ..., drop = TRUE) {
    new("Period", x@.Data[i], year = x@year[i], month = x@month[i], 
    	day = x@day[i], hour = x@hour[i], minute = x@minute[i])
})

#' @export
setMethod("[<-", signature(x = "Period", i = "Period"), 
  function(x, i, j, ..., value) {
  	x@.Data[i] <- value@.Data
  	x@year[i] <- value@year
  	x@month[i] <- value@month
  	x@day[i] <- value@day 
  	x@hour[i] <- value@hour
  	x@minute[i] <- value@minute
    x
})

#' @export
setMethod("$", signature(x = "Period"), function(x, name) {
	if (name == "second") name <- ".Data"
    slot(x, name)
})

#' @export
setMethod("$<-", signature(x = "Period"), function(x, name, value) {
	if (name == "second") name <- ".Data"
    slot(x, name) <- value
    x
})

#' Create a period object.
#'
#' new_period creates a period object with the specified values. Within a 
#' Period object, time units do not have a fixed length (except for seconds) 
#' until they are added to a date-time. The length of each time unit will 
#' depend on the date-time to which it is added. For example, a year that 
#' begins on 2009-01-01 will be 365 days long.  A year that begins on 
#' 2012-01-01 will be 366 days long. When math is performed with a period 
#' object, each unit is applied separately. How the length of a period is 
#' distributed among 
#' its units is non-trivial. For example, when leap seconds occur 1 minute 
#' is longer than 60 seconds.
#'
#' Periods track the change in the "clock time" between two date-times. They 
#' are measured in common time related units: years, months, days, hours, 
#' minutes, and seconds. Each unit except for seconds must be expressed in 
#' integer values. 
#'
#' Period objects can be easily created with the helper functions 
#' \code{\link{years}}, \code{\link{months}}, \code{\link{weeks}}, 
#' \code{\link{days}}, \code{\link{minutes}}, \code{\link{seconds}}. These objects 
#' can be added to and subtracted to date-times to create a user interface 
#' similar to object oriented programming.
#'
#' new_period is meant to be used interactively on the command line. See 
#' \code{\link{period}}, for a version that is better suited to automating 
#' within a function.
#'
#' @export new_period
#' @aliases new_period
#' @param ... a list of time units to be included in the period and their amounts. Seconds, minutes, 
#'   hours, days, weeks, months, and years are supported.
#' @return a period object
#' @seealso \code{\link{period}}, \code{\link{as.period}}
#' @keywords chron classes
#' @examples
#' new_period (second = 90, minute = 5)
#' #  5 minutes and 90 seconds
#' new_period(day = -1)
#' # -1 days
#' new_period(second = 3, minute = 1, hour = 2, day = 13, week = 1)
#' # 13 days, 2 hours, 1 minute and 3 seconds
#' new_period(hour = 1, minute = -60)
#' # 1 hour and -60 minutes
#' new_period(second = 0)
#' # 0 seconds
new_period <- period <- function(...) {
  pieces <- data.frame(...)
    
  names(pieces) <- standardise_date_names(names(pieces))
  defaults <- data.frame(
    second = 0, minute = 0, hour = 0, day = 0, week = 0, 
    month = 0, year = 0
  )
  
  pieces <- cbind(pieces, defaults[setdiff(names(defaults), names(pieces))])
  pieces <- pieces[c("year", "month", "week", "day", "hour", "minute", "second")] 
  
  pieces$day <- pieces$day + pieces$week * 7
  pieces <- pieces[,-3]
  
  if(any(trunc(pieces[,1:5]) - pieces[,1:5] != 0))
    stop("periods must have integer values", call. = FALSE)
  
  new("Period", pieces$second, year = pieces$year, month = pieces$month, 
  	day = pieces$day, hour = pieces$hour, minute = pieces$minute)
}


#' Create a period object.
#'
#' period creates a period object with the specified values. period provides the 
#' behaviour of \code{\link{new_period}} in a way that is more suitable for automating 
#' within a function.
#'
#' Within a 
#' Period object, time units do not have a fixed length (except for seconds) 
#' until they are added to a date-time. The length of each time unit will 
#' depend on the date-time to which it is added. For example, a year that 
#' begins on 2009-01-01 will be 365 days long.  A year that begins on 
#' 2012-01-01 will be 366 days long. When math is performed with a period 
#' object, each unit is applied separately. How the length of a period is 
#' distributed among 
#' its units is non-trivial. For example, when leap seconds occur 1 minute 
#' is longer than 60 seconds.
#'
#' Periods track the change in the "clock time" between two date-times. They 
#' are measured in common time related units: years, months, days, hours, 
#' minutes, and seconds. Each unit except for seconds must be expressed in 
#' integer values. 
#'
#' Period objects can be easily created with the helper functions 
#' \code{\link{years}}, \code{\link{months}}, \code{\link{weeks}}, 
#' \code{\link{days}}, \code{\link{minutes}}, \code{\link{seconds}}. These objects 
#' can be added to and subtracted to date-times to create a user interface 
#' similar to object oriented programming.
#'
#' @export period
#' @aliases period
#' @param num a numeric vector that lists the number of time units to be included in the period
#' @param units a character vector that lists the type of units to be used. The units in units are matched to the values in num according to their order.
#' @return a period object
#' @seealso \code{\link{new_period}}, \code{\link{as.period}}
#' @keywords chron classes
#' @examples
#' period(c(90, 5), c("second", "minute"))
#' #  5 minutes and 90 seconds
#' period(-1, "days")
#' # -1 days
#' period(c(3, 1, 2, 13, 1), c("second", "minute", "hour", "day", "week"))
#' # 13 days, 2 hours, 1 minute and 3 seconds
#' period(c(1, -60), c("hour", "minute"))
#' # 1 hour and -60 minutes
#' period(0, "second")
#' # 0 seconds
period <- function(num, units = "second") {
	if (length(units) %% length(num) != 0)
		stop("arguments must have same length")
		
	num <- num + rep(0, length(units))
	unit <- standardise_date_names(units)
	pieces <- setNames(as.list(num), unit)
	
	defaults <- list(second = 0, minute = 0, hour = 0, day = 0, week = 0, 
    	month = 0, year = 0)
    pieces <- c(pieces, defaults[setdiff(names(defaults), names(pieces))])
		
	new("Period", pieces$second, year = pieces$year, month = pieces$month, 
  		day = pieces$day, hour = pieces$hour, minute = pieces$minute)
}

#' Quickly create relative timespans.
#'
#' Quickly create Period objects for easy date-time manipulation. The units of 
#' the period created depend on the name of the function called. For Period 
#' objects, units do not have a fixed length until they are added to a specific 
#' date time, contrast this with \code{\link{new_duration}}. This makes periods 
#' useful for manipulations with clock times because units expand or contract 
#' in length to accomodate conventions such as leap years, leap seconds, and 
#' Daylight Savings Time. 
#'
#' When paired with date-times, these functions allow date-times to be 
#' manipulated in a method similar to object oriented programming. Period 
#' objects can be added to Date, POSIXct, and POSIXlt objects to calculate new 
#' date-times.
#'
#' @export seconds minutes hours days weeks years milliseconds microseconds microseconds nanoseconds picoseconds
#' @aliases seconds minutes hours days weeks years milliseconds microseconds microseconds nanoseconds picoseconds
#' @S3method months numeric
#' @S3method months integer
#' @param x numeric value of the number of units to be contained in the period. With the exception 
#'   of seconds(), x must be an integer. 
#' @return a period object
#' @seealso \code{\link{Period-class}}, \code{\link{new_period}}, \code{\link{ddays}}
#' @keywords chron manip
#' @examples
#'
#' x <- as.POSIXct("2009-08-03") 
#' # "2009-08-03 CDT"
#' x + days(1) + hours(6) + minutes(30)
#' # "2009-08-04 06:30:00 CDT"
#' x + days(100) - hours(8) 
#' # "2009-11-10 15:00:00 CST"
#' 
#' class(as.Date("2009-08-09") + days(1)) # retains Date class
#' # "Date"
#' as.Date("2009-08-09") + hours(12) 
#' # "2009-08-09 12:00:00 UTC"
#' class(as.Date("2009-08-09") + hours(12)) 
#' # "POSIXt"  "POSIXct"
#' # converts to POSIXt class to accomodate time units
#' 
#' years(1) - months(7) 
#' # 1 year and -7 months
#' c(1:3) * hours(1) 
#' # 1 hour   2 hours   3 hours
#' hours(1:3)
#' # 1 hour   2 hours   3 hours
#'
#' #sequencing
#' y <- ymd(090101) # "2009-01-01 CST"
#' y + months(0:11)
#' # [1] "2009-01-01 CST" "2009-02-01 CST" "2009-03-01 CST" "2009-04-01 CDT"
#' # [5] "2009-05-01 CDT" "2009-06-01 CDT" "2009-07-01 CDT" "2009-08-01 CDT"
#' # [9] "2009-09-01 CDT" "2009-10-01 CDT" "2009-11-01 CDT" "2009-12-01 CST"
#' 
#' # end of month handling
#' ymd(20090131) + months(0:11)
#' # Undefined date. Defaulting to last previous real day.
#' # [1] "2009-01-31 CST" "2009-02-28 CST" "2009-03-31 CDT" "2009-04-30 CDT"
#' # [5] "2009-05-31 CDT" "2009-06-30 CDT" "2009-07-31 CDT" "2009-08-31 CDT"
#' # [9] "2009-09-30 CDT" "2009-10-31 CDT" "2009-11-30 CST" "2009-12-31 CST"
#' 
#' # compare DST handling to durations
#' boundary <- as.POSIXct("2009-03-08 01:59:59")
#' # "2009-03-08 01:59:59 CST"
#' boundary + days(1) # period
#' # "2009-03-09 01:59:59 CDT" (clock time advances by a day)
#' boundary + edays(1) # duration
#' # "2009-03-09 02:59:59 CDT" (clock time corresponding to 86400 seconds later)
seconds <- function(x = 1) new_period(second = x)
minutes <- function(x = 1) new_period(minute = x)
hours <-   function(x = 1) new_period(hour = x)
days <-    function(x = 1) new_period(day = x)  
weeks <-   function(x = 1) new_period(week = x)
months.numeric <- months.integer <- function(x, abbreviate) new_period(month = x)
years <-   function(x = 1) new_period(year = x)
milliseconds <- function(x = 1) seconds(x/1000)
microseconds <- function(x = 1) seconds(x/1000000)
nanoseconds <- function(x = 1) seconds(x/1e9)
picoseconds <- function(x = 1) seconds(x/1e12)


#' Is x a period object?
#'
#' @export is.period
#' @param x an R object   
#' @return TRUE if x is a period object, FALSE otherwise.
#' @seealso \code{\link{is.instant}}, \code{\link{is.timespan}}, \code{\link{is.interval}}, 
#'   \code{\link{is.duration}}, \code{\link{period}}
#' @keywords logic chron
#' @examples
#' is.period(as.Date("2009-08-03")) # FALSE
#' is.period(new_period(months= 1, days = 15)) # TRUE
is.period <- function(x) is(x,"Period")






#' Convert a period to the number of units it appears to represent
#'
#' @param x A period object
#' @export
period_to_seconds <- function(x) {
	x@.Data + 
	60 * x@minute +
	60 * 60 * x@hour +
	60 * 60 * 24 * x@day +
	60 * 60 * 24 * 365 / 12 * x@month +
	60 * 60 * 24 * 365 * x@year
}
	
#' @export
setMethod(">", signature(e1 = "Period", e2 = "Period"), 
	function(e1, e2) {
	 period_to_seconds(e1) > period_to_seconds(e2)
})

#' @export
setMethod(">=", signature(e1 = "Period", e2 = "Period"), 
	function(e1, e2) {
	 period_to_seconds(e1) >= period_to_seconds(e2)
})

#' @export
setMethod("==", signature(e1 = "Period", e2 = "Period"), 
	function(e1, e2) {
	 period_to_seconds(e1) == period_to_seconds(e2)
})

#' @export
setMethod("!=", signature(e1 = "Period", e2 = "Period"), 
	function(e1, e2) {
	 period_to_seconds(e1) != period_to_seconds(e2)
})

#' @export
setMethod("<=", signature(e1 = "Period", e2 = "Period"), 
	function(e1, e2) {
	 period_to_seconds(e1) <= period_to_seconds(e2)
})

#' @export
setMethod("<", signature(e1 = "Period", e2 = "Period"), 
	function(e1, e2) {
	 period_to_seconds(e1) < period_to_seconds(e2)
})

#' @export
setMethod(">", signature(e1 = "Period", e2 = "Duration"), 
	function(e1, e2) {
	 stop("cannot compare Period to Duration:\ncoerce with as.duration")
})

#' @export
setMethod(">=", signature(e1 = "Period", e2 = "Duration"), 
	function(e1, e2) {
	 stop("cannot compare Period to Duration:\ncoerce with as.duration")})

#' @export
setMethod("==", signature(e1 = "Period", e2 = "Duration"), 
	function(e1, e2) {
	 stop("cannot compare Period to Duration:\ncoerce with as.duration")})

#' @export
setMethod("!=", signature(e1 = "Period", e2 = "Duration"), 
	function(e1, e2) {
	 stop("cannot compare Period to Duration:\ncoerce with as.duration")
})

#' @export
setMethod("<=", signature(e1 = "Period", e2 = "Duration"), 
	function(e1, e2) {
	 stop("cannot compare Period to Duration:\ncoerce with as.duration")
})

#' @export
setMethod("<", signature(e1 = "Period", e2 = "Duration"), 
	function(e1, e2) {
	 stop("cannot compare Period to Duration:\ncoerce with as.duration")})

#' @export
setMethod(">", signature(e1 = "Duration", e2 = "Period"), 
	function(e1, e2) {
	 stop("cannot compare Period to Duration:\ncoerce with as.duration")
})

#' @export
setMethod(">=", signature(e1 = "Duration", e2 = "Period"), 
	function(e1, e2) {
	 stop("cannot compare Period to Duration:\ncoerce with as.duration")})

#' @export
setMethod("==", signature(e1 = "Duration", e2 = "Period"), 
	function(e1, e2) {
	 stop("cannot compare Period to Duration:\ncoerce with as.duration")
})

#' @export
setMethod("!=", signature(e1 = "Duration", e2 = "Period"), 
	function(e1, e2) {
	 stop("cannot compare Period to Duration:\ncoerce with as.duration")
})

#' @export
setMethod("<=", signature(e1 = "Duration", e2 = "Period"), 
	function(e1, e2) {
	 stop("cannot compare Period to Duration:\ncoerce with as.duration")
})

#' @export
setMethod("<", signature(e1 = "Duration", e2 = "Period"), 
	function(e1, e2) {
	 stop("cannot compare Period to Duration:\ncoerce with as.duration")
})
	
