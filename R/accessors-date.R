#' @include periods.r
NULL

#' Get/set date component of a date-time
#'
#' Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo,
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects.
#'
#' `date()` does not yet support years before 0 C.E.
#' Also `date()` is not defined for Period objects.
#'
#' @section Base compatibility:
#' `date()` can be called without any arguments to return a string representing
#' the current date-time. This provides compatiblity with `base:date()` which
#' it overrides.
#'
#' @param x a date-time object
#' @param value an object for which the `date()` function is defined
#' @return the date of x as a Date
#' @keywords utilities manip chron methods
#' @examples
#' x <- ymd_hms("2012-03-26 23:12:13", tz = "America/New_York")
#' date(x)
#' as.Date(x) # by default as.Date assumes you want to know the date in UTC
#' as.Date(x, tz = "America/New_York")
#' date(x) <- as.Date("2000-01-02")
#' x
#' @export
date <- function(x)
  UseMethod("date")

#' @export
date.default <- function(x) {
  if (missing(x)) {
    base::date()
  } else {
    x <- as.POSIXlt(x, tz = tz(x))
    year <- x$year + 1900
    month <- x$mon + 1
    day <- x$mday
    as.Date(make_datetime(year, month, day))
  }
}
#' @export
date.Period <- function(x)
  stop("date is undefined for Period objects")

#' @rdname date
#' @export
"date<-" <- function(x, value)
  x <- x + days(date(value) - date(x))

setGeneric("date<-")

#' @export
setMethod("date<-", signature("Period"), function(x, value) {
  stop("date<- is undefined for Period objects")
})
