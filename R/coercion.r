#' @include timespans.r
#' @include durations.r
#' @include intervals.r
#' @include periods.r
#' @include Dates.r
#' @include difftimes.r
#' @include numeric.r
#' @include POSIXt.r
#' @include time-zones.r
NULL


#' Convert a variety of date-time classes to POSIXlt and POSIXct
#' @name DateCoercion
#' @keywords internal
#'
NULL

#' @export
as.POSIXct.fts <- function(x, tz = "", ...) as.POSIXct(zoo::index(x))
#' @export
as.POSIXlt.fts <- function(x, tz = "", ...) as.POSIXlt(zoo::index(x))

## #' @export
## as.POSIXlt.its <- function(x, tz = "", ...) as.POSIXlt(attr(x, "dates"))
## #' @export
## as.POSIXct.its <- function(x, tz = "", ...) as.POSIXct(attr(x, "dates"))

#' @export
as.POSIXlt.timeSeries <- function(x, tz = "", ...) {
  as.POSIXlt(timeDate::timeDate(x@positions,
    zone = x@FinCenter, FinCenter = x@FinCenter
  ))
}
#' @export
as.POSIXct.timeSeries <- function(x, tz = "", ...) {
  as.POSIXct(timeDate::timeDate(x@positions,
    zone = x@FinCenter, FinCenter = x@FinCenter
  ))
}

#' @export
as.POSIXlt.irts <- function(x, tz = "", ...) as.POSIXlt(x$time)
#' @export
as.POSIXct.irts <- function(x, tz = "", ...) as.POSIXct(x$time)

#' @export
as.POSIXlt.xts <- function(x, tz = "", ...) as.POSIXlt(zoo::index(x))
#' @export
as.POSIXct.xts <- function(x, tz = "", ...) as.POSIXct(zoo::index(x))
#' @export
as.POSIXlt.zoo <- function(x, tz = "", ...) as.POSIXlt(zoo::index(x))
#' @export
as.POSIXct.zoo <- function(x, tz = "", ...) as.POSIXct(zoo::index(x))

#' @export
as.POSIXlt.tis <- function(x, tz = "", ...) as.Date(x)

#' Convenience method to reclass dates post-modification.
#' @keywords internal
#'
#' @export
reclass_date <- function(new, orig) UseMethod("reclass_date", orig)
#' @export
reclass_date.POSIXlt <- function(new, orig) {
  as.POSIXlt(new)
}
#' @export
reclass_date.POSIXct <- function(new, orig) {
  as.POSIXct(new)
}
#' @export
reclass_date.chron <- function(new, orig) {
  chron::as.chron(new)
}
#' @export
reclass_date.timeDate <- function(new, orig) {
  timeDate::as.timeDate(new)
}
## #' @export
## reclass_date.its <- function(new, orig) {
##   its::its(new, format = "%Y-%m-%d %X")
## }
#' @export
reclass_date.ti <- function(new, orig) {
  tis::as.ti(new, tis::tifName(orig))
}
#' @export
reclass_date.Date <- function(new, orig) {
  as_date(new)
}
#' @export
reclass_date.IDate <- function(new, orig) {
  data.table::as.IDate(new)
}
#' @export
reclass_date.ITime <- function(new, orig) {
  data.table::as.ITime(new)
}


period_to_difftime <- function(per) {
  as.difftime(per)
}

#' Convenience method to reclass timespans post-modification.
#' @keywords internal
#'
#' @aliases reclass_timespan,ANY,Duration-method reclass_timespan,ANY,Interval-method
#' reclass_timespan,ANY,Period-method reclass_timespan,ANY,difftime-method
#' @export
reclass_timespan <- function(new, orig) standardGeneric("reclass_timespan")

#' @export
setGeneric("reclass_timespan",
  useAsDefault = function(new, orig) {
    stop(sprintf("reclass_timespan is not defined for class '%s'", class(x)))
  }
)

#' @export
setMethod("reclass_timespan", signature(orig = "difftime"), function(new, orig) {
  if (is.period(new)) {
    as.difftime(new)
  } else {
    make_difftime(as.numeric(new))
  }
})

