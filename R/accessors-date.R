#' @include periods.r
NULL

#' Get/set Date component of a date-time.
#'
#' Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo,
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects.
#'
#' date does not yet support years before 0 C.E. date is not defined for Period
#' objects.
#'
#' @param x a date-time object
#' @param value a numeric object
#' @return the date element of x as a Date
#' @keywords utilities manip chron methods
#' @examples
#' x <- as.POSIXct("2012-03-26 15:14:13", tz = "Etc/GMT+8")
#' date(x)
#' as.Date(x)
#' as.Date(x, tz = "Etc/GMT+8")
#' date(x) <- as.Date("2000-03-26")
#' print(x)
#' @export
date <- function(x)
  UseMethod("date")

#' @export
date.default <- function(x)
  as.Date(paste(year(x), month(x), day(x), sep = "-"))

#' @export
date.Period <- function(x)
  stop("date is undefined for Period objects")

#' @rdname date
#' @export
"date<-" <- function(x, value) {
  year(x) <- year(value)
  month(x) <- month(value)
  day(x) <- day(value)
  x
}

setGeneric("date<-")

#' @export
setMethod("date<-", signature("Period"), function(x, value){
  stop("date<- is undefined for Period objects")
})
