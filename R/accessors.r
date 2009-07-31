# Extract components from a date
# -----------------------------------------------------------

# Dates should first be converted to POSIXt with parse.r

#' TITLE
#' Sub Title
#' (blank line)
#' Paragraph explaining stuff
#' (blank line) 
#' @param    
#' @author
#' @keywords
#' @examples
#' example1()
#' example2()
#example <- function()

#' Second
#'
#' Extract seconds component of a POSIXt date object.
#' @usage second(x)
#' @usage second(x) <- z
#' @param x a POSIXt date object    
#' @author Hadley Wickham \email{h.wickham@@gmail.com}, Garrett Grolemund \email{garrettgrolemund@@rice.edu}
#' @keywords utilities, accessors
#' @examples
#' second(Sys.time())
second <- function(x) 
	UseMethod("second")
	
second.default <- function(x)
    as.POSIXlt(x)$sec
    
second.zoo <- function(x)
	as.POSIXlt(index(x))$sec
	
second.its <- function(x)
	second.default(attr(x, "dates"))
	
second.ti <- second.jul <- function(x)
	tis::hms(x)$sec

second.timeSeries <- function(x)
	second.default(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter))

second.fts <- function(x)
	second.default(dates(x))
	
second.irts <- function(x)
	second.default(x$time)


#' Minute
#'
#' Extract minutes component of a POSIXt date object.
#' 
#' @param x a POSIXt date object    
#' @author Hadley Wickham \email{h.wickham@@gmail.com}, Garrett Grolemund \email{garrettgrolemund@@rice.edu}
#' @keywords utilities, accessors
#' @examples
#' hour(Sys.time())
minute <- function(x) 
	UseMethod("minute")
	
minute.default <- function(x)
    as.POSIXlt(x)$min
    
minute.zoo <- function(x)
	as.POSIXlt(index(x))$min

minute.its <- function(x)
	minute.default(attr(x, "dates"))
	
minute.ti <- minute.jul <- function(x)
	tis::hms(x)$min

minute.timeSeries <- function(x)
	minute.default(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter))
	
minute.fts <- function(x)
	minute.default(dates(x))

minute.irts <- function(x)
	minute.default(x$time)


#' Hour
#'
#' Extract hours component of a POSIXt date object.
#' 
#' @param x a POSIXt date object    
#' @author Hadley Wickham \email{h.wickham@@gmail.com}, Garrett Grolemund \email{garrettgrolemund@@rice.edu}
#' @keywords utilities, accessors
#' @examples
#' hour(Sys.time())
hour <- function(x) 
	UseMethod("hour")
	
hour.default <- function(x)
    as.POSIXlt(x, tz = tz(x))$hour
    
hour.zoo <- function(x)
	hour.default(index(x))
	
hour.its <- function(x)
	hour.default(attr(x, "dates"))
	
hour.ti <- hour.jul <- function(x)
	tis::hms(x)$hour
	
hour.timeSeries <- function(x)
	hour.default(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter))
	
hour.fts <- function(x)
	hour.default(dates(x))
	
hour.irts <- function(x)
	as.POSIXlt(x$time, tz = "GMT")$hour

#' Day of the Year
#'
#' Returns the day of the year of a POSIXt date 
#' 
#' @param x a POSIXt date object    
#' @author Hadley Wickham \email{h.wickham@@gmail.com}, Garrett Grolemund \email{garrettgrolemund@@rice.edu}
#' @keywords utilities, accessors
#' @seealso \code{\link{wday}, \link{mday}}
#' @examples
#' date <- as.POSIXlt("2009-02-10")
#' yday(date)  # 41
yday <- function(x) 
	UseMethod("yday")
	
yday.default <- function(x)
    as.POSIXlt(x, tz = tz(x))$yday + 1
    
yday.zoo <- function(x)
	yday.default(index(x))

yday.its <- function(x)
	yday.default(attr(x, "dates"))
	
yday.ti <- yday.jul <- function(x)
	yday.default(as.Date(x))
	
yday.timeSeries <- function(x)
	yday.default(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter))
	
yday.fts <- function(x)
	yday.default(dates(x))
	
yday.irts <- function(x)
	as.POSIXlt(x$time, tz = "GMT")$yday + 1

#' Day of the Week
#'
#' Returns the day of the week of a POSIXt date. A weekday of 1 corresponds to Sunday. 
#' 
#' @param x a POSIXt date object    
#' @author Hadley Wickham \email{h.wickham@@gmail.com}, Garrett Grolemund \email{garrettgrolemund@@rice.edu}
#' @keywords utilities, accessors
#' @seealso \code{\link{yday}, \link{mday}, \link{base::weekdays}}
#' @examples
#' date <- as.POSIXlt("2009-02-10") # a tuesday
#' wday(date)  # 3
wday <- function(x) 
	UseMethod("wday")
	
