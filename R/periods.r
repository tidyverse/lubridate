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
	
  values <- c(object@year, object@month, object@day, object@hour, object@minute)
	values <- na.omit(values)
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
#' changes, and other events happen during the period. See 
#' \code{\link{Duration-class}} for an alternative way to measure timespans that 
#' allows precise comparisons between timespans. 
#' 
#' The logic that guides arithmetic with periods can be unintuitive. Starting 
#' with version 1.3.0, lubridate enforces the reversible property of arithmetic 
#' (e.g. a date + period - period = date)
#' by returning an NA if you create an implausible date by adding periods with 
#' months or years units to a date. For example, 
#' adding one month to January 31st, 2013 results in February 31st, 2013, which 
#' is not a real date. lubridate users have argued in the past that February 
#' 31st, 2013 should be rolled over to March 3rd, 2013 or rolled back to February 
#' 28, 2013. However, each of these corrections would destroy the reversibility 
#' of addition (Mar 3 - one month == Feb 3 != Jan 31, Feb 28 - one month == Jan 
#' 28 != Jan 31). If you would like to add and subtract months in a way that rolls 
#' the results back to the last day of a month (when appropriate) use the special 
#' operators, \code{\link{\%m+\%}} and \code{\link{\%m-\%}}.
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
#' @aliases second,Period-method
#' @aliases second<-,Period-method
#' @aliases minute,Period-method
#' @aliases minute<-,Period-method
#' @aliases hour,Period-method
#' @aliases hour<-,Period-method
#' @aliases day,Period-method
#' @aliases day<-,Period-method
#' @aliases month,Period-method
#' @aliases month<-,Period-method
#' @aliases year,Period-method
#' @aliases year<-,Period-method
#' @aliases as.numeric,Period-method
#' @aliases show,Period-method
#' @aliases c,Period-method
#' @aliases rep,Period-method
#' @aliases [,Period-method
#' @aliases [<-,Period,ANY,ANY,Period-method
#' @aliases [[,Period-method
#' @aliases [[<-,Period,ANY,ANY,Period-method
#' @aliases $,Period-method
#' @aliases $<-,Period-method
#' @aliases as.difftime,Period-method
#' @aliases as.character,Period-method
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
#' @aliases >,Period,numeric-method
#' @aliases >=,Period,numeric-method
#' @aliases ==,Period,numeric-method
#' @aliases !=,Period,numeric-method
#' @aliases <=,Period,numeric-method
#' @aliases <,Period,numeric-method
#' @aliases >,numeric,Period-method
#' @aliases >=,numeric,Period-method
#' @aliases ==,numeric,Period-method
#' @aliases !=,numeric,Period-method
#' @aliases <=,numeric,Period-method
#' @aliases <,numeric,Period-method
setClass("Period", contains = c("Timespan", "numeric"), 
	slots = c(year = "numeric", month = "numeric", day = "numeric", 
		hour = "numeric", minute = "numeric"), 
	prototype = prototype(year = 0, month = 0, day = 0, hour = 0, minute = 0), 
	validity = check_period)

#' @export
setMethod("show", signature(object = "Period"), function(object){
  print(format(object))
})

#' @S3method format Period
format.Period <- function(x, ...){
  if (length(x@.Data) == 0) return("Period(0)")
  show <- vector(mode = "character")
  na <- is.na(x)
  
  show <- paste(x@year, "y ", x@month, "m ", x@day, "d ",
    x@hour, "H ", x@minute, "M ", x@.Data, "S", sep="")
  start <- regexpr("[-1-9]", show)
  show <- ifelse(start > 0, substr(show, start, nchar(show)), "0S")
                 
  show[na] <- NA
  show
}

#' @S3method xtfrm Period
xtfrm.Period <- function(x){
  xtfrm(period_to_seconds(x))
}

