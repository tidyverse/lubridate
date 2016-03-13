#' Get Daylight Savings Time indicator of a date-time.
#'
#' Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo,
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects.
#'
#' A date-time's daylight savings flag can not be set because it depends on the
#' date-time's year, month, day, and hour values.
#'
#' @export
#' @param x a date-time object
#' @return A logical. TRUE if DST is in force, FALSE if not, NA if unknown.
#' @keywords utilities chron methods
#' @examples
#' x <- ymd("2012-03-26")
#' dst(x)
dst <- function(x)
  UseMethod("dst")

#' @export
dst.default <- function(x)
  c(NA, FALSE, TRUE)[as.POSIXlt(x)$isdst + 2]
