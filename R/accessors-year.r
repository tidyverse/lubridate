#' @include periods.r
NULL

#' Get/set years component of a date-time.
#'
#' Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, 
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects. 
#'
#' year does not yet support years before 0 C.E.
#'
#' @export year "year<-"
#' @aliases year year<-
#' @S3method year default
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

"year<-" <- function(x, value)
  x <- x + years(value - year(x))