#' @export
setMethod("reclass_timespan", signature(orig = "Duration"), function(new, orig) {
  as.duration(new)
})

#' @export
setMethod("reclass_timespan", signature(orig = "Interval"), function(new, orig) {
  as.duration(new)
})

#' @export
setMethod("reclass_timespan", signature(orig = "Period"), function(new, orig) {
  as.period(new)
})


#' Change an object to a duration
#'
#' as.duration changes Interval, Period and numeric class objects to
#' Duration objects. Numeric objects are changed to Duration objects
#' with the seconds unit equal to the numeric value.
#'
#' Durations are exact time measurements, whereas periods are relative time
#' measurements. See [Period-class]. The length of a period depends
#' on when it occurs. Hence, a one to one mapping does not exist between
#' durations and periods. When used with a period object, as.duration provides
#' an inexact estimate of the length of the period; each time unit is assigned
#' its most common number of seconds. A period of one month is converted to
#' 2628000 seconds (approximately 30.42 days). This ensures that 12 months will
#' sum to 365 days, or one normal year. For an exact transformation, first
#' transform the period to an interval with [as.interval()].
#'
#' @param x Object to be coerced to a duration
#' @param ... Parameters passed to other methods. Currently unused.
#' @return A duration object
#' @seealso [Duration-class], [duration()]
#' @keywords classes manip methods chron
#' @examples
#' span <- interval(ymd("2009-01-01"), ymd("2009-08-01")) # interval
#' as.duration(span)
#' as.duration(10) # numeric
#' dur <- duration(hours = 10, minutes = 6)
#' as.numeric(dur, "hours")
#' as.numeric(dur, "minutes")
#' @aliases as.duration,numeric-method as.duration,logical-method
#'   as.duration,difftime-method as.duration,Interval-method
#'   as.duration,Duration-method as.duration,Period-method
#'   as.duration,character-method
#' @export
setGeneric("as.duration",
  function(x, ...) standardGeneric("as.duration"),
  useAsDefault = function(x, ...) {
    stop(sprintf("as.duration is not defined for class '%s'", class(x)))
  }
)

setMethod("as.duration", signature(x = "character"), function(x) {
  as.duration(as.period(x))
})

setMethod("as.duration", signature(x = "numeric"), function(x) {
  new("Duration", x)
})

setMethod("as.duration", signature(x = "logical"), function(x) {
  new("Duration", as.numeric(x))
})

as_duration_from_difftime <- function(x) {
  new("Duration", as.numeric(x, "secs"))
}
setMethod("as.duration", signature(x = "difftime"), as_duration_from_difftime)

setMethod("as.duration", signature(x = "Interval"), function(x) {
  new("Duration", x@.Data)
})

setMethod("as.duration", signature(x = "Duration"), function(x) {
  x
})

setMethod("as.duration", signature(x = "Period"), function(x) {
  new("Duration", period_to_seconds(x))
})


#' Change an object to an `interval`
#'
#' as.interval changes difftime, Duration, Period and numeric class objects to
#' intervals that begin at the specified date-time. Numeric objects are first
#' coerced to timespans equal to the numeric value in seconds.
#'
#' as.interval can be used to create accurate transformations between Period
#' objects, which measure time spans in variable length units, and Duration objects,
#' which measure timespans as an exact number of seconds. A start date-
#' time must be supplied to make the conversion. Lubridate uses
#' this start date to look up how many seconds each variable
#' length unit (e.g. month, year) lasted for during the time span
#' described. See
#' [as.duration()], [as.period()].
#'
#' @param x a duration, difftime, period, or numeric object that describes the length of the interval
#' @param start a POSIXt or Date object that describes when the interval begins
#' @param ... additional arguments to pass to as.interval
#' @return an interval object
#' @seealso [interval()]
#' @keywords classes manip methods chron
#' @examples
#' diff <- make_difftime(days = 31) # difftime
#' as.interval(diff, ymd("2009-01-01"))
#' as.interval(diff, ymd("2009-02-01"))
#'
#' dur <- duration(days = 31) # duration
#' as.interval(dur, ymd("2009-01-01"))
#' as.interval(dur, ymd("2009-02-01"))
#'
#' per <- period(months = 1) # period
#' as.interval(per, ymd("2009-01-01"))
#' as.interval(per, ymd("2009-02-01"))
#'
#' as.interval(3600, ymd("2009-01-01")) # numeric
#' @aliases as.interval,numeric-method as.interval,difftime-method as.interval,Interval-method as.interval,Duration-method as.interval,Period-method as.interval,POSIXt-method as.interval,logical-method
#' @export
as.interval <- function(x, start, ...) standardGeneric("as.interval")

