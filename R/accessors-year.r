#' @include periods.r
NULL

#' Get/set years component of a date-time
#'
#' Date-time must be a POSIXct, POSIXlt, Date, Period, chron, yearmon, yearqtr,
#' zoo, zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts
#' objects.
#'
#' year does not yet support years before 0 C.E.
#'
#' @param x a date-time object
#' @param value a numeric object
#' @return the years element of x as a decimal number
#' @keywords utilities manip chron methods
#' @references
#'    \url{https://en.wikipedia.org/wiki/ISO_week_date}
#'    \url{https://www.cmmcp.org/sites/cmmcp/files/uploads/spring_skeeter_06.pdf}
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
"year<-" <- function(x, value) {
  x <- x + years(value - year(x))
}

setGeneric("year<-")

#' @export
setMethod("year<-", signature("Period"), function(x, value) {
  slot(x, "year") <- value
  x
})

.other_year <- function(x, week_start = 1) {
  x <- as.POSIXlt(x)
  date <- make_date(year(x), month(x), day(x))
  isodate <- date + ddays(4 - wday(date, week_start = week_start))
  year(isodate)
}

#' @rdname year
#' @description
#' `isoyear()` returns years according to the ISO 8601 week calendar.
#' @export
isoyear <- function(x) {
  .other_year(x, 1)
}

#' @rdname year
#' @description
#' `epiyear()` returns years according to the epidemilogical week calendars.
#' @export
epiyear <- function(x) {
  .other_year(x, 7)
}