#' @export
setMethod("c", signature(x = "Period"), function(x, ...){
  elements <- lapply(list(...), as.period)
	seconds <- c(x@.Data, unlist(lapply(elements, slot, ".Data")))
	years <- c(x@year, unlist(lapply(elements, slot, "year")))
	months <- c(x@month, unlist(lapply(elements, slot, "month"))) 
	days <- c(x@day, unlist(lapply(elements, slot, "day")))
	hours <- c(x@hour, unlist(lapply(elements, slot, "hour")))
	minutes <- c(x@minute, unlist(lapply(elements, slot, "minute")))
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
setMethod("[[", signature(x = "Period"), 
          function(x, i, j, ..., exact = TRUE) {
            new("Period", x@.Data[i], year = x@year[i], month = x@month[i], 
                day = x@day[i], hour = x@hour[i], minute = x@minute[i])
})

#' @export
setMethod("[<-", signature(x = "Period", value = "Period"), 
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
setMethod("[[<-", signature(x = "Period", value = "Period"), 
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
#' # "5M 90S"
#' new_period(day = -1)
#' # "-1d 0H 0M 0S"
#' new_period(second = 3, minute = 1, hour = 2, day = 13, week = 1)
#' # "20d 2H 1M 3S"
#' new_period(hour = 1, minute = -60)
#' # "1H -60M 0S"
#' new_period(second = 0)
#' # "0S"
new_period <- function(...) {
  pieces <- data.frame(lapply(list(...), as.numeric))
  
  names(pieces) <- standardise_date_names(names(pieces))
  defaults <- data.frame(
    second = 0, minute = 0, hour = 0, day = 0, week = 0, 
    month = 0, year = 0
  )
  
  pieces <- cbind(pieces, defaults[setdiff(names(defaults), names(pieces))])
  ## pieces <- pieces[c("year", "month", "week", "day", "hour", "minute", "second")] 
  
  pieces$day <- pieces$day + pieces$week * 7

  na <- is.na(rowSums(pieces))
  pieces$second[na] <- NA ## if any of supplied pieces is NA whole vector should be NA

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
#' @param units a character vector that lists the type of units to be used. The units in units 
#' are matched to the values in num according to their order.
#' @return a period object
#' @seealso \code{\link{new_period}}, \code{\link{as.period}}
#' @keywords chron classes
#' @examples
#' period(c(90, 5), c("second", "minute"))
#' #  "5M 90S"
#' period(-1, "days")
#' # "-1d 0H 0M 0S"
#' period(c(3, 1, 2, 13, 1), c("second", "minute", "hour", "day", "week"))
#' # "20d 2H 1M 3S"
#' period(c(1, -60), c("hour", "minute"))
#' # "1H -60M 0S"
#' period(0, "second")
#' # "0S"
period <- function(num, units = "second") {
	if (length(units) %% length(num) != 0)
		stop("arguments must have same length")
		
	num <- num + rep(0, length(units))
	unit <- standardise_date_names(units)
	pieces <- setNames(as.list(num), unit)
	
	defaults <- list(second = 0, minute = 0, hour = 0, day = 0, week = 0, 
    	month = 0, year = 0)
    pieces <- c(pieces, defaults[setdiff(names(defaults), names(pieces))])
    pieces$day <- pieces$day + 7 * pieces$week
		
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
#' # "1y -7m 0d 0H 0M 0S"
#' c(1:3) * hours(1) 
#' # "1H 0M 0S" "2H 0M 0S" "3H 0M 0S"
#' hours(1:3)
#' # "1H 0M 0S" "2H 0M 0S" "3H 0M 0S"
#'
#' #sequencing
#' y <- ymd(090101) # "2009-01-01 CST"
#' y + months(0:11)
#' # [1] "2009-01-01 CST" "2009-02-01 CST" "2009-03-01 CST" "2009-04-01 CDT"
#' # [5] "2009-05-01 CDT" "2009-06-01 CDT" "2009-07-01 CDT" "2009-08-01 CDT"
#' # [9] "2009-09-01 CDT" "2009-10-01 CDT" "2009-11-01 CDT" "2009-12-01 CST"
#' 
#' # compare DST handling to durations
#' boundary <- as.POSIXct("2009-03-08 01:59:59")
#' # "2009-03-08 01:59:59 CST"
#' boundary + days(1) # period
#' # "2009-03-09 01:59:59 CDT" (clock time advances by a day)
#' boundary + edays(1) # duration
#' # "2009-03-09 02:59:59 CDT" (clock time corresponding to 86400 
#' # seconds later)
seconds <- function(x = 1) new_period(second = x)
minutes <- function(x = 1) new_period(minute = x)
hours <-   function(x = 1) new_period(hour = x)
days <-    function(x = 1) new_period(day = x)  
weeks <-   function(x = 1) new_period(week = x)
months.numeric <- months.integer <- function(x, abbreviate) {
  new_period(month = x)
}
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
#' @seealso \code{\link{is.instant}}, \code{\link{is.timespan}}, 
#' \code{\link{is.interval}}, 
#'   \code{\link{is.duration}}, \code{\link{period}}
#' @keywords logic chron
#' @examples
#' is.period(as.Date("2009-08-03")) # FALSE
#' is.period(new_period(months= 1, days = 15)) # TRUE
is.period <- function(x) is(x,"Period")






#' Convert a period to the number of seconds it appears to represent
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

#' Contrive a period from a given number of seconds
#' 
#' seconds_to_period uses estimates of time elements (in seconds) to create the 
#' period that has the maximum number of large elements(years > months > days > 
#' hours > minutes > seconds) and roughly equates to a given number of seconds. 
#' Note that the actual number of seconds in a period depends on when the period 
#' occurs. Since there is no one-to-one relationship between the periods that 
#' seconds_to_period makes and the number of seconds given as input, these 
#' periods should be treated as rough estimates only. 
#'
#' @param x A numeric object. The number of seconds to coerce into a period.
#' @return A period that roughly equates to the number of seconds given.
#' @export
seconds_to_period <- function(x) {
  span <- as.double(x)
  remainder <- abs(span)
  newper <- new_period(second = rep(0, length(x)))
  
  slot(newper, "year") <- remainder %/% (3600 * 24 * 365.25)
  remainder <- remainder %% (3600 * 24 * 365.25)
  
  slot(newper,"day") <- remainder %/% (3600 * 24)
  remainder <- remainder %% (3600 * 24)
  
  slot(newper, "hour") <- remainder %/% (3600)
  remainder <- remainder %% (3600)
  
  slot(newper, "minute") <- remainder %/% (60)
  
  slot(newper, ".Data") <- remainder %% (60)
  
  newper * sign(span)
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

#' @export
setMethod(">", signature(e1 = "Period", e2 = "numeric"), 
          function(e1, e2) {
            stop("cannot compare Period to numeric:\ncoerce with as.numeric")
          })

#' @export
setMethod(">=", signature(e1 = "Period", e2 = "numeric"), 
          function(e1, e2) {
            stop("cannot compare Period to numeric:\ncoerce with as.numeric")})

#' @export
setMethod("==", signature(e1 = "Period", e2 = "numeric"), 
          function(e1, e2) {
            stop("cannot compare Period to numeric:\ncoerce with as.numeric")})

#' @export
setMethod("!=", signature(e1 = "Period", e2 = "numeric"), 
          function(e1, e2) {
            stop("cannot compare Period to numeric:\ncoerce with as.numeric")
          })

#' @export
setMethod("<=", signature(e1 = "Period", e2 = "numeric"), 
          function(e1, e2) {
            stop("cannot compare Period to numeric:\ncoerce with as.numeric")
          })

#' @export
setMethod("<", signature(e1 = "Period", e2 = "numeric"), 
          function(e1, e2) {
            stop("cannot compare Period to numeric:\ncoerce with as.numeric")})

#' @export
setMethod(">", signature(e1 = "numeric", e2 = "Period"), 
          function(e1, e2) {
            stop("cannot compare Period to numeric:\ncoerce with as.numeric")
          })

#' @export
setMethod(">=", signature(e1 = "numeric", e2 = "Period"), 
          function(e1, e2) {
            stop("cannot compare Period to numeric:\ncoerce with as.numeric")})

#' @export
setMethod("==", signature(e1 = "numeric", e2 = "Period"), 
          function(e1, e2) {
            stop("cannot compare Period to numeric:\ncoerce with as.numeric")
          })

#' @export
setMethod("!=", signature(e1 = "numeric", e2 = "Period"), 
          function(e1, e2) {
            stop("cannot compare Period to numeric:\ncoerce with as.numeric")
          })

#' @export
setMethod("<=", signature(e1 = "numeric", e2 = "Period"), 
          function(e1, e2) {
            stop("cannot compare Period to numeric:\ncoerce with as.numeric")
          })

#' @export
setMethod("<", signature(e1 = "numeric", e2 = "Period"), 
          function(e1, e2) {
            stop("cannot compare Period to numeric:\ncoerce with as.numeric")
          })

	
#' @S3method summary Period
summary.Period <- function(object, ...) {
  nas <- is.na(object)
  object <- object[!nas]
  persecs <- period_to_seconds(object)
  qq <- stats::quantile(persecs)
  qq <- c(qq[1L:3L], mean(persecs), qq[4L:5L])
  qq <- seconds_to_period(qq)
  qq <- as.character(qq)
  names(qq) <- c("Min.", "1st Qu.", "Median", "Mean", "3rd Qu.", 
                 "Max.")
  if (any(nas)) 
    c(qq, `NA's` = sum(nas))
  else qq
}


