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

#' @export
as.POSIXlt.its <- function(x, tz = "", ...) as.POSIXlt(attr(x, "dates"))
#' @export
as.POSIXct.its <- function(x, tz = "", ...) as.POSIXct(attr(x, "dates"))

#' @export
as.POSIXlt.timeSeries <- function(x, tz = "", ...) {
  as.POSIXlt(timeDate::timeDate(x@positions,
    zone = x@FinCenter, FinCenter = x@FinCenter))
}
#' @export
as.POSIXct.timeSeries <- function(x, tz = "", ...) {
  as.POSIXct(timeDate::timeDate(x@positions,
    zone = x@FinCenter, FinCenter = x@FinCenter))
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
#' @export
reclass_date.its <- function(new, orig) {
  its::its(new, format = "%Y-%m-%d %X")
}
#' @export
reclass_date.ti <- function(new, orig) {
  tis::as.ti(new, tis::tifName(orig))
}
#' @export
reclass_date.Date <- function(new, orig) {
  as.Date(new)
}


period_to_difftime <- function(per){
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
setGeneric("reclass_timespan")

#' @export
setMethod("reclass_timespan", signature(orig = "difftime"), function(new, orig){
	if (is.period(new))
		as.difftime(new)
	else
		make_difftime(as.numeric(new))
})

#' @export
setMethod("reclass_timespan", signature(orig = "Duration"), function(new, orig){
	suppressMessages(as.duration(new))
})

#' @export
setMethod("reclass_timespan", signature(orig = "Interval"), function(new, orig){
	suppressMessages(as.duration(new))
})

#' @export
setMethod("reclass_timespan", signature(orig = "Period"), function(new, orig){
	suppressMessages(as.period(new))
})


#' Change an object to a duration.
#'
#' as.duration changes Interval, Period and numeric class objects to
#' Duration objects. Numeric objects are changed to Duration objects
#' with the seconds unit equal to the numeric value.
#'
#' Durations are exact time measurements, whereas periods are relative time
#' measurements. See \code{\link{Period-class}}. The length of a period depends on
#' when it occurs. Hence, a one to one mapping does not exist between durations
#' and periods. When used with a period object, as.duration provides an inexact
#' estimate of the length of the period; each time unit is assigned its most
#' common number of seconds. A period of one month is converted to 2628000 seconds
#' (approximately 30.42 days). This ensures that 12 months will sum to 365 days, or
#' one normal year. For an exact
#' transformation, first transform the period to an interval with
#' \code{\link{as.interval}}.
#'
#' as.duration.period displays the message "estimate only:
#' convert periods to
#' intervals for accuracy" by default. You can turn this message off by
#' setting the global \code{lubridate.verbose} option to FALSE with
#' \code{options(lubridate.verbose = FALSE)}.
#'
#' @param x Object to be coerced to a duration
#' @return A duration object
#' @seealso \code{\link{Duration-class}}, \code{\link{duration}}
#' @keywords classes manip methods chron
#' @examples
#' span <- interval(ymd("2009-01-01"), ymd("2009-08-01")) #interval
#' # "2009-01-01 UTC--2009-08-01 UTC"
#' as.duration(span)
#' # 18316800s (~212 days)
#' as.duration(10) # numeric
#' # 10s
#' @aliases as.duration,numeric-method as.duration,logical-method as.duration,difftime-method as.duration,Interval-method as.duration,Duration-method as.duration,Period-method
#' @export
as.duration <- function(x) standardGeneric("as.duration")

#' @export
setGeneric("as.duration")

setMethod("as.duration", signature(x = "numeric"), function(x){
	new("Duration", x)
})

setMethod("as.duration", signature(x = "logical"), function(x){
  new("Duration", as.numeric(x))
})

setMethod("as.duration", signature(x = "difftime"), function(x){
	new("Duration", as.numeric(x, "secs"))
})

setMethod("as.duration", signature(x = "Interval"), function(x){
	new("Duration", x@.Data)
})

setMethod("as.duration", signature(x = "Duration"), function(x){
	x
})

setMethod("as.duration", signature(x = "Period"), function(x){
  verbose <- getOption("lubridate.verbose")
  if (is.null(verbose) || verbose) {
    message("estimate only: convert periods to intervals for accuracy")
  }
	new("Duration", period_to_seconds(x))
})




#' Change an object to an \code{interval}.
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
#' \code{\link{as.duration}}, \code{\link{as.period}}.
#'
#' @param x a duration, difftime, period, or numeric object that describes the length of the interval
#' @param start a POSIXt or Date object that describes when the interval begins
#' @param ... additional arguments to pass to as.interval
#' @return an interval object
#' @seealso \code{\link{interval}}
#' @keywords classes manip methods chron
#' @examples
#' diff <- make_difftime(days = 31) #difftime
#' as.interval(diff, ymd("2009-01-01"))
#' # 2009-01-01 UTC--2009-02-01 UTC
#' as.interval(diff, ymd("2009-02-01"))
#' # 2009-02-01 UTC--2009-03-04 UTC
#'
#' dur <- duration(days = 31) #duration
#' as.interval(dur, ymd("2009-01-01"))
#' # 2009-01-01 UTC--2009-02-01 UTC
#' as.interval(dur, ymd("2009-02-01"))
#' # 2009-02-01 UTC--2009-03-04 UTC
#'
#' per <- period(months = 1) #period
#' as.interval(per, ymd("2009-01-01"))
#' # 2009-01-01 UTC--2009-02-01 UTC
#' as.interval(per, ymd("2009-02-01"))
#' # 2009-02-01 UTC--2009-03-01 UTC
#'
#' as.interval(3600, ymd("2009-01-01")) #numeric
#' # 2009-01-01 UTC--2009-01-01 01:00:00 UTC
#' @aliases as.interval,numeric-method as.interval,difftime-method as.interval,Interval-method as.interval,Duration-method as.interval,Period-method as.interval,POSIXt-method as.interval,logical-method
#' @export
as.interval <- function(x, start, ...) standardGeneric("as.interval")

#' @export
setGeneric("as.interval")

setMethod("as.interval", signature(x = "numeric"), function(x, start, ...){
  .number_to_interval(x, start, ...)
})

setMethod("as.interval", signature(x = "difftime"), function(x, start, ...){
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

.number_to_interval <- function(x, start, ...){
  if (missing(start) & all(is.na(x)))
    start <- as.POSIXct(NA, origin = origin)
  else stopifnot(is.instant(start))

	if (is.instant(x))
		return(interval(x, start))
	else
		interval(start, start + x)
}


#' Change an object to a period.
#'
#' as.period changes Interval, Duration, difftime and numeric class objects
#' to Period class objects with the specified units.
#'
#' Users must specify which time units to measure the period in. The exact length of
#' each time unit in a period will depend on when it occurs. See
#' \code{\link{Period-class}} and \code{\link{period}}.
#' The choice of units is not trivial; units that are
#' normally equal may differ in length depending on when the time period
#' occurs. For example, when a leap second occurs one minute is longer than 60
#' seconds.
#'
#' Because periods do not have a fixed length, they can not be accurately
#' converted to and from Duration objects. Duration objects measure time spans
#' in exact numbers of seconds, see \code{\link{Duration-class}}. Hence, a one to one
#' mapping does not exist between durations and periods. When used with a
#' Duration object, as.period provides an inexact estimate; the duration is
#' broken into time units based on the most common lengths of time units, in
#' seconds. Because the length of months are particularly variable, a period
#' with a months unit can not be coerced from a duration object. For an exact
#' transformation, first transform the duration to an interval with
#' \code{\link{as.interval}}.
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
#' as.period.difftime and as.period.duration display the message "estimate only:
#' convert difftimes (or duration) to
#' intervals for accuracy" by default. You can turn this message off by
#' setting the global \code{lubridate.verbose} option to FALSE with
#' \code{options(lubridate.verbose = FALSE)}.
#'
#' @param x an interval, difftime, or numeric object
#' @param unit A character string that specifies which time units to build period in.
#' unit is only implemented for the as.period.numeric method and the as.period.interval method.
#' For as.period.interval, as.period will convert intervals to units no larger than the specified
#' unit.
#' @param ... additional arguments to pass to as.period
#' @return a period object
#' @seealso \code{\link{Period-class}}, \code{\link{period}}
#' @keywords classes manip methods chron
#' @examples
#' span <- interval(as.POSIXct("2009-01-01"), as.POSIXct("2010-02-02 01:01:01")) #interval
#' # 2009-01-01 CST--2010-02-02 01:01:01 CST
#' as.period(span)
#' # "1y 1m 1d 1H 1M 1S"
#' as.period(span, units = "day")
#' "397d 1H 1M 1S"
#' leap <- interval(ymd("2016-01-01"), ymd("2017-01-01"))
#' # 2016-01-01 UTC--2017-01-01 UTC
#' as.period(leap, unit = "days")
#' # "366d 0H 0M 0S"
#' as.period(leap, unit = "years")
#' # "1y 0m 0d 0H 0M 0S"
#' dst <- interval(ymd("2016-11-06", tz = "America/Chicago"),
#' ymd("2016-11-07", tz = "America/Chicago"))
#' # 2016-11-06 CDT--2016-11-07 CST
#' # as.period(dst, unit = "seconds")
#' # "86400S"
#' as.period(dst, unit = "hours")
#' # "24H 0M 0S"
#' @aliases as.period,numeric-method as.period,difftime-method as.period,Interval-method as.period,Duration-method as.period,Period-method as.period,logical-method
#' @export
as.period <- function(x, unit, ...) standardGeneric("as.period")

#' @export
setGeneric("as.period")

setMethod("as.period", signature(x = "numeric"), function(x, unit = "second", ...){
  x <- as.numeric(x)
  if (missing(unit)) unit <- "second"
  unit <- standardise_date_names(unit)
  f <- match.fun(paste(unit, "s", sep = ""))
  f(x)
})

setMethod("as.period", signature(x = "difftime"), function(x, unit = NULL, ...){
  verbose <- getOption("lubridate.verbose")
  if (is.null(verbose) || verbose) {
    message("estimate only: convert difftimes to intervals for accuracy")
  }
  seconds_to_period(as.double(x, "secs"))
})

setMethod("as.period", signature(x = "Interval"), function(x, unit = NULL, ...) {
  ## fixme: document this in the manual

  ## SEMANTICS: for postitive intervals all units of the period will be
  ## positive, and the oposite for negatve intervals.

  ## Periods are not symetric in the sense that as.period(int) might not be the
  ## same as -as.period(int_flip(int)). See
  ## https://github.com/hadley/lubridate/issues/285 for motivation.

  unit <-
    if (missing(unit))  "year"
    else standardise_period_names(unit)

  switch(unit,
         year = .int_to_period(x),
         month = {
           pers <- .int_to_period(x)
           month(pers) <- month(pers) + year(pers)*12L
           year(pers) <- 0L
           pers
         },
         ## fixme: add note to the docs that unit <= days results in much faster conversion
         ## fixme: add week
         day = , hour = , minute = , second = {
           secs <- x@.Data
           negs <- secs < 0 & !is.na(secs)
           units <- .units_within_seconds(abs(secs), unit)
           pers <- do.call("new", c("Period", units))
           pers[negs] <- -pers[negs]
           pers
         },
         stop("Unsuported unit ", unit))
})

.int_to_period <- function(x){
  ## this function is called only for conversion with units > day
  start <- as.POSIXlt(x@start)
  end <- as.POSIXlt(start + x@.Data)

  negs <- x@.Data < 0 & !is.na(x@.Data)

  per <- list()

  for(nm in c("sec", "min", "hour", "mday", "mon", "year")){
    per[[nm]] <- ifelse(negs, start[[nm]] - end[[nm]], end[[nm]] - start[[nm]])
  }

  names(per) <- c("second", "minute", "hour", "day", "month", "year")

  ## Remove negative ...

  ## secons
  nsecs <- per$second < 0L & !is.na(per$second)
  per$second[nsecs] <- 60L + per$second[nsecs]
  per$minute[nsecs] <- per$minute[nsecs] - 1L
  per$second[negs] <- -per$second[negs]

  ## minutes
  nmins <- per$minute < 0L & !is.na(per$minute)
  per$minute[nmins] <- 60L + per$minute[nmins]
  per$hour[nmins] <- per$hour[nmins] - 1L
  per$minute[negs] <- -per$minute[negs]

  ## hours
  nhous <- per$hour < 0L & !is.na(per$hour)
  per$hour[nhous] <- 24L + per$hour[nhous]
  per$hour[negs] <- -per$hour[negs]

  ## days

  ### postivie periods
  ndays <- !negs & per$day < 0 & !is.na(per$day)
  if (any(ndays)) {

    ## compute nr days in previous month
    add_months <- rep.int(-1L, sum(ndays))

    pmonth <- end$mon[ndays]
    pmonth[pmonth == 0L] <- 1L #dec == jan == 31 days
    prev_month_days <- .days_in_month(pmonth, end$year[ndays])

    ## difference in days:
    ## /need pmax to capture as.period(interval(ymd("1985-01-31"), ymd("1986-03-28")))/
    per$day[ndays] <- pmax(prev_month_days - start$mday[ndays], 0) + end$mday[ndays]
    per$month[ndays] <- per$month[ndays] + add_months
  }

  ## negative periods
  ndays <- negs & per$day < 0 & !is.na(per$day)
  if (any(ndays)) {

    add_months <- rep.int(1L, sum(ndays))
    this_month_days <- .days_in_month(end$mon[ndays] + 1L, end$year[ndays])

    ## Compute nr of days:
    ## /need pmax to capture as.period(interval(ymd("1985-01-31"), ymd("1986-03-28")))/
    per$day[ndays] <- pmax(this_month_days - end$mday[ndays], 0) + start$mday[ndays]
    per$month[ndays] <- per$month[ndays] - add_months
  }

  ## substract only after the day computation to capture intervals like:
  ## as.period(interval(ymd_hms("1985-12-31 5:0:0"), ymd_hms("1986-02-01 3:0:0")))
  per$day[nhous] <- per$day[nhous] - 1L
  per$day[negs] <- -per$day[negs]

  ## months
  nmons <- per$month < 0L & !is.na(per$month)
  per$month[nmons] <- 12L + per$month[nmons]
  per$year[nmons] <- per$year[nmons] - 1L
  per$month[negs] <- -per$month[negs]

  per$year[negs] <- -per$year[negs]

  new("Period", per$second, year = per$year, month = per$month,
    day = per$day, hour = per$hour, minute = per$minute)
}

setMethod("as.period", signature(x = "Duration"), function(x, unit = NULL, ...) {
  verbose <- getOption("lubridate.verbose")
  if (is.null(verbose) || verbose) {
    message("estimate only: convert durations to intervals for accuracy")
  }
  span <- x@.Data
  remainder <- abs(span)
  newper <- period(second = rep(0, length(x)))

  slot(newper, "year") <- remainder %/% (3600 * 24 * 365)
  remainder <- remainder %% (3600 * 24 * 365)

  slot(newper, "day") <- remainder %/% (3600 * 24)
  remainder <- remainder %% (3600 * 24)

  slot(newper, "hour") <- remainder %/% (3600)
  remainder <- remainder %% (3600)

  slot(newper, "minute") <- remainder %/% (60)
  newper$second <- remainder %% (60)

  newper * sign(span)
})

setMethod("as.period", signature("Period"),
          function(x, unit = NULL, ...){
            if (missing(unit) || is.null(unit)) {
              x
            } else {
              unit <- standardise_period_names(unit)
              switch(unit,
                     year = x,
                     month = {
                       month(x) <- month(x) + year(x)*12L
                       year(x) <- 0L
                       x
                     },
                     day = , hour = , minute = , second = {
                       N <- .units_within_seconds(period_to_seconds(x), unit)
                       do.call("new", c("Period", N))
                     },
                     stop("Unsuported unit ", unit))
            }
          })

setMethod("as.period", signature("logical"), function(x, unit = NULL, ...) {
  as.period(as.numeric(x), unit, ...)
})

#' @export
setGeneric("as.difftime")

#' @export
setMethod("as.difftime", signature(tim = "Interval"), function(tim, format = "%X", units = "secs"){
	as.difftime(as.numeric(tim, units), format, units)
})

#' @export
setMethod("as.difftime", signature(tim = "Duration"), function(tim, format = "%X", units = "secs"){
	as.difftime(tim@.Data, format, units)
})

#' @export
setMethod("as.difftime", signature(tim = "Period"), function(tim, format = "%X", units = "secs"){
	as.difftime(period_to_seconds(tim), format, units)
})

setGeneric("as.numeric")

#' @export
setMethod("as.numeric", signature("Duration"), function(x, units = "secs", ...){
	units <- standardise_period_names(units)

	if (units == "month") stop("cannot map durations to months")
	num <- switch(units,
		second = x@.Data,
		minute = x@.Data / 60,
		hour = x@.Data / (60 * 60),
		day = x@.Data / (60 * 60 * 24),
		week = x@.Data / (60 * 60 * 24 * 7),
		year = x@.Data / (60 * 60 * 24 * 365.25))

	as.numeric(num, ...)
})

#' @export
setMethod("as.numeric", signature(x = "Interval"), function(x, units = "secs", ...){
	message("coercing interval to duration")
	as.numeric(as.duration(x), units, ...)
})

#' @export
setMethod("as.numeric", signature(x = "Period"), function(x, units = "second", ...){
	units <- standardise_period_names(units)
	if (units == "second") x@.Data
	else slot(x, units)
})


as.POSIXt <- function(x) as.POSIXlt(x)

#' @export
setMethod("as.character", signature(x = "Period"), function(x, ...){
  format(x)
})

#' @export
setMethod("as.character", signature(x = "Duration"), function(x, ...){
  format(x)
})

#' @export
setMethod("as.character", signature(x = "Interval"), function(x, ...){
  format(x)
})


#' Convert an object to a Date
#'
#' A drop in replacement for base \code{as.Date} with two two
#' differences. First, it ignores timezone attribute resulting in a more
#' intuitive conversion (see examples). Second, it does not require origin
#' argument which defaults to 1970-01-01.
#'
#' @param x a vector of \code{\link{POSIXt}}, numeric or character objects
#' @param ... further arguments to be passed to specific methods (see above).
#' @return a vector of \code{\link{Date}} objects corresponding to \code{x}.
#' @examples
#' dt_utc <- ymd_hms("2010-08-03 00:50:50")
#' dt_europe <- ymd_hms("2010-08-03 00:50:50", tz="Europe/London")
#' c(as_date(dt_utc), as.Date(dt_utc))
#' ## [1] "2010-08-03" "2010-08-03"
#' c(as_date(dt_europe), as.Date(dt_europe))
#' ## [1] "2010-08-03" "2010-08-02"
#' ## need not suply origin
#' as_date(10)
#' ## [1] "1970-01-11"
#' @export
setGeneric(name = "as_date",
           def = function(x, ...) standardGeneric("as_date"),
           useAsDefault = as.Date)

#' @rdname as_date
#' @param tz a time zone name (default: time zone of the POSIXt object
#'   \code{x}). See \code{\link{olson_time_zones}}.
#' @export
setMethod(f = "as_date", signature = "POSIXt",
          function (x, tz = NULL) {
            tz <- if (is.null(tz)) tz(x) else tz
            as.Date(x, tz = tz)
          })

#' @rdname as_date
#' @param origin a Date object, or something which can be coerced by
#'   \code{as.Date(origin, ...)} to such an object (default: the Unix epoch of
#'   "1970-01-01"). Note that in this instance, \code{x} is assumed to reflect
#'   the number of days since \code{origin} at \code{"UTC"}.
#' @export
setMethod(f = "as_date", signature = "numeric",
          function (x, origin = lubridate::origin) {
            as.Date(x, origin = origin)
          })
