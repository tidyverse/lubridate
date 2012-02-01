#' Get Daylight Savings Time indicator of a date-time.
#'
#' Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, 
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects. 
#'
#' A date-time's daylight savings flag can not be set because it depends on the 
#' date-time's year, month, day, and hour values.
#'
#' @export dst
#' @S3method dst default
#' @param x a date-time object   
#' @return Daylight savings time flag. Positive if in force, zero if not, negative if unknown.
#' @keywords utilities chron methods
#' @examples
#' x <- now()
#' dst(x) 
dst <- function(x)
  UseMethod("dst")
  
dst.default <- function(x)
  as.POSIXlt(x)$isdst