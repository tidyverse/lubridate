#' @include periods.r
NULL

#' Get/set hours component of a date-time.
#'
#' Date-time must be a POSIXct, POSIXlt, Date, Period, chron, yearmon, yearqtr, zoo,
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects.
#'
#' @export
#' @param x a date-time object
#' @keywords utilities manip chron methods
#' @return the hours element of x as a decimal number
#' @examples
#' x <- ymd("2012-03-26")
#' hour(x)
#' hour(x) <- 1
#' hour(x) <- 25
#' hour(x) > 2
hour <- function(x)
  UseMethod("hour")

#' @export
hour.default <- function(x)
    as.POSIXlt(x, tz = tz(x))$hour

#' @export
hour.Period <- function(x)
  slot(x, "hour")

#' @export
#' @rdname hour
"hour<-" <- function(x, value)
  x <- x + hours(value - hour(x))

setGeneric("hour<-")

#' @export
setMethod("hour<-", signature("Period"), function(x, value){
  slot(x, "hour") <- value
  x
})
