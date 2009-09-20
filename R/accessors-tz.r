#' Get/set time zone component of a date-time.
#'
#' Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, 
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects.
#'
#' Setting tz does not update a date-time to display the same moment as measured 
#' at a different time zone. See \code{\link{with_tz}}. Setting a new time zone 
#' creates a new date-time. The numerical value of the hours element stays the 
#' same, only the time zone attribute is replaced.  This creates a new date-time 
#' that occurs an integer value of hours before or after the original date-time.  
#'
#' If x is of a class that displays all date-times in the GMT timezone, such as 
#' chron, then R will update the number in the hours element to display the new 
#' date-time in the GMT timezone. 
#'
#' For a description of the time zone attribute, see \code{\link[base]{DateTimeClasses}}. 
#'
#' @aliases tz tz.default tz.zoo tz.its tz.ti tz.timeseries tz.fts tz.irts tz<- tz<-.default 
#'   tz<-.chron tz<-.zoo tz<-.its tz<-.ti tz<-.timeDate tz<-.jul tz<-.timeSeries tz<-.fts tz<-.irts
#' @param x a date-time object   
#' @return the first element of x's tzone attribute vector as a character string. If no tzone 
#'   attribute exists, tz returns "GMT".
#' @keywords utilities manip chron methods
#' @examples
#' x <- now()
#' tz(x) 
#' tz(x) <- "GMT"  
#' x
#' tz(x) <- ""
#' x
#' Sys.setenv(TZ = "GMT")
#' x
#' tz(x)
#' Sys.unsetenv("TZ")
tz <- function (x) 
  UseMethod("tz")

tz.default <- function(x) {
  if (is.null(attr(x,"tzone")) && !is.POSIXt(x))
    return("GMT")
  tzs <- attr(as.POSIXlt(x),"tzone")
  tzs[1]
}

tz.zoo <- function(x){
  tzs <- attr(as.POSIXlt(index(x)), "tzone")
  tzs[1]
}

tz.its <- function(x)
  tz.default(attr(x, "dates"))

tz.ti <- tz.jul <- function(x)
  tz.default(as.Date(x))
  
tz.timeSeries <- function(x)
  x@FinCenter

tz.fts <- function(x)
  tz.default(dates(x))
  
tz.irts <- function(x)
  return("GMT")

"tz<-" <- function(x, value) {
  if (all(value == tz(x)))
    return(x)
  UseMethod("tz<-")
}
  
"tz<-.default" <- function(x, value)
  ISOdatetime(year(x),  month(x), mday(x), hour(x), minute(x), second(x), value)


"tz<-.Date" <- "tz<-.timeDate" <- function(x, value){
  date <- "tz<-.default"(x,value)
  f <- match.fun(paste("as", class(x)[1], sep = "."))
  f(date)
}

"tz<-.zoo" <- function(x, value){
  compatible <- recognize(index(x))
  if(!compatible)
    stop("series uses unrecognized date format")
     
  new <- "tz<-"(index(x), value)
  'index<-'(x, new)
}

"tz<-.its" <- function(x, value){
  dates <- "second<-.default"(attr(x,"dates"), value)
  attr(x, "dates") <- dates
  its(x, dates, format = "%Y-%m-%d %X")
}

"tz<-.ti" <- function(x, value){
  date <- "tz<-.default"(as.Date(x),value)
  as.ti(date, tifName(x))
}


"tz<-.jul" <- function(x, value){
  date <- "tz<-.default"(x,value)
  as.jul(date)
}

"tz<-.timeSeries" <- function(x, value){
  positions <- "tz<-.default"(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter), value)
  timeSeries(series(x), positions)
}

"tz<-.fts" <- function(x, value){
  date <- "tz<-.default"(dates(x), value)
  fts(x, date)
}

"tz<-.irts" <- function(x, value){
  warning("irts dates will always display with GMT timezone")
  x$time <- x$time - ("tz<-.default"(x, value) - x$time)
  x
}
