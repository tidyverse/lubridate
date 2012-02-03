#' @include periods.r
NULL

#' Get/set seconds component of a date-time.
#'
#' Date-time must be a  POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, 
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects. 
#'
#' @export second "second<-"
#' @aliases second second<-
#' @S3method second default
#' @param x a date-time object   
#' @return the seconds element of x as a decimal number
#' @keywords utilities manip chron methods
#' @examples
#' x <- now()
#' second(x)
#' second(x) <- 1
#' second(x) <- 61 
#' second(x) > 2
second <- function(x) 
  UseMethod("second")
  
second.default <- function(x)
  as.POSIXlt(x, tz = tz(x))$sec

"second<-" <- function(x, value)
  x <- x + seconds(value - second(x))
  