wday.default <- function(x)
    as.POSIXlt(x, tz = tz(x))$wday + 1
    
wday.zoo <- function(x)
	wday.default(index(x))

wday.its <- function(x)
	wday.default(attr(x, "dates"))
	
wday.ti <- wday.jul <- function(x)
	wday.default(as.Date(x))
	
wday.timeSeries <- function(x)
	wday.default(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter))
	
wday.fts <- function(x)
	wday.default(dates(x))
	
wday.irts <- function(x)
	as.POSIXlt(x$time, tz = "GMT")$wday + 1
	
#' Day of the Month
#'
#' Returns the day of the month of a POSIXt date 
#' 
#' @param x a POSIXt date object    
#' @author Hadley Wickham \email{h.wickham@@gmail.com}, Garrett Grolemund \email{garrettgrolemund@@rice.edu}
#' @keywords utilities, accessors
#' @seealso \code{\link{wday}, \link{yday}}
#' @examples
#' date <- as.POSIXlt("2009-02-10")
#' mday(date)  # 10
mday <- function(x) 
	UseMethod("mday")
	
mday.default <- function(x)
    as.POSIXlt(x, tz = tz(x))$mday
    
mday.zoo <- function(x)
	mday.default(index(x))

mday.its <- function(x)
	mday.default(attr(x, "dates"))
	
mday.ti <- mday.jul <- function(x)
	mday.default(as.Date(x))
	
mday.timeSeries <- function(x)
	mday.default(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter))
	
mday.fts <- function(x)
	mday.default(dates(x))
	
mday.irts <- function(x)
	as.POSIXlt(x$time, tz = "GMT")$mday

#' Week of the Year
#'
#' Returns the week number for the year of a POSIXt date. 
#' 
#' @param x a POSIXt date object    
#' @author Hadley Wickham \email{h.wickham@@gmail.com}, Garrett Grolemund \email{garrettgrolemund@@rice.edu}
#' @keywords utilities, accessors
#' @examples
#' date <- as.POSIXlt("2009-01-01")
#' week(date)  # 1
#' date <- as.POSIXlt("2009-12-25")
#' week(date)  # 52
week <- function(x)
    yday(x) %/% 7 + 1


#' Month
#'
#' Returns the month of a POSIXt date. 
#' 
#' @param x a POSIXt date object    
#' @author Hadley Wickham \email{h.wickham@@gmail.com}, Garrett Grolemund \email{garrettgrolemund@@rice.edu}
#' @keywords utilities, accessors
#' @examples
#' date <- as.POSIXlt("2009-01-01")
#' month(date)  # 2
month <- function(x) 
	UseMethod("month")
	
month.default <- function(x)
    as.POSIXlt(x, tz = tz(x))$mon + 1
    
month.zoo <- function(x)
	month.default(index(x))

month.its <- function(x)
	month.default(attr(x, "dates"))	

month.ti <- month.jul <- function(x)
	month.default(as.Date(x))
	
month.timeSeries <- function(x)
	month.default(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter))
	
month.fts <- function(x)
	month.default(dates(x))
	
month.irts <- function(x)
	as.POSIXlt(x$time, tz = "GMT")$mon + 1
	
#' Year
#'
#' Returns the year of a POSIXt date. 
#' 
#' @param x a POSIXt date object    
#' @author Hadley Wickham \email{h.wickham@@gmail.com}, Garrett Grolemund \email{garrettgrolemund@@rice.edu}
#' @keywords utilities, accessors
#' @examples
#' date <- as.POSIXlt("2009-01-01")
#' year(date)  # 2009
year <- function(x) 
	UseMethod("year")
	
year.default <- function(x)
    as.POSIXlt(x, tz = tz(x))$year + 1900
    
year.zoo <- function(x)
	year.default(index(x))

year.its <- function(x)
	year.default(attr(x, "dates"))
	
year.ti <- year.jul <- function(x)
	year.default(as.Date(x))

year.timeSeries <- function(x)
	year.default(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter))
	
year.fts <- function(x)
	year.default(dates(x))
	
year.irts <- function(x)
	as.POSIXlt(x$time, tz = "GMT")$year + 1900

# Extract the first entry in the time zone vector.

