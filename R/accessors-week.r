
#' Get/set weeks component of a date-time.
#'
#' Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, 
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects. Weeks is 
#' the number of complete seven day periods that have occured between the date 
#' and  January 1st, plus one. 
#'
#' @aliases week<- week<-.default week<-.Date week<-.chron week<-.zoo week<-.its week<-.ti 
#'   week<-.timeDate week<-.jul week<-.timeSeries week<-.fts week<-.irts week
#' @param x a date-time object   
#' @return the weeks element of x as an integer number
#' @keywords utilities manip chron
#' @examples
#' x <- now()
#' week(x) 
#' week(x) <- 1  
#' week(x) <- 54
#' week(x) > 3
week <- function(x)
  yday(x) %/% 7 + 1

"week<-" <- function(x, value){
  if (all(value == week(x)))
    return(x)
  UseMethod("week<-")
}

"week<-.default" <- function(x, value){
  new <- as.POSIXct(x) - (week(x) - value) * 3600 * 24 * 7
  DST(x, new)
}

"week<-.Date" <- "week<-.chron" <- "week<-.timeDate" <- function(x, value){
  date <- "week<-.default"(x,value)
  f <- match.fun(paste("as", class(x)[1], sep = "."))
  f(date)
}

"week<-.zoo" <- function(x, value){
  compatible <- recognize(index(x))
  if(!compatible)
    stop("series uses unrecognized date format")
     
  new <- "week<-"(index(x), value)
  'index<-'(x, new)
}

"week<-.its" <- function(x, value){
  dates <- "week<-.default"(attr(x,"dates"), value)
  attr(x, "dates") <- dates
  its(x, dates, format = "%Y-%m-%d %X")
}

"week<-.ti" <- function(x, value){
  date <- "week<-.default"(as.Date(x),value)
  as.ti(date, tifName(x))
}

"week<-.jul" <- function(x, value)
  x - (week(x) - value)*3600*24*7/86400

"week<-.timeSeries" <- function(x, value){
  positions <- "week<-.default"(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter), value)
  timeSeries(series(x), positions)
}

"week<-.fts" <- function(x, value){
  date <- "week<-.default"(dates(x), value)
  fts(x, date)
}

"week<-.irts" <- function(x, value){
  x$time <- as.POSIXlt(x$time, tz = "GMT") - (week(x) - value) * 3600 * 24 * 7
  x
}
