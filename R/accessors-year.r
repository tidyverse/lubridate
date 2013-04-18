#' @include periods.r
NULL

#' Get/set years component of a date-time.
#'
#' Date-time must be a POSIXct, POSIXlt, Date, Period, chron, yearmon, yearqtr, zoo, 
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects. 
#'
#' year does not yet support years before 0 C.E.
#'
#' @export year "year<-"
#' @aliases year year<-
#' @S3method year default
#' @S3method year Period
#' @param x a date-time object   
#' @return the years element of x as a decimal number
#' @keywords utilities manip chron methods
#' @examples
#' x <- ymd("2012-03-26")
#' year(x) 
#' year(x) <- 2001  
#' year(x) > 1995
year <- function(x) 
  UseMethod("year")
  
year.default <- function(x)
    as.POSIXlt(x, tz = tz(x))$year + 1900

year.Period <- function(x)
  slot(x, "year")

"year<-" <- function(x, value)
  x <- x + years(value - year(x))


setGeneric("year<-")

#' @export
setMethod("year<-", signature("Period"), function(x, value){
  slot(x, "year") <- value
  x
})
