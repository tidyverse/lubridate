options(DST = "relative")

#' Is a year a leap year?
#'
#' If x is a recognized date-time object, leap.year will return whether x occurs during a leap year. If x is a number, leap.year returns whether it would be a leap year under the Gregorian calendar. 
#'
#' aliases leap.year leap_year leapyear
#' @param date a date-time object or a year 
#' @return TRUE if x is a leap year, FALSE otherwise
#' @keywords logic chron
#' @examples
#' x <- as.Date("2009-08-02")
#' leap.year(x) # FALSE
#' leap.year(2009) # FALSE
#' leap.year(2008) # TRUE
#' leap.year(1900) # FALSE
#' leap.year(2000) # TRUE
leap.year <- function(date) {
	recognized <- recognize(date)
	if (recognized)
		year <- year(date)
	else if (all(is.numeric(date)))
		year <- date
	else
		stop("unrecognized date format")
  (year %% 4 == 0) & ((year %% 100 != 0) | (year %% 400 == 0))
}

#' The current time 
#'
#' @param tzone a character vector specifying which time zone you would like the current time in. tzone defaults to the system time zone set on your computer.
#' @return the current date and time as a POSIXct object
#'
#' @keywords chron utilities
#' @examples
#' now()
#' now("GMT")
#' now() == now("GMT") # would be true if computer processed both at the same instant
#' now() < now() # TRUE
#' now() > now() # FALSE
now <- function(tzone = "") 
	with_tz(Sys.time(),tzone)


#' The current date 
#'
#' @param tzone a character vector specifying which time zone you would like to find the current date of. tzone defaults to the system time zone set on your computer.
#' @return the current date as a Date object
#'
#' @keywords chron utilities
#' @examples
#' today("")
#' today("GMT")
#' today("") == today("GMT") # not always true
#' today() < as.Date("2999-01-01") # TRUE  (so far)
today <- function(tzone ="") {
	timethere <- with_tz(Sys.time(),tzone)
	daythere <- floor_date(timethere, "day")
	as.Date(daythere)
}




#' Computes attractive axis breaks for date-time data
#'
#' pretty.dates indentifies which unit of time the sub-intervals should be measured in to provide approximately n breaks. It then chooses a "pretty" length for the sub-intervals and sets start and endpoints that 1) span the entire range of the data, and 2) allow the breaks to occur on important date-times (i.e. on the hour, on the first of the month, etc.)
#'
#' @param dates a vector of POSIXct, POSIXlt, Date, or chron date-time objects
#' @param n integer value of the desired number of breaks
#' @return a vector of date-times that can be used as axis tick marks or bin breaks
#' @keywords dplot utilities chron
#' @examples
#' x <- seq.Date(as.Date("2009-08-02"), by = "year", length.out = 2)
#' # "2009-08-02" "2010-08-02"
#' pretty.dates(x, 12)
#' #"2009-08-01 GMT" "2009-09-01 GMT" "2009-10-01 GMT" "2009-11-01 GMT" "2009-12-01 GMT" "2010-01-01 GMT" "2010-02-01 GMT" "2010-03-01 GMT" "2010-04-01 GMT" "2010-05-01 GMT" "2010-06-01 GMT" "2010-07-01 GMT" "2010-08-01 GMT" "2010-09-01 GMT"
pretty.dates <- function(dates, n){
	remember <- Sys.getenv("TZ") 
	if (Sys.getenv("TZ") == "")
		remember <- "unset"
	Sys.setenv(TZ = tz(dates[1]))
	rng <- range(dates)
	diff <- rng[2] - rng[1]
	diff <- just_seconds(diff) 
	
	binunits <- pretty.unit(diff/n)
	
	f <- match.fun(paste("pretty", binunits, sep = "."))
	binlength <- f(diff, n)
	
	start <- pretty.point(min(rng), binunits, binlength)
	end <- pretty.point(max(rng), binunits, binlength, start = F)
	
	
	breaks <- seq.POSIXt(start, end, paste(binlength, binunits)) 
	if (remember == "unset")
		Sys.unsetenv("TZ")
	else 
		Sys.setenv(TZ = remember)
	breaks
}
	
	
#' Internal function 
#'
#' For use with \code{link{pretty.dates}}
#'
#' @keywords internal
pretty.unit <- function(interval){
	
	if (interval > 3600*24*365)
		return("year")
	if (interval > 3600*24*30)
		return("month")
	if (interval > 3600*24)
		return("day")
	if (interval > 3600)
		return("hour")
	if (interval > 60)
		return("min")
	else
		return("sec")
}

