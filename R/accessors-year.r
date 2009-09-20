#' Get/set years component of a date-time.
#'
#' Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, 
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects. 
#'
#' year does not yet support years before 0 C.E.
#'
#' @aliases year year.default year.zoo year.its year.ti year.timeseries year.fts year.irts year<- 
#'   year<- default year<-.Date year<-.chron year<-.zoo year<-.its year<-.ti year<-.timeDate 
#'   year<-.jul year<-.timeSeries year<-.fts year<-.irts year<-.yearmon year<-.yearqtr
#' @param x a date-time object   
#' @return the years element of x as a decimal number
#' @keywords utilities manip chron methods
#' @examples
#' x <- now()
#' year(x) 
#' year(x) <- 2001  
#' year(x) > 1995
year <- function(x) 
  UseMethod("year")
  
year.default <- function(x)
    as.POSIXlt(x, tz = tz(x))$year + 1900
    
year.zoo <- function(x)
  year.default(index(x))

year.its <- function(x)
  year.default(attr(x, "dates"))
  
year.ti <- year.jul <- function(x)
  year.default(as.Date(x))

year.timeSeries <- function(x)
  year.default(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter))
  
year.fts <- function(x)
  year.default(dates(x))
  
year.irts <- function(x)
  as.POSIXlt(x$time, tz = "GMT")$year + 1900

"year<-" <- function(x, value) {
  if (all(value == year(x)))
    return(x)
  UseMethod("year<-")
}

"year<-.default" <- function(x, value){
  new <- ISOdatetime(
    value,  
    month(x), 
    mday(x), 
    hour(x), 
    minute(x), 
    second(x), 
    tz(x))
  
  warn <- FALSE
  
  for (i in 1:length(new)){
    n <- 1
    while (is.na(new[i])){
      warn <- TRUE
      new[i] <- ISOdatetime(
        value,  
        month(x), 
        mday(x) - n, 
        hour(x), 
        minute(x), 
        second(x), 
        tz(x))[i]
      n <- n + 1
    }
  }
    
  if (warn)
    message("Undefined date. Defaulting to last previous real day.")
    
  new
}



"year<-.Date" <- "year<-.chron" <- "year<-.yearmon" <- "year<-.yearqtr" <- "year<-.timeDate" <- function(x, value){
  date <- "year<-.default"(x,value)
  f <- match.fun(paste("as", class(x)[1], sep = "."))
  f(date)
}

"year<-.zoo" <- function(x, value){
  compatible <- recognize(index(x))
  if(!compatible)
    stop("series uses unrecognized date format")
     
  new <- "year<-"(index(x), value)
  'index<-'(x, new)
}

"year<-.its" <- function(x, value){
  dates <- "year<-.default"(attr(x,"dates"), value)
  attr(x, "dates") <- dates
  its(x, dates, format = "%Y-%m-%d %X")
}

"year<-.ti" <- function(x, value){
  date <- "year<-.default"(as.Date(x),value)
  as.ti(date, tifName(x))
}

"year<-.jul" <- function(x, value){
  date <- "year<-.default"(x,value)
  as.jul(date)
}

"year<-.timeSeries" <- function(x, value){
  positions <- "year<-.default"(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter), value)
  timeSeries(series(x), positions)
}

"year<-.fts" <- function(x, value){
  date <- "year<-.default"(dates(x), value)
  fts(x, date)
}

"year<-.irts" <- function(x, value){
  x$time <- "year<-.default"(x, value)
  x
}
