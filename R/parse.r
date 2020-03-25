##' Parse dates with **y**ear, **m**onth, and **d**ay components
##'
##' Transforms dates stored in character and numeric vectors to Date or POSIXct
##' objects (see `tz` argument). These functions recognize arbitrary
##' non-digit separators as well as no separator. As long as the order of
##' formats is correct, these functions will parse dates correctly even when the
##' input vectors contain differently formatted dates. See examples.
##'
##' In case of heterogeneous date formats, the `ymd()` family guesses formats based
##' on a subset of the input vector. If the input vector contains many missing
##' values or non-date strings, the subset might not contain meaningful dates
##' and the date-time format won't be guessed resulting in
##' `All formats failed to parse` error. In such cases please see
##' [parse_date_time()] for a more flexible parsing interface.
##'
##' If the `truncated` parameter is non-zero, the `ymd()` functions also check for
##' truncated formats. For example, `ymd()` with `truncated = 2` will also
##' parse incomplete dates like `2012-06` and `2012`.
##'
##' NOTE: The `ymd()` family of functions is based on `parse_date_time()` and thus
##' directly drop to the internal C parser for numeric months, but uses
##' [base::strptime()] for alphabetic months. This implies that some of [base::strptime()]'s
##' limitations are inherited by \pkg{lubridate}'s parser. For example, truncated
##' formats (like `%Y-%b`) will not be parsed. Numeric truncated formats (like
##' `%Y-%m`) are handled correctly by \pkg{lubridate}'s C parser.
##'
##' As of version 1.3.0, \pkg{lubridate}'s parse functions no longer return a
##' message that displays which format they used to parse their input. You can
##' change this by setting the `lubridate.verbose` option to `TRUE` with
##' `options(lubridate.verbose = TRUE)`.
##'
##' @export
##' @param ... a character or numeric vector of suspected dates
##' @param quiet logical. If `TRUE`, function evaluates without displaying
##'   customary messages.
##' @param tz Time zone indicator. If `NULL` (default), a Date object is
##'   returned. Otherwise a POSIXct with time zone attribute set to `tz`.
##' @param locale locale to be used, see [locales]. On Linux systems you
##'   can use `system("locale -a")` to list all the installed locales.
##' @param truncated integer. Number of formats that can be truncated.
##' @return a vector of class POSIXct if `tz` argument is non-`NULL` or Date if tz
##'   is `NULL` (default)
##' @seealso [parse_date_time()] for an even more flexible low level
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
##' yq('2014.2')
##'
##' ## heterogeneous formats in a single vector:
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

##' Parse date-times with **y**ear, **m**onth, and **d**ay, **h**our,
##' **m**inute, and **s**econd components.
##'
##' Transform dates stored as character or numeric vectors to POSIXct
##' objects. The `ymd_hms()` family of functions recognizes all non-alphanumeric
##' separators (with the exception of "." if `frac = TRUE`) and correctly
##' handles heterogeneous date-time representations. For more flexibility in
##' treatment of heterogeneous formats, see low level parser
##' [parse_date_time()].
##'
##' The `ymd_hms()` functions automatically assign the Universal Coordinated Time
##' Zone (UTC) to the parsed date. This time zone can be changed with
##' [force_tz()].
##'
##' The most common type of irregularity in date-time data is the truncation
##' due to rounding or unavailability of the time stamp. If the `truncated`
##' parameter is non-zero, the `ymd_hms()` functions also check for truncated
##' formats. For example, `ymd_hms()` with `truncated = 3` will also parse
##' incomplete dates like `2012-06-01 12:23`, `2012-06-01 12` and
##' `2012-06-01`. NOTE: The `ymd()` family of functions is based on
##' [base::strptime()] which currently fails to parse `%y-%m` formats.
##'
##' In case of heterogeneous date formats the `ymd_hms()` family guesses formats
##' based on a subset of the input vector. If the input vector contains many
##' missing values or non-date strings, the subset might not contain meaningful
##' dates and the date-time format won't be guessed resulting in
##' `All formats failed to parse` error. In such cases please see
##' [parse_date_time()] for a more flexible parsing interface.
##'
##' As of version 1.3.0, \pkg{lubridate}'s parse functions no longer return a
##' message that displays which format they used to parse their input. You can
##' change this by setting the `lubridate.verbose` option to `TRUE` with
##' `options(lubridate.verbose = TRUE)`.
##'
##' @export
##' @param ... a character vector of dates in year, month, day, hour, minute,
##'   second format
##' @param quiet logical. If `TRUE`, function evaluates without displaying customary messages.
##' @param tz a character string that specifies which time zone to parse the date with. The string
##' must be a time zone that is recognized by the user's OS.
##' @param locale locale to be used, see \link{locales}. On Linux systems you
##' can use `system("locale -a")` to list all the installed locales.
##' @param truncated integer, indicating how many formats can be missing. See details.
##' @return a vector of [POSIXct] date-time objects
##' @seealso
##' - [ymd()], [hms()]
##' - [parse_date_time()] for the underlying mechanism
##' @keywords POSIXt parse
##' @examples
##'
##' x <- c("2010-04-14-04-35-59", "2010-04-01-12-00-00")
##' ymd_hms(x)
##' x <- c("2011-12-31 12:59:59", "2010-01-01 12:00:00")
##' ymd_hms(x)
##'
##'
##' ## ** heterogeneous formats **
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
##'   ymd_hms(x_RO, locale = "ro_RO.utf8")
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
  if (roll) {
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
  if (roll) {
    hms <- .roll_hms(hour = out["H", ], min = out["M", ])
    period(hour = hms$hour, minute = hms$min, second = hms$sec)
  } else {
    period(hour = out["H", ], minute = out["M", ])
  }
}

