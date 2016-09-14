##' Parse dates according to the order in that year, month, and day elements
##' appear in the input vector.
##'
##' Transforms dates stored in character and numeric vectors to Date or POSIXct
##' objects (see \code{tz} argument). These functions recognize arbitrary
##' non-digit separators as well as no separator. As long as the order of
##' formats is correct, these functions will parse dates correctly even when the
##' input vectors contain differently formatted dates. See examples.
##'
##' If \code{truncated} parameter is non-zero \code{ymd} functions also check for
##' truncated formats. For example \code{ymd} with \code{truncated = 2} will also
##' parse incomplete dates like \code{2012-06} and \code{2012}.
##'
##' NOTE: \code{ymd} family of functions are based on `parse_date_time` and thus
##' directly drop to internal C parser for numeric months, but use R's
##' `strptime` for alphabetic months. This implies that some of the `strptime`'s
##' limitations are inherited by lubridate's parser. For example truncated
##' formats (like \%Y-\%b) will not be parsed. Numeric truncated formats (like
##' \%Y-\%m) are handled correctly by lubridate's C parser.
##'
##' As of version 1.3.0, lubridate's parse functions no longer return a
##' message that displays which format they used to parse their input. You can
##' change this by setting the \code{lubridate.verbose} option to TRUE with
##' \code{options(lubridate.verbose = TRUE)}.
##'
##' @export
##' @param ... a character or numeric vector of suspected dates
##' @param quiet logical. When TRUE function evalueates without displaying
##'   customary messages.
##' @param tz Time zone indicator. If NULL (default) a Date object is
##'   returned. Otherwise a POSIXct with time zone attribute set to \code{tz}.
##' @param locale locale to be used, see \link{locales}. On linux systems you
##'   can use \code{system("locale -a")} to list all the installed locales.
##' @param truncated integer. Number of formats that can be truncated.
##' @return a vector of class POSIXct if tz argument is non-NULL or Date if tz
##'   is NULL (default)
##' @seealso \code{\link{parse_date_time}} for an even more flexible low level
##'   mechanism.
##' @keywords chron
##' @examples
##' x <- c("09-01-01", "09-01-02", "09-01-03")
##' ymd(x)
##' x <- c("2009-01-01", "2009-01-02", "2009-01-03")
##' ymd(x)
##' ymd(090101, 90102)
##' now() > ymd(20090101)
##' ## TRUE
##' dmy(010210)
##' mdy(010210)
##'
##' ## heterogenuous formats in a single vector:
##' x <- c(20090101, "2009-01-02", "2009 01 03", "2009-1-4",
##'        "2009-1, 5", "Created on 2009 1 6", "200901 !!! 07")
##' ymd(x)
##'
##' ## What lubridate might not handle:
##'
##' ## Extremely weird cases when one of the separators is "" and some of the
##' ## formats are not in double digits might not be parsed correctly:
##' \dontrun{ymd("201002-01", "201002-1", "20102-1")
##' dmy("0312-2010", "312-2010")}
ymd <- function(..., quiet = FALSE, tz = NULL, locale = Sys.getlocale("LC_TIME"),  truncated = 0)
  .parse_xxx(..., orders = "ymd", quiet = quiet, tz = tz, locale = locale,  truncated = truncated)

#' @export
#' @rdname ymd
ydm <- function(..., quiet = FALSE, tz = NULL, locale = Sys.getlocale("LC_TIME"),  truncated = 0)
  .parse_xxx(..., orders = "ydm", quiet = quiet, tz = tz, locale = locale,  truncated = truncated)

#' @export
#' @rdname ymd
mdy <- function(..., quiet = FALSE, tz = NULL, locale = Sys.getlocale("LC_TIME"),  truncated = 0)
  .parse_xxx(..., orders = "mdy", quiet = quiet, tz = tz, locale = locale,  truncated = truncated)

#' @export
#' @rdname ymd
myd <- function(..., quiet = FALSE, tz = NULL, locale = Sys.getlocale("LC_TIME"),  truncated = 0)
  .parse_xxx(..., orders = "myd", quiet = quiet, tz = tz, locale = locale,  truncated = truncated)

#' @export
#' @rdname ymd
dmy <- function(..., quiet = FALSE, tz = NULL, locale = Sys.getlocale("LC_TIME"),  truncated = 0)
  .parse_xxx(..., orders = "dmy", quiet = quiet, tz = tz, locale = locale,  truncated = truncated)

#' @export
#' @rdname ymd
dym <- function(..., quiet = FALSE, tz = NULL, locale = Sys.getlocale("LC_TIME"),  truncated = 0)
  .parse_xxx(..., orders = "dym", quiet = quiet, tz = tz, locale = locale,  truncated = truncated)

#' @export
#' @rdname ymd
yq <- function(..., quiet = FALSE, tz = NULL, locale = Sys.getlocale("LC_TIME"))
  .parse_xxx(..., orders = "yq", quiet = quiet, tz = tz, locale = locale, truncated = 0)

