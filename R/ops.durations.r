#' Addition for the duration class. 
#'
#' @param e1 a duration, difftime, POSIXt, or Date object
#' @param e2 a duration, difftime, POSIXt, or Date object
#' @seealso \code{link{"-.duration"}, link{"*.duration"}, link{"/.duration"}}
#' @keywords arith chron methods
#' @ examples
#' x <- new_duration(day = 1)
#' x + Sys.time()
#' Sys.Date + x
#' x + difftime(Sys.time() + 3600, Sys.time())
#' x + x
"+.duration" <- "+.POSIXt" <- "+.difftime" <- "+.Date" <- function(e1, e2){
	
	if (is.timepoint(e1)) {
		if (is.timepoint(e2))
			stop("binary '+' not defined for adding dates together")
		else
			add_duration_to_date(e1, e2)
	}

	else if (is.timeperiod(e1)) {
		if (is.timepoint(e2))
			add_duration_to_date(e2, e1)
		else if (is.timeperiod(e2))
			add_duration_to_duration(e1, e2)
		else
			add_number_to_duration(e1, e2)
	}

	else if (is.numeric(e1)) {
		if (is.timepoint(e2))
			add_duration_to_date(e2, e1)
		else if (is.timeperiod(e2))
			add_number_to_duration(e2, e1)
		else stop("Unknown object class")
	}
}

# shares documentation with "+.duration"
add_duration_to_date <- function(date, timeperiod) {
	dur <- as.duration(timeperiod)
	
	days <- just_seconds(dur) %/% 86400
	seconds <- just_seconds(dur) %% 86400
	
	second(date) <- second(date) + seconds
	yday(date) <- yday(date) + days
	month(date) <- month(date) + just_months(dur)
	date
}

# shares documentation with "+.duration"
add_duration_to_duration <- function(period1, period2) {
	dur1 <- as.duration(period1)
	dur2 <- as.duration(period2)
	
	seconds <- just_seconds(dur1) + just_seconds(dur2)
	months <- just_months(dur1) + just_months(dur2)
	
	new_duration(second = seconds, month = months)
}

# shares documentation with "+.duration"
add_number_to_duration <- function(dur, num){
	if (is.difftime(dur)){
		num <- structure(num, units = units(dur), class = "difftime")
		make_difftime( as.numeric(num, units = "secs") +  as.numeric(dur, units = "secs"))
	}
	else if (is.duration(dur))
		add_duration_to_duration(dur, num)
	else
		stop("unrecognized time period class")
}

#' Makes a difftime object from given number of seconds 
#'
#' @param diff number value of seconds to be transformed into a difftime object
#' @ examples
#' make_difftime(1)
#' make_difftime(60)
#' make_difftime(3600)
make_difftime <- function (diff) {  
	seconds <- abs(diff)
    if (seconds < 60) 
        units <- "secs"
    else if (seconds < 3600)
        units <- "mins"
    else if (seconds < 86400)
        units <- "hours"
    else if (seconds < 604800)
    	units <- "days"
    else units <- "weeks"
    
    switch(units, secs = structure(diff, units = "secs", class = "difftime"), 
    mins = structure(diff/60, units = "mins", class = "difftime"), 
    hours = structure(diff/3600, units = "hours", class = "difftime"), 
    days = structure(diff/86400, units = "days", class = "difftime"), 
    weeks = structure(diff/(604800), units = "weeks", class = "difftime"))
}

#' Multiplication for the duration class. 
#'
#' @param e1 a duration or numeric object
#' @param e2 a duration or numeric object
#' @seealso \code{link{"+.duration"}, link{"-.duration"}, link{"/.duration"}}
#' @keywords arith chron methods
#' @ examples
#' x <- new_duration(day = 1)
#' x * 3
#' 3 * x
"*.duration" <- function(e1, e2){
    if (is.duration(e1) && is.duration(e2)) {
    NA
  } else if (is.duration(e1)){
    multiply_duration_by_numeric(e2, e1)
  } else if (is.duration(e2)) {
    multiply_duration_by_numeric(e1, e2)
  } else {
    base::'*'(e1, e2)
  }
}  

