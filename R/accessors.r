# Extract components from a date
# -----------------------------------------------------------

# Converts to a recognizable date format to POSIXlt list format, then extract 
#   desired information.
# Note: The origin refers to the origin time in GMT
second <- function(x, origin = "1970-01-01") as.POSIXlt(x, origin = origin)$sec
minute <- function(x, origin = "1970-01-01") as.POSIXlt(x, origin = origin)$min
hour <- function(x, origin = "1970-01-01") as.POSIXlt(x, origin = origin)$hour
yday <- function(x, origin = "1970-01-01") as.POSIXlt(x, origin = origin)$yday + 1
wday <- function(x, origin = "1970-01-01") as.POSIXlt(x, origin = origin)$wday + 1
mday <- function(x, origin = "1970-01-01") as.POSIXlt(x, origin = origin)$mday
week <- function(x, origin = "1970-01-01") yday(x, origin = origin) %/% 7 + 1
month <- function(x, origin = "1970-01-01") as.POSIXlt(x, origin = origin)$mon + 1
year <- function(x, origin = "1970-01-01") as.POSIXlt(x, origin = origin)$year + 1900

# Extract the last entry in the time zone vector.
# Note: Should this be the first entry? It appears that the last entry will 
#   sometimes be the base timezone and sometimes the daylight savings alternate 
#   time zone. On the otherhand, the first entry is often "".
tz <- function(x, origin = "1970-01-01") {
  tzs <- attr(as.POSIXlt(x, origin = origin),"tzone")
  tzs[length(tzs)]
}

# am is true iff the time is before 12:00 noon, otherwise pm is true 
am <- function(x, origin = "1970-01-01") hour(x, origin) < 12
pm <- function(x, origin = "1970-01-01") !am(x, origin)


# Set components of a date, modifying the value in place
# (Set a component of the date to a specified value)
# --------------------------------------------------------------------------

# To change a component to a given value, remove or add the difference in 
#   seconds between the original time and the time with the desired value.

#Note: If present, fractional seconds will remain. Do we want to discard these 
#  when we set a value? Maybe just when we set the seconds value?
"second<-" <- function(x, value, origin = "1970-01-01") as.POSIXlt(x, origin = origin) - (second(x, origin) - value)
"minute<-" <- function(x, value, origin = "1970-01-01") as.POSIXlt(x, origin = origin) - (minute(x, origin) - value) * 60
"hour<-" <- function(x, value, origin = "1970-01-01") as.POSIXlt(x, origin = origin) - (hour(x, origin) - value) * 3600
"yday<-" <- function(x, value, origin = "1970-01-01") as.POSIXlt(x, origin = origin) - (yday(x, origin) - value) * 3600 * 24
"wday<-" <- function(x, value, origin = "1970-01-01") as.POSIXlt(x, origin = origin) - (wday(x, origin) - value) * 3600 * 24
"mday<-" <- function(x, value, origin = "1970-01-01") as.POSIXlt(x, origin = origin) - (mday(x, origin) - value) * 3600 * 24
"week<-" <- function(x, value, origin = "1970-01-01") as.POSIXlt(x, origin = origin) - (week(x, origin) - value) * 3600 * 24 * 7

# Create a new POSIXlt date using the components of our old date with a modified 
#    month value.  A new month value > 12, affects both the year and month values.

"month<-" <- function(x, value, origin = "1970-01-01") {
  ISOdatetime(
    year(x, origin) + (value - 1) %/% 12,  
    
    # %% is the modulo operator in R
    (value - 1) %% 12 + 1, 
    mday(x, origin), 
    hour(x, origin), 
    minute(x, origin), 
    second(x, origin), 
    tz(x, origin))
}
"year<-" <- function(x, value, origin = "1970-01-01") {
  ISOdatetime(value,  month(x, origin), mday(x, origin), hour(x, origin), minute(x, origin), second(x, origin), tz(x, origin))
}
"tz<-" <- function(x, value, origin = "1970-01-01") {
  ISOdatetime(year(x, origin),  month(x, origin), mday(x, origin), hour(x, origin), minute(x, origin), second(x, origin),
    value)
}

# Modify a date and return changed value
# (This is a wrapper(?) for the functions above. Allows more than one change at 
#   a time.)
# ---------------------------------------------------------------------------

# Object is the date we want to change.
# ... is a list of the changes we wish to make. Names must be given.  Names must 
#   be in the set (second, minute, hour, yday, wday, mday, week, month, year, 
#   tz). 
# Perhaps we should add an error message to clarify this?
update.Date <- update.POSIXt <- function(object, , origin = "1970-01-01", ...) {

  # a list of the changes we wish to make
  changes <- list(...)
  
  for(change in names(changes)) {

    # for each change, we select the function we will need to use
    f <- match.fun(paste(change, "<-", sep = ""))
    
    # we update the date with the new change
    object <- f(object, changes[[change]], origin)
  }
  object
}

# Note: if a user inputs a change that would "rollover" to affect more than one 
#   component, the order in which the desired changes are listed will affect the #   answer. 
# For example, object <- 1-01-2000, and changes are year = 2001, month = 12.  
#   If month is listed before year, update.Date will return 1-01-2001. 
#   If year is listed before month, update.Date will return 1-01-2002.