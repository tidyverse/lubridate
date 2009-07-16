# Extract components from a date
# -----------------------------------------------------------

# Dates should first be converted to POSIXct with parse.r

#' TITLE
#' Sub Title
#' (blank line)
#' Paragraph explaining stuff
#' (blank line) 
#' @param    
#' @author
#' @keywords
#' examples
#' example1()
#' example2()
#example <- function()

#' Second
#' Add seconds to your time
#' 
#' @param x A time object    
#' @author Garret Gman \email{garretgman@@gmail.com}
#' @keywords utilities
#' examples
#' second(Sys.time())
second <- function(x) 
    as.POSIXlt(x)$sec


minute <- function(x) 
    as.POSIXlt(x)$min
hour <- function(x) 
    as.POSIXlt(x)$hour
yday <- function(x) 
    as.POSIXlt(x)$yday + 1
wday <- function(x) 
    as.POSIXlt(x)$wday + 1
mday <- function(x) 
    as.POSIXlt(x)$mday
week <- function(x) 
    yday(x) %/% 7 + 1
month <- function(x) 
    as.POSIXlt(x)$mon + 1
year <- function(x) 
    as.POSIXlt(x)$year + 1900


# Extract the last entry in the time zone vector.

tz <- function(x) {
  tzs <- attr(as.POSIXlt(x),"tzone")
  tzs[1]
}

am <- function(x) hour(x) < 12
pm <- function(x) !am(x)



# Set a component of the date to a specified value
# --------------------------------------------------------------------------

# To change a component to a given value, remove or add the difference in 
# seconds between the original time and the time with the desired value.

# Fractional seconds are incuded in the seconds variable
"second<-" <- function(x, value) as.POSIXlt(x) - (second(x) - value)
"minute<-" <- function(x, value) as.POSIXlt(x) - (minute(x) - value) * 60
"hour<-" <- function(x, value) as.POSIXlt(x) - (hour(x) - value) * 3600
"yday<-" <- function(x, value) as.POSIXlt(x) - (yday(x) - value) * 3600 * 24
"wday<-" <- function(x, value) as.POSIXlt(x) - (wday(x) - value) * 3600 * 24
"mday<-" <- function(x, value) as.POSIXlt(x) - (mday(x) - value) * 3600 * 24
"week<-" <- function(x, value) as.POSIXlt(x) - (week(x) - value) * 3600 * 24 * 7


"month<-" <- function(x, value) {
  # Seconds approach no longer applies: months are not of uniformly long
  if(value - trunc(value) != 0) stop("Month must be an integer")
  ISOdatetime(
    year(x) + (value - 1) %/% 12,  # New month values > 12 also change the year
    
    # %% is the modulo operator in R
    (value - 1) %% 12 + 1, 
    mday(x), 
    hour(x), 
    minute(x), 
    second(x), 
    tz(x))
}

"year<-" <- function(x, value) {
  ISOdatetime(value,  month(x), mday(x), hour(x), minute(x), second(x), tz(x))
}
"tz<-" <- function(x, value) {
  ISOdatetime(year(x),  month(x), mday(x), hour(x), minute(x), second(x),
    value)
}

# Modify a date and return changed value. A wrapper for the functions above. 
# ---------------------------------------------------------------------------

# Object is the date we want to change.
# ... is a list of the changes we wish to make. Names must be given.  Names must 
# be in the set (second, minute, hour, yday, wday, mday, week, month, year, 
# tz). 
# Perhaps we should add an error message to clarify this?
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