#' Time Zone
#' Returns the time zone of a POSIXt date. 
#'
#' Returns the first element of the time zone attribute vector. For a description of the time zone attribute, see \code{\link{base:DateTimeClasses}}. If supply = T, tz() will return the time zone of \code{\link{Sys.time}} whenever x does not have its own time zone attribute.
#' 
#' @param x a POSIXt date object
#' @param supply logical. Should the system time zone be returned if x's time zone is missing?    
#' @author Hadley Wickham \email{h.wickham@@gmail.com}, Garrett Grolemund \email{garrettgrolemund@@rice.edu}
#' @keywords utilities, accessors
#' @examples
#' tz(Sys.time())
tz <- function (x, supply = T) 
	UseMethod("tz")

tz.default <- function(x, supply = T) {
    if (supply){
        if (is.null(attr(x,"tzone")) && !is.POSIXt(x))
            return("GMT")
    }
  tzs <- attr(as.POSIXlt(x),"tzone")
  tzs[1]
}

tz.zoo <- function(x, supply = T){
	tzs <- attr(as.POSIXlt(index(x)), "tzone")
	tzs[1]
}

tz.its <- function(x)
	tz.default(attr(x, "dates"))

tz.ti <- tz.jul <- function(x)
	tz.default(as.Date(x))
	
tz.timeSeries <- function(x)
	x@FinCenter

tz.fts <- function(x)
	tz.default(dates(x))
	
tz.irts <- function(x)
	return("GMT")


#' AM/PM
#'
#' Identifies whether POSIXt date time occurs in the AM or PM. 
#'
#' @param x a POSIXt date object    
#' @author Hadley Wickham \email{h.wickham@@gmail.com}, Garrett Grolemund \email{garrettgrolemund@@rice.edu}
#' @keywords utilities, accessors
#' @examples
#' am(Sys.time())
#' pm(Sys.time())
am <- function(x) hour(x) < 12

#' AM/PM
#'
#' Identifies whether POSIXt date time occurs in the AM or PM. 
#'
#' @param x a POSIXt date object    
#' @author Hadley Wickham \email{h.wickham@@gmail.com}, Garrett Grolemund \email{garrettgrolemund@@rice.edu}
#' @keywords utilities, accessors
#' @examples
#' am(Sys.time())
#' pm(Sys.time())
pm <- function(x) !am(x)



# Set a component of the date to a specified value
# --------------------------------------------------------------------------

# To change a component to a given value, remove or add the difference in 
# seconds between the original time and the time with the desired value.

# Fractional seconds are incuded in the seconds variable

#' Second<-
#'
#' Internal function. Replaces the seconds element of a POSIXt date with a specified value.
#' 
#' @param x a POSIXt date object
#' @param value a number that will be substituted for the date's seconds component.    
#' @author Hadley Wickham \email{h.wickham@@gmail.com}, Garrett Grolemund \email{garrettgrolemund@@rice.edu}
#' @keywords internal, accessors
"second<-" <- function(x, value){
	if (all(value == second(x)))
		return(x)
	UseMethod("second<-")
}

"second<-.default" <- function(x, value){
	as.POSIXct(x) - (second(x) - value)
}

"second<-.chron" <- "second<-.timeDate" <- function(x, value){
	date <- "second<-.default"(x,value)
	f <- match.fun(paste("as", class(x)[1], sep = "."))
	f(date)
}

"second<-.zoo" <- function(x, value){
	compatible <- recognize(index(x))
	if(!compatible)
		stop("series uses unrecognized date format")
		 
	new <- "second<-"(index(x), value)
	'index<-'(x, new)
}


"second<-.its" <- function(x, value){
	dates <- "second<-.default"(attr(x,"dates"), value)
	attr(x, "dates") <- dates
	its(x, dates, format = "%Y-%m-%d %X")
}

"second<-.ti" <- function(x, value){
	date <- "second<-.default"(as.Date(x),value)
	as.ti(date, tifName(x))
}

"second<-.jul" <- function(x, value)
	x - (second(x) - value)/86400


"second<-.timeSeries" <- function(x, value){
	positions <- "second<-.default"(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter), value)
	timeSeries(series(x), positions)
}

"second<-.fts" <- function(x, value){
	date <- "second<-.default"(dates(x), value)
	fts(x, date)
}

"second<-.irts" <- function(x, value){
	x$time <- "second<-.default"(x$time, value)
	x
}

#' Minute<-
#'
#' Internal function. Replaces the minutes element of a POSIXt date with a specified value.
#' 
#' @param x a POSIXt date object
#' @param value a number that will be substituted for the date's minutes component.    
#' @author Hadley Wickham \email{h.wickham@@gmail.com}, Garrett Grolemund \email{garrettgrolemund@@rice.edu}
#' @keywords internal, accessors
"minute<-" <- function(x, value){
	if (all(value == minute(x)))
		return(x)
	UseMethod("minute<-")
}

