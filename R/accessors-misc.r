
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
#' update is a wrapper function for \code{\link{year}}, \code{\link{month}},
#' \code{\link{week}}, \code{\link{yday}}, \code{\link{wday}}, \code{\link{mday}},
#' \code{\link{hour}},
#' \code{\link{minute}}, \code{\link{second}} and \code{\link{tz}}. It returns a date with
#' the specified elements updated. Elements not specified will be left
#' unaltered. Update.Date does not add the specified values to the existing
#'  date, it substitutes them for the appropriate parts of the existing date. 
#'
#' update implements changes in the order year, month, week, yday, wday,
#' mday, hour, minute, second, tz.  If conflicting requests are set, requests
#' that occur later in the order will overwrite those that occur earlier.  If
#' a request causes spillover to another component (such as 13 months, which 
#' spills over to 1 year and 1 month) this spillover will be added to any 
#' requests inputed for the first category (see examples).
#'
#' If the seconds, minutes, or hours element is updated, a POSIXt object will 
#' be returned, even when object is a Date object.  Date objects do not support
#' seconds, minutes, or hours. R recognizes Date objects as having an initial 
#' value of zero for hours, minutes, and seconds in the "UTC" time zone. Since 
#' Date objects are displayed in the "UTC" time zone and as.POSIXt objects are 
#' displayed in the preset system time zone of your computer, a change in clock
#' time will normlly occur when the class of the object switches. Both clock times 
#' will still refer to the same instant of time, but in different time zones.
#' 
#' A date-time element may be updated to a vector of numbers. update will 
#' return a vector of updated times, one for each element. If multiple elements
#' are updated to vectors of numbers, update will return a vector of dates that
#' reflects all combinations of the updated elements.
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
update.Date <- update.POSIXt <- function(object, ...) {
  object <- as.POSIXct(object)

  todo <- list(...)
  names(todo) <- standardise_date_names(names(todo))
  
  operation_order <- c("year", "month", "week", "yday", "mday", "wday",
    "hour", "minute", "second", "tz")
  
  todo <- todo[intersect(operation_order, names(todo))]

  for(component in names(todo)) {
    settor <- match.fun(paste(component, "<-", sep = ""))
    object <- settor(object, todo[[component]])
  }
  
  object
}


#' Internal function
#'
#' @keywords internal
standardise_date_names <- function(x) {
  dates <- c("second", "minute", "hour", "mday", "wday", "yday", "day", "week", "month", "year", "tz")
  y <- gsub("(.)s$", "\\1", x)
  res <- dates[pmatch(y, dates)]
  if (any(is.na(res))) {
    stop("Invalid date name: ", paste(x[is.na(res)], collapse = ", "), 
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


#' Internal function for Daylight Savings Time changes.
#'
#' Determines how to handle time changes resulting from Daylight Savings time 
#' based on options("DST"). See \code{\link{DaylightSavingsTime}}.
#'
#' @aliases DST DST.months 
#' @keywords internal
DST <- function(date1, date2){
  if(is.Date(date2))
    return(date2)
    
  date1 <- as.POSIXlt(date1)
  date2 <- as.POSIXlt(date2)

  if(dst(date1) < 0 || dst(date2) < 0)
    return(date2)

  date2 - (dst(date2) - dst(with_tz(date1, tz(date2))))*3600
}

DST.months <- function(date1, date2){
  if(is.Date(date2))
    return(date2)
  date1 <- as.POSIXlt(date1)
  date2 <- as.POSIXlt(date2)

  if(dst(date1) < 0 || dst(date2) < 0)
    return(date2)

  suppressMessages(date2 + (dst(date2) - with_tz(date1, tz(date2)))*3600)
}