#' Changes the components of a date object
#'
#' update.Date and update.POSIXt return a date with the specified elements updated. 
#' Elements not specified will be left unaltered. update.Date and update.POSIXt do not 
#' add the specified values to the existing date, they substitute them for the 
#' appropriate parts of the existing date. 
#'
#' 
#' @name DateUpdate
#' @S3method update Date
#' @S3method update POSIXct
#' @S3method update POSIXlt
#' @param object a date-time object  
#' @param years a value to substitute for the date's year component
#' @param months a value to substitute for the date's month component
#' @param ydays a value to substitute for the date's yday component
#' @param wdays a value to substitute for the date's wday component
#' @param mdays a value to substitute for the date's mday component
#' @param days a value to substitute for the date's mday component
#' @param hours a value to substitute for the date's hour component
#' @param minutes a value to substitute for the date's minute component
#' @param seconds a value to substitute for the date's second component
#' @param tzs a value to substitute for the date's tz component
#' @param ... ...
#' @return a date object with the requested elements updated. The object will
#'   retain its original class unless an element is updated which the original
#'   class does not support. In this case, the date returned will be a POSIXlt
#'   date object.
#' @keywords manip chron 
#' @examples
#' date <- as.POSIXlt("2009-02-10") 
#' update(date, year = 2010, month = 1, mday = 1)
#' # "2010-01-01 CST"
#'
#' update(date, year =2010, month = 13, mday = 1)
#' # "2011-01-01 CST"
#'
#' update(date, minute = 10, second = 3)
#' # "2009-02-10 00:10:03 CST"
NULL

update.POSIXct <- function(object, years = year(object), 
	months = month(object), days = mday(object), 
	mdays = mday(object), ydays = yday(object), 
	wdays = wday(object), hours = hour(object), 
	minutes = minute(object), seconds = second(object), 
	tzs = tz(object), ...){
    
  d.length <- max(length(days), length(mdays), length(ydays), length(wdays), length(mday(object)))
  d.length2 <- min(length(days), length(mdays), length(ydays), length(wdays), length(mday(object)))
  
  if(d.length %% d.length2 != 0){
    stop(paste("arguments imply differing day lengths: ", 
      d.length, ", ", d.length2, sep = ""))
  }
    
  day.change <- rbind(
    days - mday(object), 
    mdays - mday(object), 
    wdays - wday(object), 
    ydays - yday(object))
  
  blank.rows <- rowSums(day.change, na.rm = TRUE)
  new.days <- day.change[which(blank.rows != 0),]
  
  if(is.matrix(new.days)){
  	if(nrow(unique(new.days)) > 1) 
    	stop("conflicting days input")
    else
    	new.days <- unique(new.days)
  }

  days <- colSums(rbind(mday(object), new.days), na.rm = TRUE)
  
    
  parts <- data.frame(years, months, days, hours, minutes, seconds)
  

  utc <- as.POSIXlt(force_tz(object, tz = "UTC"))
  
  utc$year <- parts$years - 1900
  utc$mon <- parts$months - 1
  utc$mday <- parts$days
  utc$hour <- parts$hours
  utc$min <- parts$minutes
  utc$sec <- parts$seconds

  bad29 <- which(!leap_year(utc$year) & utc$mon == 1 & utc$mday == 29)
  utc <- as.POSIXct(utc)
  utc[bad29] <- NA
  force_tz(utc, tz = tzs)
}

update.Date <- function(object, years = year(object), months = month(object), 
  days = mday(object), mdays = mday(object), ydays = yday(object), wdays = 
  wday(object), hours = hour(object), minutes = minute(object), seconds = 
  second(object), tzs = tz(object), ...){
    
  time.change <- c(hours - hour(object), minutes - minute(object), 
    seconds - second(object))  
    
  if(sum(time.change) != 0){
    return(update(with_tz(as.POSIXct(object), "UTC"), years = 
    years, months = months, days = days, mdays = mdays, ydays 
    = ydays, wdays = wdays, hours = hours, minutes = minutes, 
    seconds = seconds, tzs = tzs))
  }
    
  as.Date(update(with_tz(as.POSIXct(object), "UTC"), years = years, 
    months = months, days = days, mdays = mdays, ydays = 
    ydays, wdays = wdays, hours = hours, minutes = minutes, 
    seconds = seconds, tzs = tzs))
}

update.POSIXlt <- function(object, years = year(object), months = month(object), 
  days = mday(object), mdays = mday(object), ydays = yday(object), wdays = 
  wday(object), hours = hour(object), minutes = minute(object), seconds = 
  second(object), tzs = tz(object), ...){
  as.POSIXlt(update(as.POSIXct(object), years = years, months = 
    months, days = days, mdays = mdays, ydays = ydays, wdays = 
    wdays, hours = hours, minutes = minutes, seconds = 
    seconds, tzs = tzs))
}