"minute<-.default" <- function(x, value)
	as.POSIXct(x) - (minute(x) - value) * 60


"minute<-.chron" <- "minute<-.timeDate" <- function(x, value){
	date <- "minute<-.default"(x,value)
	f <- match.fun(paste("as", class(x)[1], sep = "."))
	f(date)
}

"minute<-.zoo" <- function(x, value){
	compatible <- recognize(index(x))
	if(!compatible)
		stop("series uses unrecognized date format")
		 
	new <- "minute<-"(index(x), value)
	'index<-'(x, new)
}

"minute<-.its" <- function(x, value){
	dates <- "minute<-.default"(attr(x,"dates"), value)
	attr(x, "dates") <- dates
	its(x, dates, format = "%Y-%m-%d %X")
}

"minute<-.ti" <- function(x, value){
	date <- "minute<-.default"(as.Date(x),value)
	as.ti(date, tifName(x))
}

"minute<-.jul" <- function(x, value)
	x - (minute(x) - value)*60/86400

"minute<-.timeSeries" <- function(x, value){
	positions <- "minute<-.default"(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter), value)
	timeSeries(series(x), positions)
}

"minute<-.fts" <- function(x, value){
	date <- "minute<-.default"(dates(x), value)
	fts(x, date)
}

"minute<-.irts" <- function(x, value){
	x$time <- "minute<-.default"(x$time, value)
	x
}

#' Hour<-
#'
#' Internal function. Replaces the hours element of a POSIXt date with a specified value.
#' 
#' @param x a POSIXt date object
#' @param value a number that will be substituted for the date's hours component.    
#' @author Hadley Wickham \email{h.wickham@@gmail.com}, Garrett Grolemund \email{garrettgrolemund@@rice.edu}
#' @keywords internal, accessors
"hour<-" <- function(x, value) {
	if (all(value == hour(x)))
		return(x)
	UseMethod("hour<-")
}

"hour<-.default" <- function(x, value)
	as.POSIXct(x, tz = tz(x)) - (hour(x) - value) * 3600


"hour<-.chron" <- "hour<-.timeDate" <- function(x, value){
	date <- "hour<-.default"(x,value)
	f <- match.fun(paste("as", class(x)[1], sep = "."))
	f(date)
}

"hour<-.zoo" <- function(x, value){
	compatible <- recognize(index(x))
	if(!compatible)
		stop("series uses unrecognized date format")
		 
	new <- "hour<-"(index(x), value)
	'index<-'(x, new)
}

"hour<-.its" <- function(x, value){
	dates <- "hour<-.default"(attr(x,"dates"), value)
	attr(x, "dates") <- dates
	its(x, dates, format = "%Y-%m-%d %X")
}

"hour<-.ti" <- function(x, value){
	date <- "hour<-.default"(as.Date(x),value)
	as.ti(date, tifName(x))
}

"hour<-.jul" <- function(x, value)
	x - (hour(x) - value)*3600/86400

"hour<-.timeSeries" <- function(x, value){
	positions <- "hour<-.default"(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter), value)
	timeSeries(series(x), positions)
}

"hour<-.fts" <- function(x, value){
	date <- "hour<-.default"(dates(x), value)
	fts(x, date)
}

"hour<-.irts" <- function(x, value){
	x$time <- as.POSIXlt(x$time, tz = "GMT") - (hour(x) - value) * 3600
	x
}

#' Yday<-
#'
#' Internal function. Replaces the ydays element of a POSIXt date with a specified value.
#' 
#' @param x a POSIXt date object
#' @param value a number that will be substituted for the date's ydays component.    
#' @author Hadley Wickham \email{h.wickham@@gmail.com}, Garrett Grolemund \email{garrettgrolemund@@rice.edu}
#' @keywords internal, accessors
#' @seealso \code{\link{yday}}
"yday<-" <- function(x, value){
	if (all(value == yday(x)))
		return(x)
	UseMethod("yday<-")
}

"yday<-.default" <- function(x, value)
	as.POSIXct(x) - (yday(x) - value) * 3600 * 24



"yday<-.Date" <- "yday<-.chron" <- "yday<-.timeDate" <- function(x, value){
	date <- "yday<-.default"(x,value)
	f <- match.fun(paste("as", class(x)[1], sep = "."))
	f(date)
}

"yday<-.zoo" <- function(x, value){
	compatible <- recognize(index(x))
	if(!compatible)
		stop("series uses unrecognized date format")
		 
	new <- "yday<-"(index(x), value)
	'index<-'(x, new)
}

