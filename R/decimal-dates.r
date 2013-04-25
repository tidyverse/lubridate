#' Converts a date to a decimal of its year. 
#'
#' @export decimal_date 
#' @S3method decimal_date default 
#' @S3method decimal_date zoo 
#' @S3method decimal_date its
#' @param date a POSIXt or Date object   
#' @return a numeric object where the date is expressed as a fraction of its year
#' @keywords manip chron methods
#' @examples
#' date <- ymd("2009-02-10")
#' decimal_date(date)  # 2009.11
decimal_date <- function(date)
  UseMethod("decimal_date")
  
decimal_date.default <- function(date){

  if(any(!inherits(date, c("POSIXt", "POSIXct", "POSIXlt", "Date"))))
    stop("date(s) not in POSIXt or Date format")
  
  decimal <- as.numeric(difftime(date, floor_date(date, "year"), units = "secs"))
  nonzero <- decimal != 0
  decimal[nonzero] <- decimal[nonzero]/as.numeric(difftime(ceiling_date(date[nonzero], 
  "year"), floor_date(date[nonzero], "year"), units = "secs"))
  
    year(date) + decimal
}

decimal_date.zoo <- function(date)
  decimal_date(zoo::index(date))

decimal_date.its <- function(date)
  decimal_date.default(attr(date, "dates"))


#' Converts a decimal to a date. 
#'
#' @export 
#' @param decimal a numeric object   
#' @param tz the time zone required
#' @return a POSIXct object, whose year corresponds to the integer part of 
#' decimal. The months, days, hours, minutes and seconds elements are picked so 
#' the date-time will accurately represent the fraction of the year expressed by
#' decimal.
#' @keywords manip chron methods
#' @examples
#' date <- ymd("2009-02-10")
#' decimal <- decimal_date(date)  # 2009.11
#' date_decimal(decimal) # "2009-02-10 UTC"
date_decimal <- function(decimal, tz = NULL) {
  year <- trunc(decimal)
  frac <- decimal - year
  start <- ymd(paste(year, "01", "01"))
  seconds <- as.numeric(ymd(paste(year + 1, "01", "01")) - start, units = "secs")
  
  if (!is.null(tz)) start <- force_tz(start, tz)
  start + seconds * frac
}
  
