#' Round, flour and ceiling methods for date-time objects.
#'
#' Users can specify whether to round to the nearest second, minute, hour, day,
#' week, month, quarter, or year.
#'
#' \code{round_date} takes a date-time object and rounds it to the nearest
#' integer value of the specified time unit. For rounding date-ties which is
#' exactly halfway between two consecutive units, the convention is to round
#' up. Note that this is in line with the behavior of R's base
#' \link[base]{round.POSIXt} function but does not follow the convention of the
#' base \link[base]{round} function which "goes to the even digit" per IEC
#' 60559.
#'
#' \code{floor_date} takes a date-time object and rounds it down to the nearest integer
#' value of the specified time unit.
#'
#' \code{ceiling_date} takes a date-time object and rounds it up to the nearest
#' integer value of the specified time unit.
#'
#' By convention the boundary for a month is the first second of the month. Thus
#' \code{floor_date(ymd("2000-03-01"), "month")} gives "2000-03-01 UTC".
#' @rdname round_date
#' @param x a vector of date-time objects
#' @param unit a character string specifying the time unit to be rounded to. Should be one of
#'   "second", "minute", "hour", "day", "week", "month", "quarter", or "year."
#' @return x with the appropriate units floored
#' @keywords manip chron
#' @seealso \link[base]{round}
#' @examples
#' x <- as.POSIXct("2009-08-03 12:01:59.23")
#' round_date(x, "second")
#' # "2009-08-03 12:01:59 CDT"
#' round_date(x, "minute")
#' # "2009-08-03 12:02:00 CDT"
#' round_date(x, "hour")
#' # "2009-08-03 12:00:00 CDT"
#' round_date(x, "day")
#' # "2009-08-04 CDT"
#' round_date(x, "week")
#' # "2009-08-02 CDT"
#' round_date(x, "month")
#' # "2009-08-01 CDT"
#' round_date(x, "quarter")
#' # "2009-07-01 CDT"
#' round_date(x, "year")
#' # "2010-01-01 CST"
#'
#' x <- as.POSIXct("2009-08-03 12:01:59.23")
#' floor_date(x, "second")
#' # "2009-08-03 12:01:59 CDT"
#' floor_date(x, "minute")
#' # "2009-08-03 12:01:00 CDT"
#' floor_date(x, "hour")
#' # "2009-08-03 12:00:00 CDT"
#' floor_date(x, "day")
#' # "2009-08-03 CDT"
#' floor_date(x, "week")
#' # "2009-08-02 CDT"
#' floor_date(x, "month")
#' # "2009-08-01 CDT"
#' floor_date(x, "quarter")
#' # "2009-07-01 CDT"
#' floor_date(x, "year")
#' # "2009-01-01 CST"
#'
#' x <- as.POSIXct("2009-08-03 12:01:59.23")
#' ceiling_date(x, "second")
#' # "2009-08-03 12:02:00 CDT"
#' ceiling_date(x, "minute")
#' # "2009-08-03 12:02:00 CDT"
#' ceiling_date(x, "hour")
#' # "2009-08-03 13:00:00 CDT"
#' ceiling_date(x, "day")
#' # "2009-08-04 CDT"
#' ceiling_date(x, "week")
#' # "2009-08-09 CDT"
#' ceiling_date(x, "month")
#' # "2009-09-01 CDT"
#' ceiling_date(x, "quarter")
#' # "2009-10-01 CDT"
#' ceiling_date(x, "year")
#' # "2010-01-01 CST"
#' @export
round_date <- function(x, unit = c("second", "minute", "hour", "day", "week", "month", "year", "quarter")) {

  if(!length(x)) return(x)

  unit <- match.arg(unit)

  new <-
    if(unit %in% c("second", "minute", "hour", "day")){
      round.POSIXt(x, units = lub2base_units[[unit]])
    } else {
      above <- unclass(as.POSIXct(ceiling_date(x, unit)))
      mid <- unclass(as.POSIXct(x))
      below <- unclass(as.POSIXct(floor_date(x, unit)))
      wabove <- (above - mid) <= (mid - below)
      wabove <- !is.na(wabove) & wabove
      new <- below
      new[wabove] <- above[wabove]
      .POSIXct(new, tz = tz(x))
    }

  reclass_date(new, x)
}

#' @rdname round_date
#' @export
floor_date <- function(x, unit = c("second", "minute", "hour", "day", "week", "month", "year", "quarter")) {
	if(!length(x)) return(x)
  unit <- match.arg(unit)

  if(unit %in% c("second", "minute", "hour", "day")){
    reclass_date(trunc(x, units = lub2base_units[[unit]]), x)
  } else {
    new <- switch(unit,
                  week    = update(x, wdays = 1, hours = 0, minutes = 0, seconds = 0, simple = T),
                  month   = update(x, mdays = 1, hours = 0, minutes = 0, seconds = 0, simple = T),
                  quarter = update(x, months = ((month(x)-1)%/%3)*3+1, mdays = 1, hours = 0, minutes = 0, seconds = 0, simple = T),
                  year    = update(x, ydays = 1, hours = 0, minutes = 0, seconds = 0, simple = T))
    new
  }
}

#' @rdname round_date
#' @export
ceiling_date <- function(x, unit = c("second", "minute", "hour", "day", "week", "month", "year", "quarter")) {
	if(!length(x)) return(x)
	unit <- match.arg(unit)

  if(unit == "second"){
    update(x, seconds = ceiling(second(x)), simple = T)
  }else if(is.POSIXt(x) & (unit %in% c("minute", "hour", "day"))){
    ## cannot use this for Date class, (local tz interferes with computation)
    ## tohink: maybe make rounding functions generic
    new <- as.POSIXct(x, tz = tz(x))
    new <- new + switch(unit, minute = 59, hour = 3599, day = 86399)
    reclass_date(trunc.POSIXt(new, units = lub2base_units[[unit]]), x)
  } else {
    ## we need this to accomodate the case when date is on a boundary
    new <- update(x, seconds = second(x) - 1L, simple = T)
    new <- switch(unit,
                  minute  = update(new, minute = minute(new) + 1L, second = 0, simple = T),
                  hour    = update(new, hour = hour(new) + 1L, minute = 0, second = 0, simple = T),
                  day     = update(new, day = day(new) + 1L, hour = 0, minute = 0, second = 0, simple = T),
                  week    = update(new, wday = 8, hour = 0, minute = 0, second = 0, simple = T),
                  month   = update(new, month = month(new) + 1L, mday = 1, hour = 0, minute = 0, second = 0, simple = T),
                  quarter = update(new, month = ((month(new)-1)%/%3)*3+4, mday = 1, hour = 0, minute = 0, second = 0, simple = T),
                  year    = update(new, year = year(new) + 1L, month = 1, mday = 1,  hour = 0, minute = 0, second = 0, simple = T))
    reclass_date(new, x)
  }
}

## fixme: this function is nowhere used
parse_unit_spec <- function(unitspec) {
  parts <- strsplit(unitspec, " ")[[1]]
  if (length(parts) == 1) {
    mult <- 1
    unit <- unitspec
  } else {
    mult <- as.numeric(parts[[1]])
    unit <- parts[[2]]
  }

  unit <- gsub("s$", "", unit)
  unit <- match.arg(unit,
    c("second","minute","hour","day", "week", "month", "year"))

  list(unit = unit, mult = mult)
}
