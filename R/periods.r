#' Create a period object.
#'
#' new_period creates a period object with the specified values. Within a 
#' period object, time units do not have a fixed length (except for seconds) 
#' until they are added to a date-time. The length of each time unit will 
#' depend on the date-time to which it is added. For example, a year that 
#' begins on 2009-01-01 will be 365 days long.  A year that begins on 
#' 2012-01-01 will be 366 days long. When math is performed with a period 
#' object, each unit is applied separately. How a period is distributed among 
#' the time units is non-trivial. For example, when leap seconds occur 1 minute 
#' is longer than 60 seconds.
#'
#' Periods track the change in the "clock time" between two date-times. They 
#' are measured in common time related units: years, months, days, hours, 
#' minutes, and seconds. Each unit except for seconds must be expressed in 
#' integer values. 
#'
#' Period objects can be easily created with the helper functions 
#' \code{\link{years}}, \code{\link{months}}, \code{\link{weeks}}, 
#' \code{\link{days}}, \code{\link{minutes}}, \code{\link{seconds}}. These objects 
#' can be added to and subtracted to date-times to create a user interface 
#' similar to object oriented programming.
#'
#' @export new_period
#' @S3method "%/%" period
#' @S3method "%%" period
#' @S3method "/" period
#' @S3method "*" period
#' @S3method "+" period
#' @S3method "-" period
#' @S3method rep period
#' @S3method print period
#' @S3method format period
#' @S3method c period
#' @param ... a list of time units to be included in the period and their amounts. Seconds, minutes, 
#'   hours, days, weeks, months, and years are supported.
#' @return a period object
#' @seealso \code{\link{period}}, \code{\link{as.period}}
#' @keywords chron classes
#' @examples
#' new_period (second = 90, minute = 5)
#' #  5 minutes and 90 seconds
#' new_period(day = -1)
#' # -1 days
#' new_period(second = 3, minute = 1, hour = 2, day = 6, week = 1)
#' # 13 days, 2 hours, 1 minute and 3 seconds
#' new_period(hour = 1, minute = -60)
#' # 1 hour and -60 minutes
#' new_period(second = 0)
#' # 0 seconds
new_period <- function(...) {
  pieces <- data.frame(...)
    
  names(pieces) <- standardise_date_names(names(pieces))
  defaults <- data.frame(
    second = 0, minute = 0, hour = 0, day = 0, week = 0, 
    month = 0, year = 0
  )
  
  pieces <- cbind(pieces, defaults[setdiff(names(defaults), names(pieces))])
  pieces <- pieces[c("year", "month", "week", "day", "hour", "minute", "second")] 
  
  pieces$day <- pieces$day + pieces$week * 7
  pieces <- pieces[,-3]
  
  if(any(trunc(pieces[,1:5]) - pieces[,1:5] != 0))
    stop("periods must have integer values", call. = FALSE)
  
  structure(pieces, class = c("period", "data.frame"))
}

