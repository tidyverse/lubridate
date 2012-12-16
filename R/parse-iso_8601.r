################################################################################
#'
#' ymd_hms_z
#'
#' Wrapper for \code{ymd_hms} function where there is a trailing Z. 
#' 
#' This is often found for strings in ISO-8601 format, where Z signifies "UTC".
#' As such, the timezone option is not offered for this format.
#' 
#' Note: the scope of lubridate does not include formatting to strings. 
#' The following format is suggested, first ensuring the instant is expressed
#' as UTC: \code{"\%Y-\%m-\%dT\%H-\%M-\%SZ"}
#' 
#' In the spirit of not writing code where code is not absolutely needed, this 
#' function may be redundant. The only thing it does is force the date-time to
#' be parsed as UTC.
#' 
#' Furthermore, the same thing might be accomplished by tweaking 
#' \code{.parse_xxx}, such that if it "sees" the trailing \code{"Z"}, 
#' it ignores the \code{tz} argument in favor of \code{"UTC"}. This author isn't 
#' confident enough to muck with \code{.parse_xxx}, so he punts instead.
#'
#' @param ... a character vector of dates in year, month, day, hour, minute, 
#'   second format 
#' @param quiet logical. When TRUE function evaluates without displaying customary messages.
#' @param locale locale to be used, see \link{locales}. On linux systems you
#' can use \code{system("locale -a")} to list all the installed locales.
#' @param truncated integer, indicating how many formats can be missing. See details.
#' @return a vector of POSIXct date-time objects
#' @seealso \code{\link{ymd}}, \code{\link{hms}}. \code{\link{parse_date_time}}
#' for underlying mechanism.
#' @keywords POSIXt parse 
#' 
#' @export
#' 
#' @examples
#' my_instant <- ymd_hms_z("2012-03-04T05:06:07Z")
#' format(my_instant, "\%Y-\%m-\%dT\%H:\%M:\%SZ")
#' 
ymd_hms_z <- function(..., quiet = FALSE, locale = Sys.getlocale("LC_TIME"),  truncated = 0){
  # simply a wrapper for ymd_hms, with time-zone set to UTC
  ymd_hms(..., quiet = FALSE, tz="UTC", locale = Sys.getlocale("LC_TIME"),  truncated = 0)
}

################################################################################
#'
#' ymd_hms_o
#'
#' Wrapper for \code{ymd_hms} function where there is a trailing offset
#' 
#' Examples of acceptable formats for the offset are:
#' \code{"+00:00"}, \code{"-05:00"}, \code{"+0100"}, \code{"-06"}.
#' 
#' The same thing might be accomplished by tweaking 
#' \code{.parse_xxx}, such that if it "sees" a trailing \code{"-05:00"},
#' ignores the \code{tz} argument in favor of \code{"UTC"}
#' and applies the offset. This author isn't confident enough to muck with
#' \code{.parse_xxx}, so he punts instead.
#' 
#' @param ... a character vector of dates in year, month, day, hour, minute, 
#'   second format 
#' @param quiet logical. When TRUE function evaluates without displaying customary messages.
#' @param locale locale to be used, see \link{locales}. On linux systems you
#' can use \code{system("locale -a")} to list all the installed locales.
#' @param truncated integer, indicating how many formats can be missing. See details.
#' @return a vector of POSIXct date-time objects, expressed as UTC
#' @seealso \code{\link{ymd}}, \code{\link{hms}}. \code{\link{parse_date_time}}
#' for underlying mechanism.
#' @keywords POSIXt parse 
#' 
#' @export
#' 
#' @examples
#' my_instant <- ymd_hms_o("2012-03-04T05:06:07-05:00")
#' my_offset <- helper_offset(with_tz(my_instant, tz="America/New_York"), sep=":")
#' paste(format(my_instant, "\%Y-\%m-\%dT\%H:\%M:\%S"), my_offset, sep="")
#'
ymd_hms_o <- function(..., quiet = FALSE, locale = Sys.getlocale("LC_TIME"),  truncated = 0){
  
  # regular expression to parse out the trailing offset
  # (.*)          string to be passed to ymd_hms
  # ([+-])        string describing the sign of offset
  # (\\d{2})      string describing hours-component of offset
  # :?            optional colon
  # (\\d{2})      optional string describing the minutes-component of offset 
  re_trail <- "(.*)([+-])(\\d{2}):?(\\d{2})?"
  
  # match the input strings using str_match
  mat_match <- str_match(..., re_trail)
  
  # assign match results
  str_ymd_hms <- mat_match[,2]
  str_sign <- mat_match[,3]
  str_hour <- mat_match[,4]
  str_minute <- mat_match[,5]
  
  # replace "" with "00" in str_minute
  str_minute <- str_replace(str_minute, "^$", "00")
  
  # incorporate sign into offset
  sgn <- ifelse(str_sign=="+", 1, -1)
  
  # calculate the offset as a duration
  offset <- dhours(sgn*as.numeric(str_hour)) + 
            dminutes(sgn*as.numeric(str_minute))

  # calculate the base date-time
  dtm_utc <- ymd_hms(str_ymd_hms, tz="UTC")
  
  # apply the offset
  dtm_utc <- dtm_utc - offset
  
  return(dtm_utc)
  
}

################################################################################
#'
#' helper_offset 
#'
#' function to make a character representation of date-time offset from UTC
#' 
#' uses the timezone associated to the input vector to determine the UTC offset
#' for each member.
#' 
#' @param ... a vector of POSIXct date-time objects
#' @param sep character, hour-minute seperator, default ":"
#' @return a character vector "+HHMM", "-HH:MM", etc.
#' 
#' @export
#' @examples
#' my_instant <- ymd_hms_o("2012-03-04T05:06:07-05:00")
#' my_offset <- helper_offset(with_tz(my_instant, tz="America/New_York"), sep=":")
#' paste(format(my_instant, "\%Y-\%m-\%dT\%H:\%M:\%S"), my_offset, sep="")
#'
helper_offset <- function(..., sep=":"){
  
  # calulate offset by forcing this time as utc
  dtm_utc <- force_tz(..., tz="UTC")
  
  # the offset is the duration represented by the difference in time
  offset_duration = as.duration(dtm_utc - ...)

  # determine sign 
  offset_sign <- ifelse(offset_duration >= 0, "+", "-")
  
  # remove sign
  offset_duration <- abs(offset_duration)
  
  # determine hour
  offset_hour <- floor(offset_duration/dhours(1))
  
  # determine minutes
  offset_minute <- floor((offset_duration-dhours(offset_hour))/dminutes(30))
  
  # assemble string
  str_hm <- paste(sprintf("%02d", offset_hour), 
                  sprintf("%02d", offset_minute), 
                  sep=sep)
  
  # attach sign
  result <- paste(offset_sign, str_hm, sep="")
  
  return(result)
}