##' Parse dates that have hours, minutes, or seconds elements.
##'
##' Transform dates stored as character or numeric vectors to POSIXct
##' objects. ymd_hms family of functions recognize all non-alphanumeric
##' separators (with the exception of "." if \code{frac = TRUE}) and correctly
##' handle heterogeneous date-time representations. For more flexibility in
##' treatment of heterogeneous formats, see low level parser
##' \code{\link{parse_date_time}}.
##'
##' ymd_hms() functions automatically assigns the Universal Coordinated Time
##' Zone (UTC) to the parsed date. This time zone can be changed with
##' \code{\link{force_tz}}.
##'
##' The most common type of irregularity in date-time data is the truncation
##' due to rounding or unavailability of the time stamp. If \code{truncated}
##' parameter is non-zero \code{ymd_hms} functions also check for truncated
##' formats. For example \code{ymd_hms} with \code{truncated = 3} will also parse
##' incomplete dates like \code{2012-06-01 12:23}, \code{2012-06-01 12} and
##' \code{2012-06-01}. NOTE: \code{ymd} family of functions are based on
##' \code{strptime} which currently fails to parse \code{\%y-\%m} formats.
##'
##' As of version 1.3.0, lubridate's parse functions no longer return a
##' message that displays which format they used to parse their input. You can
##' change this by setting the \code{lubridate.verbose} option to true with
##' \code{options(lubridate.verbose = TRUE)}.
##'
##' @export
##' @param ... a character vector of dates in year, month, day, hour, minute,
##'   second format
##' @param quiet logical. When TRUE function evalueates without displaying customary messages.
##' @param tz a character string that specifies which time zone to parse the date with. The string
##' must be a time zone that is recognized by the user's OS.
##' @param locale locale to be used, see \link{locales}. On linux systems you
##' can use \code{system("locale -a")} to list all the installed locales.
##' @param truncated integer, indicating how many formats can be missing. See details.
##' @return a vector of POSIXct date-time objects
##' @seealso \code{\link{ymd}}, \code{\link{hms}}. \code{\link{parse_date_time}}
##' for underlying mechanism.
##' @keywords POSIXt parse
##' @examples
##'
##' x <- c("2010-04-14-04-35-59", "2010-04-01-12-00-00")
##' ymd_hms(x)
##' x <- c("2011-12-31 12:59:59", "2010-01-01 12:00:00")
##' ymd_hms(x)
##'
##'
##' ## ** heterogenuous formats **
##' x <- c(20100101120101, "2009-01-02 12-01-02", "2009.01.03 12:01:03",
##'        "2009-1-4 12-1-4",
##'        "2009-1, 5 12:1, 5",
##'        "200901-08 1201-08",
##'        "2009 arbitrary 1 non-decimal 6 chars 12 in between 1 !!! 6",
##'        "OR collapsed formats: 20090107 120107 (as long as prefixed with zeros)",
##'        "Automatic wday, Thu, detection, 10-01-10 10:01:10 and p format: AM",
##'        "Created on 10-01-11 at 10:01:11 PM")
##' ymd_hms(x)
##'
##' ## ** fractional seconds **
##' op <- options(digits.secs=3)
##' dmy_hms("20/2/06 11:16:16.683")
##' options(op)
##'
##' ## ** different formats for ISO8601 timezone offset **
##' ymd_hms(c("2013-01-24 19:39:07.880-0600",
##' "2013-01-24 19:39:07.880", "2013-01-24 19:39:07.880-06:00",
##' "2013-01-24 19:39:07.880-06", "2013-01-24 19:39:07.880Z"))
##'
##' ## ** internationalization **
##' \dontrun{
##' x_RO <- "Ma 2012 august 14 11:28:30 "
##' ymd_hms(x_RO, locale = "ro_RO.utf8")
##' }
##'
##' ## ** truncated time-dates **
##' x <- c("2011-12-31 12:59:59", "2010-01-01 12:11", "2010-01-01 12", "2010-01-01")
##' ymd_hms(x, truncated = 3)
##' x <- c("2011-12-31 12:59", "2010-01-01 12", "2010-01-01")
##' ymd_hm(x, truncated = 2)
##' ## ** What lubridate might not handle **
##' ## Extremely weird cases when one of the separators is "" and some of the
##' ## formats are not in double digits might not be parsed correctly:
##' \dontrun{
##' ymd_hm("20100201 07-01", "20100201 07-1", "20100201 7-01")}
##'
ymd_hms <- function(..., quiet = FALSE, tz = "UTC", locale = Sys.getlocale("LC_TIME"),  truncated = 0){
  .parse_xxx_hms(..., orders = c("ymdTz", "ymdT"), quiet = quiet, tz = tz, locale = locale,  truncated = truncated)
}