#' Quickly create relative timespans.
#'
#' Quickly create period objects for easy date-time manipulation. The units of 
#' the period created depend on the name of the function called. For period 
#' objects, units do not have a fixed length until they are added to a specific 
#' date time, contrast this with \code{\link{durations}}. This makes periods 
#' useful for manipulations with clock times because units expand or contract 
#' in length to accomodate conventions such as leap years, leap seconds, and 
#' Daylight Savings Time. 
#'
#' When paired with date-times, these functions allow date-times to be 
#' manipulated in a method similar to object oriented programming. Period 
#' objects can be added to Date, POSIXt, and Interval objects.
#' 
#' y, m, w, d are predefined period objects such that y = 1 year, m = 1 month, w = 1 week, d = 1 day.
#'
#' @export seconds minutes hours days weeks years y m w d milliseconds microseconds microseconds nanoseconds picoseconds
#' @aliases seconds minutes hours days weeks years y m w d milliseconds microseconds microseconds nanoseconds picoseconds
#' @S3method months numeric
#' @S3method months integer
#' @param x numeric value of the number of units to be contained in the period. With the exception 
#'   of seconds(), x must be an integer. 
#' @return a period object
#' @seealso \code{\link{period}}, \code{\link{new_period}}, \code{\link{ddays}}
#' @keywords chron manip
#' @examples
#'
#' x <- as.POSIXct("2009-08-03") 
#' # "2009-08-03 CDT"
#' x + days(1) + hours(6) + minutes(30)
#' # "2009-08-04 06:30:00 CDT"
#' x + days(100) - hours(8) 
#' # "2009-11-10 15:00:00 CST"
#' 
#' class(as.Date("2009-08-09") + days(1)) # retains Date class
#' # "Date"
#' as.Date("2009-08-09") + hours(12) 
#' # "2009-08-09 12:00:00 UTC"
#' class(as.Date("2009-08-09") + hours(12)) 
#' # "POSIXt"  "POSIXct"
#' # converts to POSIXt class to accomodate time units
#' 
#' years(1) - months(7) 
#' # 1 year and -7 months
#' c(1:3) * hours(1) 
#' # 1 hour   2 hours   3 hours
#' hours(1:3)
#' # 1 hour   2 hours   3 hours
#'
#' #sequencing
#' y <- ymd(090101) # "2009-01-01 CST"
#' y + months(0:11)
#' # [1] "2009-01-01 CST" "2009-02-01 CST" "2009-03-01 CST" "2009-04-01 CDT"
#' # [5] "2009-05-01 CDT" "2009-06-01 CDT" "2009-07-01 CDT" "2009-08-01 CDT"
#' # [9] "2009-09-01 CDT" "2009-10-01 CDT" "2009-11-01 CDT" "2009-12-01 CST"
#' 
#' # end of month handling
#' ymd(20090131) + months(0:11)
#' # Undefined date. Defaulting to last previous real day.
#' # [1] "2009-01-31 CST" "2009-02-28 CST" "2009-03-31 CDT" "2009-04-30 CDT"
#' # [5] "2009-05-31 CDT" "2009-06-30 CDT" "2009-07-31 CDT" "2009-08-31 CDT"
#' # [9] "2009-09-30 CDT" "2009-10-31 CDT" "2009-11-30 CST" "2009-12-31 CST"
#' 
#' # compare DST handling to durations
#' boundary <- as.POSIXct("2009-03-08 01:59:59")
#' # "2009-03-08 01:59:59 CST"
#' boundary + days(1) # period
#' # "2009-03-09 01:59:59 CDT" (clock time advances by a day)
#' boundary + edays(1) # duration
#' # "2009-03-09 02:59:59 CDT" (clock time corresponding to 86400 seconds later)
seconds <- function(x = 1) new_period(second = x)
minutes <- function(x = 1) new_period(minute = x)
hours <-   function(x = 1) new_period(hour = x)
days <-    function(x = 1) new_period(day = x)  
weeks <-   function(x = 1) new_period(week = x)
months.numeric <- months.integer <- function(x, abbreviate) new_period(month = x)
years <-   function(x = 1) new_period(year = x)
y <- years(1)
m <- months(1)
d <- days(1)
w <- weeks(1)
milliseconds <- function(x = 1) seconds(x/1000)
microseconds <- function(x = 1) seconds(x/1000000)
nanoseconds <- function(x = 1) seconds(x/1e9)
picoseconds <- function(x = 1) seconds(x/1e12)


#' Is x a period object?
#'
#' @export is.period
#' @param x an R object   
#' @return TRUE if x is a period object, FALSE otherwise.
#' @seealso \code{\link{is.instant}}, \code{\link{is.timespan}}, \code{\link{is.interval}}, 
#'   \code{\link{is.duration}}, \code{\link{period}}
#' @keywords logic chron
#' @examples
#' is.period(as.Date("2009-08-03")) # FALSE
#' is.period(new_period(months= 1, days = 15)) # TRUE
is.period <- function(x) is(x,"Period")



