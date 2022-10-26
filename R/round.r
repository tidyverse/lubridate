#' Round, floor and ceiling methods for date-time objects
#'
#' @description
#' `round_date()` takes a date-time object and time unit, and rounds it to the nearest value
#' of the specified time unit. For rounding date-times which are exactly halfway
#' between two consecutive units, the convention is to round up. Note that this
#' is in line with the behavior of R's [base::round.POSIXt()] function
#' but does not follow the convention of the base [base::round()] function
#' which "rounds to the even digit", as per IEC 60559.
#'
#' Rounding to the nearest unit or multiple of a unit is supported. All
#' meaningful specifications in the English language are supported - secs, min,
#' mins, 2 minutes, 3 years etc.
#'
#' Rounding to fractional seconds is also supported. Please note that rounding to
#' fractions smaller than 1 second can lead to large precision errors due to the
#' floating point representation of the POSIXct objects. See examples.
#'
#'
#' @details In \pkg{lubridate}, functions that round date-time objects try to
#'   preserve the class of the input object whenever possible. This is done by
#'   first rounding to an instant, and then converting to the original class as per
#'   usual R conventions.
#'
#'
#' @section Rounding Up Date Objects:
#'
#' By default, rounding up `Date` objects follows 3 steps:
#'
#' 1. Convert to an instant representing lower bound of the Date:
#'    `2000-01-01` --> `2000-01-01 00:00:00`
#'
#' 2. Round up to the \strong{next} closest rounding unit boundary. For example,
#'    if the rounding unit is `month` then next closest boundary of `2000-01-01`
#'    is `2000-02-01 00:00:00`.
#'
#'    The motivation for this is that the "partial" `2000-01-01` is conceptually
#'    an interval (`2000-01-01 00:00:00` -- `2000-01-02 00:00:00`) and the day
#'    hasn't started clocking yet at the exact boundary `00:00:00`. Thus, it
#'    seems wrong to round a day to its lower boundary.
#'
#'    Behavior on the boundary can be changed by setting
#'    `change_on_boundary` to `TRUE` or `FALSE`.
#'
#' 3. If the rounding unit is smaller than a day, return the instant from step 2
#'     (`POSIXct`), otherwise convert to and return a `Date` object.
#'
#' @rdname round_date
#' @param x a vector of date-time objects
#' @param unit a string, `Period` object or a date-time object. When a singleton string,
#'   it specifies a time unit or a multiple of a unit to be rounded to. Valid base units
#'   are `second`, `minute`, `hour`, `day`, `week`, `month`, `bimonth`, `quarter`,
#'   `season`, `halfyear` and `year`. Arbitrary unique English abbreviations as in the
#'   [period()] constructor are allowed. Rounding to multiples of units (except weeks)
#'   is supported. When `unit` is a `Period` object, units of the period objects are
#'   used. This is equivalent to converting the period object to its string
#'   representation and passing as `unit` argument.
#'
#'   When `unit` is a date-time object rounding is done to the nearest of the
#'   elements in `unit`. If range of `unit` vector does not cover the range of
#'   `x` `ceiling_date()` and `floor_date()` round to the `max(x)` and `min(x)`
#'   for elements that fall outside of `range(unit)`.
#' @param change_on_boundary if this is `NULL` (the default), instants on the
#'   boundary remain unchanged, but `Date` objects are rounded up to the next
#'   boundary. If this is `TRUE`, instants on the boundary are rounded up to the
#'   next boundary. If this is `FALSE`, nothing on the boundary is rounded up at
#'   all. This was the default for \pkg{lubridate} prior to `v1.6.0`. See
#'   section `Rounding Up Date Objects` below for more details.
#'
#' @inheritParams DateTimeUpdate
#' @return When `unit` is a string, return a Date object if `x` is a Date and
#'   `unit` is larger or equal than "day", otherwise a POSIXct object. When
#'   `unit` is a date-time object, return a date-time object of the same class
#'   and same time zone as `unit`.
#' @keywords manip chron
#' @seealso [base::round()]
#' @examples
#'
#' ## print fractional seconds
#' options(digits.secs = 6)
#'
#' x <- ymd_hms("2009-08-03 12:01:59.23")
#' round_date(x, ".5s")
#' round_date(x, "sec")
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
#' x <- ymd_hms("2009-08-03 12:01:59.23")
#' floor_date(x, ".1s")
#' floor_date(x, "second")
#' floor_date(x, "minute")
#' floor_date(x, "hour")
#' floor_date(x, "day")
#' floor_date(x, "week")
#' floor_date(x, "month")
#' floor_date(x, "bimonth")
#' floor_date(x, "quarter")
#' floor_date(x, "season")
#' floor_date(x, "halfyear")
#' floor_date(x, "year")
#'
#' x <- ymd_hms("2009-08-03 12:01:59.23")
#' ceiling_date(x, ".1 sec") # imprecise representation at 0.1 sec !!!
#' ceiling_date(x, "second")
#' ceiling_date(x, "minute")
#' ceiling_date(x, "5 mins")
#' ceiling_date(x, "hour")
#' ceiling_date(x, "day")
#' ceiling_date(x, "week")
#' ceiling_date(x, "month")
#' ceiling_date(x, "bimonth") == ceiling_date(x, "2 months")
#' ceiling_date(x, "quarter")
#' ceiling_date(x, "season")
#' ceiling_date(x, "halfyear")
#' ceiling_date(x, "year")
#'
#' ## Period unit argument
#' floor_date(x, days(2))
#' floor_date(x, years(1))
#'
#' ## As of R 3.4.2 POSIXct printing of fractional numbers is wrong
#' as.POSIXct("2009-08-03 12:01:59.3") ## -> "2009-08-03 12:01:59.2 CEST"
#' ceiling_date(x, ".1 sec") ## -> "2009-08-03 12:01:59.2 CEST"
#'
#' ## behaviour of `change_on_boundary`
#' ## As per default behaviour `NULL`, instants on the boundary remain the
#' ## same but dates are rounded up
#' ceiling_date(ymd_hms("2000-01-01 00:00:00"), "month")
#' ceiling_date(ymd("2000-01-01"), "month")
#'
#' ## If `TRUE`, both instants and dates on the boundary are rounded up
#' ceiling_date(ymd_hms("2000-01-01 00:00:00"), "month", change_on_boundary = TRUE)
#' ceiling_date(ymd("2000-01-01"), "month")
#'
#' ## If `FALSE`, both instants and dates on the boundary remain the same
#' ceiling_date(ymd_hms("2000-01-01 00:00:00"), "month", change_on_boundary = FALSE)
#' ceiling_date(ymd("2000-01-01"), "month")
#' @export
round_date <- function(x, unit = "second", week_start = getOption("lubridate.week.start", 7)) {
  if (length(x) == 0) {
    return(x)
  }

  xx <- as.POSIXct(as_datetime(x, tz = tz(x)))

  .round <- function(below, above) {
    mid <- unclass(xx)
    below <- unclass(below)
    above <- unclass(above)
    wabove <- (above - mid) <= (mid - below)
    wabove <- !is.na(wabove) & wabove
    new <- below
    new[wabove] <- above[wabove]
    .POSIXct(new, tz = tz(x))
  }

  if (is.POSIXt(unit) || is.Date(unit)) {
    u <- as_datetime(unit, tz = tz(unit))
    below <- floor_to_posix(xx, u, TRUE)
    above <- ceil_to_posix(xx, u, TRUE)
    reclass_date(.round(below, above), unit)
  } else {
    parsed_unit <- parse_period_unit(unit)
    n <- parsed_unit$n
    basic_unit <- standardise_period_names(parsed_unit$unit)

    new <-
      if (n == 1 && basic_unit %in% c("second", "minute", "hour", "day")) {
        ## special case for fast rounding
        round.POSIXt(xx, units = lub2base_units[[basic_unit]])
      } else {
        below <- as.POSIXct(floor_date(xx, unit = unit, week_start = week_start))
        above <- as.POSIXct(ceiling_date(xx, unit = unit, week_start = week_start))
        .round(below, above)
      }
    reclass_date_maybe(new, x, unit)
  }
}

