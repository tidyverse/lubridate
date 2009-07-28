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
    as.POSIXlt(x)$sec

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
    as.POSIXlt(x)$min

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
	as.POSIXlt(x, tz = tz(x))$hour

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
    as.POSIXlt(x)$yday + 1

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
    as.POSIXlt(x)$wday + 1

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
mday <- day <- function(x) 
    as.POSIXlt(x)$mday

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
    as.POSIXlt(x)$mon + 1

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
    as.POSIXlt(x)$year + 1900


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
tz <- function(x, supply = T) {
    if (supply){
        if (is.null(attr(x,"tzone")) && !is.POSIXt(x))
            return("GMT")
    }
  tzs <- attr(as.POSIXlt(x),"tzone")
  tzs[1]
}

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
"second<-" <- function(x, value) 
	UseMethod("second<-")

"second<-.default" <- function(x, value){
	if (value == second(x))
		return(x)
	as.POSIXct(x) - (second(x) - value)
}

"second<-.chron" <- function(x, value){
	date <- "second<-.default"(x,value)
	f <- match.fun(paste("as", class(x)[1], sep = "."))
	f(date)
}



#' Minute<-
#'
#' Internal function. Replaces the minutes element of a POSIXt date with a specified value.
#' 
#' @param x a POSIXt date object
#' @param value a number that will be substituted for the date's minutes component.    
#' @author Hadley Wickham \email{h.wickham@@gmail.com}, Garrett Grolemund \email{garrettgrolemund@@rice.edu}
#' @keywords internal, accessors
"minute<-" <- function(x, value) 
	UseMethod("minute<-")

"minute<-.default" <- function(x, value){
	if (value == minute(x))
		return(x)
	as.POSIXct(x) - (minute(x) - value) * 60
}

"minute<-.chron" <- function(x, value){
	date <- "minute<-.default"(x,value)
	f <- match.fun(paste("as", class(x)[1], sep = "."))
	f(date)
}


#' Hour<-
#'
#' Internal function. Replaces the hours element of a POSIXt date with a specified value.
#' 
#' @param x a POSIXt date object
#' @param value a number that will be substituted for the date's hours component.    
#' @author Hadley Wickham \email{h.wickham@@gmail.com}, Garrett Grolemund \email{garrettgrolemund@@rice.edu}
#' @keywords internal, accessors
"hour<-" <- function(x, value) 
	UseMethod("hour<-")

"hour<-.default" <- function(x, value){
	if (value == hour(x))
		return(x)
	as.POSIXct(x) - (hour(x) - value) * 3600
}

"hour<-.chron" <- function(x, value){
	date <- "hour<-.default"(x,value)
	f <- match.fun(paste("as", class(x)[1], sep = "."))
	f(date)
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
"yday<-" <- function(x, value)
	UseMethod("yday<-")

"yday<-.default" <- function(x, value){
	if (value == yday(x))
		return(x)
	as.POSIXct(x) - (yday(x) - value) * 3600 * 24
}


"yday<-.Date" <- "yday<-.chron" <- function(x, value){
	date <- "yday<-.default"(x,value)
	f <- match.fun(paste("as", class(x)[1], sep = "."))
	f(date)
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
"wday<-" <- function(x, value)
	UseMethod("wday<-")

"wday<-.default" <- function(x, value){
	if (value == wday(x))
		return(x)
	as.POSIXct(x) - (wday(x) - value) * 3600 * 24
}

"wday<-.Date" <- "wday<-.chron" <- function(x, value){
	date <- "wday<-.default"(x,value)
	f <- match.fun(paste("as", class(x)[1], sep = "."))
	f(date)
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
"mday<-" <- "day<-" <- function(x, value)
	UseMethod("mday<-")

"mday<-.default" <- function(x, value){
	if (value == mday(x))
		return(x)
	as.POSIXct(x) - (mday(x) - value) * 3600 * 24
}


"mday<-.Date" <- "mday<-.chron" <-function(x, value){
	date <- "mday<-.default"(x,value)
	f <- match.fun(paste("as", class(x)[1], sep = "."))
	f(date)
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
"week<-" <- function(x, value)
	UseMethod("week<-")

"week<-.default" <- function(x, value){
	if (value == week(x))
		return(x)
	as.POSIXct(x) - (week(x) - value) * 3600 * 24 * 7
}


"week<-.Date" <- "week<-.chron" <- function(x, value){
	date <- "week<-.default"(x,value)
	f <- match.fun(paste("as", class(x)[1], sep = "."))
	f(date)
}

#' Month<-
#'
#' Internal function. Replaces the months element of a POSIXt date with a specified value. If x is missing a time zone attribute, month<- will coerce the time zone to the system time zone.
#' 
#' @param x a POSIXt date object
#' @param value a number that will be substituted for the date's months component.    
#' @author Hadley Wickham \email{h.wickham@@gmail.com}, Garrett Grolemund \email{garrettgrolemund@@rice.edu}
#' @keywords internal, accessors
"month<-" <- function(x, value) 
	UseMethod("month<-")

"month<-.default" <- function(x, value){
	if (value == month(x))
		return(x)
	date <- ISOdatetime(
		year(x) + (value - 1) %/% 12,  
		(value - 1) %% 12 + 1, 
		mday(x), 
		hour(x), 
		minute(x), 
		second(x), 
		tz(x))
}

"month<-.Date" <- "month<-.chron" <- function(x, value){
	date <- "month<-.default"(x,value)
	f <- match.fun(paste("as", class(x)[1], sep = "."))
	f(date)
}


#' Year<-
#'
#' Internal function. Replaces the years element of a POSIXt date with a specified value. If x is missing a time zone attribute, year<- will coerce the time zone to the system time zone.

#' 
#' @param x a POSIXt date object
#' @param value a number that will be substituted for the date's years component.    
#' @author Hadley Wickham \email{h.wickham@@gmail.com}, Garrett Grolemund \email{garrettgrolemund@@rice.edu}
#' @keywords internal, accessors
"year<-" <- function(x, value) 
	UseMethod("year<-")

"year<-.default" <- function(x, value){
	if (value == year(x))
		return(x)
	ISOdatetime(value,  month(x), mday(x), hour(x), minute(x), second(x), tz(x))
}


"year<-.Date" <- "year<-.chron" <- function(x, value){
	date <- "year<-.default"(x,value)
	f <- match.fun(paste("as", class(x)[1], sep = "."))
	f(date)
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
"tz<-" <- function(x, value) 
	UseMethod("tz<-")
	
"tz<-.default" <- function(x, value){
	if (value == tz(x))
		return(x)
	ISOdatetime(year(x),  month(x), mday(x), hour(x), minute(x), second(x), value)
}

"tz<-.Date" <- function(x, value){
	date <- "tz<-.default"(x,value)
	f <- match.fun(paste("as", class(x)[1], sep = "."))
	f(date)
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
decimal_date <- function(date){
	if(!inherits(date, c("POSIXt", "POSIXct", "POSIXlt", "Date")))
		stop("date not in POSIXt or Date format")
	just_year <- floor_date(date, "year")
	if (leap.year(date))
		decimal <- just_seconds(date - just_year)/ (3600*24*366)
	else
		decimal <- just_seconds(date - just_year)/ (3600*24*365)
	year(date) + decimal
}

just_months <- function(dur)
	as.numeric(dur) %/% 10^11


just_seconds <- function(dur)
	as.numeric(dur) %% 10^11 - 50000000000
