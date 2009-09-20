#' Get/set months component of a date-time.
#'
#' Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, 
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects. 
#'
#' @aliases month.default month.zoo month.its month.ti month.timeseries month.fts month.irts month 
#'   month<- month<-.default month<-.Date month<-.chron month<-.zoo month<-.its month<-.ti 
#'   month<-.timeDate month<-.jul month<-.timeSeries month<-.fts month<-.irts month<-.yearmon
#' @param x a date-time object  
#' @param label logical. TRUE will display the month as a character string such as "January." FALSE 
#'   will display the month as a number.
#' @param abbr logical. FALSE will display the month as a character string label, such as 
#'   "January". TRUE will display an abbreviated version of the label, such as "Jan". abbr is 
#'   disregarded if label = FALSE. 
#' @return the months element of x as a number (1-12) or character string. 1 = January.
#' @keywords utilities manip chron methods
#' @examples
#' x <- now()
#' month(x) 
#' month(x) <- 1  
#' month(x) <- 13
#' month(x) > 3
#'
#' month(ymd(080101))
#' # 1
#' month(ymd(080101), label = TRUE)
#' # "January"
#' month(ymd(080101), label = TRUE, abbr = TRUE)
#' # "Jan"
#' month(ymd(080101) + months(0:11), label = TRUE, abbr = TRUE)
#' # "Jan" "Feb" "Mar" "Apr" "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov" "Dec"
month <- function(x, label = FALSE, abbr = FALSE) 
  UseMethod("month")
  
month.default <- function(x, label = FALSE, abbr = FALSE)
  month(as.POSIXlt(x, tz = "GMT")$mon + 1, label, abbr)
  
month.numeric <- function(x, label = FALSE, abbr = FALSE) {
  if (!label) return(x)
  
  if (abbr) {
    labels <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep",
                "Oct", "Nov", "Dec")
  } else {
    labels <- c("January", "February", "March", "April", "May", "June",
                "July", "August", "September", "October", "November",
                "December")
  }
  
  ordered(x, labels = labels)
}
    
month.zoo <- function(x, label = FALSE, abbr = FALSE)
  month.default(index(x), label, abbr)

month.its <- function(x, label = FALSE, abbr = FALSE)
  month.default(attr(x, "dates"), label, abbr)  

month.ti <- month.jul <- function(x, label = FALSE, abbr = FALSE)
  month.default(as.Date(x), label, abbr)
  
month.timeSeries <- function(x, label = FALSE, abbr = FALSE)
  month.default(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter), label, abbr)
  
month.fts <- function(x, label = FALSE, abbr = FALSE)
  month.default(dates(x), label, abbr)
  
month.irts <- function(x, label = FALSE, abbr = FALSE)
  month(x$time)

"month<-" <- function(x, value) {
  if (all(value == month(x)))
    return(x)
  UseMethod("month<-")
}

"month<-.default" <- function(x, value){
  new <- ISOdatetime(
    year(x) + (value - 1) %/% 12,  
    (value - 1) %% 12 + 1, 
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
        year(x) + (value - 1) %/% 12,  
        (value - 1) %% 12 + 1, 
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


"month<-.Date" <- "month<-.chron" <- "month<-.yearmon" <- "month<-.timeDate" <- function(x, value){
  date <- "month<-.default"(x,value)
  f <- match.fun(paste("as", class(x)[1], sep = "."))
  f(date)
}

"month<-.zoo" <- function(x, value){
  compatible <- recognize(index(x))
  if(!compatible)
    stop("series uses unrecognized date format")
     
  new <- "month<-"(index(x), value)
  'index<-'(x, new)
}

"month<-.its" <- function(x, value){
  dates <- "month<-.default"(attr(x,"dates"), value)
  attr(x, "dates") <- dates
  its(x, dates, format = "%Y-%m-%d %X")
}

"month<-.ti" <- function(x, value){
  date <- "month<-.default"(as.Date(x),value)
  as.ti(date, tifName(x))
}


"month<-.jul" <- function(x, value){
  date <- "month<-.default"(x,value)
  as.jul(date)
}

"month<-.timeSeries" <- function(x, value){
  positions <- "month<-.default"(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter), value)
  timeSeries(series(x), positions)
}

"month<-.fts" <- function(x, value){
  date <- "month<-.default"(dates(x), value)
  fts(x, date)
}

"month<-.irts" <- function(x, value){
  x$time <- "month<-.default"(x, value)
  x
}
