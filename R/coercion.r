#' @include timespans.r
#' @include durations.r
#' @include intervals.r
#' @include periods.r
#' @include Dates.r
#' @include difftimes.r
#' @include numeric.r
#' @include POSIXt.r
NULL


#' Convert every date method we know about to POSIXlt and POSIXct
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
  as.chron(new)
}
reclass_date.timeDate <- function(new, orig) {
  as.timeDate(new)
}
reclass_date.its <- function(new, orig) {
  its(x, dates, format = "%Y-%m-%d %X")
}
reclass_date.ti <- function(new, orig) {
  as.ti(new, tifName(orig))
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
#' @export reclass_timespan
#' @S3method reclass_timespan difftime
reclass_timespan <- function(new, orig)
	UseMethod("reclass_timespan", orig)

reclass_timespan.difftime <- function(new, orig){
	if (is.period(new))
		as.difftime(new)
	else
		make_difftime(as.numeric(new))
}

#' @export
setGeneric("reclass_timespan")

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
#' as.duration changes interval, period and numeric objects to 
#' duration objects. Numeric objects are changed to duration objects 
#' with the seconds unit equal to the numeric value. 
#'
#' Durations are exact time measurements, whereas periods are relative time 
#' measurements. See \code{\link{Period-class}}. The length of a period depends on 
#' when it occurs. Hence, a one to one mapping does not exist between durations 
#' and periods. When used with a period object, as.duration provides an inexact 
#' estimate of the length of the period; each time unit is assigned its most 
#' common number of seconds. Periods with a months unit cannot be coerced to 
#' durations because of the variability of month lengths. For an exact 
#' transformation, first transform the period to an interval with 
#' \code{\link{as.interval}}.
#'
#' @export as.duration 
#' @S3method as.duration default 
#' @S3method as.duration difftime
#' @S3method as.duration numeric
#' @param x an interval, period, or numeric object   
#' @return a duration object
#' @seealso \code{\link{Duration-class}}, \code{\link{new_duration}}
#' @keywords classes manip methods chron
#' @examples
#' span <- new_interval(ymd("2009-01-01"), ymd("2009-08-01")) #interval
#' # 2009-01-01 -- 2009-08-01 
#' as.duration(span)
#' # 18316800s (212d)
#' as.duration(10) # numeric
#' # 10s
as.duration <- function(x)
  UseMethod("as.duration")
  
as.duration.default <- function(x)
  new("Duration", x) 
  
as.duration.numeric <- function(x)
  new("Duration", x) 

as.duration.difftime <- function(x)
	new("Duration", as.numeric(x, "secs"))

#' @export 
setGeneric("as.duration") 

#' @export
setMethod("as.duration", signature(x = "Interval"), function(x){
	new("Duration", x@.Data)
})

#' @export
setMethod("as.duration", signature(x = "Duration"), function(x){
	x
})

#' @export
setMethod("as.duration", signature(x = "Period"), function(x){
	message("estimate only: convert periods to intervals for accuracy")
	new("Duration", periods_to_seconds(x))
})

#' Change an object to an interval.
#'
#' as.interval changes difftime, duration, period and numeric objects to 
#' intervals that begin at the specified date-time. Numeric objects are first 
#' coerced to time spans equal to the numeric value in seconds. 
#'
#' as.interval can be used to create accurate transformations between period 
#' objects, which measure time spans in variable length units, and difftime objects, 
#' which measure timespans as an exact number of seconds. A start date-
#' time must be supplied to make the conversion. Lubridate uses 
#' this start date to look up how many seconds each variable 
#' length unit (e.g. month, year) lasted for during the time span 
#' described. See 
#' \code{\link{as.duration}}, \code{\link{as.period}}.
#'
#' @export as.interval
#' @param x a duration (i.e. difftime), period, or numeric object that describes the length of the 
#'   interval
#' @param start a POSIXt or Date object that describes when the interval begins   
#' @return an interval object
#' @seealso \code{\link{interval}}, \code{\link{new_interval}}
#' @keywords classes manip methods chron
#' @examples
#' diff <- new_difftime(days = 31) #difftime
#' as.interval(diff, ymd("2009-01-01"))
#' # 2009-01-01 -- 2009-02-01
#' as.interval(diff, ymd("2009-02-01"))
#' # 2009-02-01 -- 2009-03-04
#' 
#' dur <- new_duration(days = 31) #duration
#' as.interval(dur, ymd("2009-01-01"))
#' # 2009-01-01 -- 2009-02-01
#' as.interval(dur, ymd("2009-02-01"))
#' # 2009-02-01 -- 2009-03-04
#'
#' per <- new_period(months = 1) #period
#' as.interval(per, ymd("2009-01-01"))
#' # 2009-01-01 -- 2009-02-01 
#' as.interval(per, ymd("2009-02-01"))
#' # 2009-02-01 -- 2009-03-01
#'
#' as.interval(3600, ymd("2009-01-01")) #numeric
#' # 2009-01-01 -- 2009-01-01 01:00:00
as.interval <- function(x, start){
	stopifnot(is.instant(start))
	if (is.instant(x))
		return(new_interval(x, start))
	else
		new_interval(start, start + x)
}


#' Change an object to a period.
#'
#' as.period changes interval, duration (i.e., difftime)  and numeric objects 
#' to period objects with the specified units.
#'
#' Users must specify which time units to measure the period in. The length of 
#' each time unit in a period depends on when it occurs. See 
#' \code{\link{Period-class}} and \code{\link{new_period}}. 
#' The choice of units is not trivial; units that are 
#' normally equal may differ in length depending on when the time period 
#' occurs. For example, when a leap second occurs one minute is longer than 60 
#' seconds.
#'
#' Because periods do not have a fixed length, they can not be accurately 
#' converted to and from duration objects. Duration objects measure time spans 
#' in exact numbers of seconds, see \code{\link{Duration-class}}. Hence, a one to one 
#' mapping does not exist between durations and periods. When used with a 
#' duration object, as.period provides an inexact estimate; the duration is 
#' broken into time units based on the most common lengths of time units, in 
#' seconds. Because the length of months are particularly variable, a period 
#' with a months unit can not be coerced from a duration object. For an exact 
#' transformation, first transform the duration to an interval with 
#' \code{\link{as.interval}}.
#'
#' @export as.period 
#' @S3method as.period default 
#' @S3method as.period difftime 
#' @param x an interval, difftime, or numeric object   
#' @return a period object
#' @seealso \code{\link{Period-class}}, \code{\link{new_period}}
#' @keywords classes manip methods chron
#' @examples
#' span <- new_interval(as.POSIXct("2009-01-01"), as.POSIXct("2010-02-02 01:01:01")) #interval
#' # [1] 2009-01-01 -- 2010-02-02 01:01:01
#' as.period(span)
#' # 1 year, 1 month, 1 day, 1 hour, 1 minute and 1 second
as.period <- function(x)
  UseMethod("as.period")
  
as.period.default <- function(x){
  x <- as.numeric(x)
  unit <- standardise_date_names(units[1])
  f <- match.fun(paste(unit, "s", sep = ""))
  f(x)
}

as.period.difftime <- function(x){
  message("estimate only: convert difftimes to intervals for accuracy")
  span <- as.double(x, "secs")
  remainder <- abs(span)
  newper <- new_period(second = rep(0, length(x)))
  
  slot(newper, "year") <- remainder %/% (3600 * 24 * 365.25)
  remainder <- remainder %% (3600 * 24 * 365.25)
  
  slot(newper,"day") <- remainder %/% (3600 * 24)
  remainder <- remainder %% (3600 * 24)
  
  slot(newper, "hour") <- remainder %/% (3600)
  remainder <- remainder %% (3600)
  
  slot(newper, "minute") <- remainder %/% (60)
  
  slot(newper, ".Data") <- remainder %% (60)
  
  newper * sign(span)
}

#' @export
setGeneric("as.period")

#' @export
setMethod("as.period", signature(x = "Interval"), function(x) {
  start <- as.POSIXlt(x@start)
  end <- as.POSIXlt(start + x@.Data)

  to.per <- as.data.frame(unclass(end)) - 
    as.data.frame(unclass(start))
    
  names(to.per)[1:6] <- c("second", "minute", "hour", "day", "month", "year")
  to.per <- to.per[1:6]
  
  # remove negative periods
  nsecs <- to.per$second < 0
  to.per$second[nsecs] <- 60 + to.per$second[nsecs]
  to.per$minute[nsecs] <- to.per$minute[nsecs] - 1
  
  nmins <- to.per$minute < 0
  to.per$minute[nmins] <- 60 + to.per$minute[nmins]
  to.per$hour[nmins] <- to.per$hour[nmins] - 1
  
  nhous <- to.per$hour < 0
  to.per$hour[nhous] <- 24 + to.per$hour[nhous]
  to.per$day[nhous] <- to.per$day[nhous] - 1
  
  ndays <- to.per$day < 0
  if (any(ndays)) {
	  day.no <- floor_date(end, "month") - days(1)
	  day.no <- day.no$mday
	  to.per$day[ndays] <- day.no[ndays] + to.per$day[ndays]
	  to.per$month[ndays] <- to.per$month[ndays] - 1
  }
  
  nmons <- to.per$month < 0
  to.per$month[nmons] <- 12 + to.per$month[nmons]
  to.per$year[nmons] <- to.per$year[nmons] - 1
  
  new("Period", to.per$second, year = to.per$year, month = to.per$month, day = to.per$day, hour = to.per$hour, minute = to.per$minute)
})

#' @export
setMethod("as.period", signature(x = "Duration"), function(x) {
  message("estimate only: convert durations to intervals for accuracy")
  span <- x@.Data
  remainder <- abs(span)
  newper <- new_period(second = rep(0, length(x)))
  
  slot(newper, "year") <- remainder %/% (3600 * 24 * 365.25)
  remainder <- remainder %% (3600 * 24 * 365.25)
  
  slot(newper, "day") <- remainder %/% (3600 * 24)
  remainder <- remainder %% (3600 * 24)
  
  slot(newper, "hour") <- remainder %/% (3600)
  remainder <- remainder %% (3600)
  
  slot(newper, "minute") <- remainder %/% (60)
  newper$second <- remainder %% (60)
  
  newper * sign(span)
})

#' @export
setMethod("as.period", signature("Period"), function(x) x)

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