reclass_date_maybe <- function(new, orig, unit) {
  if (is.Date(orig) && !unit %in% c("day", "week", "month", "year")) {
    as.POSIXct(new)
  } else {
    reclass_date(new, orig)
  }
}

#' @description
#' `floor_date()` takes a date-time object and rounds it down to the nearest
#' boundary of the specified time unit.
#' @rdname round_date
#' @export
floor_date <- function(x, unit = "seconds", week_start = getOption("lubridate.week.start", 7)) {
  if (length(x) == 0) {
    return(x)
  }

  xx <- as_datetime(x, tz = tz(x))

  if (is.POSIXct(unit) || is.Date(unit)) {
    new <- floor_to_posix(xx, as_datetime(unit, tz = tz(unit)))
    return(reclass_date(new, unit))
  }

  parsed_unit <- parse_period_unit(unit)
  n <- parsed_unit$n
  unit <- standardise_period_names(parsed_unit$unit)

  if (unit %in% c("second", "minute", "hour", "day")) {

    # as_datetime is necesary for correct tz = UTC when x is Date
    out <- trunc_multi_unit(xx, unit, n)
    reclass_date_maybe(out, x, unit)
  } else {
    if (n > 1 && unit == "week") {
      ## fixme:
      warning("Multi-unit not supported for weeks. Ignoring.")
    }

    if (unit %in% c("bimonth", "quarter", "halfyear", "season") ||
      (n > 1 && unit == "month")) {
      new_months <-
        switch(unit,
          month    = floor_multi_unit1(month(xx), n),
          bimonth  = floor_multi_unit1(month(xx), 2 * n),
          quarter  = floor_multi_unit1(month(xx), 3 * n),
          halfyear = floor_multi_unit1(month(xx), 6 * n),
          season   = floor_multi_unit(month(xx), 3 * n)
        )
      n <- Inf
      unit <- "month"
    }

    new <-
      switch(unit,
        week = update(xx, wdays = 1, hours = 0, minutes = 0, seconds = 0, week_start = week_start),
        month = {
          if (n > 1) {
            update(xx, months = new_months, mdays = 1, hours = 0, minutes = 0, seconds = 0)
          } else {
            update(xx, mdays = 1, hours = 0, minutes = 0, seconds = 0)
          }
        },
        year = {
          ## due to bug https://github.com/tidyverse/lubridate/issues/319 we
          ## need to do it in two steps
          if (n > 1) {
            y <- update(xx, ydays = 1, hours = 0, minutes = 0, seconds = 0)
            update(y, years = floor_multi_unit(year(y), n))
          } else {
            update(xx, ydays = 1, hours = 0, minutes = 0, seconds = 0)
          }
        }
      )

    reclass_date_maybe(new, x, unit)
  }
}