#' @export
#' @rdname ymd_hms
ymd_hm <- function(..., quiet = FALSE, tz = "UTC", locale = Sys.getlocale("LC_TIME"),  truncated = 0)
  .parse_xxx_hms(..., orders =  "ymdR", quiet = quiet, tz = tz, locale = locale,  truncated = truncated)

#' @export
#' @rdname ymd_hms
ymd_h <- function(..., quiet = FALSE, tz = "UTC", locale = Sys.getlocale("LC_TIME"),  truncated = 0)
  .parse_xxx_hms(..., orders = "ymdr", quiet = quiet, tz = tz, locale = locale,  truncated = truncated)

#' @export
#' @rdname ymd_hms
dmy_hms <- function(..., quiet = FALSE, tz = "UTC", locale = Sys.getlocale("LC_TIME"),  truncated = 0)
  .parse_xxx_hms(..., orders = c("dmyTz", "dmyT"), quiet = quiet, tz = tz, locale = locale,  truncated = truncated)

#' @export
#' @rdname ymd_hms
dmy_hm <- function(..., quiet = FALSE, tz = "UTC", locale = Sys.getlocale("LC_TIME"),  truncated = 0)
  .parse_xxx_hms(..., orders = "dmyR", quiet = quiet, tz = tz, locale = locale,  truncated = truncated)

#' @export
#' @rdname ymd_hms
dmy_h <- function(..., quiet = FALSE, tz = "UTC", locale = Sys.getlocale("LC_TIME"),  truncated = 0)
  .parse_xxx_hms(..., orders = "dmyr", quiet = quiet, tz = tz, locale = locale,  truncated = truncated)

#' @export
#' @rdname ymd_hms
mdy_hms <- function(..., quiet = FALSE, tz = "UTC", locale = Sys.getlocale("LC_TIME"),  truncated = 0)
  .parse_xxx_hms(..., orders = c("mdyTz", "mdyT"), quiet = quiet, tz = tz, locale = locale,  truncated = truncated)

#' @export
#' @rdname ymd_hms
mdy_hm <- function(..., quiet = FALSE, tz = "UTC", locale = Sys.getlocale("LC_TIME"),  truncated = 0)
  .parse_xxx_hms(..., orders = "mdyR", quiet = quiet, tz = tz, locale = locale,  truncated = truncated)

#' @export
#' @rdname ymd_hms
mdy_h <- function(..., quiet = FALSE, tz = "UTC", locale = Sys.getlocale("LC_TIME"),  truncated = 0)
  .parse_xxx_hms(..., orders = "mdyr", quiet = quiet, tz = tz, locale = locale,  truncated = truncated)

#' @export
#' @rdname ymd_hms
ydm_hms <- function(..., quiet = FALSE, tz = "UTC", locale = Sys.getlocale("LC_TIME"),  truncated = 0)
  .parse_xxx_hms(..., orders = c("ydmTz", "ydmT"), quiet = quiet, tz = tz, locale = locale,  truncated = truncated)

#' @export
#' @rdname ymd_hms
ydm_hm <- function(..., quiet = FALSE, tz = "UTC", locale = Sys.getlocale("LC_TIME"),  truncated = 0)
  .parse_xxx_hms(..., orders = "ydmR", quiet = quiet, tz = tz, locale = locale,  truncated = truncated)

#' @export
#' @rdname ymd_hms
ydm_h <- function(..., quiet = FALSE, tz = "UTC", locale = Sys.getlocale("LC_TIME"),  truncated = 0)
  .parse_xxx_hms(..., orders = "ydmr", quiet = quiet, tz = tz, locale = locale,  truncated = truncated)


##' @rdname hms
##' @examples
##' ms(c("09:10", "09:02", "1:10"))
##' ms("7 6")
##' ms("6,5")
##' @export
ms <- function(..., quiet = FALSE, roll = FALSE) {
  out <- .parse_hms(..., order = "MS", quiet = quiet)
  if(roll){
    hms <- .roll_hms(min = out["M", ], sec = out["S", ])
    period(hour = hms$hour, minute = hms$min, second = hms$sec)
  } else {
    period(minute = out["M", ], second = out["S", ])
  }
}

##' @rdname hms
##' @examples
##' hm(c("09:10", "09:02", "1:10"))
##' hm("7 6")
##' hm("6,5")
##' @export
hm <- function(..., quiet = FALSE, roll = FALSE) {
  out <- .parse_hms(..., order = "HM", quiet = quiet)
  if(roll){
    hms <- .roll_hms(hour = out["H", ], min = out["M", ])
    period(hour = hms$hour, minute = hms$min, second = hms$sec)
  } else {
    period(hour = out["H", ], minute = out["M", ])
  }
}