##' Parse periods with **h**our, **m**inute, and **s**econd components
##'
##' Transforms a character or numeric vector into a period object with the
##' specified number of hours, minutes, and seconds. `hms()` recognizes all
##' non-numeric characters except '-' as separators ('-' is used for negative
##' `durations`). After hours, minutes and seconds have been parsed, the
##' remaining input is ignored.
##'
##' @param ... a character vector of hour minute second triples
##' @param quiet logical. If `TRUE`, function evaluates without displaying
##'   customary messages.
##' @param roll logical. If `TRUE`, smaller units are rolled over to higher units
##'   if they exceed the conventional limit. For example,
##'   `hms("01:59:120", roll = TRUE)` produces period "2H 1M 0S".
##' @return a vector of period objects
##' @seealso [hm()], [ms()]
##' @keywords period
##' @examples
##'
##' x <- c("09:10:01", "09:10:02", "09:10:03")
##' hms(x)
##'
##' hms("7 6 5", "3:23:::2", "2 : 23 : 33", "Finished in 9 hours, 20 min and 4 seconds")
##' @export
hms <- function(..., quiet = FALSE, roll = FALSE) {
  out <- .parse_hms(..., order = "HMS", quiet = quiet)
  if (roll) {
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

.parse_hms <- function(..., order, quiet = FALSE) {
  ## wrapper for C level parse_hms
  hms <- unlist(lapply(list(...), .num_to_date), use.names= FALSE)
  out <- matrix(.Call(C_parse_hms, hms, order),
                nrow = 3L, dimnames = list(c("H", "M", "S"), NULL))
  if (!quiet) {
    ## fixme: this warning should be dropped to C and thrown only when there are
    ## real parsing errors #530
    if (any(is.na(out[substr(order, ln <- nchar(order), ln), ])))
      warning("Some strings failed to parse, or all strings are NAs")
  }
  out
}

##' User friendly date-time parsing functions
##'
##' `parse_date_time()` parses an input vector into POSIXct date-time
##' object. It differs from [base::strptime()] in two respects. First,
##' it allows specification of the order in which the formats occur without the
##' need to include separators and the `%` prefix. Such a formatting argument is
##' referred to as "order". Second, it allows the user to specify several
##' format-orders to handle heterogeneous date-time character
##' representations.
##'
##' When several format-orders are specified, `parse_date_time()` selects
##' (guesses) format-orders based on a training subset of the input
##' strings. After guessing the formats are ordered according to the performance
##' on the training set and applied recursively on the entire input vector. You
##' can disable training with `train = FALSE`.
##'
##' `parse_date_time()`, and all derived functions, such as `ymd_hms()`,
##' `ymd()`, etc., will drop into `fast_strptime()` instead of
##' [base::strptime()] whenever the guessed from the input data formats are all
##' numeric.
##'
##' The list below contains formats recognized by \pkg{lubridate}. For numeric formats
##' leading 0s are optional. As compared to [base::strptime()], some of the
##' formats are new or have been extended for efficiency reasons. These formats
##' are marked with "(*)". The fast parsers `parse_date_time2()` and
##' `fast_strptime()` accept only formats marked with "(!)".
##'
##'
##' \describe{ \item{`a`}{Abbreviated weekday name in the current
##' locale. (Also matches full name)}
##'
##' \item{`A`}{Full weekday name in the current locale.  (Also matches
##' abbreviated name).
##'
##' You don't need to specify `a` and `A` formats explicitly. Wday is
##' automatically handled if `preproc_wday = TRUE`}
##'
##' \item{`b` (!)}{Abbreviated or full month name in the current locale. The C
##' parser currently understands only English month names.}
##'
##' \item{`B` (!)}{Same as b.}
##'
##' \item{`d` (!)}{Day of the month as decimal number (01--31 or 0--31)}
##'
##' \item{`H` (!)}{Hours as decimal number (00--24 or 0--24).}
##'
##' \item{`I` (!)}{Hours as decimal number (01--12 or 1--12).}
##'
##' \item{`j`}{Day of year as decimal number (001--366 or 1--366).}
##'
##' \item{`q` (!*)}{Quarter (1--4). The quarter month is added to the parsed month
##' if `m` format is present.}
##'
##' \item{`m` (!*)}{Month as decimal number (01--12 or 1--12). For
##'                   `parse_date_time`. As a \pkg{lubridate} extension, also
##'                   matches abbreviated and full months names as `b` and
##'                   `B` formats. C parser understands only English month
##'                   names.}
##'
##' \item{`M` (!)}{Minute as decimal number (00--59 or 0--59).}
##'
##' \item{`p` (!)}{AM/PM indicator in the locale. Normally used in conjunction
##'                   with `I` and \bold{not} with `H`.  But the \pkg{lubridate}
##'                   C parser accepts H format as long as hour is not greater
##'                   than 12. C parser understands only English locale AM/PM
##'                   indicator.}
##'
##' \item{`S` (!)}{Second as decimal number (00--61 or 0--61), allowing for up
##' to two leap-seconds (but POSIX-compliant implementations will ignore leap
##' seconds).}
##'
##' \item{`OS`}{Fractional second.}
##'
##' \item{`U`}{Week of the year as decimal number (00--53 or 0--53) using
##' Sunday as the first day 1 of the week (and typically with the first Sunday
##' of the year as day 1 of week 1).  The US convention.}
##'
##' \item{`w`}{Weekday as decimal number (0--6, Sunday is 0).}
##'
##' \item{`W`}{Week of the year as decimal number (00--53 or 0--53) using
##' Monday as the first day of week (and typically with the first Monday of the
##' year as day 1 of week 1).  The UK convention.}
##'
##' \item{`y` (!*)}{Year without century (00--99 or 0--99).  In
##' `parse_date_time()` also matches year with century (Y format).}
##'
##' \item{`Y` (!)}{Year with century.}
##'
##' \item{`z` (!*)}{ISO8601 signed offset in hours and minutes from UTC. For
##' example `-0800`, `-08:00` or `-08`, all represent 8 hours
##' behind UTC. This format also matches the Z (Zulu) UTC indicator. Because
##' [base::strptime()] doesn't fully support ISO8601 this format is implemented as an
##' union of 4 orders: Ou (Z), Oz (-0800), OO (-08:00) and Oo (-08). You can use
##' these four orders as any other but it is rarely
##' necessary. `parse_date_time2()` and `fast_strptime()` support all of
##' the timezone formats.}
##'
##' \item{`Om` (!*)}{Matches numeric month and English alphabetic months
##'                    (Both, long and abbreviated forms).}
##'
##' \item{`Op` (!*)}{Matches AM/PM English indicator.}
##'
##' \item{`r` (*)}{Matches `Ip` and `H` orders.}
##'
##' \item{`R` (*)}{Matches `HM` and`IMp` orders.}
##'
##' \item{`T` (*)}{Matches `IMSp`, `HMS`, and `HMOS` orders.}
##' }
##'
##'
##' @export
##' @param x a character or numeric vector of dates
##' @param orders a character vector of date-time formats. Each order string is a
##'   series of formatting characters as listed in [base::strptime()] but might not
##'   include the `"%"` prefix. For example, "ymd" will match all the possible
##'   dates in year, month, day order. Formatting orders might include
##'   arbitrary separators. These are discarded. See details for implemented
##'   formats.
##' @param tz a character string that specifies the time zone with which to
##'   parse the dates
##' @param truncated integer, number of formats that can be missing. The most
##'   common type of irregularity in date-time data is the truncation due to
##'   rounding or unavailability of the time stamp. If the `truncated` parameter
##'   is non-zero `parse_date_time()` also checks for truncated formats. For
##'   example,  if the format order is "ymdHMS" and `truncated = 3`,
##'   `parse_date_time()` will correctly parse incomplete date-times like
##'   `2012-06-01 12:23`, `2012-06-01 12` and `2012-06-01`. \bold{NOTE:} The `ymd()`
##'   family of functions is based on [base::strptime()] which currently fails to parse
##'   `%Y-%m` formats.
##' @param quiet logical. If `TRUE`, progress messages are not printed, and
##'   `No formats found` error is suppressed and the function simply returns a
##'   vector of NAs.  This mirrors the behavior of base R functions [base::strptime()]
##'   and [base::as.POSIXct()].
##' @param locale locale to be used, see \link{locales}. On Linux systems you
##'   can use `system("locale -a")` to list all the installed locales.
##' @param select_formats A function to select actual formats for parsing from a
##'   set of formats which matched a training subset of `x`. It receives a named
##'   integer vector and returns a character vector of selected formats. Names
##'   of the input vector are formats (not orders) that matched the training
##'   set. Numeric values are the number of dates (in the training set) that
##'   matched the corresponding format. You should use this argument if the
##'   default selection method fails to select the formats in the right
##'   order. By default the formats with most formatting tokens (`%`) are
##'   selected and `%Y` counts as 2.5 tokens (so that it has a priority over
##'   `%y%m`). See examples.
##' @param exact logical. If `TRUE`, the `orders` parameter is interpreted as an
##'   exact [base::strptime()] format and no training or guessing are performed
##'   (i.e. `train`, `drop` parameters are irrelevant).
##' @param train logical, default `TRUE`. Whether to train formats on a subset of
##'   the input vector. The result of this is that supplied orders are sorted
##'   according to performance on this training set, which commonly results in
##'   increased performance. Please note that even when `train = FALSE` (and
##'   `exact = FALSE`) guessing of the actual formats is still performed on a
##'   pseudo-random subset of the original input vector. This might result in
##'   `All formats failed to parse` error. See notes below.
##' @param drop logical, default `FALSE`. Whether to drop formats that didn't
##'   match on the training set. If `FALSE`, unmatched on the training set formats
##'   are tried as a last resort at the end of the parsing queue. Applies only
##'   when `train = TRUE`. Setting this parameter to `TRUE` might slightly speed up
##'   parsing in situations involving many formats. Prior to v1.7.0 this
##'   parameter was implicitly `TRUE`, which resulted in occasional surprising
##'   behavior when rare patterns where not present in the training set.
##' @return a vector of POSIXct date-time objects
##' @seealso [base::strptime()], [ymd()], [ymd_hms()]
##' @keywords chron
##' @note `parse_date_time()` (and the derivatives `ymd()`, `ymd_hms()`, etc.)
##'   relies on a sparse guesser that takes at most 501 elements from the supplied
##'   character vector in order to identify appropriate formats from the
##'   supplied orders. If you get the error `All formats failed to parse` and
##'   you are confident that your vector contains valid dates, you should either
##'   set `exact` argument to `TRUE` or use functions that don't perform format
##'   guessing (`fast_strptime()`, `parse_date_time2()` or [base::strptime()]).
##' @note For performance reasons, when timezone is not UTC,
##'   `parse_date_time2()` and `fast_strptime()` perform no validity checks for
##'   daylight savings time. Thus, if your input string contains an invalid date
##'   time which falls into DST gap and `lt = TRUE` you will get an `POSIXlt`
##'   object with a non-existent time. If `lt = FALSE` your time instant will be
##'   adjusted to a valid time by adding an hour. See examples. If you want to
##'   get NA for invalid date-times use [fit_to_timeline()] explicitly.
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
##' ## ** heterogeneous date-times **
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
##' my_select <-   function(trained, drop=FALSE, ...){
##'    n_fmts <- nchar(gsub("[^%]", "", names(trained))) + grepl("%y", names(trained))*1.5
##'    names(trained[ which.max(n_fmts) ])
##' }
##'
##' parse_date_time(c("27-09-13", "27-09-2013"), "dmy", select_formats = my_select)
##'
##' ## ** invalid times with "fast" parsing **
##' parse_date_time("2010-03-14 02:05:06",  "YmdHMS", tz = "America/New_York")
##' parse_date_time2("2010-03-14 02:05:06",  "YmdHMS", tz = "America/New_York")
##' parse_date_time2("2010-03-14 02:05:06",  "YmdHMS", tz = "America/New_York", lt = TRUE)
parse_date_time <- function(x, orders, tz = "UTC", truncated = 0, quiet = FALSE,
                            locale = Sys.getlocale("LC_TIME"), select_formats = .select_formats,
                            exact = FALSE, train = TRUE, drop = FALSE) {

  ## backward compatible hack
  if (is.null(tz)) tz <- ""
  if (length(tz) != 1 || is.na(tz))
    stop("`tz` argument must be a character of length one")

  orig_locale <- Sys.getlocale("LC_TIME")
  Sys.setlocale("LC_TIME", locale)
  on.exit(Sys.setlocale("LC_TIME", orig_locale))

  x <- as.character(.num_to_date(x))
  if (truncated != 0)
    orders <- .add_truncated(orders, truncated)

  .local_parse <- function(x, first = FALSE) {
    formats <-
      if (exact) {
        orders
      } else {
        train <- .get_train_set(x)
        .best_formats(train, orders, locale = locale, select_formats, drop = drop)
      }
    if (length(formats) > 0) {
      out <- .parse_date_time(x, formats, tz = tz, quiet = quiet, locale = locale)
      new_na <- is.na(out)
      if (any(new_na)) {
        x <- x[new_na]
        if (length(x) == length(out)) {
          # don't recur if failed for all
          failed <<- length(x)
        } else {
          out[new_na] <- .local_parse(x)
        }
      }
      out
    } else {
      if (first && !quiet) {
        warning("All formats failed to parse. No formats found.", call. = FALSE)
        warned <<- TRUE
      }
      failed <<- length(x)
      NA
    }
  }

  failed <- 0L
  warned <- FALSE
  to_parse <- which(!is.na(x) & nzchar(x)) ## missing data might be ""
  ## prepare an NA vector
  out <- .POSIXct(rep.int(NA_real_, length(x)), tz = tz)

  if (length(to_parse)) {
    out[to_parse] <- .local_parse(x[to_parse], TRUE)
    if (failed > 0 && !quiet && !warned)
      warning(" ", failed, " failed to parse.", call. = FALSE)
  }

  out
}

parse_dt <- function(x, orders, is_format = FALSE, return_lt = FALSE, cutoff_2000 = 68L) {
  .Call(C_parse_dt, x, orders, as.logical(is_format), as.logical(return_lt), as.integer(cutoff_2000))
}

##' @description
##' `parse_date_time2()` is a fast C parser of numeric
##' orders.
##'
##' @rdname parse_date_time
##' @export
##' @param lt logical. If `TRUE`, returned object is of class POSIXlt, and POSIXct
##'   otherwise. For compatibility with [base::strptime()] the default is `TRUE`
##'   for `fast_strptime()` and `FALSE` for `parse_date_time2()`.
##' @param cutoff_2000 integer. For `y` format,  two-digit numbers smaller or equal to
##'   `cutoff_2000` are parsed as 20th's century, 19th's otherwise. Available only
##'   for functions relying on `lubridate`s internal parser.
parse_date_time2 <- function(x, orders, tz = "UTC", exact = FALSE, lt = FALSE, cutoff_2000 = 68L){
  if (length(tz) != 1 || is.na(tz))
    stop("`tz` argument must be a character of length one")
  if (length(orders) > 1)
    warning("Multiple orders supplied. Only first order is used.")
  if (!exact)
    orders <- gsub("[^[:alpha:]]+", "", as.character(orders[[1]])) ## remove all separators
  if (lt) {
    .mklt(parse_dt(x, orders, exact, TRUE, cutoff_2000), tz)
  } else {
    if (is_utc(tz)){
      .POSIXct(parse_dt(x, orders, exact, FALSE, cutoff_2000), tz = "UTC")
    } else {
      as.POSIXct(.mklt(parse_dt(x, orders, exact, TRUE, cutoff_2000), tz))
    }
  }
}

##' @description
##' `fast_strptime()` is a fast C parser of numeric formats only
##' that accepts explicit format arguments, just like
##' [base::strptime()].
##' @rdname parse_date_time
##' @export
##' @param format a character string of formats. It should include all the
##'   separators and each format must be prefixed with %, just as in the format
##'   argument of [base::strptime()].
fast_strptime <- function(x, format, tz = "UTC", lt = TRUE, cutoff_2000 = 68L) {
  if (length(format) > 1)
    warning("Multiple formats supplied. Only first format is used.")
  format <- as.character(format[[1]])
  if (lt) {
    .mklt(parse_dt(x, format, TRUE, TRUE, cutoff_2000), tz)
  } else{
    if (is_utc(tz)) {
      .POSIXct(parse_dt(x, format, TRUE, FALSE, cutoff_2000), "UTC")
    } else {
      as.POSIXct(.mklt(parse_dt(x, format, TRUE, TRUE, cutoff_2000), tz))
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

.parse_date_time <- function(x, formats, tz, quiet, locale){

  ## print(formats) # for debugging

  out <- .strptime(x, formats[[1]], tz = tz, quiet = quiet, locale = locale)
  na <- is.na(out)
  newx <- x[na]

  if (is_verbose())
    message(" ", sum(!na) , " parsed with ", gsub("^@|@$", "", formats[[1]]))

  ## recursive parsing
  if (length(formats) > 1 && length(newx) > 0)
    out[na] <- .parse_date_time(newx, formats[-1], tz = tz, quiet = quiet, locale = locale)

  ## return POSIXlt
  out
}

.strptime <- function(x, fmt, tz = "UTC", quiet = FALSE, locale = NULL){

  ## Depending on fmt we might need to preprocess x.
  ## ISO8601 and internal parser are the only cases so far.
  ## %Ou: "2013-04-16T04:59:59Z"
  ## %Oo: "2013-04-16T04:59:59+01"
  ## %Oz: "2013-04-16T04:59:59+0100"
  ## %OO: "2013-04-16T04:59:59+01:00"

  ## is_posix <-  0 < regexpr("^[^%]*%Y[^%]+%m[^%]+%d[^%]+(%H[^%](%M[^%](%S)?)?)?[^%Z]*$", fmt)

  c_parser <- 0 < regexpr("^[^%0-9]*(%([YymdqIHMSz]|O[SzuoOpmb])[^%0-9Z]*)+$", fmt)
  zpos <- regexpr("%O((?<z>z)|(?<u>u)|(?<o>o)|(?<O>O))", fmt, perl = TRUE)

  if (c_parser) {
    ## C PARSER:
    out <- fast_strptime(x, fmt, tz = "UTC", lt = FALSE)

    if (!is_utc(tz)) {
      out <-
        if (zpos > 0){
          if (!quiet)
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

    ## strptime doesn't accept 'locale' argument; need a hard reset
    if (!is.null(locale)) {
      old_lc_time <- Sys.getlocale("LC_TIME")
      if (old_lc_time != locale){
        Sys.setlocale("LC_TIME", locale)
        on.exit(Sys.setlocale("LC_TIME", old_lc_time))
      }
    }

    if (zpos > 0){
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

      fmt <- .str_sub(fmt, zpos, zpos + attr(zpos, "match.length") - 1, repl)

      ## user has supplied tz argument -> convert to tz
      if (!is_utc(tz)){
        if (!quiet)
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

  if (truncated > 0) {
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
  if (truncated > 0){
    ## Take first 3 formats and append formats from .xxx_hms_truncations
    ## co responding to the 4th format letter in order[[1]] -- T, R or r.
    xxx <- substr(orders[[1]], 1, 3) ##
    add <- paste(xxx, .xxx_hms_truncations[[substr(orders[[1]], 4, 4)]], sep = "")
    rest <- length(add) - truncated
    if (rest  < 0)
      orders <- c(orders, add, .add_truncated(xxx, abs(rest)))
    else
      orders <- c(orders, add[1:truncated])
  }
  dates <- unlist(lapply(list(...), .num_to_date), use.names = FALSE)
  parse_date_time(dates, orders, tz = tz, quiet = quiet, locale = locale)
}

.parse_xxx <- function(..., orders, quiet, tz, locale,  truncated){
  dates <- unlist(lapply(list(...), .num_to_date), use.names = FALSE)
  if (is.null(tz)) {
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

.parse_iso_dt <- function(x, tz) {
  parse_date_time(x, orders = c("ymdTz", "ymdT", "ymd"), tz = tz, train = FALSE)
}

as_POSIXct <- function(x, tz) {
  if (is.character(x))
    .parse_iso_dt(x, tz = tz)
  else if (!is.POSIXct(x))
    as.POSIXct(x, tz = tz)
  else x
}
## parse.r ends here
