#' @include timespans.r

check_duration <- function(object){
	if (is.numeric(object@.Data))
		TRUE
	else
		"Duration value is not a number. Should be numeric."
}


#' Duration class
#'
#' Duration is an S4 class that extends the \code{\link{Timespan-class}} class. 
#' Durations record the exact number of seconds in a time span. They measure the 
#' exact passage of time but do not always align with measurements 
#' made in larger units of time such as hours, months and years. 
#' This is because the length of larger time units can be affected 
#' by conventions such as leap years 
#' and Daylight Savings Time. 
#' 
#' Durations provide a method for measuring generalized timespans when we wish to 
#' treat time as a mathematical quantity that increases in a uniform, monotone manner 
#' along a continuous numberline. They allow exact comparisons with other durations. 
#' See \code{\link{Period-class}} for an alternative way to measure timespans that better 
#' preserves clock times. 
#'
#' Durations class objects have one slot: .Data, a numeric object equal to the number 
#' of seconds in the duration.
#'
#'
#'
#'
#' @name Duration-class
#' @rdname Duration-class
#' @exportClass Duration
#' @aliases as.numeric,Duration-method
#' @aliases show,Duration-method
#' @aliases c,Duration-method
#' @aliases rep,Duration-method
#' @aliases [,Duration-method
#' @aliases [<-,Duration,ANY-method
#' @aliases $,Duration-method
#' @aliases $<-,Duration-method
#' @aliases as.difftime,Duration-method
#' @aliases +,Duration,Duration-method
#' @aliases +,Duration,Interval-method
#' @aliases +,Duration,Period-method
#' @aliases +,Duration,Date-method
#' @aliases +,Date,Duration-method
#' @aliases +,Duration,difftime-method
#' @aliases +,difftime,Duration-method
#' @aliases +,Duration,numeric-method
#' @aliases +,numeric,Duration-method
#' @aliases +,Duration,POSIXct-method
#' @aliases +,POSIXct,Duration-method
#' @aliases +,Duration,POSIXlt-method
#' @aliases +,POSIXlt,Duration-method
#' @aliases /,Duration,Duration-method
#' @aliases /,Duration,Interval-method
#' @aliases /,Duration,Period-method
#' @aliases /,Duration,difftime-method
#' @aliases /,difftime,Duration-method
#' @aliases /,Duration,numeric-method
#' @aliases *,Duration,ANY-method
#' @aliases *,ANY,Duration-method
#' @aliases -,Duration,missing-method
#' @aliases -,ANY,Duration-method
setClass("Duration", contains = c("Timespan", "numeric"), validity = check_duration)

compute_estimate <- function (x) {  
  seconds <- abs(x)
    if (any(seconds < 60)) 
        units <- "secs"
    else if (any(seconds < 3600))
        units <- "mins"
    else if (any(seconds < 86400))
        units <- "hours"
    else if (any(seconds < 31557600))
        units <- "days"
    else
    	units <- "years"
    
    switch(units, secs = paste(round(x, 2), " seconds", sep = ""), 
      mins = paste("~", round(x/60, 2), " minutes", sep = ""), 
      hours = paste("~", round(x/3600, 2), " hours", sep = ""), 
      days = paste("~", round(x/86400, 2), " days", sep = ""), 
      years = paste("~", round(x/31557600, 2), " years", sep = ""))
}


#' @export
setMethod("show", signature(object = "Duration"), function(object){
	if (all(object@.Data < 120))
		print(paste(object@.Data, "s", sep = ""))
	else
		print(paste(object@.Data, "s", " (", compute_estimate(object@.Data), ")", sep = ""), quote = FALSE)
})

#' @S3method format Duration
format.Duration <- function(x, ...) {
	if (all(x@.Data < 120))
		print(paste(x@.Data, "s", sep = ""))
	else
		paste(x@.Data, "s", " (", compute_estimate(x@.Data), ")", sep = "")
}

#' @export
setMethod("c", signature(x = "Duration"), function(x, ...){
	durs <- c(x@.Data, unlist(list(...)))
	new("Duration", durs)
})

#' @export
setMethod("rep", signature(x = "Duration"), function(x, ...){
	new("Duration", rep(as.numeric(x), ...))
})

#' @export
setMethod("[", signature(x = "Duration"), 
  function(x, i, j, ..., drop = TRUE) {
    new("Duration", x@.Data[i])
})

#' @export
setMethod("[<-", signature(x = "Duration"), 
  function(x, i, j, ..., value) {
  	x@.Data[i] <- value
    new("Duration", x@.Data)
})



