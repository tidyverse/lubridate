#' Create a period object.
#'
#' new_period creates a period object with the specified values. Within a period object, time units do not have a fixed length (except for seconds) until they are added to a date-time. The length of each time unit will depend on the date-time to which it is added. For example, a year that begins on 2009-01-01 will be 365 days long.  A year that begins on 2012-01-01 will be 366 days long. When math is performed with a period object, each unit is applied separately. How a period is distributed among the time units is non-trivial. For example, when leap seconds occur 1 minute is longer than 60 seconds.
#'
#' Periods track the change in the "clock time" between two date-times. They are measured in common time related units: years, months, days, hours, minutes, and seconds. Each unit except for seconds must be expressed in integer values. 
#'
#' Period objects can be easily created with the helper functions \code{link{years}}, \code{link{months}}, \code{link{weeks}}, \code{link{days}}, \code{link{minutes}}, \code{link{seconds}}. These objects can be added to and subtracted to date-times to create a user interface similar to object oriented programming.
#'
#' @param ... a list of time units to be included in the period and their amounts. Seconds, minutes, hours, days, weeks, months, and years are supported. See \code{link{standardise_date_names}} for more details.
#' @return a period object
#' @seealso \code{link{period}, link{as.period}}
#' @keywords chron classes
#' @examples
#' new_period (second = 90, minute = 5)
#' #  5 minutes and 90 seconds
#' new_period(day = -1)
#' # -1 days
#' new_period(second = 3, minute = 1, hour = 2, day = 6, week = 1)
#' # 13 days, 2 hours, 1 minute and 3 seconds
#' new_period(hour = 1, minute = -60)
#' # 1 hour and -60 minutes
#' new_period(second = 0)
#' # 0 seconds
new_period <- function(...) {
  pieces <- data.frame(...)
  if(any(trunc(pieces) - pieces != 0))
  	stop("periods must have integer values", call. = F)
  	
  names(pieces) <- standardise_date_names(names(pieces))
  defaults <- data.frame(
    second = 0, minute = 0, hour = 0, day = 0, week = 0, 
    month = 0, year = 0
  )
  
  pieces <- cbind(pieces, defaults[setdiff(names(defaults), names(pieces))])
  pieces <- pieces[c("year", "month", "week", "day", "hour", "minute", "second")] 
  
  pieces$day <- pieces$day + pieces$week * 7
  pieces <- pieces[,-3]
  
  structure(pieces, class = c("period", "data.frame"))
}

seconds <- function(x = 1) new_period(second = x)
minutes <- function(x = 1) new_period(minute = x)
hours <-   function(x = 1) new_period(hour = x)
days <-    function(x = 1) new_period(day = x)  
weeks <-   function(x = 1) new_period(week = x)
months <-  function(x = 1) new_period(month = x)
years <-   function(x = 1) new_period(year = x)

y <- years(1)
m <- months(1)
w <- weeks(1)
d <- days(1)

#' Internal function. Formats period objects.
#'
#' keywords internal print chron
format.period <- function(period, ...){
	show <- vector(mode = "character")
	for (i in 1:nrow(period)){
		per <- period[i,]
	
		per <- per[which(per != 0)]
		if (length(per) == 0) show[i] <- "0 seconds"
		
		else{
			singular <- names(per)
	   		plural <- paste(singular, "s", sep = "")
    
	    	IDs <-paste(per, ifelse(!is.na(per) & per == 1, singular, plural))
 		   	if(length(IDs) == 1) show[i] <- IDs
    		else
    			show[i] <- paste(paste(IDs[-length(IDs)], collapse = ", "), IDs[length(IDs)],sep = " and ")
    	}
    }
    paste(show, collapse = "   ")
}

#' Internal function for printing interval objects.
#'
#' keywords internal print chron
print.period <- function(x, ...) {
  print(format(x), ..., quote = FALSE)
}


#' Because periods do not have a fixed length, they can not be accurately converted to and from duration objects. Duration objects measure time spans in exact numbers of seconds, see \code{link{duration}}. 
as.period <- function(x, periods, ...)
	UseMethod("as.period")
	
as.period.default <- function(x, periods, ...){
	x <- as.numeric(x)
	unit <- standardise_date_names(periods[1])
	f <- match.fun(paste(unit, "s", sep = ""))
	f(x)
}

as.period.interval <- function(x, periods = c("year", "month", "day", "hour", "minute", "seconds"), ...){
	periods <- standardise_date_names(periods)
	newper <- new_period(second = 0)
	
	for(i in 1:length(periods)){
		start <- x$start + newper
		name <- match(periods[i], names(newper))
		f <- match.fun(periods[i])
		newper[1,name] <- f(x$end) - f(start)
	}

	remainder <- as.double(difftime(x$end, x$start + newper), "secs")
	newper$second <- newper$second + remainder
newper
}

as.period.difftime <- function(x, periods){
	periods <- standardise_date_names(periods)
	span <- as.double(x, "secs")
	remainder <- abs(span)
	newper <- new_period(second = 0)
	denominator <- c(second = 1, minute = 60, hour = 3600, day = (3600 * 24), year =  (3600 * 24 * 7 * 365))
	
	for (i in 1:length(periods)){
		bite <- switch(periods[i], 
			"second" = span, 
			"minute" = span %/% 60 * 60, 
			"hour" = span %/% 3600 * 3600, 
			"day" = span %/% (3600 * 24) * (3600 * 24), 
			"month" = stop("month length cannot be estimated from durtions", call. = F),
			"year" = span %/% (3600 * 24 * 7 * 365) * (3600 * 24 * 7 * 365))
		remainder <- remainder - bite
		newper[periods[i]] <- bite / denominator[[periods[i]]]
	}
	
	newper$second <- newper$second + remainder
	newper * sign(span)
}