##' Create a period with the specified hours, minutes, and seconds
##'
##' Transforms a character or numeric vector into a period object with the
##' specified number of hours, minutes, and seconds. hms() recognizes all
##' non-numeric characters except '-' as separators ('-' is used for negative
##' durations).  After hours, minutes and seconds have been parsed, the
##' remaining input is ingored.
##'
##' @param ... a character vector of hour minute second triples
##' @param quiet logical. When TRUE function evalueates without displaying
##'   customary messages.
##' @param roll logica. When TRUE smaller units are rolled over to higher units
##'   if they exceed the conventional limit. For example \code{hms("01:59:120",
##'   roll=TRUE)} produces period "2H 1M 0S".
##' @return a vector of period objects
##' @seealso \code{\link{hm}, \link{ms}}
##' @keywords period
##' @useDynLib lubridate parse_hms
##' @examples
##'
##' x <- c("09:10:01", "09:10:02", "09:10:03")
##' hms(x)
##'
##' hms("7 6 5", "3:23:::2", "2 : 23 : 33", "Finished in 9 hours, 20 min and 4 seconds")
##' @export
hms <- function(..., quiet = FALSE, roll = FALSE) {
  out <- .parse_hms(..., order = "HMS", quiet = quiet)
  if(roll){
    hms <- .roll_hms(out["H", ], out["M", ], out["S", ])
    period(hour = hms$hour, minute = hms$min, second = hms$sec)
  } else {
    period(hour = out["H", ], minute = out["M", ], second = out["S", ])
  }
}

.roll_hms <- function(hour = 0, min = 0, sec = 0){
  min <- min + sec %/% 60
  sec <- sec %% 60
  hour <- hour + min %/% 60
  min <- min %% 60
  list(hour = hour, min = min, sec = sec)
}

.parse_hms <- function(..., order, quiet = FALSE){
  ## wraper for C level parse_hms
  hms <- unlist(lapply(list(...), .num_to_date), use.names= FALSE)
  out <- matrix(.Call("parse_hms", hms, order),
                nrow = 3L, dimnames = list(c("H", "M", "S"), NULL))
  if(!quiet && all(is.na(out[substr(order, ln <- nchar(order), ln), ])))
    warning("Some strings failed to parse")
  out
}

