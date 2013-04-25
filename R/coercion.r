#' @include timespans.r
#' @include durations.r
#' @include intervals.r
#' @include periods.r
#' @include Dates.r
#' @include difftimes.r
#' @include numeric.r
#' @include POSIXt.r
NULL


#' Convert a variety of date-time classes to POSIXlt and POSIXct
#' @name DateCoercion
#' @keywords internal 
#'
#' @S3method as.POSIXlt fts
#' @S3method as.POSIXlt its
#' @S3method as.POSIXlt timeSeries
#' @S3method as.POSIXlt irts
#' @S3method as.POSIXlt xts
#' @S3method as.POSIXlt zoo
#' @S3method as.POSIXlt tis
#' @S3method as.POSIXct fts
#' @S3method as.POSIXct its
#' @S3method as.POSIXct timeSeries
#' @S3method as.POSIXct irts
#' @S3method as.POSIXct xts
#' @S3method as.POSIXct zoo
NULL

as.POSIXct.fts <- function(x, tz = "", ...) as.POSIXct(fts::dates.fts(x))
as.POSIXlt.fts <- function(x, tz = "", ...) as.POSIXlt(fts::dates.fts(x))

as.POSIXlt.its <- function(x, tz = "", ...) as.POSIXlt(attr(x, "dates"))
as.POSIXct.its <- function(x, tz = "", ...) as.POSIXct(attr(x, "dates"))

as.POSIXlt.timeSeries <- function(x, tz = "", ...) {
  as.POSIXlt(timeDate::timeDate(x@positions, 
    zone = x@FinCenter, FinCenter = x@FinCenter))
}
as.POSIXct.timeSeries <- function(x, tz = "", ...) {
  as.POSIXct(timeDate::timeDate(x@positions, 
    zone = x@FinCenter, FinCenter = x@FinCenter))
}

as.POSIXlt.irts <- function(x, tz = "", ...) as.POSIXlt(x$time)
as.POSIXct.irts <- function(x, tz = "", ...) as.POSIXct(x$time)

as.POSIXlt.xts <- function(x, tz = "", ...) as.POSIXlt(zoo::index(x))
as.POSIXct.xts <- function(x, tz = "", ...) as.POSIXct(zoo::index(x))
as.POSIXlt.zoo <- function(x, tz = "", ...) as.POSIXlt(zoo::index(x))
as.POSIXct.zoo <- function(x, tz = "", ...) as.POSIXct(zoo::index(x))

as.POSIXlt.tis <- function(x, tz = "", ...) as.Date(x)

#' Convenience method to reclass dates post-modification.
#' @keywords internal
#'
#' @export reclass_date
#' @S3method reclass_date POSIXlt
#' @S3method reclass_date POSIXct
#' @S3method reclass_date chron
#' @S3method reclass_date timeDate
#' @S3method reclass_date its
#' @S3method reclass_date ti
#' @S3method reclass_date Date
reclass_date <- function(new, orig) UseMethod("reclass_date", orig)
reclass_date.POSIXlt <- function(new, orig) {
  as.POSIXlt(new)
}
reclass_date.POSIXct <- function(new, orig) {
  as.POSIXct(new)
}
reclass_date.chron <- function(new, orig) {
  chron::as.chron(new)
}
reclass_date.timeDate <- function(new, orig) {
  timeDate::as.timeDate(new)
}
reclass_date.its <- function(new, orig) {
  its::its(new, format = "%Y-%m-%d %X")
}
reclass_date.ti <- function(new, orig) {
  tis::as.ti(new, tis::tifName(orig))
}
reclass_date.Date <- function(new, orig) {
  as.Date(new)
}


period_to_difftime <- function(per){
	as.difftime(per)
}

#' Convenience method to reclass timespans post-modification.
#' @keywords internal
#'
#' @export
#' @aliases reclass_timespan,ANY,difftime-method
#' @aliases reclass_timespan,ANY,Duration-method
#' @aliases reclass_timespan,ANY,Interval-method
#' @aliases reclass_timespan,ANY,Period-method
reclass_timespan <- function(new, orig) standardGeneric("reclass_timespan")

