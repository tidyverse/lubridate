#' @include periods.r
NULL

#' Get/set seconds component of a date-time
#'
#' Date-time must be a  POSIXct, POSIXlt, Date, Period, chron, yearmon, yearqtr, zoo,
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects.
#'
#' @export
#' @param x a date-time object
#' @param value numeric value to be assigned
#' @return the seconds element of x as a decimal number
#' @keywords utilities manip chron methods
#' @examples
#' x <- ymd("2012-03-26")
#' second(x)
#' second(x) <- 1
#' second(x) <- 61
#' second(x) > 2
second <- function(x) {
  UseMethod("second")
}

#' @export
second.default <- function(x) {
  as.POSIXlt(x, tz = tz(x))$sec
}

#' @export
second.Period <- function(x) {
  slot(x, ".Data")
}

#' @rdname second
#' @export
setGeneric("second<-",
  function (x, value) standardGeneric("second<-"),
  useAsDefault = function(x, value) {
    y <- update_datetime(as.POSIXct(x), seconds = value)
    reclass_date(y, x)
  }
)

#' @export
setMethod("second<-", "Duration", function(x, value) {
  x <- x + seconds(value - second(x))
})

#' @export
setMethod("second<-", signature("Period"), function(x, value) {
  slot(x, ".Data") <- value
  x
})

#' @export
setMethod("second<-", "Interval", function(x, value) {
  x <- x + seconds(value - second(x))
})

#' @export
setMethod("second<-", "POSIXt", function(x, value) {
  update_datetime(x, seconds = value, roll_dst = "NA")
})

#' @export
setMethod("second<-", "Date", function(x, value) {
  update_datetime(x, seconds = value, roll_dst = "NA")
})