##' Parse character and numeric date-time vectors with user friendly order
##' formats.
##'
##' \code{parse_date_time} parses an input vector into POSIXct date-time
##' object. It differs from \code{\link[base]{strptime}} in two respects. First,
##' it allows specification of the order in which the formats occur without the
##' need to include separators and "\%" prefix. Such a formating argument is
##' refered to as "order". Second, it allows the user to specify several
##' format-orders to handle heterogeneous date-time character
##' representations. \cr \code{parse_date_time2} is a fast C parser of numeric
##' orders. \cr \code{fast_strptime} is a fast C parser of numeric formats only
##' that accepts explicit format arguments, just as
##' \code{\link[base]{strptime}}.
##'
##' When several format-orders are specified \code{parse_date_time} sorts the
##' supplied format-orders based on a training set and then applies them
##' recursively on the input vector.
##'
##' \code{parse_date_time}, and all derived functions, such as \code{ymd_hms},
##' \code{ymd} etc, will drop into \code{fast_strptime} instead of
##' \code{strptime} whenever the guessed from the input data formats are all
##' numeric.
##'
##' The list below contains formats recognized by lubridate. For numeric formats
##' leading 0s are optional. As compared to base \code{strptime}, some of the
##' formats are new or have been extended for efficiency reasons. These formats
##' are marked with "*". Fast parsers, \code{parse_date_time2} and
##' \code{fast_strptime}, accept only formats marked with "!".
##'
##'
##' \describe{ \item{\code{a}}{Abbreviated weekday name in the current
##' locale. (Also matches full name)}
##'
##' \item{\code{A}}{Full weekday name in the current locale.  (Also matches
##' abbreviated name).
##'
##' You need not specify \code{a} and \code{A} formats explicitly. Wday is
##' automatically handled if \code{preproc_wday = TRUE}}
##'
##' \item{\code{b}!}{Abbreviated month name in the current locale (also matches
##' full name). C parser understands English months only.}
##'
##' \item{\code{B}!}{Same as b.}
##'
##' \item{\code{d}!}{Day of the month as decimal number (01--31 or 0--31)}
##'
##' \item{\code{H}!}{Hours as decimal number (00--24 or 0--24).}
##'
##' \item{\code{I}!}{Hours as decimal number (01--12 or 1--12).}
##'
##' \item{\code{j}}{Day of year as decimal number (001--366 or 1--366).}
##'
##' \item{\code{q}!*}{Quarter (1-4). The quarter month is added to parsed month
##' if \code{m} format is present.}
##'
##' \item{\code{m}!*}{Month as decimal number (01--12 or 1--12). For
##'                   \code{parse_date_time}. As lubridate extension, also
##'                   matches abbreviated and full months names as \code{b} and
##'                   \code{B} formats. C parser understands only English month
##'                   names.}
##'
##' \item{\code{M}!}{Minute as decimal number (00--59 or 0--59).}
##'
##' \item{\code{p}!}{AM/PM indicator in the locale. Normally used in conjunction
##'                   with \code{I} and \bold{not} with \code{H}.  But lubridate
##'                   C parser accepts H format as long as hour is not greater
##'                   than 12. C parser understands only English locale AM/PM
##'                   indicator.}
##'
##' \item{\code{S}!}{Second as decimal number (00--61 or 0--61), allowing for up
##' to two leap-seconds (but POSIX-compliant implementations will ignore leap
##' seconds).}
##'
##' \item{\code{OS}}{Fractional second.}
##'
##' \item{\code{U}}{Week of the year as decimal number (00--53 or 0-53) using
##' Sunday as the first day 1 of the week (and typically with the first Sunday
##' of the year as day 1 of week 1).  The US convention.}
##'
##' \item{\code{w}}{Weekday as decimal number (0--6, Sunday is 0).}
##'
##' \item{\code{W}}{Week of the year as decimal number (00--53 or 0-53) using
##' Monday as the first day of week (and typically with the first Monday of the
##' year as day 1 of week 1).  The UK convention.}
##'
##' \item{\code{y}!*}{Year without century (00--99 or 0--99).  In
##' \code{parse_date_time} also matches year with century (Y format).}
##'
##' \item{\code{Y}!}{Year with century.}
##'
##' \item{\code{z}!*}{ISO8601 signed offset in hours and minutes from UTC. For
##' example \code{-0800}, \code{-08:00} or \code{-08}, all represent 8 hours
##' behind UTC. This format also matches the Z (Zulu) UTC indicator. Because
##' strptime doesn't fully support ISO8601 this format is implemented as an
##' union of 4 orders: Ou (Z), Oz (-0800), OO (-08:00) and Oo (-08). You can use
##' these four orders as any other but it is rarely
##' necessary. \code{parse_date_time2} and \code{fast_strptime} support all of
##' the timezone formats.}
##'
##' \item{\code{Om}!*}{Matches numeric month and English alphabetic months
##'                    (Both, long and abbreviated forms).}
##'
##' \item{\code{Op}!*}{Matches AM/PM English indicator.}
##'
##' \item{\code{r}*}{Matches \code{Ip} and \code{H} orders.}
##' \item{\code{R}*}{Matches \code{HM} and\code{IMp} orders.}
##' \item{\code{T}*}{Matches \code{IMSp}, \code{HMS}, and \code{HMOS} orders.}
##' }
##'
##'
##' @export
##' @param x a character or numeric vector of dates
##' @param orders a character vector of date-time formats. Each order string is
##'   series of formatting characters as listed \code{\link[base]{strptime}} but
##'   might not include the "\%" prefix, for example "ymd" will match all the
##'   possible dates in year, month, day order.  Formatting orders might include
##'   arbitrary separators. These are discarded.  See details for implemented
##'   formats.
##' @param tz a character string that specifies the time zone with which to
##'   parse the dates
##' @param truncated integer, number of formats that can be missing. The most
##'   common type of irregularity in date-time data is the truncation due to
##'   rounding or unavailability of the time stamp. If \code{truncated}
##'   parameter is non-zero \code{parse_date_time} also checks for truncated
##'   formats. For example,  if the format order is "ymdHMS" and \code{truncated
##'   = 3}, \code{parse_date_time} will correctly parse incomplete dates like
##'   \code{2012-06-01 12:23}, \code{2012-06-01 12} and
##'   \code{2012-06-01}. \bold{NOTE:} \code{ymd} family of functions are based
##'   on \code{strptime} which currently fails to parse \code{\%y-\%m} formats.
##' @param quiet logical. When TRUE progress messages are not printed, and
##'   "no formats found" error is surpresed and the function simply returns a
##'   vector of NAs.  This mirrors the behavior of base R functions
##'   \code{strptime} and \code{as.POSIXct}. Default is FALSE.
##' @param locale locale to be used, see \link{locales}. On linux systems you
##'   can use \code{system("locale -a")} to list all the installed locales.
##' @param select_formats A function to select actual formats for parsing from a
##'   set of formats which matched a training subset of \code{x}. it receives a
##'   named integer vector and returns a character vector of selected
##'   formats. Names of the input vector are formats (not orders) that matched
##'   the training set. Numeric values are the number of dates (in the training
##'   set) that matched the corresponding format. You should use this argument
##'   if the default selection method fails to select the formats in the right
##'   order. By default the formats with most formating tockens (\%) are
##'   selected and \%Y counts as 2.5 tockens (so that it has a priority over
##'   \%y\%m). Se examples.
##' @param exact logical. If \code{TRUE}, \code{orders} parameter is interpreted
##'   as an exact \code{strptime} format and no trainign or guessing are
##'   performed.
##' @return a vector of POSIXct date-time objects
##' @seealso \code{strptime}, \code{\link{ymd}}, \code{\link{ymd_hms}}
##' @keywords chron
##' @note \code{parse_date_time} (and the derivatives \code{ymb}, \code{ymd_hms}
##'   etc) rely on a sparse guesser that takes at most 501 elements from the
##'   supplied character vector in order to identify appropriate formats from
##'   the supplied orders. If you get the error \code{All formats failed to
##'   parse} and you are confident that your vector contains valid dates, you
##'   should either set \code{exact} argument to TRUE or use functions that
##'   don't perform format guessing (\code{fast_strptime},
##'   \code{parse_date_time2} or \code{strptime} ).
##' @note For performance reasons, when timezone is not UTC,
##'   \code{parse_date_time2} and \code{fast_strptime} perform no validity
##'   checks for daylight savings time. Thus, if your input string contains an
##'   invalid date time which falls into DST gap and \code{lt=TRUE} you will get
##'   an \code{POSIXlt} object with a non-existen time. If \code{lt=FALSE} your
##'   time instant will be adjusted to a valid time by adding an hour. See
##'   examples. If you want to get NA for invalid date-times use
##'   \code{\link{fit_to_timeline}} explicitely.
##'
##' @examples
##'
##' ## ** orders are much easier to write **
##' x <- c("09-01-01", "09-01-02", "09-01-03")
##' parse_date_time(x, "ymd")
##' parse_date_time(x, "y m d")
##' parse_date_time(x, "%y%m%d")
##' #  "2009-01-01 UTC" "2009-01-02 UTC" "2009-01-03 UTC"
##'
##' ## ** heterogenuous date-times **
##' x <- c("09-01-01", "090102", "09-01 03", "09-01-03 12:02")
##' parse_date_time(x, c("ymd", "ymd HM"))
##'
##' ## ** different ymd orders **
##' x <- c("2009-01-01", "02022010", "02-02-2010")
##' parse_date_time(x, c("dmY", "ymd"))
##' ##  "2009-01-01 UTC" "2010-02-02 UTC" "2010-02-02 UTC"
##'
##' ## ** truncated time-dates **
##' x <- c("2011-12-31 12:59:59", "2010-01-01 12:11", "2010-01-01 12", "2010-01-01")
##' parse_date_time(x, "Ymd HMS", truncated = 3)
##'
##' ## ** specifying exact formats and avoiding training and guessing **
##' parse_date_time(x, c("%m-%d-%y", "%m%d%y", "%m-%d-%y %H:%M"), exact = TRUE)
##' parse_date_time(c('12/17/1996 04:00:00','4/18/1950 0130'),
##'                 c('%m/%d/%Y %I:%M:%S','%m/%d/%Y %H%M'), exact = TRUE)
##'
##' ## ** quarters and partial dates **
##' parse_date_time(c("2016.2", "2016-04"), orders = "Yq")
##' parse_date_time(c("2016", "2016-04"), orders = c("Y", "Ym"))
##'
##' ## ** fast parsing **
##' \dontrun{
##'   options(digits.secs = 3)
##'   ## random times between 1400 and 3000
##'   tt <- as.character(.POSIXct(runif(1000, -17987443200, 32503680000)))
##'   tt <- rep.int(tt, 1000)
##'
##'   system.time(out <- as.POSIXct(tt, tz = "UTC"))
##'   system.time(out1 <- ymd_hms(tt)) # constant overhead on long vectors
##'   system.time(out2 <- parse_date_time2(tt, "YmdHMOS"))
##'   system.time(out3 <- fast_strptime(tt, "%Y-%m-%d %H:%M:%OS"))
##'
##'   all.equal(out, out1)
##'   all.equal(out, out2)
##'   all.equal(out, out3)
##' }
##'
##' ## ** how to use `select_formats` argument **
##' ## By default %Y has precedence:
##' parse_date_time(c("27-09-13", "27-09-2013"), "dmy")
##'
##' ## to give priority to %y format, define your own select_format function:
##'
##' my_select <-   function(trained){
##'    n_fmts <- nchar(gsub("[^%]", "", names(trained))) + grepl("%y", names(trained))*1.5
##'    names(trained[ which.max(n_fmts) ])
##' }
##'
##' parse_date_time(c("27-09-13", "27-09-2013"), "dmy", select_formats = my_select)
##'
##' ## ** invalid times with "fast" parcing **
##' parse_date_time("2010-03-14 02:05:06",  "YmdHMS", tz = "America/New_York")
##' parse_date_time2("2010-03-14 02:05:06",  "YmdHMS", tz = "America/New_York")
##' parse_date_time2("2010-03-14 02:05:06",  "YmdHMS", tz = "America/New_York", lt = TRUE)
parse_date_time <- function(x, orders, tz = "UTC", truncated = 0, quiet = FALSE,
                            locale = Sys.getlocale("LC_TIME"), select_formats = .select_formats,
                            exact = FALSE){

  orig_locale <- Sys.getlocale("LC_TIME")
  Sys.setlocale("LC_TIME", locale)
  on.exit(Sys.setlocale("LC_TIME", orig_locale))

  x <- as.character(.num_to_date(x))
  if( truncated != 0 )
    orders <- .add_truncated(orders, truncated)

  .local_parse <- function(x, first = FALSE){
    formats <-
      if(exact){
        orders
      } else {
        train <- .get_train_set(x)
        .best_formats(train, orders, locale = locale, select_formats)
      }
    if( length(formats) > 0 ){
      out <- .parse_date_time(x, formats, tz = tz, quiet = quiet)
      new_na <- is.na(out)
      if( any(new_na) ){
        x <- x[new_na]
        if(length(x) < length(out)) # don't recur if failed for all
          out[new_na] <- .local_parse(x)
      }
      out
    }else{
      if ( first && !quiet) {
        warning("All formats failed to parse. No formats found.", call. = FALSE)
        warned <<- TRUE
      }
      failed <<- length(x)
      NA
    }
  }

  failed <- 0L
  warned <- FALSE
  to_parse <- !is.na(x) & nzchar(x) ## missing data might be ""
  ## prepare an NA vector
  out <- .POSIXct(rep.int(NA, length(x)), tz = tz)
  out[to_parse] <- .local_parse(x[to_parse], TRUE)

  if( failed > 0 && !quiet && !warned )
    warning(" ", failed, " failed to parse.", call. = FALSE)

  out
}

