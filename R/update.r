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
#' @S3method update POSIXt
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

#' @export
#' @method update POSIXt
update.POSIXt <- update.POSIXct <- update.POSIXlt <- function(object, ...){
  
  if(!length(object)) return(object)
  date <- as.POSIXlt(object)
  
  # adjudicate units input
  units <- list(...)
  names(units) <- standardise_lt_names(names(units))
  
  new.tz <- NA
  if (!is.null(units$tz)) {
    new.tz <- units$tz
    units$tz <- NULL
  }
  
  day.units <- c("day", "wday", "mday", "yday")
  ndays <- day.units %in% names(units)
  n <- sum(ndays)
  
  if (n > 1) stop("conflicting days input")
  if (n) {
    day <- day.units[ndays]
    if (day != "mday") {
      names(units)[names(units) == day] <- "mday"
    if (day != "day")
      units$mday <- units$mday - date[[day]] + date$mday - 1
    }
  }  
  
  if (!is.null(units$mon)) units$mon <- units$mon - 1
  if (!is.null(units$year)) units$year <- units$year - 1900
  
  # make new date-times
  class(date) <- "list"
  date[names(units)] <- units
  date[c("wday", "yday")] <- list(wday = NA, yday = NA)  
  class(date) <- c("POSIXlt", "POSIXt")
  if (!is.na(new.tz)) attr(date, "tzone") <- new.tz
  
  # fit to timeline
  # POSIXct format avoids negative and NA elements in POSIXlt format
  ct <- fit_to_timeline(date)
  reclass_date(ct, object)
  
}
  

#' Fit a POSIXlt date-time to the timeline
#' 
#' The POSIXlt format allows you to create instants that do not exist in 
#' real life due to daylight savings time and other conventions. fit_to_timeline
#' matches POSIXlt date-times to a real times. If an instant does not exist, fit 
#' to timeline will replace it with an NA. If an instant does exist, but has 
#' been paired with an incorrect timezone/daylight savings time combination, 
#' fit_to_timeline returns the instant with the correct combination.
#'
#'
#' @export fit_to_timeline
#' @param lt a POSIXlt date-time object.
#' @param class a character string that describes what type of object to return, 
#' POSIXlt or POSIXct. Defaults to POSIXct.
#' @return a POSIXct or POSIXlt object that contains no illusory date-times
#'
#' @examples
#' \dontrun{
#' tricky <- structure(list(sec = c(0, 0, 0, -1), min = c(0L, 5L, 0L, 0L), 
#' hour = c(2L, 0L, 2L, 2L), mday = c(4L, 4L, 14L, 4L), mon = c(10L, 10L, 2L, 10L), 
#' year = c(112L, 112L, 110L, 112L), wday = c(0L, 0L, 0L, 0L), 
#' yday = c(308L, 308L, 72L, 308L), isdst = c(1L, 0L, 1L, 1L)), 
#' .Names = c("sec", "min", "hour", "mday", "mon", "year", "wday", "yday", 
#' "isdst"), class = c("POSIXlt", "POSIXt"), tzone = c("America/Chicago", "CST", "CDT"))
#' tricky
#' ## [1] "2012-11-04 02:00:00 CDT" Doesn't exist 
#' ## because clocks "fall back" to 1:00 CST
#' 
#' ## [2] "2012-11-04 00:05:00 CST" Times are still 
#' ## CDT, not CST at this instant
#' 
#' ## [3] "2010-03-14 02:00:00 CDT" Doesn't exist 
#' ##because clocks "spring forward" past this time 
#' ## for daylight savings
#' 
#' ## [4] "2012-11-04 01:59:59 CDT" Does exist, but 
#' ## has deceptive internal structure
#' 
#' fit_to_timeline(tricky)
#' ## [1] "2012-11-04 02:00:00 CST" instant paired 
#' ## with correct timezone & DST combination
#' 
#' ## [2] "2012-11-04 00:05:00 CDT" instant paired 
#' ## with correct timezone & DST combination
#' 
#' ## [3] NA fake time changed to NA (compare to as.POSIXct(tricky))
#' ## [4] "2012-11-04 01:59:59 CDT" real instant, left as is
#' }
fit_to_timeline <- function(lt, class = "POSIXct") {
  if (class != "POSIXlt" && class != "POSIXct")
    stop("class argument must be POSIXlt or POSIXct")
  
  # fall break - DST only changes if it has to
  ct <- as.POSIXct(lt)
  t <- lt
  t$isdst <- as.POSIXlt(ct)$isdst
  
  # spring break
  ct <- as.POSIXct(t) # should directly match if not in gap
  chours <- format.POSIXlt(as.POSIXlt(ct), "%H", usetz = FALSE)
  lhours <- format.POSIXlt(t, "%H", usetz = FALSE)
  
  if (class == "POSIXlt") {
    t[chours != lhours] <- NA
    t
  } else {
    ct[chours != lhours] <- NA
    ct
  }
}
  




#' @export
#' @method update Date
update.Date <- function(object, ...){ 
  
  lt <- as.POSIXlt(object, tz = "UTC")
  
  new <- update(lt, ...)
  
  if (sum(c(new$hour, new$min, new$sec))) {
    new
  } else {
    as.Date(new)
  }
}
