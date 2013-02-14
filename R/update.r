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
update.POSIXt <- function(object, years. = year(object), 
  months. = month(object), hours. = hour(object), 
  minutes. = minute(object), seconds. = second(object), tz. = tz(object),
  days. = NULL, wdays. = NULL, mdays. = NULL, ydays. = NULL, ...){
  
  # just return empty objects
  if(!length(object)) return(object)
  
  xday <- sum(c(!is.null(days.), !is.null(wdays.), !is.null(mdays.), !is.null(ydays.)))
  if (!xday) days. <- mday(object)
  else {
    if (xday > 1) stop("conflicting days input")
    if (!is.null(mdays.)) days. <- mdays.
    else if (!is.null(wdays.)) days. <- wdays. - wday(object) + day(object)
    else if (!is.null(ydays.)) days. <- ydays. - yday(object) + day(object)
  }  
  
  lt <- structure(list(sec = seconds., 
                       min = minutes., 
                       hour = hours., 
                       mday = days., 
                       mon = months. - 1,
                       year = years. - 1900,
                       wday = NULL,
                       yday = NULL,
                       isdst = NULL), 
                  tzone = tz.,
                  class = c("POSIXlt", "POSIXt"))
  
  ct <- as.POSIXct(lt) 
  
  # tests whether time is invalid due to daylight savings gap
  ct[hour(ct) != hour(format(lt))] <- NA
  reclass_date(ct, object)
}

#' @export
#' @method update Date
update.Date <- function(object, years. = year(object), 
  months. = month(object), tz. = tz(object), 
  hours. = 0, minutes. = 0, seconds. = 0, wdays. = NULL, 
  mdays. = NULL, ydays. = NULL, days. = NULL, ...){ 
  
  ct <- as.POSIXct(object)
  attr(ct, "tzone") <- "UTC"
  
  new <- update(ct, years. = years., months. = months., 
    days. = days., mdays. = mdays., ydays. = ydays., wdays. = wdays., 
    hours. = hours., minutes. = minutes., seconds. = seconds., 
    tzs. = tzs.)
  
  if (sum(na.omit(c(hours., minutes., seconds.)))) {
    new
  } else {
    as.Date(new)
  }
}