#' @export
setGeneric("as.interval",
  function(x, start, ...) standardGeneric("as.interval"),
  useAsDefault = function(x, start, ...) {
    stop(sprintf("as.interval is not defined for class '%s'", class(x)))
  }
)

setMethod("as.interval", signature(x = "numeric"), function(x, start, ...) {
  .number_to_interval(x, start, ...)
})

setMethod("as.interval", signature(x = "difftime"), function(x, start, ...) {
  .number_to_interval(x, start, ...)
})

setMethod("as.interval", signature(x = "Interval"), function(x, start, ...) {
  x
})

setMethod("as.interval", signature(x = "POSIXt"), function(x, start, ...) {
  .number_to_interval(x, start, ...)
})

#' @export
setMethod("as.interval", signature("logical"), function(x, start, ...) {
  .number_to_interval(as.numeric(x), start, ...)
})

.number_to_interval <- function(x, start, ...) {
  if (missing(start) & all(is.na(x))) {
    start <- .POSIXct(NA_real_, tz = "UTC")
  } else {
    stopifnot(is.instant(start))
  }

  if (is.instant(x)) {
    return(interval(x, start))
  } else {
    interval(start, start + x)
  }
}


#' Change an object to a period
#'
#' as.period changes Interval, Duration, difftime and numeric class objects
#' to Period class objects with the specified units.
#'
#' Users must specify which time units to measure the period in. The exact length of
#' each time unit in a period will depend on when it occurs. See
#' [Period-class] and [period()].
#' The choice of units is not trivial; units that are
#' normally equal may differ in length depending on when the time period
#' occurs. For example, when a leap second occurs one minute is longer than 60
#' seconds.
#'
#' Because periods do not have a fixed length, they can not be accurately
#' converted to and from Duration objects. Duration objects measure time spans
#' in exact numbers of seconds, see [Duration-class]. Hence, a one to one
#' mapping does not exist between durations and periods. When used with a
#' Duration object, as.period provides an inexact estimate; the duration is
#' broken into time units based on the most common lengths of time units, in
#' seconds. Because the length of months are particularly variable, a period
#' with a months unit can not be coerced from a duration object. For an exact
#' transformation, first transform the duration to an interval with
#' [as.interval()].
#'
#' Coercing an interval to a period may cause surprising behavior if you request
#' periods with small units. A leap year is 366 days long, but one year long. Such
#' an interval will convert to 366 days when unit is set to days and 1 year when
#' unit is set to years. Adding 366 days to a date will often give a different
#' result than adding one year. Daylight savings is the one exception where this
#' does not apply. Interval lengths are calculated on the UTC timeline, which does
#' not use daylight savings. Hence, periods converted with seconds or minutes will not
#' reflect the actual variation in seconds and minutes that occurs due to daylight
#' savings. These periods will show the "naive" change in seconds and minutes that is
#' suggested by the differences in clock time. See the examples below.
#'
#' @param x an interval, difftime, or numeric object
#' @param unit A character string that specifies which time units to build period in.
#' unit is only implemented for the as.period.numeric method and the as.period.interval method.
#' For as.period.interval, as.period will convert intervals to units no larger than the specified
#' unit.
#' @param ... additional arguments to pass to as.period
#' @return a period object
#' @seealso [Period-class], [period()]
#' @keywords classes manip methods chron
#' @examples
#' span <- interval(ymd_hms("2009-01-01 00:00:00"), ymd_hms("2010-02-02 01:01:01")) # interval
#' as.period(span)
#' as.period(span, unit = "day")
#' "397d 1H 1M 1S"
#' leap <- interval(ymd("2016-01-01"), ymd("2017-01-01"))
#' as.period(leap, unit = "days")
#' as.period(leap, unit = "years")
#' dst <- interval(
#'   ymd("2016-11-06", tz = "America/Chicago"),
#'   ymd("2016-11-07", tz = "America/Chicago")
#' )
#' # as.period(dst, unit = "seconds")
#' as.period(dst, unit = "hours")
#' per <- period(hours = 10, minutes = 6)
#' as.numeric(per, "hours")
#' as.numeric(per, "minutes")
#' @aliases as.period,numeric-method as.period,difftime-method
#'   as.period,Interval-method as.period,Duration-method as.period,Period-method
#'   as.period,logical-method as.period,character-method
#' @export
setGeneric("as.period",
  function(x, unit, ...) standardGeneric("as.period"),
  useAsDefault = function(x, unit, ...) {
    stop(sprintf("as.period is not defined for class '%s'", class(x)))
  }
)

