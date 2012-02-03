#' @include periods.r
NULL

#' Get/set weeks component of a date-time.
#'
#' Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, 
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects. Weeks is 
#' the number of complete seven day periods that have occured between the date 
#' and  January 1st, plus one. 
#'
#' @export week "week<-"
#' @aliases week week<-
#' @param x a date-time object   
#' @return the weeks element of x as an integer number
#' @keywords utilities manip chron
#' @examples
#' x <- now()
#' week(x) 
#' week(x) <- 1  
#' week(x) <- 54
#' week(x) > 3
week <- function(x)
  yday(x) %/% 7 + 1

  
"week<-" <- function(x, value)
  x <- x + days((value - week(x)) * 7)
