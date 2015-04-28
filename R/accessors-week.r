#' @include periods.r
NULL

#' Get/set weeks component of a date-time.
#'
#' Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo,
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects. Weeks is
#' the number of complete seven day periods that have occured between the date
#' and January 1st, plus one. \code{isoweek} returns the week as it would appear
#' in the ISO 8601 system, which uses a reoccuring leap week.
#'
#' @param x a date-time object   
#' @param value a numeric object
#' @return the weeks element of x as an integer number
#' @keywords utilities manip chron
#' @references \url{http://en.wikipedia.org/wiki/ISO_week_date}
#' @examples
#' x <- ymd("2012-03-26")
#' week(x) 
#' week(x) <- 1  
#' week(x) <- 54
#' week(x) > 3
#' @export
week <- function(x)
  (yday(x) - 1) %/% 7 + 1

#' @rdname week
#' @export
"week<-" <- function(x, value)
  x <- x + days((value - week(x)) * 7)

#' @rdname week
#' @export
isoweek <- function(x){
  xday <- parse_date_time2(paste(year(x), month(x), day(x)), "Ymd", tz = "UTC")
  ## week day (monday first)
  dn <- 1 + (wday(x) + 5) %% 7
  nth <- xday + ddays(4 - dn)
  jan1 <- parse_date_time2(paste(year(nth), "1", "1"), "Ymd", tz = "UTC") 
  1L + as.integer(difftime(nth,  jan1, units = "days")) %/% 7L
}
