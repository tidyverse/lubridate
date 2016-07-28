#' @include periods.r
NULL

#' Get/set seconds component of a date-time.
#'
#' Date-time must be a  POSIXct, POSIXlt, Date, Period, chron, yearmon, yearqtr, zoo,
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects.
#'
#' @export
#' @param x a date-time object
#' @return the seconds element of x as a decimal number
#' @keywords utilities manip chron methods
#' @examples
#' x <- ymd("2012-03-26")
#' second(x)
#' second(x) <- 1
#' second(x) <- 61
#' second(x) > 2
second <- function(x)
  UseMethod("second")

#' @export
second.default <- function(x)
  as.POSIXlt(x, tz = tz(x))$sec

#' @export
second.Period <- function(x)
  slot(x, ".Data")

#' @rdname second
#' @export
"second<-" <- function(x, value)
  x <- x + seconds(value - second(x))


setGeneric("second<-")

#' @export
setMethod("second<-", signature("Period"), function(x, value){
  slot(x, ".Data") <- value
  x
})
