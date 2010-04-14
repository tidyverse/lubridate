
#' Get Daylight Savings Time indicator of a date-time.
#'
#' Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, 
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects. 
#'
#' A date-time's daylight savings flag can not be set because it depends on the 
#' date-time's year, month, day, and hour values.
#'
#' @aliases dst dst.default dst.zoo dst.its dst.ti dst.timeseries dst.fts dst.irts
#' @param x a date-time object   
#' @return Daylight savings time flag. Positive if in force, zero if not, negative if unknown.
#' @seealso \code{\link{DaylightSavingsTime}}
#' @keywords utilities chron methods
#' @examples
#' x <- now()
#' dst(x) 
dst <- function(x)
  UseMethod("dst")
  
dst.default <- function(x)
  as.POSIXlt(x)$isdst




#' Changes the components of a date object
#'
#' update.Date and update.POSIXt return a date with the specified elements updated. 
#' Elements not specified will be left unaltered. update.Date and update.POSIXt do not 
#' add the specified values to the existing date, they substitute them for the 
#' appropriate parts of the existing date. 
#'
#' 
#' @method update Date
#' @method update POSIXt
#' @method update POSIXct
#' @method update POSIXlt
#' @param object a date-time object  
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
#' @return a date object with the requested elements updated. The object will retain its original class unless an element is updated which the original class does not support. In this case, the date returned will be a POSIXlt date object.
#' @keywords manip chron 
#' @examples
#' date <- as.POSIXlt("2009-02-10") 
#' update(date, year = 2010, month = 1, mday = 1)
#' # "2010-01-01 CST"
#'
#' update(date, year =2010, month = 13, mday = 1)
#' # "2011-01-01 CST"
#'
#' update(date, yday = 35, wday = 4, mday = 3) 
#' # "2009-02-03 CST"
#'
#' update(date, minute = 10, second = 3)
#' # "2009-02-10 00:10:03 CST"
update.Date <- update.POSIXt <- function(x, years = year(x), 
	months = month(x), days = mday(x), hours = hour(x), minutes = 
	minute(x), seconds = second(x), tzs = attr(as.POSIXlt(x), 	"tzone")){
		
	parts <- data.frame(years, months, days, hours, minutes, seconds)
	

	utc <- as.POSIXlt(force_tz(x, tz = "UTC"))
	
	utc$year <- parts$years - 1900
	utc$mon <- parts$months - 1
	utc$mday <- parts$days
	utc$hour <- parts$hours
	utc$min <- parts$minutes
	utc$sec <- parts$seconds

	force_tz(utc, tz = tz(x))
}


#' Internal function
#'
#' @keywords internal
standardise_date_names <- function(x) {
  dates <- c("second", "minute", "hour", "mday", "wday", "yday", "day", "week", "month", "year", "tz")
  y <- gsub("(.)s$", "\\1", x)
  res <- dates[pmatch(y, dates)]
  if (any(is.na(res))) {
    stop("Invalid unit name: ", paste(x[is.na(res)], collapse = ", "), 
      call. = FALSE)
  }
  res
}


#' Converts a date to a decimal of its year. 
#'
#' @aliases decimal_date decimal.date decimal_date.default decimal_date.zoo decimal_date.its
#' @param date a POSIXt or Date object   
#' @return a numeric object where the date is expressed as a fraction of its year
#' @keywords manip chron methods
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

#' Returns just the months component of a duration. 
#'
#' @param dur a duration object 
#' @return the number of months as well as the number of years (as months) contained in a duration. 
#'   See \code{link{duration}} for further details.   
#' @seealso \code{\link{just_seconds}}
#' @keywords utilities chron
#' @examples
#' x <- new_duration(year = 1, month = 4, day = 30, hour = 2, second = 1)
#' x # 1 year, 4 months, 4 weeks, 2 days, 2 hours and 1 second
#' just_months(x)  # 16
just_months <- function(dur)
  as.numeric(dur) %/% 10^11

#' Returns just the seconds component of a duration. 
#'
#' @param dur a duration object  
#' @return the number of weeks, days, hours, minutes, and seconds in a duration as seconds. See 
#'   \code{\link{duration}} for further details.
#' @seealso \code{\link{just_months}}
#' @keywords utilities chron
#' @examples
#' x <- new_duration(year = 1, month = 4, day = 30, hour = 2, second = 1)
#' x # 1 year, 4 months, 4 weeks, 2 days, 2 hours and 1 second
#' just_seconds(x)  # 2599201
just_seconds <- function(dur)
  as.numeric(dur) %% 10^11 - 50000000000

#' Internal function. Is an object in a recognized date format?
#'
#' @param x an R object
#' @return TRUE if x is a POSIXlt, POSIXct, yearmon, yearqtr, or Date object, FALSE otherwise.
#' @keywords internal
recognize <- function(x){
  recognized <- c("POSIXt", "POSIXlt", "POSIXct", "yearmon", "yearqtr", "Date")
  
  if (all(class(x) %in% recognized))
    return(TRUE)
  return(FALSE)
}