"yday<-.its" <- function(x, value){
	dates <- "yday<-.default"(attr(x,"dates"), value)
	attr(x, "dates") <- dates
	its(x, dates, format = "%Y-%m-%d %X")
}

"yday<-.ti" <- function(x, value){
	date <- "yday<-.default"(as.Date(x),value)
	as.ti(date, tifName(x))
}

"yday<-.jul" <- function(x, value)
	x - (yday(x) - value)*3600*24/86400

"yday<-.timeSeries" <- function(x, value){
	positions <- "yday<-.default"(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter), value)
	timeSeries(series(x), positions)
}

"yday<-.fts" <- function(x, value){
	date <- "yday<-.default"(dates(x), value)
	fts(x, date)
}

"yday<-.irts" <- function(x, value){
	x$time <- as.POSIXlt(x$time, tz = "GMT") - (yday(x) - value) * 3600 * 24
	x
}

#' Wday<-
#'
#' Internal function. Replaces the wdays element of a POSIXt date with a specified value.
#' 
#' @param x a POSIXt date object
#' @param value a number that will be substituted for the date's wdays component.    
#' @author Hadley Wickham \email{h.wickham@@gmail.com}, Garrett Grolemund \email{garrettgrolemund@@rice.edu}
#' @keywords internal, accessors
#' @seealso \code{\link{wday}}
"wday<-" <- function(x, value){
	if (all(value == wday(x)))
		return(x)
	UseMethod("wday<-")
}

"wday<-.default" <- function(x, value)
	as.POSIXct(x) - (wday(x) - value) * 3600 * 24


"wday<-.Date" <- "wday<-.chron" <- "wday<-.timeDate" <- function(x, value){
	date <- "wday<-.default"(x,value)
	f <- match.fun(paste("as", class(x)[1], sep = "."))
	f(date)
}

"wday<-.zoo" <- function(x, value){
	compatible <- recognize(index(x))
	if(!compatible)
		stop("series uses unrecognized date format")
		 
	new <- "wday<-"(index(x), value)
	'index<-'(x, new)
}


"wday<-.its" <- function(x, value){
	dates <- "wday<-.default"(attr(x,"dates"), value)
	attr(x, "dates") <- dates
	its(x, dates, format = "%Y-%m-%d %X")
}

"wday<-.ti" <- function(x, value){
	date <- "wday<-.default"(as.Date(x),value)
	as.ti(date, tifName(x))
}

"wday<-.jul" <- function(x, value)
	x - (wday(x) - value)*3600*24/86400

"wday<-.timeSeries" <- function(x, value){
	positions <- "wday-.default"(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter), value)
	timeSeries(series(x), positions)
}

"wday<-.fts" <- function(x, value){
	date <- "wday<-.default"(dates(x), value)
	fts(x, date)
}

"wday<-.irts" <- function(x, value){
	x$time <- as.POSIXlt(x$time, tz = "GMT") - (wday(x) - value) * 3600 * 24
	x
}


#' Mday<-
#'
#' Internal function. Replaces the mdays element of a POSIXt date with a specified value.
#' 
#' @param x a POSIXt date object
#' @param value a number that will be substituted for the date's mdays component.    
#' @author Hadley Wickham \email{h.wickham@@gmail.com}, Garrett Grolemund \email{garrettgrolemund@@rice.edu}
#' @keywords internal, accessors
#' @seealso \code{\link{mday}}
"mday<-" <- "day<-" <- function(x, value){
	if (all(value == mday(x)))
		return(x)
	UseMethod("mday<-")
}

"mday<-.default" <- function(x, value)
	as.POSIXct(x) - (mday(x) - value) * 3600 * 24

"mday<-.Date" <- "mday<-.chron" <- "mday<-.timeDate" <-function(x, value){
	date <- "mday<-.default"(x,value)
	f <- match.fun(paste("as", class(x)[1], sep = "."))
	f(date)
}

"mday<-.zoo" <- function(x, value){
	compatible <- recognize(index(x))
	if(!compatible)
		stop("series uses unrecognized date format")
		 
	new <- "mday<-"(index(x), value)
	'index<-'(x, new)
}

"mday<-.its" <- function(x, value){
	dates <- "mday<-.default"(attr(x,"dates"), value)
	attr(x, "dates") <- dates
	its(x, dates, format = "%Y-%m-%d %X")
}

"mday<-.ti" <- function(x, value){
	date <- "mday<-.default"(as.Date(x),value)
	as.ti(date, tifName(x))
}

"mday<-.jul" <- function(x, value)
	x - (mday(x) - value)*3600*24/86400