#' @export
setGeneric("reclass_timespan")

setMethod("reclass_timespan", signature(orig = "difftime"), function(new, orig){
	if (is.period(new))
		as.difftime(new)
	else
		make_difftime(as.numeric(new))
})

setMethod("reclass_timespan", signature(orig = "Duration"), function(new, orig){
	suppressMessages(as.duration(new))
})

setMethod("reclass_timespan", signature(orig = "Interval"), function(new, orig){
	suppressMessages(as.duration(new))
})
	
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
#' @seealso \code{\link{Duration-class}}, \code{\link{new_duration}}
#' @keywords classes manip methods chron
#' @examples
#' span <- interval(ymd("2009-01-01"), ymd("2009-08-01")) #interval
#' # "2009-01-01 UTC--2009-08-01 UTC"
#' as.duration(span)
#' # 18316800s (~212 days)
#' as.duration(10) # numeric
#' # 10s
#' @export 
#' @aliases as.duration,numeric-method
#' @aliases as.duration,logical-method
#' @aliases as.duration,difftime-method
#' @aliases as.duration,Interval-method
#' @aliases as.duration,Duration-method
#' @aliases as.duration,Period-method
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







#' Change an object to an interval.
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
#' @export as.interval
#' @param x a duration, difftime, period, or numeric object that describes the length of the interval
#' @param start a POSIXt or Date object that describes when the interval begins   
#' @param ... additional arguments to pass to as.interval
#' @return an interval object
#' @seealso \code{\link{interval}}, \code{\link{new_interval}}
#' @keywords classes manip methods chron
#' @examples
#' diff <- new_difftime(days = 31) #difftime
#' as.interval(diff, ymd("2009-01-01"))
#' # 2009-01-01 UTC--2009-02-01 UTC
#' as.interval(diff, ymd("2009-02-01"))
#' # 2009-02-01 UTC--2009-03-04 UTC
#' 
#' dur <- new_duration(days = 31) #duration
#' as.interval(dur, ymd("2009-01-01"))
#' # 2009-01-01 UTC--2009-02-01 UTC
#' as.interval(dur, ymd("2009-02-01"))
#' # 2009-02-01 UTC--2009-03-04 UTC
#'
#' per <- new_period(months = 1) #period
#' as.interval(per, ymd("2009-01-01"))
#' # 2009-01-01 UTC--2009-02-01 UTC 
#' as.interval(per, ymd("2009-02-01"))
#' # 2009-02-01 UTC--2009-03-01 UTC
#'
#' as.interval(3600, ymd("2009-01-01")) #numeric
#' # 2009-01-01 UTC--2009-01-01 01:00:00 UTC
#' @aliases as.interval,numeric-method
#' @aliases as.interval,difftime-method
#' @aliases as.interval,Interval-method
#' @aliases as.interval,Duration-method
#' @aliases as.interval,Period-method
#' @aliases as.interval,POSIXt-method
#' @aliases as.interval,logical-method
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
		return(new_interval(x, start))
	else
		new_interval(start, start + x)
}


