#' @include accessors-month.r
NULL

#' Get the fiscal quarter of a date-time.
#'
#' Fiscal quarters are a way of dividing the year into fourths. The first quarter (Q1) 
#' comprises January, February and March; the second quarter (Q2) comprises April, May, 
#' June; the third quarter (Q3) comprises July, August, September; the fourth quarter (Q4)
#' October, November, December.
#'
#' @param x a date-time object of class POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, 
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, fts or anything else that can be converted 
#' with as.POSIXlt
#' @keywords utilities manip chron methods
#' @return numeric the fiscal quarter that the date-time occurs in
#' @examples
#' x <- ymd(c("2012-03-26", "2012-05-04", "2012-09-23", "2012-12-31"))
#' # 1 2 3 4
#' @export
quarter <- function(x) {
  m <- month(x)
  quarters <- c("1" = 1, 
                "2" = 1, 
                "3" = 1, 
                "4" = 2, 
                "5" = 2, 
                "6" = 2, 
                "7" = 3, 
                "8" = 3, 
                "9" = 3, 
                "10" = 4, 
                "11" = 4, 
                "12" = 4)
  unname(quarters[m])
}
  