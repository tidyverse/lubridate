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
#' @export tz "tz<-"
#' @aliases tz tz<-
#' @S3method tz default 
#' @S3method tz zoo 
#' @S3method tz timeSeries
#' @S3method tz irts 
#' @param x a date-time object   
#' @return the first element of x's tzone attribute vector as a character string. If no tzone 
#'   attribute exists, tz returns "GMT".
#' @keywords utilities manip chron methods
#' @examples
#' x <- now()
#' tz(x) 
#' tz(x) <- "GMT"  
#' x
#' tz(x) <- "America/New_York"
#' x
#' Sys.setenv(TZ = "GMT")
#' now()
#' tz(now())
#' Sys.unsetenv("TZ")
tz <- function (x) 
  UseMethod("tz")

tz.default <- function(x) {
  if (is.null(attr(x,"tzone")) && !is.POSIXt(x))
    return("UTC")
  tzs <- attr(as.POSIXlt(x),"tzone")
  tzs[1]
}

tz.zoo <- function(x){
  tzs <- attr(as.POSIXlt(index(x)), "tzone")
  tzs[1]
}

tz.timeSeries <- function(x)
  x@FinCenter

tz.irts <- function(x)
  return("GMT")

"tz<-" <- function(x, value){
  new <- force_tz(x, value)
  reclass_date(new, x)
}