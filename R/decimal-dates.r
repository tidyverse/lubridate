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
  
decimal <- as.numeric(difftime(date, floor_date(date, "year"), 
  units = "secs"))/as.numeric(difftime(ceiling_date(date, 
  "year"), floor_date(date, "year"), units = "secs"))
  
    year(date) + decimal
}

decimal_date.zoo <- function(date)
  decimal_date(zoo::index(date))

decimal_date.its <- function(date)
  decimal_date.default(attr(date, "dates"))