##' @rdname parse_date_time
##' @export
##' @param lt logical. If TRUE returned object is of class POSIXlt, and POSIXct
##'   otherwise. For compatibility with base `strptime` function default is TRUE
##'   for `fast_strptime` and FALSE for `parse_date_time2`.
parse_date_time2 <- function(x, orders, tz = "UTC", exact = FALSE, lt = FALSE){
  if(length(orders) > 1)
    warning("Multiple orders supplied. Only first order is used.")
  if(!exact)
    orders <- gsub("[^[:alpha:]]+", "", as.character(orders[[1]])) ## remove all separators
  if(lt){
    .mklt(.Call("parse_dt", x, orders, FALSE, TRUE), tz)
  } else {
    if (tz == "UTC"){
      .POSIXct(.Call("parse_dt", x, orders, FALSE, FALSE), tz = "UTC")
    } else {
      as.POSIXct(.mklt(.Call("parse_dt", x, orders, FALSE, TRUE), tz))
    }
  }
}

##' @useDynLib lubridate parse_dt
##' @rdname parse_date_time
##' @export
##' @param format a character string of formats. It should include all the
##'   separators and each format must be prefixed with %, just as in the format
##'   argument of \code{strptime}.
fast_strptime <- function(x, format, tz = "UTC", lt = TRUE){
  if(length(format) > 1)
    warning("Multiple formats supplied. Only first format is used.")
  format <- as.character(format[[1]])
  if(lt){
    .mklt(.Call("parse_dt", x, format, TRUE, TRUE), tz)
  } else{
    if(tz == "UTC"){
      .POSIXct(.Call("parse_dt", x, format, TRUE, FALSE), "UTC")
    } else {
      as.POSIXct(.mklt(.Call("parse_dt", x, format, TRUE, TRUE), tz))
    }
  }
}




