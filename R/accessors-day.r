#' Get/set days component of a date-time.
#'
#' Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, 
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects. 
#'
#' @export day yday mday wday
#' @S3method yday default
#' @S3method yday zoo
#' @S3method yday its 
#' @S3method yday ti
#' @S3method yday timeseries
#' @S3method yday fts
#' @S3method yday irts 
#' @S3method mday default
#' @S3method mday zoo
#' @S3method mday its 
#' @S3method mday ti
#' @S3method mday timeseries
#' @S3method mday fts
#' @S3method mday irts 
#' @S3method yday default
#' @S3method "yday<-" zoo
#' @S3method "yday<-" its 
#' @S3method "yday<-" ti
#' @S3method "yday<-" timeseries
#' @S3method "yday<-" fts
#' @S3method "yday<-" irts 
#' @S3method "mday<-" default
#' @S3method "mday<-" zoo
#' @S3method "mday<-" its 
#' @S3method "mday<-" ti
#' @S3method "mday<-" timeseries
#' @S3method "mday<-" fts
#' @S3method "mday<-" irts 
#' @param x a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, zooreg,
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
#' @S3method wday default
#' @S3method wday zoo
#' @S3method wday its 
#' @S3method wday ti
#' @S3method wday timeseries
#' @S3method wday fts
#' @S3method wday irts
#' @S3method "wday<-" default
#' @S3method "wday<-" zoo
#' @S3method "wday<-" its 
#' @S3method "wday<-" ti
#' @S3method "wday<-" timeseries
#' @S3method "wday<-" fts
#' @S3method "wday<-" irts
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


"yday<-" <- function(x, value)
  x <- x + days(value - yday(x))

"wday<-" <- function(x, value)
  x <- x + days(value - wday(x))

"day<-" <- "mday<-" <- function(x, value)
  x <- x + days(value - mday(x))