setMethod("as.period", signature(x = "character"), function(x, ...) {
  parse_period(x)
})

setMethod("as.period", signature(x = "numeric"), function(x, unit = "second", ...) {
  x <- as.numeric(x)
  if (missing(unit)) unit <- "second"
  unit <- standardise_date_names(unit[[1]])
  f <- get(paste(unit, "s", sep = ""),
    envir = asNamespace("lubridate"),
    mode = "function", inherits = FALSE
  )
  f(x)
})

setMethod("as.period", signature(x = "difftime"), function(x, unit = NULL, ...) {
  seconds_to_period(as.double(x, "secs"))
})

setMethod("as.period", signature(x = "Interval"), function(x, unit = NULL, ...) {
  ## fixme: document this in the manual

  ## SEMANTICS: for postitive intervals all units of the period will be
  ## positive, and the oposite for negatve intervals.

  ## Periods are not symetric in the sense that as.period(int) might not be the
  ## same as -as.period(int_flip(int)). See
  ## https://github.com/tidyverse/lubridate/issues/285 for motivation.

  unit <-
    if (missing(unit)) {
      "year"
    } else {
      standardise_period_names(unit)
    }

  switch(unit,
    year = .int_to_period(x),
    month = {
      x <- .int_to_period(x)
      as.period(x, unit = unit)
    },
    ## fixme: add note to the docs that unit <= days results in much faster conversion
    ## fixme: add week
    day = ,
    hour = ,
    minute = ,
    second = {
      secs <- x@.Data
      negs <- secs < 0 & !is.na(secs)
      units <- .units_within_seconds(abs(secs), unit)
      pers <- do.call("new", c("Period", units))
      pers[negs] <- -pers[negs]
      pers
    },
    stop("Unsuported unit ", unit)
  )
})

