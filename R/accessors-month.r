#' @include periods.r
NULL

#' Get/set months component of a date-time.
#'
#' Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, 
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects. 
#'
#' @export month "month<-"
#' @aliases month month<-
#' @S3method month default
#' @param x a date-time object  
#' @param label logical. TRUE will display the month as a character string
#'   such as "January." FALSE will display the month as a number.
#' @param abbr logical. FALSE will display the month as a character string #'
#'   label, such as #' "January". TRUE will display an abbreviated version of
#'   the label, such as "Jan". abbr is #' disregarded if label = FALSE.
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
month <- function(x, label = FALSE, abbr = TRUE) 
  UseMethod("month")
  
month.default <- function(x, label = FALSE, abbr = TRUE)
  month(as.POSIXlt(x, tz = tz(x))$mon + 1, label, abbr)
  
month.numeric <- function(x, label = FALSE, abbr = TRUE) {
  if (!label) return(x)
  
  if (abbr) {
    labels <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep",
                "Oct", "Nov", "Dec")
  } else {
    labels <- c("January", "February", "March", "April", "May", "June",
                "July", "August", "September", "October", "November",
                "December")
  }
  
  ordered(x, levels = 1:12, labels = labels)
}
    


"month<-" <- function(x, value) {
	if (!is.numeric(value)) {
			value <- pmatch(tolower(value), c("january", "february", "march", 
  		"june", "july", "august", "september", "october", "november", "december"))
  	}
  	x <- x + months(value - month(x))
 }