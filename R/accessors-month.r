#' @include periods.r
NULL

#' Get/set months component of a date-time.
#'
#' Date-time must be a POSIXct, POSIXlt, Date, Period, chron, yearmon, yearqtr, zoo, 
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects. 
#'
#' @export month "month<-"
#' @aliases month month<-
#' @S3method month default
#' @S3method month numeric
#' @S3method month Period
#' @param x a date-time object  
#' @param label logical. TRUE will display the month as a character string
#'   such as "January." FALSE will display the month as a number.
#' @param abbr logical. FALSE will display the month as a character string #'
#'   label, such as #' "January". TRUE will display an abbreviated version of
#'   the label, such as "Jan". abbr is #' disregarded if label = FALSE.
#' @return the months element of x as a number (1-12) or character string. 1 = January.
#' @keywords utilities manip chron methods
#' @examples
#' x <- ymd("2012-03-26")
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
    
month.Period <- function(x, label = FALSE, abbr = TRUE)
  slot(x, "month")

"month<-" <- function(x, value) {
	if (!is.numeric(value)) {
			value <- pmatch(tolower(value), c("january", "february", "march", 
  		"june", "july", "august", "september", "october", "november", "december"))
  	}
  	x <- x + months(value - month(x))
 }

#' Get the number of days in the month of a date-time.
#' 
#' Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, 
#' zoo, zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects.
#'
#' @export days_in_month
#' @param x a date-time object
#' @return An integer of the number of days in the month component of the date-time object.
days_in_month <- function(x) {
  month_x <- month(x, label = TRUE)
  N_DAYS <- c(
    Jan = 31L, Feb = 28L, Mar = 31L, 
    Apr = 30L, May = 31L, Jun = 30L, 
    Jul = 31L, Aug = 31L, Sep = 30L, 
    Oct = 31L, Nov = 30L, Dec = 31L
  )
  n_days <- N_DAYS[month_x]
  n_days[month_x == "Feb" & leap_year(x)] <- 29L
  n_days
}


setGeneric("month<-")

#' @export
setMethod("month<-", signature("Period"), function(x, value){
  slot(x, "month") <- value
  x
})