"mday<-.timeSeries" <- function(x, value){
	positions <- "mday<-.default"(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter), value)
	timeSeries(series(x), positions)
}

"mday<-.fts" <- function(x, value){
	date <- "mday<-.default"(dates(x), value)
	fts(x, date)
}

"mday<-.irts" <- function(x, value){
	x$time <- as.POSIXlt(x$time, tz = "GMT") - (mday(x) - value) * 3600 * 24	
	x
}

#' Week<-
#'
#' Internal function. Replaces the weeks element of a POSIXt date with a specified value.
#' 
#' @param x a POSIXt date object
#' @param value a number that will be substituted for the date's weeks component.    
#' @author Hadley Wickham \email{h.wickham@@gmail.com}, Garrett Grolemund \email{garrettgrolemund@@rice.edu}
#' @keywords internal, accessors
#' @seealso \code{\link{week}}
"week<-" <- function(x, value){
	if (all(value == week(x)))
		return(x)
	UseMethod("week<-")
}

"week<-.default" <- function(x, value)
	as.POSIXct(x) - (week(x) - value) * 3600 * 24 * 7


"week<-.Date" <- "week<-.chron" <- "week<-.timeDate" <- function(x, value){
	date <- "week<-.default"(x,value)
	f <- match.fun(paste("as", class(x)[1], sep = "."))
	f(date)
}

"week<-.zoo" <- function(x, value){
	compatible <- recognize(index(x))
	if(!compatible)
		stop("series uses unrecognized date format")
		 
	new <- "week<-"(index(x), value)
	'index<-'(x, new)
}

"week<-.its" <- function(x, value){
	dates <- "week<-.default"(attr(x,"dates"), value)
	attr(x, "dates") <- dates
	its(x, dates, format = "%Y-%m-%d %X")
}

"week<-.ti" <- function(x, value){
	date <- "week<-.default"(as.Date(x),value)
	as.ti(date, tifName(x))
}

"week<-.jul" <- function(x, value)
	x - (week(x) - value)*3600*24*7/86400

"week<-.timeSeries" <- function(x, value){
	positions <- "week<-.default"(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter), value)
	timeSeries(series(x), positions)
}

"week<-.fts" <- function(x, value){
	date <- "week<-.default"(dates(x), value)
	fts(x, date)
}

"week<-.irts" <- function(x, value){
	x$time <- as.POSIXlt(x$time, tz = "GMT") - (week(x) - value) * 3600 * 24 * 7
	x
}

#' Month<-
#'
#' Internal function. Replaces the months element of a POSIXt date with a specified value. If x is missing a time zone attribute, month<- will coerce the time zone to the system time zone.
#' 
#' @param x a POSIXt date object
#' @param value a number that will be substituted for the date's months component.    
#' @author Hadley Wickham \email{h.wickham@@gmail.com}, Garrett Grolemund \email{garrettgrolemund@@rice.edu}
#' @keywords internal, accessors
"month<-" <- function(x, value) {
	if (all(value == month(x)))
		return(x)
	UseMethod("month<-")
}

"month<-.default" <- function(x, value){
	ISOdatetime(
		year(x) + (value - 1) %/% 12,  
		(value - 1) %% 12 + 1, 
		mday(x), 
		hour(x), 
		minute(x), 
		second(x), 
		tz(x))
}

"month<-.Date" <- "month<-.chron" <- "month<-.yearmon" <- "month<-.timeDate" <- function(x, value){
	date <- "month<-.default"(x,value)
	f <- match.fun(paste("as", class(x)[1], sep = "."))
	f(date)
}

"month<-.zoo" <- function(x, value){
	compatible <- recognize(index(x))
	if(!compatible)
		stop("series uses unrecognized date format")
		 
	new <- "month<-"(index(x), value)
	'index<-'(x, new)
}

"month<-.its" <- function(x, value){
	dates <- "month<-.default"(attr(x,"dates"), value)
	attr(x, "dates") <- dates
	its(x, dates, format = "%Y-%m-%d %X")
}

"month<-.ti" <- function(x, value){
	date <- "month<-.default"(as.Date(x),value)
	as.ti(date, tifName(x))
}


"month<-.jul" <- function(x, value){
	date <- "month<-.default"(x,value)
	as.jul(date)
}

"month<-.timeSeries" <- function(x, value){
	positions <- "month<-.default"(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter), value)
	timeSeries(series(x), positions)
}

"month<-.fts" <- function(x, value){
	date <- "month<-.default"(dates(x), value)
	fts(x, date)
}

