#' @include periods.r
NULL

#' Get/set weeks component of a date-time
#'
#' @description
#' `week()` returns the number of complete seven day periods that have
#' occurred between the date and January 1st, plus one.

#' @param x a date-time object. Must be a POSIXct, POSIXlt, Date, chron,
#'   yearmon, yearqtr, zoo, zooreg, timeDate, xts, its, ti, jul, timeSeries, or
#'   fts object.
#' @param value a numeric object
#' @return the weeks element of x as an integer number
#' @keywords utilities manip chron
#' @references
#'    \url{https://en.wikipedia.org/wiki/ISO_week_date}
#' @seealso [isoyear()]
#' @examples
#' x <- ymd("2012-03-26")
#' week(x)
#' week(x) <- 1
#' week(x) <- 54
#' week(x) > 3
#' @export
week <- function(x) {
  (yday(x) - 1) %/% 7 + 1
}

#' @rdname week
#' @export
"week<-" <- function(x, value) {
  x <- x + days((value - week(x)) * 7)
}

.other_week <- function(x, week_start) {
  x <- as.POSIXlt(x)
  date <- make_date(year(x), month(x), day(x))
  wday <- wday(x, week_start = week_start)
  date <- date + (4 - wday)
  jan1 <- as.numeric(make_date(year(date), 1, 1))
  1L + (as.numeric(date) - jan1) %/% 7L
}

#' @description `isoweek()` returns the week as it would appear in the ISO 8601
#'   system, which uses a reoccurring leap week.
#' @rdname week
#' @export
isoweek <- function(x) {
  .other_week(x, 1)
}

#' @description `epiweek()` is the US CDC version of epidemiological week. It
#'   follows same rules as `isoweek()` but starts on Sunday. In other parts of
#'   the world the convention is to start epidemiological weeks on Monday,
#'   which is the same as `isoweek`.
#'
#' @rdname week
#' @export
epiweek <- function(x) {
  .other_week(x, 7)
}
