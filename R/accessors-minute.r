#' Get/set minutes component of a date-time.
#'
#' Date-time must be a  POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, 
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects. 
#'
#' @aliases minute.default minute.zoo minute.its minute.ti minute.timeseries minute.fts minute.irts #'   minute minute<- minute<-.default  minute<-.chron minute<-.zoo minute<-.its
#'   minute<-.ti minute<-.timeDate minute<-.jul minute<-.timeSeries
#'   minute<-.fts minute<-.irts 
#' @param x a date-time object   
#' @keywords utilities manip chron methods
#' @return the minutes element of x as a decimal number
#' @examples
#' x <- now()
#' minute(x)
#' minute(x) <- 1
#' minute(x) <- 61 
#' minute(x) > 2
minute <- function(x) 
  UseMethod("minute")
  
extract_date <- function(x)  UseMethod("extract_date")
extract_date.POSIXt <- function(x) x
extract_date.zoo <- function(x) index(x)
extract_date.its <- function(x) attr(x, "dates")
extract_date.timeSeries <- function(x)  timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter)
extract_date.fts <- function(x) dates(x)
extract_date.irts <- function(x) x$time
  
minute.default <- function(x)
    as.POSIXlt(extract_date(x))$min

minute.jul <- function(x) tis::hms(x)$min
minute.ti <- minute.jul
"minute<-" <- function(x, value){
  if (all(value == minute(x)))
    return(x)
  UseMethod("minute<-")
}

"minute<-.default" <- function(x, value){
  new <- as.POSIXct(x) - (minute(x) - value) * 60
  DST(x, new)
}


"minute<-.chron" <- "minute<-.timeDate" <- function(x, value){
  date <- "minute<-.default"(x,value)
  f <- match.fun(paste("as", class(x)[1], sep = "."))
  f(date)
}

"minute<-.zoo" <- function(x, value){
  compatible <- recognize(index(x))
  if(!compatible)
    stop("series uses unrecognized date format")
     
  new <- "minute<-"(index(x), value)
  'index<-'(x, new)
}

"minute<-.its" <- function(x, value){
  dates <- "minute<-.default"(attr(x,"dates"), value)
  attr(x, "dates") <- dates
  its(x, dates, format = "%Y-%m-%d %X")
}

"minute<-.ti" <- function(x, value){
  date <- "minute<-.default"(as.Date(x),value)
  as.ti(date, tifName(x))
}

"minute<-.jul" <- function(x, value)
  x - (minute(x) - value)*60/86400

"minute<-.timeSeries" <- function(x, value){
  positions <- "minute<-.default"(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter), value)
  timeSeries(series(x), positions)
}

"minute<-.fts" <- function(x, value){
  date <- "minute<-.default"(dates(x), value)
  fts(x, date)
}

"minute<-.irts" <- function(x, value){
  x$time <- "minute<-.default"(x$time, value)
  x
}
