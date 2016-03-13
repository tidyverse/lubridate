#' @include periods.r
NULL

#' Get/set months component of a date-time.
#'
#' Date-time must be a POSIXct, POSIXlt, Date, Period, chron, yearmon, yearqtr, zoo,
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects.
#'
#' @param x a date-time object
#' @param label logical. TRUE will display the month as a character string such
#'   as "January." FALSE will display the month as a number.
#' @param abbr logical. FALSE will display the month as a character string
#'   label, such as "January". TRUE will display an abbreviated version of the
#'  label, such as "Jan". abbr is disregarded if label = FALSE.
#' @param value a numeric object
#' @return the months element of x as a number (1-12) or character string. 1 =
#'   January.
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
#' # "Jan"
#' month(ymd(080101), label = TRUE, abbr = FALSE)
#' # "January"
#' month(ymd(080101) + months(0:11), label = TRUE)
#' # "Jan" "Feb" "Mar" "Apr" "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov" "Dec"
#' @export
month <- function(x, label = FALSE, abbr = TRUE)
  UseMethod("month")

#' @export
month.default <- function(x, label = FALSE, abbr = TRUE)
  month(as.POSIXlt(x, tz = tz(x))$mon + 1, label, abbr)

#' @export
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

#' @export
month.Period <- function(x, label = FALSE, abbr = TRUE)
  slot(x, "month")

#' @rdname month
#' @export
"month<-" <- function(x, value) {
	if (!is.numeric(value)) {
			value <- pmatch(tolower(value), c("january", "february", "march",
  		"june", "july", "august", "september", "october", "november", "december"))
  	}
  	x <- x + months(value - month(x))
 }

setGeneric("month<-")

#' @export
setMethod("month<-", signature("Period"), function(x, value){
  slot(x, "month") <- value
  x
})

#' Get the number of days in the month of a date-time.
#'
#' Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr,
#' zoo, zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects.
#'
#' @export
#' @param x a date-time object
#' @return An integer of the number of days in the month component of the date-time object.
days_in_month <- function(x) {
  month_x <- month(x, label = TRUE)
  n_days <- N_DAYS_IN_MONTHS[month_x]
  n_days[month_x == "Feb" & leap_year(x)] <- 29L
  n_days
}

## fixme: integrate with above, this oen is needed internally
.days_in_month <- function(m, y){
  n_days <- N_DAYS_IN_MONTHS[m]
  n_days[m == 2L & leap_year(y)] <- 29L
  n_days
}

## tothink: export?
days_in_months_so_far <- function(month, leap){
  ## if month is negative, compute from the end of the year
  cum_days_pos <- c(0, cumsum(N_DAYS_IN_MONTHS)[-12])
  cum_days_neg <- c(0, cumsum(rev(N_DAYS_IN_MONTHS))[-12])
  negative <- month < 0
  positive <- month > 0
  sofar <- integer(length(month))
  sofar[negative] <- cum_days_neg[-month[negative]]
  sofar[positive] <- cum_days_pos[month[positive]]
  adjust <- leap & ((negative & month == -12) | (positive & month > 2))
  sofar[adjust] <- sofar[adjust] + 1L
  sofar
}
## days_in_months_so_far(c(1, 2, 3, -10, -11, -12), rep.int(T, 6))
## [1]   0  31  60 275 306 335
## days_in_months_so_far(c(1, 2, 3, -10, -11, -12), rep.int(F, 6))
## [1]   0  31  59 275 306 334