### INTERNAL
.mklt <- function(dtlist, tz){
  na_fill <- rep_len(NA_integer_, length(dtlist$sec))
  dtlist[["wday"]] <- na_fill
  dtlist[["yday"]] <- na_fill
  dtlist[["isdst"]] <- -1L
  .POSIXlt(dtlist, tz = tz)
}

.parse_date_time <- function(x, formats, tz, quiet){

  ## print(formats) # for debugging

  out <- .strptime(x, formats[[1]], tz = tz, quiet = quiet)
  na <- is.na(out)
  newx <- x[na]

  verbose <- getOption("lubridate.verbose")
  if( !is.null(verbose) && verbose )
    message(" ", sum(!na) , " parsed with ", gsub("^@|@$", "", formats[[1]]))

  ## recursive parsing
  if( length(formats) > 1 && length(newx) > 0 )
    out[na] <- .parse_date_time(newx, formats[-1], tz = tz, quiet = quiet)

  ## return POSIXlt
  out
}

.strptime <- function(x, fmt, tz = "UTC", quiet = FALSE){

  ## Depending on fmt we might need to preprocess x.
  ## ISO8601 and internal parser are the only cases so far.
  ## %Ou: "2013-04-16T04:59:59Z"
  ## %Oo: "2013-04-16T04:59:59+01"
  ## %Oz: "2013-04-16T04:59:59+0100"
  ## %OO: "2013-04-16T04:59:59+01:00"

  ## is_posix <-  0 < regexpr("^[^%]*%Y[^%]+%m[^%]+%d[^%]+(%H[^%](%M[^%](%S)?)?)?[^%Z]*$", fmt)

  c_parser <- 0 < regexpr("^[^%0-9]*(%([YymdqIHMSz]|O[SzuoOpm])[^%0-9Z]*)+$", fmt)
  zpos <- regexpr("%O((?<z>z)|(?<u>u)|(?<o>o)|(?<O>O))", fmt, perl = TRUE)

  if (c_parser) {
    ## C PARSER:

    out <- fast_strptime(x, fmt, tz = "UTC", lt = FALSE)

    if ( tz != "UTC" ){
      out <-
        if( zpos > 0 ){
          if( !quiet )
            message("Date in ISO8601 format; converting timezone from UTC to \"", tz,  "\".")
          with_tz(out, tzone = tz)
        } else {
          ## force_tz is very slow
          force_tz(out, tzone = tz)
        }
    }

    out

  } else {
    ## STRPTIME PARSER:

    if( zpos > 0 ){
      ## If ISO8601 -> pre-process x and fmt
      capt <- attr(zpos, "capture.names")[attr(zpos, "capture.start") > 0][[2]] ## <- second subexp
      repl <- switch(capt,
                     z = "%z",
                     u ="Z",
                     ## substitute +aa with +aa00
                     o = { x <- sub("([+-]\\d{2}(?=\\D+)?$)", "\\100", x, perl = TRUE)
                           "%z"},
                     ## substitute +aa:bb with +aabb
                     O = { x <- sub("([+-]\\d{2}):(?=[^:]+$)", "\\1", x, perl = TRUE)
                           "%z"},
                     stop("Unrecognised capture detected; please report this bug"))

      str_sub(fmt, zpos, zpos + attr(zpos, "match.length") - 1) <- repl

      ## user has supplied tz argument -> convert to tz
      if( tz != "UTC" ){
        if( !quiet )
          message("Date in ISO8601 format; converting timezone from UTC to \"", tz,  "\".")
        return(with_tz(strptime(.enclose(x), .enclose(fmt), "UTC"), tzone = tz))
      }
    }

    strptime(.enclose(x), .enclose(fmt), tz)
  }
}


