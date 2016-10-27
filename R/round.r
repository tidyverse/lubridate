#' Round, floor and ceiling methods for date-time objects.
#'
#' Rounding to the nearest unit or multiple of a unit are supported. All
#' meaningfull specifications in English language are supported - secs, min,
#' mins, 2 minutes, 3 years etc.
#' \cr
#' \code{round_date} takes a date-time object and rounds it to the nearest value
#' of the specified time unit. For rounding date-times which is exactly halfway
#' between two consecutive units, the convention is to round up. Note that this
#' is in line with the behavior of R's base \link[base]{round.POSIXt} function
#' but does not follow the convention of the base \link[base]{round} function
#' which "rounds to the even digit" per IEC 60559.
#' \cr
#' \code{floor_date} takes a date-time object and rounds it down to the nearest
#' boundary of the specified  time unit.
#' \cr
#' \code{ceiling_date} takes a date-time object and rounds it up to the nearest
#' boundary of the specified time unit.
#'
#' In \code{lubridate} rounding of a date-time objects tries to preserve the
#' class of the input object whenever it is meaningful. This is done by first
#' rounding to an instant and then converting to the original class by usual R
#' conventions.
#'
#'
#' @section Rounding Up Date Objects:
#'
#'  By default rounding up \code{Date} objects follows 3 steps:
#'
#'    \enumerate{
#'
#'      \item Convert to an instant representing lower bound of the Date:
#'           \code{2000-01-01} --> \code{2000-01-01 00:00:00}
#'
#'      \item Round up to the \strong{next} closest rounding unit boundary. For
#'           example, if the rounding unit is \code{month} then next boundary
#'           for \code{2000-01-01} will be \code{2000-02-01 00:00:00}.
#'
#'           The motivation for this behavior is that \code{2000-01-01} is
#'           conceptually an interval \code{(2000-01-01 00:00:00 -- 2000-01-02
#'           00:00:00)} and the day hasn't started clocking yet at the exact
#'           boundary \code{00:00:00}. Thus, it seems wrong to round up a day to
#'           its lower boundary.
#'
#'      \item If rounding unit is smaller than a day, return the instant from
#'          step 2 above (\code{POSIXct}), otherwise return the \code{Date}
#'          immediately following that instant.
#'
#'     }
#'
#'  The behavior on the boundary in the second step above can be changed by
#'  setting \code{change_on_boundary} to a non-\code{NULL} value.
#'
#' @rdname round_date
#' @param x a vector of date-time objects
#' @param unit a character string specifying the time unit or a multiple of a
#'   unit to be rounded to. Valid base units are second, minute, hour, day,
#'   week, month, bimonth, quarter, halfyear, or year. Arbitrary unique English
#'   abbreviations as in \code{\link{period}} constructor are also
#'   supported. Rounding to multiple of units (except weeks) is supported from
#'   \code{v1.6.0}.
#' @param change_on_boundary If NULL (the default) don't change instants on the
#'   boundary (\code{ceiling_date(ymd_hms('2000-01-01 00:00:00'))} is
#'   \code{2000-01-01 00:00:00}), but round up \code{Date} objects to the next
#'   boundary (\code{ceiling_date(ymd("2000-01-01"), "month")} is
#'   \code{"2000-02-01"}). When \code{TRUE}, instants on the boundary are
#'   rounded up to the next boundary. When \code{FALSE}, date-time on the
#'   boundary are never rounded up (this was the default for \code{lubridate}
#'   prior to \code{v1.6.0}. See section \code{Rounding Up Date Objects} below
#'   for more details.
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

reclass_date_maybe <- function(new, orig, unit){
  if(is.Date(orig) && !unit %in% c("day", "week", "month", "year")) as.POSIXct(new)
  else reclass_date(new, orig)
}

#' @rdname round_date
#' @export
floor_date <- function(x, unit = "seconds") {
  if(!length(x)) return(x)

  parsed_unit <- parse_period_unit(unit)
  n <- parsed_unit$n
  unit <- standardise_period_names(parsed_unit$unit)

  if(unit %in% c("second", "minute", "hour", "day")){

    out <- trunc_multi_unit(x, unit, n)
    reclass_date_maybe(out, x, unit)

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
#' @examples
#' x <- ymd("2000-01-01")
#' ceiling_date(x, "month")
#' ceiling_date(x, "month", change_on_boundary = TRUE)
ceiling_date <- function(x, unit = "seconds", change_on_boundary = NULL) {

  if(!length(x))
    return(x)

  parsed_unit <- parse_period_unit(unit)
  n <- parsed_unit$n
  unit <- standardise_period_names(parsed_unit$unit)

  if(is.null(change_on_boundary)){
    change_on_boundary <- is.Date(x)
  }

  if(unit == "second"){

    sec <- second(x)
    csec <- ceil_multi_unit(sec, n)
    if(!change_on_boundary){
      wsec <- which(csec - n ==  sec)
      if(length(wsec))
        csec[wsec] <- sec[wsec]
    }
    update(x, seconds = csec, simple = T)

  } else if (unit %in% c("minute", "hour", "day")){

    ## cannot use this for minute/hour for Date class; local tz interferes with
    ## the computation
    new <- as_datetime(x, tz = tz(x))
    delta <- switch(unit, minute = 60, hour = 3600, day = 86400) * n
    new <-
      if(change_on_boundary){
        trunc_multi_unit(new, unit, n) + delta
      } else{
        new1 <- trunc_multi_unit(new, unit, n)
        not_same <- which(new1 != new)
        new1[not_same] <- new1[not_same] + delta
        new1
      }
    reclass_date_maybe(new, x, unit)

  } else {

    if(n > 1 && unit == "week"){
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
                  week   = update(new, wday = 8, hour = 0, minute = 0, second = 0),
                  month  = update(new, month = ceil_multi_unit1(month(new), n), mdays = 1, hours = 0, minutes = 0, seconds = 0),
                  year   = update(new, year = ceil_multi_unit(year(new), n), month = 1, mday = 1,  hour = 0, minute = 0, second = 0))

    reclass_date_maybe(new, x, unit)
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
