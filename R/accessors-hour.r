#' Get/set hours component of a date-time.
#'
#' Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, 
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects. 
#'
#' @aliases hour.default hour.zoo hour.its hour.ti hour.timeseries hour.fts hour.irts hour hour<- 
#'   hour<-.default hour<-.chron hour<-.zoo hour<-.its hour<-.ti hour<-.timeDate hour<-.jul 
#'   hour<-.timeSeries hour<-.fts hour<-.irts
#' @param x a date-time object   
#' @keywords utilities manip chron methods
#' @return the hours element of x as a decimal number
#' @examples
#' x <- now()
#' hour(x)
#' hour(x) <- 1
#' hour(x) <- 61 
#' hour(x) > 2
hour <- function(x) 
  UseMethod("hour")
  
hour.default <- function(x)
    as.POSIXlt(x, tz = tz(x))$hour
    

"hour<-" <- function(x, value) {
  if (all(value == hour(x)))
    return(x)
  UseMethod("hour<-")
}

"hour<-.default" <- function(x, value){
  new <- as.POSIXct(x, tz = tz(x)) - (hour(x) - value) * 3600
  DST(x, new)
}


"hour<-.chron" <- "hour<-.timeDate" <- function(x, value){
  date <- "hour<-.default"(x,value)
  f <- match.fun(paste("as", class(x)[1], sep = "."))
  f(date)
}

"hour<-.zoo" <- function(x, value){
  compatible <- recognize(index(x))
  if(!compatible)
    stop("series uses unrecognized date format")
     
  new <- "hour<-"(index(x), value)
  'index<-'(x, new)
}

"hour<-.its" <- function(x, value){
  dates <- "hour<-.default"(attr(x,"dates"), value)
  attr(x, "dates") <- dates
  its(x, dates, format = "%Y-%m-%d %X")
}

"hour<-.ti" <- function(x, value){
  date <- "hour<-.default"(as.Date(x),value)
  as.ti(date, tifName(x))
}

"hour<-.jul" <- function(x, value)
  x - (hour(x) - value)*3600/86400

"hour<-.timeSeries" <- function(x, value){
  positions <- "hour<-.default"(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter), value)
  timeSeries(series(x), positions)
}

"hour<-.fts" <- function(x, value){
  date <- "hour<-.default"(dates(x), value)
  fts(x, date)
}

"hour<-.irts" <- function(x, value){
  x$time <- as.POSIXlt(x$time, tz = "GMT") - (hour(x) - value) * 3600
  x
}