.int_to_period <- function(x) {
  ## this function is called only for conversion with units > day
  start <- as.POSIXlt(x@start)
  end <- unclass(as.POSIXlt(start + x@.Data))
  start <- unclass(start)

  negs <- x@.Data < 0 & !is.na(x@.Data)

  per <- list()

  for (nm in c("sec", "min", "hour", "mday", "mon", "year")) {
    per[[nm]] <- ifelse(negs, start[[nm]] - end[[nm]], end[[nm]] - start[[nm]])
  }

  names(per) <- c("second", "minute", "hour", "day", "month", "year")

  ## Remove negative ...

  ## seconds
  nsecs <- per$second < 0 & !is.na(per$second)
  per$second[nsecs] <- 60 + per$second[nsecs]
  per$minute[nsecs] <- per$minute[nsecs] - 1
  per$second[negs] <- -per$second[negs]

  ## minutes
  nmins <- per$minute < 0 & !is.na(per$minute)
  per$minute[nmins] <- 60 + per$minute[nmins]
  per$hour[nmins] <- per$hour[nmins] - 1
  per$minute[negs] <- -per$minute[negs]

  ## hours
  nhous <- per$hour < 0 & !is.na(per$hour)
  per$hour[nhous] <- 24 + per$hour[nhous]
  per$hour[negs] <- -per$hour[negs]

  ## days

  ### postivie periods
  ndays <- !negs & per$day < 0 & !is.na(per$day)
  if (any(ndays)) {

    ## compute nr days in previous month
    add_months <- rep.int(-1, sum(ndays))

    pmonth <- end$mon[ndays]
    pmonth[pmonth == 0] <- 1 # dec == jan == 31 days
    prev_month_days <- .days_in_month(pmonth, end$year[ndays])

    ## difference in days:
    ## /need pmax to capture as.period(interval(ymd("1985-01-31"), ymd("1986-03-28")))/
    per$day[ndays] <- pmax(prev_month_days - start$mday[ndays], 0) + end$mday[ndays]
    per$month[ndays] <- per$month[ndays] + add_months
  }

  ## negative periods
  ndays <- negs & per$day < 0 & !is.na(per$day)
  if (any(ndays)) {
    add_months <- rep.int(1, sum(ndays))
    this_month_days <- .days_in_month(end$mon[ndays] + 1, end$year[ndays])

    ## Compute nr of days:
    ## /need pmax to capture as.period(interval(ymd("1985-01-31"), ymd("1986-03-28")))/
    per$day[ndays] <- pmax(this_month_days - end$mday[ndays], 0) + start$mday[ndays]
    per$month[ndays] <- per$month[ndays] - add_months
  }

  ## substract only after the day computation to capture intervals like:
  ## as.period(interval(ymd_hms("1985-12-31 5:0:0"), ymd_hms("1986-02-01 3:0:0")))
  per$day[nhous] <- per$day[nhous] - 1
  per$day[negs] <- -per$day[negs]

  ## months
  nmons <- per$month < 0 & !is.na(per$month)
  per$month[nmons] <- 12 + per$month[nmons]
  per$year[nmons] <- per$year[nmons] - 1
  per$month[negs] <- -per$month[negs]

  per$year[negs] <- -per$year[negs]

  new("Period", per$second,
    year = per$year, month = per$month,
    day = per$day, hour = per$hour, minute = per$minute
  )
}

setMethod("as.period", signature(x = "Duration"), function(x, unit = NULL, ...) {
  span <- x@.Data
  remainder <- abs(span)
  newper <- period(second = rep(0, length(x)))

  slot(newper, "year") <- remainder %/% average_durations[["year"]]
  remainder <- remainder %% average_durations[["year"]]

  slot(newper, "day") <- remainder %/% (3600 * 24)
  remainder <- remainder %% (3600 * 24)

  slot(newper, "hour") <- remainder %/% (3600)
  remainder <- remainder %% (3600)

  slot(newper, "minute") <- remainder %/% (60)
  newper$second <- remainder %% (60)

  newper * sign(span)
})

setMethod(
  "as.period", signature("Period"),
  function(x, unit = NULL, ...) {
    if (missing(unit) || is.null(unit)) {
      x
    } else {
      unit <- standardise_period_names(unit)
      switch(unit,
        year = x,
        month = {
          years <- 0
          months <- month(x) + year(x) * 12
          new(
            "Period",
            x$second,
            year = years,
            month = months,
            day = x$day,
            hour = x$hour,
            minute = x$minute
          )
        },
        day = ,
        hour = ,
        minute = ,
        second = {
          N <- .units_within_seconds(period_to_seconds(x), unit)
          do.call("new", c("Period", N))
        },
        stop("Unsuported unit ", unit)
      )
    }
  }
)

setMethod("as.period", signature("logical"), function(x, unit = NULL, ...) {
  as.period(as.numeric(x), unit, ...)
})

#' @importFrom generics as.difftime
#' @export
generics::as.difftime