"month<-.irts" <- function(x, value){
	x$time <- "month<-.default"(x, value)
	x
}

#' Year<-
#'
#' Internal function. Replaces the years element of a POSIXt date with a specified value. If x is missing a time zone attribute, year<- will coerce the time zone to the system time zone.

#' 
#' @param x a POSIXt date object
#' @param value a number that will be substituted for the date's years component.    
#' @author Hadley Wickham \email{h.wickham@@gmail.com}, Garrett Grolemund \email{garrettgrolemund@@rice.edu}
#' @keywords internal, accessors
"year<-" <- function(x, value) {
	if (all(value == year(x)))
		return(x)
	UseMethod("year<-")
}

"year<-.default" <- function(x, value)	
	ISOdatetime(value,  month(x), mday(x), hour(x), minute(x), second(x), tz(x))



"year<-.Date" <- "year<-.chron" <- "year<-.yearmon" <- "year<-.yearqtr" <- "year<-.timeDate" <- function(x, value){
	date <- "year<-.default"(x,value)
	f <- match.fun(paste("as", class(x)[1], sep = "."))
	f(date)
}

"year<-.zoo" <- function(x, value){
	compatible <- recognize(index(x))
	if(!compatible)
		stop("series uses unrecognized date format")
		 
	new <- "year<-"(index(x), value)
	'index<-'(x, new)
}

"year<-.its" <- function(x, value){
	dates <- "year<-.default"(attr(x,"dates"), value)
	attr(x, "dates") <- dates
	its(x, dates, format = "%Y-%m-%d %X")
}

"year<-.ti" <- function(x, value){
	date <- "year<-.default"(as.Date(x),value)
	as.ti(date, tifName(x))
}

"year<-.jul" <- function(x, value){
	date <- "year<-.default"(x,value)
	as.jul(date)
}

"year<-.timeSeries" <- function(x, value){
	positions <- "year<-.default"(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter), value)
	timeSeries(series(x), positions)
}

"year<-.fts" <- function(x, value){
	date <- "year<-.default"(dates(x), value)
	fts(x, date)
}

"year<-.irts" <- function(x, value){
	x$time <- "year<-.default"(x, value)
	x
}

#' Tz<-
#'
#' Internal function. Replaces the time zone element of a POSIXt date with a specified value.
#' 
#' @param x a POSIXt date object
#' @param value a number that will be substituted for the date's time zone component.    
#' @author Hadley Wickham \email{h.wickham@@gmail.com}, Garrett Grolemund \email{garrettgrolemund@@rice.edu}
#' @keywords internal, accessors
#' @seealso \code{\link{tz}}
"tz<-" <- function(x, value) {
	if (all(value == tz(x)))
		return(x)
	UseMethod("tz<-")
}
	
"tz<-.default" <- function(x, value)
	ISOdatetime(year(x),  month(x), mday(x), hour(x), minute(x), second(x), value)


"tz<-.Date" <- "tz<-.timeDate" <- function(x, value){
	date <- "tz<-.default"(x,value)
	f <- match.fun(paste("as", class(x)[1], sep = "."))
	f(date)
}

"tz<-.zoo" <- function(x, value){
	compatible <- recognize(index(x))
	if(!compatible)
		stop("series uses unrecognized date format")
		 
	new <- "tz<-"(index(x), value)
	'index<-'(x, new)
}

"tz<-.its" <- function(x, value){
	dates <- "second<-.default"(attr(x,"dates"), value)
	attr(x, "dates") <- dates
	its(x, dates, format = "%Y-%m-%d %X")
}

"tz<-.ti" <- function(x, value){
	date <- "tz<-.default"(as.Date(x),value)
	as.ti(date, tifName(x))
}


"tz<-.jul" <- function(x, value){
	date <- "tz<-.default"(x,value)
	as.jul(date)
}

"tz<-.timeSeries" <- function(x, value){
	positions <- "tz<-.default"(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter), value)
	timeSeries(series(x), positions)
}

"tz<-.fts" <- function(x, value){
	date <- "tz<-.default"(dates(x), value)
	fts(x, date)
}

"tz<-.irts" <- function(x, value){
	warning("irts dates will always display with GMT timezone")
	x$time <- x$time - ("tz<-.default"(x, value) - x$time)
	x
}

# Modify a date and return changed value. A wrapper for the functions above. 
# ---------------------------------------------------------------------------

# Object is the date we want to change.
# ... is a list of the changes we wish to make. Names must be given.  Names must 
# be in the set (second, minute, hour, yday, wday, mday, week, month, year, 
# tz). 
# Perhaps we should add an error message to clarify this?

