#' Get/set days component of a date-time.
#'
#' Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, 
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects. 
#'
#' @aliases yday.default yday.zoo yday.its yday.ti yday.timeseries yday.fts yday.irts wday.default 
#'   wday.zoo wday.its wday.ti wday.timeseries wday.fts wday.irts mday.default mday.zoo mday.its 
#'   mday.ti mday.timeseries mday.fts mday.irts yday mday wday day<- yday<-.default yday<-.Date 
#'   yday<-.chron yday<-.zoo yday<-.its yday<-.ti yday<-.timeDate yday<-.jul yday<-.timeSeries 
#'   yday<-.fts yday<-.irts wday<- wday<-.default wday<-.Date wday<-.chron wday<-.zoo wday<-.its 
#'   wday<-.ti wday<-.timeDate wday<-.jul wday<-.timeSeries wday<-.fts wday<-.irts mday<- 
#'   mday<-.default mday<-.Date mday<-.chron mday<-.zoo mday<-.its mday<-.ti mday<-.timeDate 
#'   mday<-.jul mday<-.timeSeries mday<-.fts mday<-.irts
#' @param x a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, zooreg, timeDate, xts, its, ti, 
#'   jul, timeSeries, or fts object. 
#' @param label logical. Only available for wday. TRUE will display the day of the week as a 
#'   character string label such as "Sunday." FALSE will display the day of the week as a number.
#' @param abbr logical. Only available for wday. FALSE will display the day of the week as a 
#'   character string label such as "Sunday." TRUE will display an abbreviated version of the 
#'   label, such as "Sun". abbr is disregarded if label = FALSE.
#' @return yday returns the day of the year as a decimal number (01-366). mday returns the day of 
#'   the month as a decimal number (01-31). wday returns the day of the week as a decimal number 
#'   (01-07, Sunday is 1).
#' @keywords utilities manip chron methods
#' @examples
#' x <- as.Date("2009-09-02")
#' yday(x) #245
#' mday(x) #2
#' wday(x) #4
#' yday(x) <- 1  #"2009-01-01"
#' yday(x) <- 366 #"2010-01-01"
#' mday(x) > 3
#'
#' wday(ymd(080101))
#' # 3
#' wday(ymd(080101), label = TRUE)
#' # "Tuesday"
#' wday(ymd(080101), label = TRUE, abbr = TRUE)
#' # "Tues"
#' wday(ymd(080101) + days(-2:4), label = TRUE, abbr = TRUE)
#' # "Sun"   "Mon"   "Tues"  "Wed"   "Thurs" "Fri"   "Sat" 
yday <- function(x) 
  UseMethod("yday")
  
yday.default <- function(x)
  as.POSIXlt(x, tz = tz(x))$yday + 1


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


"yday<-" <- function(x, value)
	x <- x + days(value - yday(x))

"wday<-" <- function(x, value)
	x <- x + days(value - wday(x))

"day<-" <- "mday<-" <- function(x, value)
	x <- x + days(value - mday(x))