## Expand format strings to also include truncated formats
## Get locations of letters as vector
## Choose the number at the n - truncated place in the vector
## return the substring created by 1 to tat number.
.add_truncated <- function(orders, truncated){
  out <- orders

  if ( truncated > 0 ) {
    trunc_one <- function(order) {
      alphas <- gregexpr("[a-zA-Z]", order)[[1]]
      start <- max(0, length(alphas) - truncated)
      cut_points <- alphas[start:(length(alphas)-1)]

      truncs <- c()
      for (j in seq_along(cut_points))
        truncs <- c(truncs, substr(order, 1, cut_points[j]))
      truncs
    }

  } else {
    trunc_one <- function(order) {
      alphas <- gregexpr("[a-zA-Z]", order)[[1]][-1]
      end <- max(1, abs(truncated) - 1)
      cut_points <- alphas[1:end]

      truncs <- c()
      for (j in seq_along(cut_points))
        truncs <- c(truncs, substr(order, cut_points[j], nchar(order)))
      truncs
    }
  }

  for (i in seq_along(orders)) {
    out <- c(out, trunc_one(orders[i]))
  }

  out
}


.xxx_hms_truncations <- list(T = c("R", "r", ""), R = c("r", ""), r = "")

.parse_xxx_hms <- function(..., orders, truncated, quiet, tz, locale){
  ## !!! NOTE: truncated operates on first element in ORDERS !
  if( truncated > 0 ){
    ## Take first 3 formats and append formats from .xxx_hms_truncations
    ## co responding to the 4th format letter in order[[1]] -- T, R or r.
    xxx <- substr(orders[[1]], 1, 3) ##
    add <- paste(xxx, .xxx_hms_truncations[[substr(orders[[1]], 4, 4)]], sep = "")
    rest <- length(add) - truncated
    if( rest  < 0 )
      orders <- c(orders, add, .add_truncated(xxx, abs(rest)))
    else
      orders <- c(orders, add[1:truncated])
  }
  dates <- unlist(lapply(list(...), .num_to_date), use.names = FALSE)
  parse_date_time(dates, orders, tz = tz, quiet = quiet, locale = locale)
}

.parse_xxx <- function(..., orders, quiet, tz = NULL, locale = locale,  truncated){
  dates <- unlist(lapply(list(...), .num_to_date), use.names = FALSE)
  if(is.null(tz)){
    as.Date.POSIXct(parse_date_time(dates, orders, quiet = quiet, tz = "UTC",
                                    locale = locale, truncated = truncated))
  } else {
    parse_date_time(dates, orders, quiet = quiet, tz = tz,
                    locale = locale, truncated = truncated)
  }
}

.num_to_date <- function(x) {
  if (is.numeric(x)) {
    out <- rep.int(as.character(NA), length(x))
    nnas <- !is.na(x)
    x <- format(x[nnas], scientific = FALSE, trim = TRUE)
    x <- paste(ifelse(nchar(x) %% 2 == 1, "0", ""), x, sep = "")
    out[nnas] <- x
    out
  }else as.character(x)
}

## parse.r ends here