#' @export
setMethod("as.difftime", signature(tim = "Interval"), function(tim, format = "%X", units = "secs") {
  as.difftime(as.numeric(tim, units), format, units)
})

as_difftime_from_duration <- function(tim, format = "%X", units = "secs") {
  as.difftime(tim@.Data, format, units)
}
#' @export
setMethod("as.difftime", signature(tim = "Duration"), as_difftime_from_duration)

#' @export
setMethod("as.difftime", signature(tim = "Period"), function(tim, format = "%X", units = "secs") {
  as.difftime(period_to_seconds(tim), format, units)
})

seconds_to_unit <- function(secs, unit = "second") {
  switch(unit,
    second = secs,
    minute = secs / 60,
    hour   = secs / 3600,
    day    = secs / 86400,
    month  = secs / (86400 * 365.25 / 12),
    week   = secs / (86400 * 7),
    year   = secs / (86400 * 365.25),
    stop("invalid unit ", unit)
  )
}

setGeneric("as.numeric")

#' @export
setMethod("as.numeric", signature("Duration"), function(x, units = "secs", ...) {
  unit <- standardise_period_names(units)
  as.numeric(seconds_to_unit(x@.Data, unit), ...)
})

#' @export
setMethod("as.numeric", signature(x = "Interval"), function(x, units = "secs", ...) {
  as.numeric(as.duration(x), units, ...)
})

#' @export
setMethod("as.numeric", signature(x = "Period"), function(x, units = "second", ...) {
  unit <- standardise_period_names(units)
  as.numeric(seconds_to_unit(period_to_seconds(x), unit = unit), ...)
})

setGeneric("as.integer")

#' @export
setMethod("as.integer", signature("Duration"), function(x, units = "secs", ...) {
  unit <- standardise_period_names(units)
  as.integer(seconds_to_unit(x@.Data, unit), ...)
})

#' @export
setMethod("as.integer", signature(x = "Interval"), function(x, units = "secs", ...) {
  as.integer(as.duration(x), units, ...)
})

#' @export
setMethod("as.integer", signature(x = "Period"), function(x, units = "second", ...) {
  unit <- standardise_period_names(units)
  as.integer(seconds_to_unit(period_to_seconds(x), unit = unit), ...)
})

as.POSIXt <- function(x) as.POSIXlt(x)

## TODO{MM}:  Do not confuse  as.character()  and  format()
## -------   {originally were used interchangably in R for Date and POSIX?t}

#' @export
setMethod("as.character", signature(x = "Period"), function(x, ...) {
  format(x)
})

#' @export
setMethod("as.character", signature(x = "Duration"), function(x, ...) {
  format(x)
})

#' @export
setMethod("as.character", signature(x = "Interval"), function(x, ...) {
  format(x)
})


#' Convert an object to a date or date-time
#'
#'
#' @section Compare to base R:
#'
#' These are drop in replacements for [as.Date()] and [as.POSIXct()], with a few
#' tweaks to make them work more intuitively.
#'
#' \itemize{
#'
#' \item Called on a `POSIXct` object, `as_date()` uses the tzone attribute of
#'   the object to return the same date as indicated by the printed representation
#'   of the object. This differs from as.Date, which ignores the attribute and
#'   uses only the tz argument to `as.Date()` ("UTC" by default).
#'
#' \item Both functions provide a default origin argument for numeric vectors.
#'
#' \item Both functions will generate NAs for invalid date format. Valid formats are
#'   those described by ISO8601 standard. A warning message will provide a count of the
#'   elements that were not converted.
#'
#' \item `as_datetime()` defaults to using UTC.
#'
#' }
#'
#' @param x a vector of [POSIXt], numeric or character objects
#' @param origin a Date object, or something which can be coerced by `as.Date(origin,
#'   ...)` to such an object (default: the Unix epoch of "1970-01-01"). Note that in
#'   this instance, `x` is assumed to reflect the number of days since `origin` at
#'   `"UTC"`.
#' @param tz a time zone name (default: time zone of the POSIXt object `x`). See
#'   [OlsonNames()].
#' @param format format argument for character methods. When supplied parsing is
#'   performed by `parse_date_time(x, orders = formats, exact = TRUE)`. Thus, multiple
#'   formats are supported and are tried in turn.
#' @param ... further arguments to be passed to specific methods (see above).
#' @return a vector of [Date] objects corresponding to `x`.
#' @examples
#' dt_utc <- ymd_hms("2010-08-03 00:50:50")
#' dt_europe <- ymd_hms("2010-08-03 00:50:50", tz = "Europe/London")
#' c(as_date(dt_utc), as.Date(dt_utc))
#' c(as_date(dt_europe), as.Date(dt_europe))
#' ## need not supply origin
#' as_date(10)
#' ## Will replace invalid date format with NA
#' dt_wrong <- c("2009-09-29", "2012-11-29", "2015-29-12")
#' as_date(dt_wrong)
#' @export
setGeneric("as_date",
  def = function(x, ...) standardGeneric("as_date")
)