#' Internal function 
#'
#' For use with \code{link{pretty.dates}}
#'
#' @keywords internal

pretty.sec <- function(span, n){
	lengths <- c(1,2,5,10,15,30,60)
	fit <- abs(span - lengths*n)
	lengths[which.min(fit)]
}

#' Internal function 
#'
#' For use with \code{link{pretty.dates}}
#'
#' @keywords internal
pretty.min <- function(span, n){
	span <- span/60
	lengths <- c(1,2,5,10,15,30,60)
	fit <- abs(span - lengths*n)
	lengths[which.min(fit)]
}

#' Internal function 
#'
#' For use with \code{link{pretty.dates}}
#'
#' @keywords internal
pretty.hour <- function(span, n){
	span <- span / 3600
	lengths <- c(1,2,3,4,6,8,12,24)
	fit <- abs(span - lengths*n)
	lengths[which.min(fit)]
}

#' Internal function 
#'
#' For use with \code{link{pretty.dates}}
#'
#' @keywords internal
pretty.day <- function(span, n){
	span <- span / (3600 * 24)
	pretty(1:span, n = n)[2]
}

#' Internal function 
#'
#' For use with \code{link{pretty.dates}}
#'
#' @keywords internal
pretty.month <- function(span, n){
	span <- span / (3600 * 24 * 30)
	lengths <- c(1,2,3,4,6,12)
	fit <- abs(span - lengths*n)
	lengths[which.min(fit)]
}
	
#' Internal function 
#'
#' For use with \code{link{pretty.dates}}
#'
#' @keywords internal
pretty.year <- function(span, n){
	span <- span / (3600 * 24 * 365)
	pretty(1:span, n = n)[2]
}

#' Internal function 
#'
#' For use with \code{link{pretty.dates}}
#'
#' @keywords internal
pretty.point <- function(x, units, length, start = TRUE){
	x <- as.POSIXct(x)
	
	floors <- c("sec", "min", "hour", "day", "d", "month", "year")
	floorto <- floors[which(floors == units) + 1]
	lower <- floor_date(x, floorto)
	upper <- ceiling_date(x, floorto)
	
	points <- seq.POSIXt(lower, upper, paste(length, units))
	
	if (start)
		points <- points[points <= x]

	else
		points <- points[points >= x]
		
	fit <- x - points	
	fit <- abs(just_seconds(fit))
	return(points[which.min(fit)])
	
}

#' Get date-time in a different time zone
#' 
#' with_tz returns a date-time as it would appear in a different time zone.  The actual moment of time measured does not change, just the time zone it is measured in.
#'
#' @param time a POSIXct, POSIXlt, Date, or chron date-time object.
#' @param tzone a character string containing the time zone to convert to. R must recognize the name contained in the string as a time zone on your system.
#' @return a POSIXct object in the updated time zone
#' @keywords chron manip
#' @seealso \code{link{replace_tz}}
#' @examples
#' x <- as.POSIXct("2009-08-07 00:00:00 CDT")
#' with_tz(x, "GMT")
#' # "2009-08-07 05:00:00 GMT"
with_tz <- function (time, tzone = "") 
	as.POSIXct(format(as.POSIXct(time), tz = tzone), tz = tzone)

#' 1970-01-01 GMT
#'
#' Origin is the date-time for 1970-01-01 GMT in POSIXct format. This date-time is the origin for the numbering system used by POSIXct, POSIXlt, chron, and Date classes.
#'
#' @keywords data chron
#' @examples
#' origin
#' # "1970-01-01 GMT"
origin <- with_tz(structure(0, class = c("POSIXt", "POSIXct")), "GMT")