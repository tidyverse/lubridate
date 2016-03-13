#' Converts a date to a decimal of its year.
#'
#' @export
#' @param date a POSIXt or Date object
#' @return a numeric object where the date is expressed as a fraction of its year
#' @keywords manip chron methods
#' @examples
#' date <- ymd("2009-02-10")
#' decimal_date(date)  # 2009.11
decimal_date <- function(date)
  UseMethod("decimal_date")

#' @export
decimal_date.default <- function(date){

  if(any(!inherits(date, c("POSIXt", "POSIXct", "POSIXlt", "Date"))))
    stop("date(s) not in POSIXt or Date format")

  date <- force_tz(as.POSIXlt(date), tzone = "UTC")
  Y <- year(date)
  start <- make_datetime(Y, 1L, 1L)
  end <- make_datetime(Y + 1L, 1L, 1L)
  sofar <- as.numeric(difftime(date, start, units = "secs"))
  total <- as.numeric(difftime(end, start, units = "secs"))
  Y + sofar/total
}

#' @export
decimal_date.zoo <- function(date)
  decimal_date(zoo::index(date))

#' @export
decimal_date.its <- function(date)
  decimal_date.default(attr(date, "dates"))


#' Converts a decimal to a date.
#'
#' @export
#' @param decimal a numeric object
#' @param tz the time zone required
#' @return a POSIXct object, whose year corresponds to the integer part of
#' decimal. The months, days, hours, minutes and seconds elements are picked so
#' the date-time will accurately represent the fraction of the year expressed by
#' decimal.
#' @keywords manip chron methods
#' @examples
#' date <- ymd("2009-02-10")
#' decimal <- decimal_date(date)  # 2009.11
#' date_decimal(decimal) # "2009-02-10 UTC"
date_decimal <- function(decimal, tz = NULL) {
  Y <- trunc(decimal)
  ## parsing is much faster than updating
  start <- make_datetime(Y, 1L, 1L)
  end <- make_datetime(Y + 1L, 1L, 1L)
  seconds <- as.numeric(difftime(end, start, units = "secs"))
  frac <- decimal - Y
  end <- start + seconds*frac
  if (!is.null(tz))
    force_tz(end, tz)
  else
    end
}
