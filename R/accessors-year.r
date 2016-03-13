#' @include periods.r
NULL

#' Get/set years component of a date-time.
#'
#' Date-time must be a POSIXct, POSIXlt, Date, Period, chron, yearmon, yearqtr, zoo,
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects.
#'
#' year does not yet support years before 0 C.E.
#'
#' @param x a date-time object
#' @param value a numeric object
#' @return the years element of x as a decimal number
#' @keywords utilities manip chron methods
#' @examples
#' x <- ymd("2012-03-26")
#' year(x)
#' year(x) <- 2001
#' year(x) > 1995
#' @export
year <- function(x)
  UseMethod("year")

#' @export
year.default <- function(x)
    as.POSIXlt(x, tz = tz(x))$year + 1900

#' @export
year.Period <- function(x)
  slot(x, "year")

#' @rdname year
#' @export
"year<-" <- function(x, value)
  x <- x + years(value - year(x))

setGeneric("year<-")

#' @export
setMethod("year<-", signature("Period"), function(x, value){
  slot(x, "year") <- value
  x
})

#' @rdname year
#' @export
isoyear <- function(x) {
  xday <- make_datetime(year(x), month(x), day(x), tz = tz(x))
  dn <- 1 + (wday(x) + 5) %% 7
  nth <- xday + ddays(4 - dn)
  year(nth)
}
