#' @include periods.r
NULL

#' Get/set Date component of a date-time.
#'
#' Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo,
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects.
#'
#' \code{date} does not yet support years before 0 C.E.
#' Also \code{date} is not defined for Period objects.
#'
#' @param x a date-time object
#' @param value an object for which the \code{date()} function is defined
#' @return the date of x as a Date
#' @keywords utilities manip chron methods
#' @examples
#' x <- as.POSIXct("2012-03-26 23:12:13", tz = "Etc/GMT+8")
#' date(x)
#' as.Date(x) # by default as.Date assumes you want to know the date in UTC
#' as.Date(x, tz = "Etc/GMT+8")
#' date(x) <- as.Date("2000-01-02")
#' x
#' @export
date <- function(x)
  UseMethod("date")

#' @export
date.default <- function(x) {
  x <-  as.POSIXlt(x, tz = tz(x))
  year <- x$year + 1900
  month <- x$mon + 1
  day <- x$mday

  as.Date(make_datetime(year, month, day))
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
setMethod("date<-", signature("Period"), function(x, value){
  stop("date<- is undefined for Period objects")
})