#' @description
#' `ceiling_date()` takes a date-time object and rounds it up to the nearest
#' boundary of the specified time unit.
#' @rdname round_date
#' @export
#' @examples
#'
#' x <- ymd_hms("2000-01-01 00:00:00")
#' ceiling_date(x, "month")
#' ceiling_date(x, "month", change_on_boundary = TRUE)
#'
#' ## For Date objects first day of the month is not on the
#' ## "boundary". change_on_boundary applies to instants only.
#' x <- ymd("2000-01-01")
#' ceiling_date(x, "month")
#' ceiling_date(x, "month", change_on_boundary = TRUE)
ceiling_date <- function(x, unit = "seconds", change_on_boundary = NULL, week_start = getOption("lubridate.week.start", 7)) {
  if (length(x) == 0) {
    return(x)
  }

  xx <- as_datetime(x, tz = tz(x))

  if (is.POSIXct(unit) || is.Date(unit)) {
    new <- ceil_to_posix(xx, as_datetime(unit, tz = tz(unit)))
    return(reclass_date(new, unit))
  }

  parsed_unit <- parse_period_unit(unit)
  n <- parsed_unit$n
  unit <- standardise_period_names(parsed_unit$unit)

  if (is.null(change_on_boundary)) {
    change_on_boundary <- is.Date(x)
  }

  if (unit == "second") {
    new <- as_datetime(x, tz = tz(x))
    sec <- second(new)
    csec <- ceil_multi_unit(sec, n)
    if (!change_on_boundary) {
      wsec <- which(csec - n == sec)
      if (length(wsec)) {
        csec[wsec] <- sec[wsec]
      }
    }
    update(new, seconds = csec, simple = T)
  } else if (unit %in% c("minute", "hour")) {

    ## as_datetime converts Date to POSIXct with tz=UTC
    delta <- switch(unit,
      minute = 60,
      hour = 3600,
      day = 86400
    ) * n
    new <-
      if (change_on_boundary) {
        trunc_multi_unit(xx, unit, n) + delta
      } else {
        new1 <- trunc_multi_unit(xx, unit, n)
        not_same <- which(new1 != xx)
        new1[not_same] <- new1[not_same] + delta
        new1
      }
    reclass_date_maybe(new, x, unit)
  } else {
    if (n > 1 && unit == "week") {
      warning("Multi-unit not supported for weeks. Ignoring.")
    }

    ## need this to accomodate the case when date is on a boundary
    new <-
      if (change_on_boundary) {
        xx
      } else {
        update(xx, seconds = second(xx) - 0.00001, simple = T)
      }

    if (unit %in% c("month", "bimonth", "quarter", "halfyear", "season")) {
      new_month <-
        switch(unit,
          month    = ceil_multi_unit1(month(new), n),
          bimonth  = ceil_multi_unit1(month(new), 2 * n),
          quarter  = ceil_multi_unit1(month(new), 3 * n),
          halfyear = ceil_multi_unit1(month(new), 6 * n),
          season   = ceil_multi_unit(month(new), 3 * n)
        )
      unit <- "month"
    }

    new <- switch(unit,
      minute = update(new, minutes = ceil_multi_unit(minute(new), n), seconds = 0, simple = T),
      hour   = update(new, hours = ceil_multi_unit(hour(new), n), minutes = 0, seconds = 0, simple = T),
      day    = update(new, days = ceil_multi_unit1(day(new), n), hours = 0, minutes = 0, seconds = 0),
      week   = update(new, wdays = 8, hours = 0, minutes = 0, seconds = 0, week_start = week_start),
      month  = update(new, months = new_month, mdays = 1, hours = 0, minutes = 0, seconds = 0),
      year   = update(new, years = ceil_multi_unit(year(new), n), months = 1, mdays = 1, hours = 0, minutes = 0, seconds = 0)
    )

    reclass_date_maybe(new, x, unit)
  }
}

