# Extract components from a date
# -----------------------------------------------------------

# Convert a recognizable date format to POSIXlt list format, then extract 
#   desired information.
# Note: The as.POSIXlt() function appears to need a second input "origin" (the 
#   date from which seconds have been measured) for many (all?) forms of x
second <- function(x) as.POSIXlt(x)$sec
minute <- function(x) as.POSIXlt(x)$min
hour <- function(x) as.POSIXlt(x)$hour
yday <- function(x) as.POSIXlt(x)$yday + 1
wday <- function(x) as.POSIXlt(x)$wday + 1
mday <- function(x) as.POSIXlt(x)$mday
week <- function(x) yday(x) %/% 7 + 1
month <- function(x) as.POSIXlt(x)$mon + 1
year <- function(x) as.POSIXlt(x)$year + 1900

# Extract the last entry in the time zone vector.
# Note: Should this be the first entry? It appears that the last entry will 
#   sometimes be the base timezone and sometimes the daylight savings alternate 
#   time zone.
tz <- function(x) {
  tzs <- attr(as.POSIXlt(x),"tzone")
  tzs[length(tzs)]
}

# am is true iff the time is before 12:00 noon, otherwise pm is true 
am <- function(x) hour(x) < 12
pm <- function(x) !am(x)


# Set components of a date, modifying the value in place
# (Set a component of the date to a specified value)
# --------------------------------------------------------------------------

# To change a component to a given value, remove or add the difference in 
#   seconds between the original time and the time with the desired value.

#Note: If present, fractional seconds will remain. Do we want to discard these 
#  when we set a value? Maybe just when we set the seconds value?
"second<-" <- function(x, value) as.POSIXlt(x) - (second(x) - value)
"minute<-" <- function(x, value) as.POSIXlt(x) - (minute(x) - value) * 60
"hour<-" <- function(x, value) as.POSIXlt(x) - (hour(x) - value) * 3600
"yday<-" <- function(x, value) as.POSIXlt(x) - (yday(x) - value) * 3600 * 24
"wday<-" <- function(x, value) as.POSIXlt(x) - (wday(x) - value) * 3600 * 24
"mday<-" <- function(x, value) as.POSIXlt(x) - (mday(x) - value) * 3600 * 24
"week<-" <- function(x, value) as.POSIXlt(x) - (week(x) - value) * 3600 * 24 * 7

# Create a new POSIXlt date using the components of our old date with a modified 
# month value.  A new month value > 12, affects both the year and month values.

"month<-" <- function(x, value) {
  ISOdatetime(
    year(x) + (value - 1) %/% 12,  
    
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

# Modify a date and return changed value
# (This is a wrapper(?) for the functions above. Allows more than one change at 
#   a time.)
# ---------------------------------------------------------------------------

# Object is the date we want to change.
# ... is a list of the changes we wish to make. Names must be given.  Names must 
#   be in the set (second, minute, hour, yday, wday, mday, week, month, year, 
#   tz). 
# Perhaps we should add an error message to clarify this?
update.Date <- update.POSIXt <- function(object, ...) {

  # a list of the changes we wish to make
  changes <- list(...)
  
  for(change in names(changes)) {

    # for each change, we select the function we will need to use
    f <- match.fun(paste(change, "<-", sep = ""))
    
    # we update the date with the new change
    object <- f(object, changes[[change]])
  }
  object
}

# Note: if a user inputs a change that would "rollover" to affect more than one 
#   component, the order in which the desired changes are listed will affect the #   answer. 
# For example, object <- 1-01-2000, and changes are year = 2001, month = 12.  
#   If month is listed before year, update.Date will return 1-01-2001. 
#   If year is listed before month, update.Date will return 1-01-2002.