#' @rdname as_date
#' @export
setMethod("as_date", "ANY",
  function(x, ...) {
    ## From: Kurt Hornik <Kurt.Hornik@wu.ac.at>
    ## Date: Tue, 3 Apr 2018 18:53:19
    ##
    ## `zoo` has its own as.Date for which it registers its yearmon
    ## method (and base::as.Date as the default S3 method).  In fact,
    ## zoo also exports as.Date.yearmon etc, but the above
    ##
    ##    lubridate::as_date(zoo::as.yearmon("2011-01-07"))
    ##
    ## does not attach the zoo exports, hence does not find
    ## as.Date.yearmon on the search path.
    if (inherits(x, c("yearmon", "yearqtr"))) {
      zoo::as.Date(x, ...)
    } else {
      base::as.Date(x, ...)
    }
  }
)

#' @rdname as_date
#' @export
setMethod("as_date", "POSIXt",
  function(x, tz = NULL) {
    tz <- if (is.null(tz)) tz(x) else tz
    as.Date(x, tz = tz)
  }
)

#' @rdname as_date
setMethod("as_date", "numeric",
  function(x, origin = lubridate::origin) {
    as.Date(x, origin = origin)
  }
)

#' @rdname as_date
#' @export
setMethod("as_date", "character",
  function(x, tz = NULL, format = NULL) {
    if (!is.null(tz)) {
      warning("`tz` argument is ignored by `as_date()`", call. = FALSE)
    }
    if (is.null(format)) {
      as_date(.parse_iso_dt(x, tz = "UTC"))
    } else {
      as_date(parse_date_time(x, format, tz = "UTC", exact = TRUE))
    }
  }
)

#' @rdname as_date
#' @export
setGeneric("as_datetime",
  function(x, ...) standardGeneric("as_datetime")
)

#' @rdname as_date
#' @export
setMethod("as_datetime", "ANY",
  function(x, tz = lubridate::tz(x)) {
    with_tz(as.POSIXct(x, tz = tz), tzone = tz)
  }
)

#' @rdname as_date
#' @export
setMethod("as_datetime", "POSIXt",
  function(x, tz = lubridate::tz(x)) {
    with_tz(x, tz)
  }
)

#' @rdname as_date
#' @export
setMethod("as_datetime", "numeric",
  function(x, origin = lubridate::origin, tz = "UTC") {
    as.POSIXct(x, origin = origin, tz = tz)
  }
)

#' @rdname as_date
#' @export
setMethod("as_datetime", "character",
  function(x, tz = "UTC", format = NULL) {
    if (is.null(format)) {
      .parse_iso_dt(x, tz)
    } else {
      parse_date_time(x, format, tz = tz, exact = TRUE)
    }
  }
)

#' @rdname as_date
#' @export
setMethod("as_datetime", "Date",
  function(x, tz = "UTC") {
    dt <- .POSIXct(as.numeric(x) * 86400, tz = "UTC")
    if (is_utc(tz)) {
      return(dt)
    } else {
      force_tz(dt, tzone = tz)
    }
  }
)