# shares documentation with "*.duration"
multiply_duration_by_numeric <- function(num, dur){
	seconds <- just_seconds(dur)
	months <- just_months(dur)
	new_duration(month = num * months, second = num * seconds)
}


#' Division for the duration class. 
#'
#' @param e1 a duration or numeric object
#' @param e2 a duration or numeric object
#' @seealso \code{link{"+.duration"}, link{"-.duration"}, link{"*.duration"}}
#' @keywords arith chron methods
#' @ examples
#' x <- new_duration(day = 1)
#' x / 2
#' 2 / x
"/.duration" <- function(e1, e2){
    if (is.duration(e1) && is.duration(e2)) {
    NA
  } else if (is.duration(e1)){
    divide_duration_by_numeric(e2, e1)
  } else if (is.duration(e2)) {
    divide_duration_by_numeric(e1, e2)
  } else {
    base::'*'(e1, e2)
  }
}  

# shares documentation with "/.duration"
divide_duration_by_numeric <- function(num, dur){
	seconds <- just_seconds(dur)/num
	months <- just_months(dur)/num
	new_duration(month = months, second = seconds)
}

  
#' Subtraction for the duration class. 
#'
#' The subtraction methods also return a duration object when a POSIXt or Date object is subtracted from another POSIXt or Date object. To retrieve this difference as a difftime, use \code{link{as.difftime}}. Since a specific number of seconds exists between two dates, the duration returned will not include unspecific time units such as years and months. To get a nonspecific duration use \code{link{get_duration}}. See \code{link{duration}} for more details.
#'
#' @param e1 a duration, difftime, POSIXt, or Date object
#' @param e2 a duration, difftime, POSIXt, or Date object
#' @seealso \code{link{"+.duration"}, link{"*.duration"}, link{"/.duration"}}
#' @keywords arith chron methods
#' @ examples
#' x <- new_duration(day = 1)
#' Sys.time() - x
#' -x
#' x - x
#' as.Date("2009-08-02") - as.Date("2008-11-25")
"-.duration" <- "-.POSIXt" <- "-.difftime" <- "-.Date" <- function(e1, e2){
	if (missing(e2))
		-1 * e1
	else if(is.timepoint(e1) && is.timepoint(e2))
		as.duration(difftime(e1, e2))
	else if (is.POSIXt(e1) && !is.timeperiod(e2))
		structure(unclass(as.POSIXct(e1)) - e2, class = c("POSIXt", "POSIXct"))
	else		
		e1  + (-1 * e2)
}

#' returns the duration between two date-times. 
#'
#' get_duration returns the duration between two date-times, as measured by years, months, weeks, days, hours, minutes, and seconds. Because years and months both have nonspecific numbers of seconds (e.g, the number of seconds in a month depends on which month it is) the get_duration output is also nonspecific. To obtain a specific duration, use regular subtraction methods. See \code{link{duration}} for more details. 
#'
#' @param e1 a date-time object
#' @param e2 a date-time object
#' @seealso \code{link{"+.duration"}, link{"*.duration"}, link{"/.duration"}}
#' @ examples
#' x <- as.Date("2009-08-02")  
#' y <- as.Date("2008-11-25")
#' get_duration(x,y)
#' x - y
get_duration <- function(date1, date2) {
	months1 <- year(date1) * 12 + month(date1)
	months2 <- year(date2) * 12 + month(date2)
	
	secs1 <- mday(date1)*3600*24 + hour(date1)*3600 + minute(date1)*60 + second(date1)
	secs2 <- mday(date2)*3600*24 + hour(date2)*3600 + minute(date2)*60 + second(date2)
	
	new_duration(month = months1 - months2, second = secs1 - secs2)

}


