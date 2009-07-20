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
    as.POSIXlt(x)$hour


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
mday <- function(x) 
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
tz <- function(x, supply = F) {
    if (supply){
        if (is.null(attr(as.POSIXlt(x),"tzone")))
            return("")
        if (is.na(attr(as.POSIXlt(x),"tzone")[1]))
            return("")
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
"second<-" <- function(x, value) as.POSIXlt(x) - (second(x) - value)

#' Minute<-
#'
#' Internal function. Replaces the minutes element of a POSIXt date with a specified value.
#' 
#' @param x a POSIXt date object
#' @param value a number that will be substituted for the date's minutes component.    
#' @author Hadley Wickham \email{h.wickham@@gmail.com}, Garrett Grolemund \email{garrettgrolemund@@rice.edu}
#' @keywords internal, accessors
"minute<-" <- function(x, value) as.POSIXlt(x) - (minute(x) - value) * 60

#' Hour<-
#'
#' Internal function. Replaces the hours element of a POSIXt date with a specified value.
#' 
#' @param x a POSIXt date object
#' @param value a number that will be substituted for the date's hours component.    
#' @author Hadley Wickham \email{h.wickham@@gmail.com}, Garrett Grolemund \email{garrettgrolemund@@rice.edu}
#' @keywords internal, accessors
"hour<-" <- function(x, value) as.POSIXlt(x) - (hour(x) - value) * 3600

#' Yday<-
#'
#' Internal function. Replaces the ydays element of a POSIXt date with a specified value.
#' 
#' @param x a POSIXt date object
#' @param value a number that will be substituted for the date's ydays component.    
#' @author Hadley Wickham \email{h.wickham@@gmail.com}, Garrett Grolemund \email{garrettgrolemund@@rice.edu}
#' @keywords internal, accessors
#' @seealso \code{\link{yday}}
"yday<-" <- function(x, value) as.POSIXlt(x) - (yday(x) - value) * 3600 * 24

#' Wday<-
#'
#' Internal function. Replaces the wdays element of a POSIXt date with a specified value.
#' 
#' @param x a POSIXt date object
#' @param value a number that will be substituted for the date's wdays component.    
#' @author Hadley Wickham \email{h.wickham@@gmail.com}, Garrett Grolemund \email{garrettgrolemund@@rice.edu}
#' @keywords internal, accessors
#' @seealso \code{\link{wday}}
"wday<-" <- function(x, value) as.POSIXlt(x) - (wday(x) - value) * 3600 * 24

#' Mday<-
#'
#' Internal function. Replaces the mdays element of a POSIXt date with a specified value.
#' 
#' @param x a POSIXt date object
#' @param value a number that will be substituted for the date's mdays component.    
#' @author Hadley Wickham \email{h.wickham@@gmail.com}, Garrett Grolemund \email{garrettgrolemund@@rice.edu}
#' @keywords internal, accessors
#' @seealso \code{\link{mday}}
"mday<-" <- function(x, value) as.POSIXlt(x) - (mday(x) - value) * 3600 * 24

#' Week<-
#'
#' Internal function. Replaces the weeks element of a POSIXt date with a specified value.
#' 
#' @param x a POSIXt date object
#' @param value a number that will be substituted for the date's weeks component.    
#' @author Hadley Wickham \email{h.wickham@@gmail.com}, Garrett Grolemund \email{garrettgrolemund@@rice.edu}
#' @keywords internal, accessors
#' @seealso \code{\link{week}}
"week<-" <- function(x, value) as.POSIXlt(x) - (week(x) - value) * 3600 * 24 * 7

#' Month<-
#'
#' Internal function. Replaces the months element of a POSIXt date with a specified value. If x is missing a time zone attribute, month<- will coerce the time zone to the system time zone.
#' 
#' @param x a POSIXt date object
#' @param value a number that will be substituted for the date's months component.    
#' @author Hadley Wickham \email{h.wickham@@gmail.com}, Garrett Grolemund \email{garrettgrolemund@@rice.edu}
#' @keywords internal, accessors
"month<-" <- function(x, value) {
  # Seconds approach no longer applies: months are not uniformly long

  ISOdatetime(
    year(x) + (value - 1) %/% 12,  # New month values > 12 also change the year
    
    # %% is the modulo operator in R
    (value - 1) %% 12 + 1, 
    mday(x), 
    hour(x), 
    minute(x), 
    second(x), 
    tz(x, supply = T))
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
  ISOdatetime(value,  month(x), mday(x), hour(x), minute(x), second(x), tz(x, supply = T))
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
    ISOdatetime(year(x),  month(x), mday(x), hour(x), minute(x), second(x), value)
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
  
  # ordering to do list
  changes <- as.list(c(year = todo$year, 
    month = todo$month, 
    week = todo$week, 
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
	if (!is.POSIXt(date))
		stop("date not in POSIXt format")
	just_year <- update.Date(date, month = 1, week = 1, yday = 1, hour = 1, minute = 1, second = 1)
	if (leap.year(date))
		decimal <- (date - just_year)/ 31622400
	else
		decimal <- (date - just_year)/ 31536000
	year(date) + decimal$seconds
}

just_months <- function(dur){
	as.numeric(dur) %/% 10^10
}

just_seconds <- function(dur){
	as.numeric(dur) %% 10^10
}