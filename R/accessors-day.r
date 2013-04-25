#' @include periods.r
NULL

#' Get/set days component of a date-time.
#'
#' Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, 
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects. 
#'
#' @export day yday mday "day<-" "yday<-" "mday<-"
#' @aliases day yday mday day<- yday<- mday<-
#' @S3method yday default
#' @S3method mday default
#' @S3method mday Period
#' @param x a POSIXct, POSIXlt, Date, Period, chron, yearmon, yearqtr, zoo, zooreg,
#'    timeDate, xts, its, ti, jul, timeSeries, or fts object. 
#' @return yday returns the day of the year as a decimal number (01-366). mday returns the day of 
#'   the month as a decimal number (01-31). 
#' @seealso \code{\link{wday}}
#' @keywords utilities manip chron methods
#' @examples
#' x <- as.Date("2009-09-02")
#' yday(x) #245
#' mday(x) #2
#' yday(x) <- 1  #"2009-01-01"
#' yday(x) <- 366 #"2010-01-01"
#' mday(x) > 3
yday <- function(x) 
  UseMethod("yday")
  
yday.default <- function(x)
  as.POSIXlt(x, tz = tz(x))$yday + 1



#' Get/set days component of a date-time.
#'
#' Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, 
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects. 
#'
#' @export wday "wday<-"
#' @aliases wday wday<- 
#' @S3method wday default
#' @S3method wday numeric
#' @param x a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, zooreg, timeDate, xts, its, ti, 
#'   jul, timeSeries, or fts object. 
#' @param label logical. Only available for wday. TRUE will display the day of the week as a 
#'   character string label such as "Sunday." FALSE will display the day of the week as a number.
#' @param abbr logical. Only available for wday. FALSE will display the day of the week as a 
#'   character string label such as "Sunday." TRUE will display an abbreviated version of the 
#'   label, such as "Sun". abbr is disregarded if label = FALSE.
#' @return wday returns the day of the week as a decimal number 
#'   (01-07, Sunday is 1).
#' @seealso \code{\link{yday}}, \code{\link{mday}}
#' @keywords utilities manip chron methods
#' @examples
#' x <- as.Date("2009-09-02")
#' wday(x) #4
#'
#' wday(ymd(080101))
#' # 3
#' wday(ymd(080101), label = TRUE)
#' # "Tuesday"
#' wday(ymd(080101), label = TRUE, abbr = TRUE)
#' # "Tues"
#' wday(ymd(080101) + days(-2:4), label = TRUE, abbr = TRUE)
#' # "Sun"   "Mon"   "Tues"  "Wed"   "Thurs" "Fri"   "Sat" 
wday <- function(x, label = FALSE, abbr = TRUE) 
  UseMethod("wday")

wday.default <- function(x, label = FALSE, abbr = TRUE){
  wday(as.POSIXlt(x, tz = tz(x))$wday + 1, label, abbr)
}

wday.numeric <- function(x, label = FALSE, abbr = TRUE) {
  if (!label) return(x)
  
  if (abbr) {
    labels <- c("Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat")
  } else {
    labels <- c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday",
                "Friday", "Saturday")
  }
  ordered(x, levels = 1:7, labels = labels)  
}

  
mday <- day <- function(x) 
  UseMethod("mday")
  
mday.default <- function(x)
  as.POSIXlt(x, tz = tz(x))$mday

mday.Period <- function(x)
  slot(x, "day")

"yday<-" <- function(x, value)
  x <- x + days(value - yday(x))

"wday<-" <- function(x, value){
  if (!is.numeric(value)) {
  	value <- pmatch(tolower(value), c("sunday", "monday", "tuesday", 
  		"wednesday", "thursday", "friday", "saturday"))
  }
  x <- x + days(value - wday(x))
}

"day<-" <- "mday<-" <- function(x, value)
  x <- x + days(value - mday(x))

setGeneric("day<-")

#' @export
setMethod("day<-", signature("Period"), function(x, value){
  slot(x, "day") <- value
  x
})
