#' Get date-time in a different time zone
#' 
#' with_tz returns a date-time as it would appear in a different time zone.  
#' The actual moment of time measured does not change, just the time zone it is 
#' measured in. with_tz defaults to the Universal Coordinated time zone (UTC) when an unrecognized time zone is inputted. See \code{\link{Sys.timezone}} for more information on how R recognizes time zones.
#'
#' @export with_tz
#' @param time a POSIXct, POSIXlt, Date, or chron date-time object.
#' @param tzone a character string containing the time zone to convert to. R must recognize the name 
#'   contained in the string as a time zone on your system.
#' @return a POSIXct object in the updated time zone
#' @keywords chron manip
#' @seealso \code{\link{force_tz}}
#' @examples
#' x <- as.POSIXct("2009-08-07 00:00:01", tz = "America/New_york")
#' with_tz(x, "GMT")
#' # "2009-08-07 04:00:01 GMT"
with_tz <- function (time, tzone = ""){
  new <- as.POSIXct(format(as.POSIXct(time), tz = tzone), 
    tz = tzone)
  reclass_date(new, time)
}

#' Replace time zone to create new date-time
#' 
#' force_tz returns a the date-time that has the same clock time as x in the new time zone.  
#' Although the new date-time has the same clock time (e.g. the 
#' same values in the year, month, days, etc. elements) it is a 
#' different moment of time than the input date-time. force_tz defaults to the Universal Coordinated time zone (UTC) when an unrecognized time zone is inputted. See \code{\link{Sys.timezone}} for more information on how R recognizes time zones.
#'
#' @export force_tz
#'
#' @param time a POSIXct, POSIXlt, Date, or chron date-time object.
#' @param tzone a character string containing the time zone to convert to. R must recognize the name 
#' contained in the string as a time zone on your system.
#' @return a POSIXct object in the updated time zone
#' @keywords chron manip
#' @seealso \code{\link{force_tz}}
#' @examples
#' x <- as.POSIXct("2009-08-07 00:00:01", tz = "America/New_york")
#' force_tz(x, "GMT")
#' # "2009-08-07 00:00:01 GMT"
force_tz <- function(time, tzone = ""){
  x <- as.POSIXlt(time)
  
  if(is.null(tzone)) tzone <- ""
  new <- ISOdatetime(year(x),  month(x), mday(x), hour(x),
    minute(x), second(x), tzone)
  new[hour(with_tz(new, tzone)) != hour(time)] <- NA
    
  reclass_date(new, time)
}


# Note: alternative method? as.POSIXlt(format(as.POSIXct(x)), tz = tz)