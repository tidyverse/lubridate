#' @include periods.r
NULL

#' Get/set weeks component of a date-time.
#'
#' \code{week} returns the number of complete seven day periods that have
#' occured between the date and January 1st, plus one.\cr
#' \code{isoweek} returns the week as it would appear in the ISO 8601 system,
#' which uses a reoccuring leap week.
#'
#' @param x a date-time object. Must be a POSIXct, POSIXlt, Date, chron,
#'   yearmon, yearqtr, zoo, zooreg, timeDate, xts, its, ti, jul, timeSeries, or
#'   fts object.
#' @param value a numeric object
#' @return the weeks element of x as an integer number
#' @keywords utilities manip chron
#' @references \url{http://en.wikipedia.org/wiki/ISO_week_date}
#' @seealso \code{\link{isoyear}}
#' @examples
#' x <- ymd("2012-03-26")
#' week(x)
#' week(x) <- 1
#' week(x) <- 54
#' week(x) > 3
#' @export
week <- function(x)
  (yday(x) - 1) %/% 7 + 1

#' @rdname week
#' @export
"week<-" <- function(x, value)
  x <- x + days((value - week(x)) * 7)

#' @rdname week
#' @export
isoweek <- function(x){
  xday <- make_datetime(year(x), month(x), day(x))
  ## week day (monday first)
  dn <- 1 + (wday(x) + 5) %% 7
  nth <- xday + ddays(4 - dn)
  jan1 <- make_datetime(year(nth), 1, 1)
  1L + as.integer(difftime(nth,  jan1, units = "days")) %/% 7L
}
