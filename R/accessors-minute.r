#' @include periods.r
NULL

#' Get/set minutes component of a date-time.
#'
#' Date-time must be a  POSIXct, POSIXlt, Date, Period, chron, yearmon, yearqtr, zoo,
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects.
#'
#' @export
#' @param x a date-time object
#' @keywords utilities manip chron methods
#' @return the minutes element of x as a decimal number
#' @examples
#' x <- ymd("2012-03-26")
#' minute(x)
#' minute(x) <- 1
#' minute(x) <- 61
#' minute(x) > 2
minute <- function(x)
  UseMethod("minute")

#' @export
minute.default <- function(x)
  as.POSIXlt(x, tz = tz(x))$min

#' @export
minute.Period <- function(x)
  slot(x, "minute")

#' @rdname minute
#' @export
"minute<-" <- function(x, value)
  x <- x + minutes(value - minute(x))

setGeneric("minute<-")

#' @export
setMethod("minute<-", signature("Period"), function(x, value){
  slot(x, "minute") <- value
  x
})
