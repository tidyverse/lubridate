#' @include periods.r
NULL

#' Get/set hours component of a date-time
#'
#' Date-time must be a POSIXct, POSIXlt, Date, Period, chron, yearmon, yearqtr, zoo,
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects.
#'
#' @export
#' @param x a date-time object
#' @param value numeric value to be assigned to the `hour` component
#' @keywords utilities manip chron methods
#' @return the hours element of x as a decimal number
#' @examples
#' x <- ymd("2012-03-26")
#' hour(x)
#' hour(x) <- 1
#' hour(x) <- 25
#' hour(x) > 2
hour <- function(x) {
  UseMethod("hour")
}

#' @export
hour.default <- function(x) {
  as.POSIXlt(x, tz = tz(x))$hour
}

#' @export
hour.Period <- function(x) {
  slot(x, "hour")
}


#' @rdname hour
#' @export
setGeneric("hour<-",
  function (x, value) standardGeneric("hour<-"),
  useAsDefault = function(x, value) {
    y <- update_datetime(as.POSIXct(x), hours = value)
    reclass_date(y, x)
  }
)

#' @export
setMethod("hour<-", "Duration", function(x, value) {
  x <- x + hours(value - hour(x))
})

#' @export
setMethod("hour<-", signature("Period"), function(x, value) {
  slot(x, "hour") <- value
  x
})

#' @export
setMethod("hour<-", "Interval", function(x, value) {
  x <- x + hours(value - hour(x))
})

#' @export
setMethod("hour<-", "POSIXt", function(x, value) {
  update_datetime(x, hours = value, roll_dst = "NA")
})

#' @export
setMethod("hour<-", "Date", function(x, value) {
  update_datetime(x, hours = value, roll_dst = "NA")
})