trunc_multi_limits <- c(second = 60L, minute = 60L, hour = 24, day = 31)

trunc_multi_unit <- function(x, unit, n) {
  x <- as.POSIXlt(x)
  if (n > trunc_multi_limits[[unit]]) {
    stop(sprintf("Rounding with %s > %d is not supported", unit, trunc_multi_limits[[unit]]))
  }

  switch(unit,
    second = {
      x$sec <- if (n == 1) trunc(x$sec) else floor_multi_unit(x$sec, n)
    },
    minute = {
      x$sec[] <- 0
      x$min <- floor_multi_unit(x$min, n)
    },
    hour = {
      x$sec[] <- 0
      x$min[] <- 0L
      x$hour <- floor_multi_unit(x$hour, n)
    },
    day = {
      x$sec[] <- 0
      x$min[] <- 0L
      x$hour[] <- 0L
      x$isdst[] <- -1L
      x$mday <- floor_multi_unit1(x$mday, n)
    },
    stop("Invalid unit ", unit)
  )
  x
}

floor_multi_unit <- function(x, n) {
  (x %/% n) * n
}

floor_multi_unit1 <- function(x, n) {
  (((x - 1) %/% n) * n) + 1L
}

ceil_multi_unit <- function(x, n) {
  (x %/% n) * n + n
}

ceil_multi_unit1 <- function(x, n) {
  (((x - 1) %/% n) * n) + n + 1L
}

check_round_endpoints <- function(unit) {
  if (length(unit) == 0) {
    stop("Zero length `unit` argument", call. = FALSE)
  }
  if (any(is.na(unit))) {
    stop("NAs in `unit` argument`", call. = FALSE)
  }
}

floor_to_posix <- function(x, endpoints, tight = FALSE) {
  check_round_endpoints(endpoints)
  if (all(is.na(x))) {
    return(x)
  }
  endpoints <- sort(endpoints)
  ux <- unclass(x)
  min <- min(ux, na.rm = TRUE)
  breaks <- unclass(endpoints)
  emin <- breaks[[1]]
  if (min < emin) {
    beg <- .POSIXct(if (tight) emin else min, tz = tz(endpoints))
    endpoints <- c(beg, endpoints)
    breaks <- c(min, breaks)
  }
  breaks <- c(breaks, Inf)
  bins <- .bincode(ux, breaks, right = FALSE, include.lowest = TRUE)
  endpoints[bins]
}

ceil_to_posix <- function(x, endpoints, tight = FALSE) {
  check_round_endpoints(endpoints)
  if (all(is.na(x))) {
    return(x)
  }
  endpoints <- sort(endpoints)
  ux <- unclass(x)
  max <- max(ux, na.rm = TRUE)
  breaks <- unclass(endpoints)
  emax <- breaks[[length(breaks)]]
  if (emax < max) {
    end <- .POSIXct(if (tight) emax else max, tz = tz(endpoints))
    endpoints <- c(endpoints, end)
    breaks <- c(breaks, max)
  }
  breaks <- c(-Inf, breaks)
  bins <- .bincode(ux, breaks, right = TRUE, include.lowest = TRUE)
  out <- endpoints[bins]
}
