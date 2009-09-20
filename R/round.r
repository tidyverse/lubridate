#' Round date-times down.
#'
#' floor_date takes a date-time object and rounds it down to the nearest integer 
#' value of the specified time unit. Users can specify whether to round down to 
#' the nearest second, minute, hour, day, week, month, or year.
#'
#' @param x a vector of date-time objects 
#' @param unit a character string specifying the time unit to be rounded to. Should be one of "second","minute","hour","day", "week", "month", or "year."
#' @return x with the appropriate units floored
#' @seealso \code{\link{ceiling_date}}, \code{\link{round_date}}
#' @keywords manip chron
#' @examples
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
#' floor_date(x, "year")
#' # "2009-01-01 CST"
floor_date <- function(x, unit = c("second","minute","hour","day", "week", "month", "year")) {
  unit <- match.arg(unit)
  keep <- getOption("DST")
  options(DST = "relative")
  
  new <- switch(unit,
    second = update.Date(x, second = floor(second(x))),
    minute = update.Date(x, second = 0),
    hour =   update.Date(x, minute = 0, second = 0),
    day =    update.Date(x, hour = 0, minute = 0, second = 0),
    week =   update.Date(x, wday = 1, hour = 0, minute = 0, second = 0),
    month =  update.Date(x, mday = 1, hour = 0, minute = 0, second = 0),
    year =   update.Date(x, yday = 1, hour = 0, minute = 0, second = 0)
  )
  options(DST = keep)
  new
}


#' Round date-times up.
#'
#' ceiling_date takes a date-time object and rounds it up to the nearest integer 
#' value of the specified time unit. Users can specify whether to round up to 
#' the nearest second, minute, hour, day, week, month, or year.
#'
#' @param x a vector of date-time objects 
#' @param unit a character string specifying the time unit to be rounded to. Should be one of "second","minute","hour","day", "week", "month", or "year."
#' @return x with the appropriate units rounded up
#' @seealso \code{\link{floor_date}}, \code{\link{round_date}}
#' @keywords manip chron
#' @examples
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
#' ceiling_date(x, "year")
#' # "2010-01-01 CST"
ceiling_date <- function(x, unit = c("second","minute","hour","day", "week", "month", "year")) {
  unit <- match.arg(unit) 
  
  switch(unit,
    second = second(x) <- ceiling(second(x)),
    minute = minute(x) <- minute(x) + 1,
    hour =   hour(x) <- hour(x) + 1,
    day =    yday(x) <- yday(x) + 1,
    week =   week(x) <- week(x) + 1,
    month =  month(x) <- month(x) + 1,
    year =   year(x) <- year(x) + 1
  )
  
  floor_date(x, unit)
}





#' Rounding for date-times.
#'
#' round_date takes a date-time object and rounds it to the nearest integer 
#' value of the specified time unit. Users can specify whether to round to the 
#' nearest second, minute, hour, day, week, month, or year.
#'
#' @param x a vector of date-time objects 
#' @param unit a character string specifying the time unit to be rounded to. Should be one of "second","minute","hour","day", "week", "month", or "year."
#' @return x with the appropriate units rounded
#' @seealso \code{\link{floor_date}}, \code{\link{ceiling_date}}
#' @keywords manip chron
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
#' round_date(x, "year")
#' # "2010-01-01 CST"
round_date <- function(x, unit = c("second","minute","hour","day", "week", "month", "year")) {
  unit <- match.arg(unit)
  
  below <- floor_date(x, unit)
  above <- ceiling_date(x, unit)

  smaller <- difftime(x, below, "secs") < difftime(above, x, "secs")
  structure(ifelse(smaller, below, above), class= class(x))
}

#' Internal function. Parse date time unit specification
#'
#' Parse the time unit specification used by \code{\link{cut.Date}} into 
#' something useful
#' 
#' @keywords internal
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