format.period <- function(x, ...){
  show <- vector(mode = "character")
  for (i in 1:nrow(x)){
    per <- x[i,]
  
    per <- per[which(per != 0)]
    if (length(per) == 0) {
      show[i] <- "0 seconds"
    } else {
      singular <- names(per)
      plural <- paste(singular, "s", sep = "")
      IDs <- paste(per, ifelse(!is.na(per) & per == 1, singular, plural))
      if(length(IDs) == 1) {
        show[i] <- IDs
      } else {
        show[i] <- paste(paste(paste(IDs[-length(IDs)], collapse = ", "),
          IDs[length(IDs)], sep = " and "), "")  
      }
    }
  }
  show
}


print.period <- function(x, ...) {
  print(format(x), ..., quote = FALSE)
}

#' Change an object to a period.
#'
#' as.period changes interval, duration (i.e., difftime)  and numeric objects 
#' to period objects with the specified units.
#'
#' Users must specify which time units to measure the period in. The length of 
#' each time unit in a period depends on when it occurs. See 
#' \code{\link{periods}}. The choice of units is not trivial; units that are 
#' normally equal may differ in length depending on when the time period 
#' occurs. For example, when a leap second occurs one minute is longer than 60 
#' seconds.
#'
#' Because periods do not have a fixed length, they can not be accurately 
#' converted to and from duration objects. Duration objects measure time spans 
#' in exact numbers of seconds, see \code{\link{duration}}. Hence, a one to one 
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
#' @S3method as.period interval
#' @S3method as.period duration
#' @param x an interval, difftime, or numeric object   
#' @return a period object
#' @seealso \code{\link{period}}, \code{\link{new_period}}
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

as.period.interval <- function(x){
  start <- as.POSIXlt(attr(x, "start"))
  end <- start + unclass(x)

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
  
  day.no <- floor_date(end, "month") - days(1)
  day.no <- day.no$mday
  ndays <- to.per$day < 0
  to.per$day[ndays] <- day.no[ndays] + to.per$day[ndays]
  to.per$month[ndays] <- to.per$month[ndays] - 1
  
  nmons <- to.per$month < 0
  to.per$month[nmons] <- 12 + to.per$month[nmons]
  to.per$year[nmons] <- to.per$year[nmons] - 1
  
  structure(to.per[,c(6:1)], class = c("period", "data.frame"))
}

as.period.difftime <- function(x){
  message("estimate only: convert durations to intervals for accuracy")
  span <- as.double(x, "secs")
  remainder <- abs(span)
  newper <- new_period(second = rep(0, length(x)))
  
  newper$year <- remainder %/% (3600 * 24 * 365.25)
  remainder <- remainder %% (3600 * 24 * 365.25)
  
  newper$day <- remainder %/% (3600 * 24)
  remainder <- remainder %% (3600 * 24)
  
  newper$hour <- remainder %/% (3600)
  remainder <- remainder %% (3600)
  
  newper$minute <- remainder %/% (60)
  newper$second <- remainder %% (60)
  
  newper * sign(span)
}

as.period.duration <- function(x){
  message("estimate only: convert durations to intervals for accuracy")
  span <- as.numeric(x)
  remainder <- abs(span)
  newper <- new_period(second = rep(0, length(x)))
  
  newper$year <- remainder %/% (3600 * 24 * 365.25)
  remainder <- remainder %% (3600 * 24 * 365.25)
  
  newper$day <- remainder %/% (3600 * 24)
  remainder <- remainder %% (3600 * 24)
  
  newper$hour <- remainder %/% (3600)
  remainder <- remainder %% (3600)
  
  newper$minute <- remainder %/% (60)
  newper$second <- remainder %% (60)
  
  newper * sign(span)
}


rep.period <- function(x, ...){
	y <- lapply(x, rep, ...)
	attr(y, "row.names") <- c(1:length(y$year))
	attr(y, "class") <- attr(x, "class")
	y
}
	
c.period <- function(...){
	pers <- list(...)
	do.call(rbind, pers)
}