#' Update.Date
#' Changes the components of a POSIXt date
#'
#' Update.Date is a wrapper function for \code{\link{year}, \link{month}, \link{week}, \link{yday}, \link{wday}, \link{mday}, \link{hour}, \link{minute}, \link{second}} and \code{\link{tz}}. It returns a POSIXt date with the specified elements updated. Elements not specified will be left unaltered. Update.Date does not add the specified values to the existing date, it substitutes them for the appropriate parts of the existing date. 
#' Update.Duration implements changes in the order year, month, week, yday, wday, mday, hour, minute, second, tz.  If conflicting requests are set, requests that occur later in the order will overwrite those that occur earlier.  If a request causes spillover to another component (such as 13 months) this spillover will be added to any requests inputed for the first category (see examples).
#' 
#' @param object a POSIXt date object  
#' @param year a value to substitute for the date's year component
#' @param month a value to substitute for the date's month component
#' @param week a value to substitute for the date's week component
#' @param yday a value to substitute for the date's yday component
#' @param wday a value to substitute for the date's wday component
#' @param mday a value to substitute for the date's mday component
#' @param hour a value to substitute for the date's hour component
#' @param minute a value to substitute for the date's minute component
#' @param second a value to substitute for the date's second component
#' @param tz a value to substitute for the date's tz component
#' @author Hadley Wickham \email{h.wickham@@gmail.com}, Garrett Grolemund \email{garrettgrolemund@@rice.edu}
#' @keywords utilities, accessors
#' @examples
#' date <- as.POSIXlt("2009-02-10") 
#' update.Date(date, year = 2010, month = 1, mday = 1)
#' # "2010-01-01 CST"
#'
#' update.Date(date, year =2010, month = 13, mday = 1)
#' # "2011-01-01 CST"
#'
#' update.Date(date, yday = 35, wday = 4, mday = 3) 
#' # "2009-02-03 CST"
#'
#' update.Date(date, minute = 10, second = 3)
#' # "2009-02-10 00:10:03 CST"
update.Date <- update.POSIXt <- function(object, ...) {

  # a list of the changes we wish to make
  todo <- list(...)
  names(todo) <- standardise_date_names(names(todo))
  
  # ordering to do list
  changes <- as.list(c(year = todo$year, 
    month = todo$month, 
    week = todo$week,
    day = todo$day, 
    yday = todo$yday,
    wday = todo$wday,
    mday = todo$mday, 
    hour = todo$hour, 
    minute = todo$minute, 
    second = todo$second,
    tz = todo$tz))  
  
  for(change in names(changes)) {

    # for each change, we select the function we will need to use
    f <- match.fun(paste(change, "<-", sep = ""))
    
    # we update the date with the new change
    object <- f(object, changes[[change]])
  }
  object
}

standardise_date_names <- function(x) {
  dates <- c("second", "minute", "hour", "day", "mday", "wday", "yday", "week", "month", "year")
  y <- gsub("s$", "", x)
  res <- dates[pmatch(y, dates)]
  if (any(is.na(res))) {
    stop("Invalid date name: ", paste(x[is.na(res)], collapse = ", "), 
      call. = FALSE)
  }
  res
}

#' Decimal Date
#'
#' Converts a date to a decimal of its year. 
#'
#' @param date a POSIXt date object    
#' @author Garrett Grolemund \email{garrettgrolemund@@rice.edu}
#' @keywords utilities
#' @examples
#' date <- as.POSIXlt("2009-02-10")
#' decimal_date(date)  # 2009.109
decimal_date <- function(date)
	UseMethod("decimal_date")
	
decimal_date.default <- function(date){
	if(any(!inherits(date, c("POSIXt", "POSIXct", "POSIXlt", "Date"))))
		stop("date(s) not in POSIXt or Date format")
	just_year <- floor_date(date, "year")
	
	decimal <- just_seconds(date - just_year)/ (3600*24*365)
	
	leap_years <- which(leap.year(date))
	decimal[leap_years] <- just_seconds(date - just_year)[leap_years]/ (3600*24*366)

	year(date) + decimal
}

decimal_date.zoo <- function(date)
	decimal_date(index(date))

decimal_date.its <- function(x)
	decimal_date.default(attr(x,"dates"))


just_months <- function(dur)
	as.numeric(dur) %/% 10^11


just_seconds <- function(dur)
	as.numeric(dur) %% 10^11 - 50000000000


recognize <- function(x){
	recognized <- c("POSIXt", "POSIXlt", "POSIXct", "yearmon", "yearqtr", "Date")
	
	if (all(class(x) %in% recognized))
		return(TRUE)
	return(FALSE)
}