#' Change an object to a period.
#'
#' as.period changes Interval, Duration, difftime and numeric class objects 
#' to Period class objects with the specified units.
#'
#' Users must specify which time units to measure the period in. The exact length of 
#' each time unit in a period will depend on when it occurs. See 
#' \code{\link{Period-class}} and \code{\link{new_period}}. 
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
#' @export
#' @param x an interval, difftime, or numeric object   
#' @param unit A character string that specifies which time units to build period in. 
#' unit is only implemented for the as.period.numeric method and the as.period.interval method. 
#' For as.period.interval, as.period will convert intervals to units no larger than the specified 
#' unit. 
#' @param ... additional arguments to pass to as.period
#' @return a period object
#' @seealso \code{\link{Period-class}}, \code{\link{new_period}}
#' @keywords classes manip methods chron
#' @examples
#' span <- new_interval(as.POSIXct("2009-01-01"), as.POSIXct("2010-02-02 01:01:01")) #interval
#' # 2009-01-01 CST--2010-02-02 01:01:01 CST
#' as.period(span)
#' # "1y 1m 1d 1H 1M 1S"
#' as.period(span, units = "day")
#' "397d 1H 1M 1S"
#' leap <- new_interval(ymd("2016-01-01"), ymd("2017-01-01"))
#' # 2016-01-01 UTC--2017-01-01 UTC
#' as.period(leap, unit = "days")
#' # "366d 0H 0M 0S"
#' as.period(leap, unit = "years")
#' # "1y 0m 0d 0H 0M 0S"
#' dst <- new_interval(ymd("2016-11-06", tz = "America/Chicago"), 
#' ymd("2016-11-07", tz = "America/Chicago"))
#' # 2016-11-06 CDT--2016-11-07 CST
#' # as.period(dst, unit = "seconds")
#' # "86400S"
#' as.period(dst, unit = "hours")
#' # "24H 0M 0S"
#' @aliases as.period,numeric-method
#' @aliases as.period,difftime-method
#' @aliases as.period,Interval-method
#' @aliases as.period,Duration-method
#' @aliases as.period,Period-method
#' @aliases as.period,logical-method
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
  negs <- int_length(x) < 0 & !is.na(int_length(x))
  x[negs] <- int_flip(x[negs])

  if (is.null(match.call()$unit)) {
    pers <- .int_to_period(x)
    pers[negs] <- -1 * pers[negs]
    return(pers)
  } else {
    unit <- match.call()$unit
    unit <- standardise_period_names(unit)
    per <- get(paste(unit, "s", sep = ""))
    num <- x %/% per(1)
    left_over <- x %% per(1)
    pers <- per(num) + .int_to_period(left_over)
  }
  
  pers[negs] <- -1 * pers[negs]
  pers
})
  
  
.int_to_period <- function(x){  
  start <- as.POSIXlt(x@start)
  end <- as.POSIXlt(start + x@.Data)

  to.per <- as.data.frame(unclass(end)) - 
    as.data.frame(unclass(start))
    
  names(to.per)[1:6] <- c("second", "minute", "hour", "day", "month", "year")
  to.per <- to.per[1:6]
  
  # remove negative periods
  nsecs <- to.per$second < 0 & !is.na(to.per$second)
  to.per$second[nsecs] <- 60 + to.per$second[nsecs]
  to.per$minute[nsecs] <- to.per$minute[nsecs] - 1
  
  nmins <- to.per$minute < 0 & !is.na(to.per$minute)
  to.per$minute[nmins] <- 60 + to.per$minute[nmins]
  to.per$hour[nmins] <- to.per$hour[nmins] - 1
  
  nhous <- to.per$hour < 0 & !is.na(to.per$hour)
  to.per$hour[nhous] <- 24 + to.per$hour[nhous]
  to.per$day[nhous] <- to.per$day[nhous] - 1
  
  ndays <- to.per$day < 0 & !is.na(to.per$day)
  if (any(ndays)) {
    day.no <- floor_date(end, "month") - days(1)
    day.no <- day.no$mday
    to.per$day[ndays] <- day.no[ndays] + to.per$day[ndays]
    to.per$month[ndays] <- to.per$month[ndays] - 1
  }
  
  nmons <- to.per$month < 0 & !is.na(to.per$month)
  to.per$month[nmons] <- 12 + to.per$month[nmons]
  to.per$year[nmons] <- to.per$year[nmons] - 1
  
  new("Period", to.per$second, year = to.per$year, month = to.per$month, 
    day = to.per$day, hour = to.per$hour, minute = to.per$minute)
}

setMethod("as.period", signature(x = "Duration"), function(x, unit = NULL, ...) {
  verbose <- getOption("lubridate.verbose")
  if (is.null(verbose) || verbose) {
    message("estimate only: convert durations to intervals for accuracy")
  }
  span <- x@.Data
  remainder <- abs(span)
  newper <- new_period(second = rep(0, length(x)))
  
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

setMethod("as.period", signature("Period"), function(x, unit = NULL, ...) x)

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
