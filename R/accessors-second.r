#' Get/set seconds component of a date-time.
#'
#' Date-time must be a  POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, 
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects. 
#'
#' @aliases second.default second.zoo second.its second.ti second.timeseries second.fts second.irts 
#'   second second<- second<-.default second<-.chron second<-.zoo second<-.its second<-.ti 
#'   second<-.timeDate second<-.jul second<-.timeSeries second<-.fts second<-.irts
#' @param x a date-time object   
#' @return the seconds element of x as a decimal number
#' @keywords utilities manip chron methods
#' @examples
#' x <- now()
#' second(x)
#' second(x) <- 1
#' second(x) <- 61 
#' second(x) > 2
second <- function(x) 
  UseMethod("second")
  

"second<-" <- function(x, value){
  if (all(value == second(x)))
    return(x)
  UseMethod("second<-")
}

"second<-.default" <- function(x, value){
  date <- extract_date(x)
  new <- as.POSIXct(date) - (second(date) - value)
  reclass_date(date, x)
  DST(x, new)
}

"second<-.chron" <- "second<-.timeDate" <- function(x, value){
  
  
  date <- "second<-.default"(x,value)
  f <- match.fun(paste("as", class(x)[1], sep = "."))
  f(date)
}

reclass_date <- function(new, orig) UseMethod("reclass_date", orig)
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

"second<-.zoo" <- function(x, value){
  compatible <- recognize(index(x))
  if(!compatible)
    stop("series uses unrecognized date format")
     
  new <- "second<-"(index(x), value)
  'index<-'(x, new)
}


"second<-.its" <- function(x, value){
  dates <- "second<-.default"(attr(x,"dates"), value)
  attr(x, "dates") <- dates
  its(x, dates, format = "%Y-%m-%d %X")
}

"second<-.ti" <- function(x, value){
  date <- "second<-.default"(as.Date(x),value)
  as.ti(date, tifName(x))
}

"second<-.jul" <- function(x, value)
  x - (second(x) - value)/86400


"second<-.timeSeries" <- function(x, value){
  positions <- "second<-.default"(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter), value)
  timeSeries(series(x), positions)
}

"second<-.fts" <- function(x, value){
  date <- "second<-.default"(dates(x), value)
  fts(x, date)
}

"second<-.irts" <- function(x, value){
  x$time <- "second<-.default"(x$time, value)
  x
}

