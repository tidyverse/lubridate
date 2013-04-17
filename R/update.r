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
  
  class(date) <- "list"
  date[names(units)] <- units
  date[c("wday", "yday", "isdst")] <- list(wday = NA, yday = NA, isdst = NA)  
  class(date) <- c("POSIXlt", "POSIXt")
  
  if (!is.na(new.tz)) attr(date, "tzone") <- new.tz

  ct <- as.POSIXct(date)
  
  if (attr(date, "tzone")[1] == "UTC") return(reclass_date(ct, object))
  
  # check for dst discrepancies
  
  # spring gap
  utc <- date
  attr(utc, "tzone") <- "UTC"
  uhours <- .Internal(format.POSIXlt(utc, "%H", usetz = FALSE))
  chours <- .Internal(format.POSIXlt(as.POSIXlt(ct), "%H", usetz = FALSE))
  
  ct[uhours != chours] <- NA
  
  # fall gap - hours same but isdst changed?
  
  reclass_date(ct, object)

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