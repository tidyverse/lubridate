#' @include periods.r
NULL

#' Get/set hours component of a date-time.
#'
#' Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, 
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects. 
#'
#' @export hour "hour<-"
#' @aliases hour hour<-
#' @S3method hour default
#' @param x a date-time object   
#' @keywords utilities manip chron methods
#' @return the hours element of x as a decimal number
#' @examples
#' x <- now()
#' hour(x)
#' hour(x) <- 1
#' hour(x) <- 61 
#' hour(x) > 2
hour <- function(x) 
  UseMethod("hour")
  
hour.default <- function(x)
    as.POSIXlt(x, tz = tz(x))$hour
    

"hour<-" <- function(x, value)
  x <- x + hours(value - hour(x))