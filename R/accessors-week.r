#' @include periods.r
NULL

#' Get/set weeks component of a date-time.
#'
#' Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, 
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects. Weeks is 
#' the number of complete seven day periods that have occured between the date 
#' and  January 1st, plus one. isoweek returns the week as it would appear in the 
#' ISO 8601 system, which uses a reoccuring leap week.
#'
#' @export week "week<-" isoweek
#' @aliases week week<- isoweek
#' @param x a date-time object   
#' @return the weeks element of x as an integer number
#' @keywords utilities manip chron
#' @examples
#' x <- ymd("2012-03-26")
#' week(x) 
#' week(x) <- 1  
#' week(x) <- 54
#' week(x) > 3
week <- function(x)
  yday(x) %/% 7 + 1

  
"week<-" <- function(x, value)
  x <- x + days((value - week(x)) * 7)


isoweek <- function(x){
  xday <- ISOdate(year(x), month(x), day(x), tz = tz(x))
  dn <- 1 + (wday(x) + 5) %% 7
  nth <- xday + ddays(4 - dn)
  jan1 <- ISOdate(year(nth), 1, 1, tz = tz(x)) 
  1 + (nth - jan1) %/% ddays(7)
}