#' Create a duration object.
#'
#' new_duration creates a duration object with the specified values. Entries for 
#' different units are cumulative. durations display as the number of seconds in a time span. When this number is large, durations also display an estimate in larger units,; however, the underlying object is 
#' always recorded as a fixed number of seconds. For display and creation 
#' purposes, units are converted to seconds using their most common lengths in 
#' seconds. Minutes = 60 seconds, hours = 3600 seconds, days = 86400 seconds, 
#' weeks = 604800. Units larger than weeks are not used due to their 
#' variability.
#'
#' Durations record the exact number of seconds in a time span. They measure the 
#' exact passage of time but do not always align with measurements 
#' made in larger units of time such as hours, months and years. 
#' This is because the length of larger time units can be affected 
#' by conventions such as leap years 
#' and Daylight Savings Time. Base R provides a second class for measuring durations, the difftime class.
#'
#' duration objects can be easily created with the helper functions 
#' \code{\link{dweeks}}, \code{\link{ddays}}, \code{\link{dminutes}}, 
#' \code{\link{dseconds}}. These objects can be added to and subtracted to date-
#' times to create a user interface similar to object oriented programming. 
#'
#' @param num the number of seconds to be included in the period (if not listing time units).
#' @param ... a list of time units to be included in the duration and their amounts. Seconds, 
#'   minutes, hours, days, and weeks are supported.
#' @return a duration object
#' @export new_duration duration
#' @aliases new_duration duration
#' @seealso \code{\link{duration}}, \code{\link{as.duration}}
#' @keywords chron classes
#' @examples
#' new_duration(second = 90)
#' # 90s
#' new_duration(minute = 1.5)
#' # 90s
#' new_duration(second = 3, minute = 1.5, hour = 2, day = 6, week = 1)
#' # 1130493s (13.08d)
#' new_duration(hour = 1, minute = -60)
#' # 0s
#' new_duration(day = -1)
#' # -86400s (-1d)
new_duration <- duration <- function(num = 0,...){
  pieces <- list(...)
  names(pieces) <- standardise_difftime_names(names(pieces))
  
  defaults <- list(secs = 0, mins = 0, hours = 0, days = 0, weeks = 0)
  pieces <- c(pieces, defaults[setdiff(names(defaults), names(pieces))])
  
  x <- num + pieces$secs +
    pieces$mins * 60 +
    pieces$hours * 3600 +
    pieces$days * 86400 +
    pieces$weeks * 604800
  
  new("Duration", x)
}

#' Quickly create exact time spans.
#'
#' Quickly create duration objects for easy date-time manipulation. The units of 
#' the duration created depend on the name of the function called. For duration 
#' objects, units are equal to their most common lengths in seconds (i.e. 
#' minutes = 60 seconds, hours = 3600 seconds, days = 86400 seconds, weeks = 
#' 604800, years = 31536000).
#'
#' When paired with date-times, these functions allow date-times to be 
#' manipulated in a method similar to object oriented programming. Duration 
#' objects can be added to Date, POSIXt, and Interval objects.
#'
#' @export eseconds eminutes ehours edays eweeks eyears dseconds dminutes dhours ddays dweeks dyears dmilliseconds emilliseconds dmicroseconds emicroseconds dnanoseconds enanoseconds dpicoseconds epicoseconds
#' @aliases eseconds eminutes ehours edays eweeks eyears dseconds dminutes dhours ddays dweeks dyears dmilliseconds emilliseconds dmicroseconds emicroseconds dnanoseconds enanoseconds dpicoseconds epicoseconds
#' @param x numeric value of the number of units to be contained in the duration. 
#' @return a duration object
#' @seealso \code{\link{duration}}, \code{\link{new_duration}}, \code{\link{days}}
#' @keywords chron manip
#' @examples
#' dseconds(1) 
#' # 1s
#' dminutes(3.5) 
#' # 210s
#'
#' x <- as.POSIXct("2009-08-03") 
#' # "2009-08-03 CDT"
#' x + ddays(1) + dhours(6) + dminutes(30)
#' # "2009-08-04 06:30:00 CDT"
#' x + ddays(100) - dhours(8) 
#' # "2009-11-10 15:00:00 CST"
#' 
#' class(as.Date("2009-08-09") + ddays(1)) # retains Date class
#' # "Date"
#' as.Date("2009-08-09") + dhours(12) 
#' # "2009-08-09 12:00:00 UTC"
#' class(as.Date("2009-08-09") + dhours(12)) 
#' # "POSIXt"  "POSIXct"
#' # converts to POSIXt class to accomodate time units
#' 
#' dweeks(1) - ddays(7) 
#' # 0s
#' c(1:3) * dhours(1) 
#' # 3600s  7200s  10800s
#' #
#' # compare DST handling to durations
#' boundary <- as.POSIXct("2009-03-08 01:59:59")
#' # "2009-03-08 01:59:59 CST"
#' boundary + days(1) # period
#' # "2009-03-09 01:59:59 CDT" (clock time advances by a day)
#' boundary + ddays(1) # duration
#' # "2009-03-09 02:59:59 CDT" (clock time corresponding to 86400 seconds later)
dseconds <- eseconds <- function(x = 1) new("Duration", x)
dminutes <- eminutes <- function(x = 1) new("Duration", x * 60)
dhours <- ehours <-   function(x = 1) new("Duration", x * 3600)
ddays <- edays <-    function(x = 1) new("Duration", x * 86400)  
dweeks <- eweeks <-   function(x = 1) new("Duration", x * 604800)
dyears <- eyears <- function(x = 1) new("Duration", x * 31536000)
dmilliseconds <- emilliseconds <- function(x = 1) milliseconds(x)
dmicroseconds <- emicroseconds <- function(x = 1) microseconds(x)
dnanoseconds <- enanoseconds <- function(x = 1) nanoseconds(x)
dpicoseconds <- epicoseconds <- function(x = 1) picoseconds(x)


#' Is x a duration object?
#'
#' @export is.duration
#' @param x an R object   
#' @return TRUE if x is a duration object, FALSE otherwise.
#' @seealso \code{\link{is.instant}}, \code{\link{is.timespan}}, \code{\link{is.interval}}, 
#'   \code{\link{is.period}}, \code{\link{duration}}
#' @keywords logic chron
#' @examples
#' is.duration(as.Date("2009-08-03")) # FALSE
#' is.duration(new_duration(days = 12.4)) # TRUE
is.duration <- function(x) is(x, "Duration")