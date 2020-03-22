#' @include periods.r
NULL

#' Get/set days component of a date-time
#'
#' @details `mday()` and `yday()` return the day of the month and day of the
#'   year respectively. `day()` and `day<-()` are aliases for `mday()` and
#'   `mday<-()`.
#' @param x a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, zooreg,
#'   timeDate, xts, its, ti, jul, timeSeries, or fts object.
#' @param label logical. Only available for wday. TRUE will display the day of
#'   the week as an ordered factor of character strings, such as "Sunday." FALSE
#'   will display the day of the week as a number.
#' @param abbr logical. Only available for wday. FALSE will display the day of
#'   the week as an ordered factor of character strings, such as "Sunday." TRUE
#'   will display an abbreviated version of the label, such as "Sun". abbr is
#'   disregarded if label = FALSE.
#' @param value a numeric object
#' @param week_start day on which week starts following ISO conventions - 1
#'   means Monday, 7 means Sunday (default). When `label = TRUE`, this will be
#'   the first level of the returned factor. You can set `lubridate.week.start`
#'   option to control this parameter globally.
#' @param locale locale to use for day names. Default to current locale.
#' @return `wday()` returns the day of the week as a decimal number or an
#'   ordered factor if label is `TRUE`.
#' @keywords utilities manip chron methods
#' @examples
#' x <- as.Date("2009-09-02")
#' wday(x) #4
#'
#' wday(ymd(080101))
#' wday(ymd(080101), label = TRUE, abbr = FALSE)
#' wday(ymd(080101), label = TRUE, abbr = TRUE)
#' wday(ymd(080101) + days(-2:4), label = TRUE, abbr = TRUE)
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
wday <- function(x, label = FALSE, abbr = TRUE,
                 week_start = getOption("lubridate.week.start", 7),
                 locale = Sys.getlocale("LC_TIME"))
  UseMethod("wday")

#' @export
wday.default <- function(x, label = FALSE, abbr = TRUE,
                         week_start = getOption("lubridate.week.start", 7),
                         locale = Sys.getlocale("LC_TIME")) {
  wday(as.POSIXlt(x, tz = tz(x))$wday + 1, label, abbr, locale = locale, week_start = week_start)
}

.shift_wday_names <- function(names, week_start = 7) {
  if (week_start != 7) {
    c(names[(week_start + 1):7], names[1:week_start])
  } else {
    names
  }
}

#' @export
wday.numeric <- function(x, label = FALSE, abbr = TRUE,
                         week_start = getOption("lubridate.week.start", 7),
                         locale = Sys.getlocale("LC_TIME")) {

  start <- as.integer(week_start)

  if (start > 7 || start < 1) stop("Invalid 'week_start' argument; must be between 1 and 7")

  if (start != 7) {
    x <- 1 + (x + (6 - start)) %% 7
  }

  if (!label) {
    return(x)
  }

  names <- .get_locale_regs(locale)$wday_names
  labels <- if (abbr) names$abr else names$full
  ordered(x, levels = 1:7, labels = .shift_wday_names(labels, week_start = start))
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
  x <- as_date(x)
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
`day<-` <- function(x, value) standardGeneric("day<-")

#' @rdname day
#' @export
`mday<-` <- function(x, value) {
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
setMethod("day<-", signature("Period"), function(x, value) {
  slot(x, "day") <- value
  x
})

#' @rdname day
#' @export
"wday<-" <- function(x, week_start = getOption("lubridate.week.start", 7), value) {
  if (!is.numeric(value)) {
    ## FIXME: how to make this localized and preserve backward compatibility? Guesser?
    labels <- .shift_wday_names(c("sunday", "monday", "tuesday", "wednesday",
                                  "thursday", "friday", "saturday"),
                                week_start)
    value <- pmatch(tolower(value), labels)
  }
  x <- x + days(value - wday(x, week_start = week_start))
}

#' @rdname day
#' @export
"yday<-" <- function(x, value)
  x <- x + days(value - yday(x))
