#' @include periods.r
NULL

#' Get/set days component of a date-time.
#'
#' @details \code{day} and \code{day<-} are aliases for \code{mday} and \code{mday<-} respectively.
#' @param x a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, zooreg, timeDate, xts, its, ti,
#'   jul, timeSeries, or fts object.
#' @param label logical. Only available for wday. TRUE will display the day of the week as an
#'   ordered factor of character strings, such as "Sunday." FALSE will display the day of the week as a number.
#' @param abbr logical. Only available for wday. FALSE will display the day of the week as an
#'   ordered factor of character strings, such as "Sunday." TRUE will display an abbreviated version of the
#'   label, such as "Sun". abbr is disregarded if label = FALSE.
#' @param value a numeric object
#' @return wday returns the day of the week as a decimal number
#'   (01-07, Sunday is 1) or an ordered factor (Sunday is first).
#' @seealso \code{\link{yday}}, \code{\link{mday}}
#' @keywords utilities manip chron methods
#' @examples
#' x <- as.Date("2009-09-02")
#' wday(x) #4
#'
#' wday(ymd(080101))
#' # 3
#' wday(ymd(080101), label = TRUE, abbr = FALSE)
#' # "Tuesday"
#' # Levels: Sunday < Monday < Tuesday < Wednesday < Thursday < Friday < Saturday
#' wday(ymd(080101), label = TRUE, abbr = TRUE)
#' # "Tues"
#' # Levels: Sunday < Monday < Tuesday < Wednesday < Thursday < Friday < Saturday
#' wday(ymd(080101) + days(-2:4), label = TRUE, abbr = TRUE)
#' # "Sun"   "Mon"   "Tues"  "Wed"   "Thurs" "Fri"   "Sat"
#' # Levels: Sunday < Monday < Tuesday < Wednesday < Thursday < Friday < Saturday
#'
#' x <- as.Date("2009-09-02")
#' yday(x) #245
#' mday(x) #2
#' yday(x) <- 1  #"2009-01-01"
#' yday(x) <- 366 #"2010-01-01"
#' mday(x) > 3
#' @export day mday
day <- function(x)
  UseMethod("mday")

#' @rdname day
#' @export
mday <- day

#' @rdname day
#' @export
wday <- function(x, label = FALSE, abbr = TRUE)
  UseMethod("wday")

#' @export
wday.default <- function(x, label = FALSE, abbr = TRUE){
  wday(as.POSIXlt(x, tz = tz(x))$wday + 1, label, abbr)
}

#' @export
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

#' @export
mday.default <- function(x)
  as.POSIXlt(x, tz = tz(x))$mday

#' @export
mday.Period <- function(x)
  slot(x, "day")

#' @rdname day
#' @export
qday <- function(x)
  UseMethod("qday")

#' @export
qday.default <- function(x) {
  as.integer(x - floor_date(x, "quarter")) + 1
}

#' @rdname day
#' @export
yday <- function(x)
  UseMethod("yday")

#' @export
yday.default <- function(x)
  as.POSIXlt(x, tz = tz(x))$yday + 1

#' @rdname day
#' @export
`day<-` <- function(x, value)  standardGeneric("day<-")

#' @rdname day
#' @export
`mday<-` <- function(x, value){
  day(x) <- value
  x
}

#' @rdname day
#' @export
`qday<-` <- function(x, value) standardGeneric("qday<-")

#' @export
setGeneric("qday<-", useAsDefault = function(x, value)
  x <- x + days(value - qday(x)))

#' @export
setGeneric("day<-", useAsDefault = function(x, value)
  x <- x + days(value - mday(x)))

#' @export
setMethod("day<-", signature("Period"), function(x, value){
  slot(x, "day") <- value
  x
})

#' @rdname day
#' @export
"wday<-" <- function(x, value){
  if (!is.numeric(value)) {
  	value <- pmatch(tolower(value), c("sunday", "monday", "tuesday",
                                      "wednesday", "thursday", "friday", "saturday"))
  }
  x <- x + days(value - wday(x))
}

#' @rdname day
#' @export
"yday<-" <- function(x, value)
  x <- x + days(value - yday(x))
