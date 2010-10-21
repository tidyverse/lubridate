#' Get/set seconds component of a date-time.
#'
#' Date-time must be a  POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, 
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects. 
#'
#' @export second "second<-"
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
  
  
picosecond <- function(x)
	(second(x) - floor(second(x))) / 10^(-12)
	
"picosecond<-" <- function(x, value)
	x <- x + picoseconds(value - picosecond(x))
	
nanosecond <- function(x)
	(second(x) - floor(second(x))) / 10^(-9)
	
"nanosecond<-" <- function(x, value)
	x <- x + nanoseconds(value - nanosecond(x))
	
microsecond <- function(x)
	(second(x) - floor(second(x))) / 10^(-6)
	
"microsecond<-" <- function(x, value)
	x <- x + microseconds(value - microsecond(x))
	
millisecond <- function(x)
	(second(x) - floor(second(x))) / 10^(-3)
	
"millisecond<-" <- function(x, value)
	x <- x + milliseconds(value - millisecond(x))