#' Round, floor and ceiling methods for date-time objects.
#'
#' Rounding to the nearest unit or multiple of a unit are supported. All
#' meaningfull specifications in english are supported - secs, min, mins, 2
#' minutes, 3 years etc.
#'
#' \code{round_date} takes a date-time object and rounds it to the nearest value
#' of the specified time unit. For rounding date-ties which is exactly halfway
#' between two consecutive units, the convention is to round up. Note that this
#' is in line with the behavior of R's base \link[base]{round.POSIXt} function
#' but does not follow the convention of the base \link[base]{round} function
#' which "goes to the even digit" per IEC 60559.
#'
#' \code{floor_date} takes a date-time object and rounds it down to the nearest
#' value of the specified time unit.
#'
#' \code{ceiling_date} takes a date-time object and rounds it up to the nearest
#' value of the specified time unit.
#'
#' By convention the boundary for a month is the 00 second of the month. Thus
#' \code{ceiling_date(ymd("2000-03-01"), "month")} is equivalent to
#' \code{ceiling_date(ymd_hms("2000-03-01 00:00:00"), "month")} and returns
#' "2000-03-01 UTC". Use \code{change_on_boundary} to alter this behavior.
#' @rdname round_date
#' @param x a vector of date-time objects
#' @param unit a character string specifying the time unit or a multiple of a
#'   unit to be rounded to. Valid base units are second, minute, hour, day,
#'   week, month, bimonth, quarter, halfyear, or year. Unique abriviation or
#'   plurals are also supported (min, mins, secs etc). Rounding to multiple of
#'   units (except weeks) is suported from \code{v1.6.0}.
#' @return x with the appropriate units floored
#' @keywords manip chron
#' @seealso \link[base]{round}
#' @examples
#' x <- as.POSIXct("2009-08-03 12:01:59.23")
#' round_date(x, "second")
#' round_date(x, "minute")
#' round_date(x, "5 mins")
#' round_date(x, "hour")
#' round_date(x, "2 hours")
#' round_date(x, "day")
#' round_date(x, "week")
#' round_date(x, "month")
#' round_date(x, "bimonth")
#' round_date(x, "quarter") == round_date(x, "3 months")
#' round_date(x, "halfyear")
#' round_date(x, "year")
#'
#' x <- as.POSIXct("2009-08-03 12:01:59.23")
#' floor_date(x, "second")
#' floor_date(x, "minute")
#' floor_date(x, "hour")
#' floor_date(x, "day")
#' floor_date(x, "week")
#' floor_date(x, "month")
#' floor_date(x, "bimonth")
#' floor_date(x, "quarter")
#' floor_date(x, "halfyear")
#' floor_date(x, "year")
#'
#' x <- as.POSIXct("2009-08-03 12:01:59.23")
#' ceiling_date(x, "second")
#' ceiling_date(x, "minute")
#' ceiling_date(x, "5 mins")
#' ceiling_date(x, "hour")
#' ceiling_date(x, "day")
#' ceiling_date(x, "week")
#' ceiling_date(x, "month")
#' ceiling_date(x, "bimonth") == ceiling_date(x, "2 months")
#' ceiling_date(x, "quarter")
#' ceiling_date(x, "halfyear")
#' ceiling_date(x, "year")
#' @export
round_date <- function(x, unit = "second") {

  if(!length(x)) return(x)

  parsed_unit <- parse_period_unit(unit)
  n <- parsed_unit$n
  basic_unit <- standardise_period_names(parsed_unit$unit)

  new <-
    if(n == 1 && basic_unit %in% c("second", "minute", "hour", "day")){
      ## special case for fast rounding
      round.POSIXt(x, units = lub2base_units[[basic_unit]])
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
floor_date <- function(x, unit = "seconds") {
  if(!length(x)) return(x)

  parsed_unit <- parse_period_unit(unit)
  n <- parsed_unit$n
  unit <- standardise_period_names(parsed_unit$unit)

  if(unit %in% c("second", "minute", "hour", "day")){

    reclass_date(trunc_multi_unit(x, unit, n), x)

  } else {

    if(n > 1 && unit == "week"){
      ## fixme:
      warning("Multi-unit not supported for weeks. Ignoring.")
    }

    if(unit %in% c("bimonth", "quarter", "halfyear")){
      switch(unit,
             bimonth = n <- 2 * n,
             quarter = n <- 3 * n,
             halfyear = n <- 6 * n)
      unit <- "month"
    }

    switch(unit,
           week     = update(x, wdays = 1, hours = 0, minutes = 0, seconds = 0),
           month    = {
             if(n > 1)
               update(x, months = floor_multi_unit1(month(x), n), mdays = 1, hours = 0, minutes = 0, seconds = 0)
             else
               update(x, mdays = 1, hours = 0, minutes = 0, seconds = 0)
           },
           year     = {
             ## due to bug https://github.com/hadley/lubridate/issues/319 we
             ## need to do it in two steps
             if(n > 1){
               y <- update(x, ydays = 1, hours = 0, minutes = 0, seconds = 0)
               update(y, years = floor_multi_unit(year(y), n))
             } else {
               update(x, ydays = 1, hours = 0, minutes = 0, seconds = 0)
             }
           })
  }
}

#' @rdname round_date
#' @export
#' @param change_on_boundary logical. If FALSE (the default) \code{ceiling_date}
#'   don't alter date-times on the boundary of the \code{unit}. The boundary is
#'   unit dependent - for second, minute, hour and day the boundary is `0` units
#'   of next smaller unit. For week, month and year the boundary is on the first
#'   day within that unit. For example for the boundary date "2000-01-01"
#'   \code{ceiling_date(ymd("2000-01-01"), "month")} is \code{"2000-01-01"}
#'   while `ceiling_date(ymd("2000-01-01"), "month", TRUE)` is "2000-02-01".
#' @examples
#' x <- ymd("2000-01-01")
#' ceiling_date(x, "month")
#' ceiling_date(x, "month", change_on_boundary = TRUE)
ceiling_date <- function(x,
                         unit = c("second", "minute", "hour", "day", "week", "month", "bimonth", "quarter", "halfyear", "year"),
                         change_on_boundary = FALSE) {
  if(!length(x))
    return(x)

  parsed_unit <- parse_period_unit(unit)
  n <- parsed_unit$n
  unit <- standardise_period_names(parsed_unit$unit)

  if(unit == "second"){

    sec <- second(x)
    csec <- ceil_multi_unit(sec, n)
    if(!change_on_boundary){
      wsec <- which(csec - n ==  sec)
      if(length(wsec))
        csec[wsec] <- sec[wsec]
    }
    update(x, seconds = csec, simple = T)

  }else if(is.POSIXt(x) & (unit %in% c("minute", "hour", "day"))){

    ## cannot use this for Date class, (local tz interferes with computation)
    new <- as.POSIXct(x, tz = tz(x))
    one <- as.numeric(change_on_boundary)
    new <- new + switch(unit,
                        minute = (59 + one)*n,
                        hour = (3599 + one)*n,
                        day = (86399 + one)*n)
    reclass_date(trunc_multi_unit(new, unit, n), x)

  } else {

    if(n > 1 && unit == "week"){
      ## fixme:
      warning("Multi-unit not supported for weeks. Ignoring.")
    }

    ## need this to accomodate the case when date is on a boundary
    new <-
      if(change_on_boundary) x
      else update(x, seconds = second(x) - 0.00001, simple = T)

    if(unit %in% c("bimonth", "quarter", "halfyear")){
      switch(unit,
             bimonth = n <- 2 * n,
             quarter = n <- 3 * n,
             halfyear = n <- 6 * n)
      unit <- "month"
    }

    new <- switch(unit,
                  minute = update(new, minute = ceil_multi_unit(minute(new), n), second = 0, simple = T),
                  hour   = update(new, hour = ceil_multi_unit(hour(new), n), minute = 0, second = 0, simple = T),
                  day    = update(new, day = ceil_multi_unit1(day(new), n), hour = 0, minute = 0, second = 0),
                  week   = update(new, wday = 8, hour = 0, minute = 0, second = 0),
                  month  = update(new, month = ceil_multi_unit1(month(new), n), mdays = 1, hours = 0, minutes = 0, seconds = 0),
                  year   = update(new, year = ceil_multi_unit(year(new), n), month = 1, mday = 1,  hour = 0, minute = 0, second = 0))

    reclass_date(new, x)
  }
}

trunc_multi_unit <- function(x, unit, n){
  y <- as.POSIXlt(x)
  switch(unit,
         second = {
           y$sec <- if(n == 1) trunc(y$sec) else floor_multi_unit(y$sec, n)
         },
         minute = {
           y$sec[] <- 0
           y$min <- floor_multi_unit(y$min, n)
         },
         hour = {
           y$sec[] <- 0
           y$min[] <- 0L
           y$hour <- floor_multi_unit(y$hour, n)
         },
         day = {
           y$sec[] <- 0
           y$min[] <- 0L
           y$hour[] <- 0L
           y$isdst[] <- -1L
           y$mday <- floor_multi_unit1(y$mday, n)
         },
         stop("Invalid unit ", unit))
  y
}

floor_multi_unit <- function(n, len) {
  (n %/% len) * len
}

floor_multi_unit1 <- function(n, len) {
  (((n - 1) %/% len) * len) + 1L
}

ceil_multi_unit <- function(n, len) {
  (n %/% len) * len + len
}

ceil_multi_unit1 <- function(n, len) {
  (((n - 1) %/% len) *  len) + len + 1L
}
