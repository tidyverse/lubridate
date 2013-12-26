##' Parse dates according to the order in that year, month, and day elements
##' appear in the input vector.
##'
##' Transforms dates stored in character and numeric vectors to POSIXct
##' objects. These functions recognize arbitrary non-digit separators as well as
##' no separator. As long as the order of formats is correct, these functions
##' will parse dates correctly even when the input vectors contain differently
##' formatted dates. See examples.
##'
##' \code{ymd} family of functions automatically assign the Universal
##' Coordinated Time Zone (UTC) to the parsed dates. This time zone can be
##' changed with \code{\link{force_tz}}.
##'
##' If \code{truncated} parameter is non-zero \code{ymd} functions also check for
##' truncated formats. For example \code{ymd} with \code{truncated = 2} will also
##' parse incomplete dates like \code{2012-06} and \code{2012}.
##'
##' NOTE: \code{ymd} family of functions are based on \code{\link{strptime}}
##' which currently correctly parses "\%y" format, but fails to parse "\%y-\%m"
##' formats.
##'
##' As of version 1.3.0, lubridate's parse functions no longer return a
##' message that displays which format they used to parse their input. You can
##' change this by setting the \code{lubridate.verbose} option to true with
##' \code{options(lubridate.verbose = TRUE)}.
##'
##' @export ymd myd dym ydm mdy dmy
##' @aliases yearmonthdate ymd myd dym ydm mdy dmy
##' @param ... a character or numeric vector of suspected dates
##' @param quiet logical. When TRUE function evalueates without displaying
##' customary messages.
##' @param tz a character string that specifies which time zone to parse the
##' date with. The string must be a time zone that is recognized by the user's
##' OS.
##' @param locale locale to be used, see \link{locales}. On linux systems you
##' can use \code{system("locale -a")} to list all the installed locales.
##' @param truncated integer. Number of formats that can be truncated.
##' @return a vector of class POSIXct
##' @seealso \code{\link{parse_date_time}} for an even more flexible low level mechanism.
##' @keywords chron
##' @examples
##' x <- c("09-01-01", "09-01-02", "09-01-03")
##' ymd(x)
##' ## "2009-01-01 UTC" "2009-01-02 UTC" "2009-01-03 UTC"
##' x <- c("2009-01-01", "2009-01-02", "2009-01-03")
##' ymd(x)
##' ## "2009-01-01 UTC" "2009-01-02 UTC" "2009-01-03 UTC"
##' ymd(090101, 90102)
##' ## "2009-01-01 UTC" "2009-01-02 UTC"
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
##'
ymd <- function(..., quiet = FALSE, tz = "UTC", locale = Sys.getlocale("LC_TIME"),  truncated = 0)
  .parse_xxx(..., orders = "ymd", quiet = quiet, tz = tz, locale = locale,  truncated = truncated)
ydm <- function(..., quiet = FALSE, tz = "UTC", locale = Sys.getlocale("LC_TIME"),  truncated = 0)
  .parse_xxx(..., orders = "ydm", quiet = quiet, tz = tz, locale = locale,  truncated = truncated)
mdy <- function(..., quiet = FALSE, tz = "UTC", locale = Sys.getlocale("LC_TIME"),  truncated = 0)
  .parse_xxx(..., orders = "mdy", quiet = quiet, tz = tz, locale = locale,  truncated = truncated)
myd <- function(..., quiet = FALSE, tz = "UTC", locale = Sys.getlocale("LC_TIME"),  truncated = 0)
  .parse_xxx(..., orders = "myd", quiet = quiet, tz = tz, locale = locale,  truncated = truncated)
dmy <- function(..., quiet = FALSE, tz = "UTC", locale = Sys.getlocale("LC_TIME"),  truncated = 0)
  .parse_xxx(..., orders = "dmy", quiet = quiet, tz = tz, locale = locale,  truncated = truncated)
dym <- function(..., quiet = FALSE, tz = "UTC", locale = Sys.getlocale("LC_TIME"),  truncated = 0)
  .parse_xxx(..., orders = "dym", quiet = quiet, tz = tz, locale = locale,  truncated = truncated)


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
##' @export ymd_hms ymd_hm ymd_h dmy_hms dmy_hm dmy_h mdy_hms mdy_hm mdy_h ydm_hms ydm_hm ydm_h
##' @aliases ymd_hms ymd_hm ymd_h dmy_hms dmy_hm dmy_h mdy_hms mdy_hm mdy_h ydm_hms ydm_hm ydm_h
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
##' # [1] "2010-04-14 04:35:59 UTC" "2010-04-01 12:00:00 UTC"
##' x <- c("2011-12-31 12:59:59", "2010-01-01 12:00:00")
##' ymd_hms(x)
##' # [1] "2011-12-31 12:59:59 UTC" "2010-01-01 12:00:00 UTC"
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
##' ## "2006-02-20 11:16:16.683 UTC"
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
##' ## [1] "2011-12-31 12:59:59 UTC" "2010-01-01 12:11:00 UTC"
##' ## [3] "2010-01-01 12:00:00 UTC" "2010-01-01 00:00:00 UTC"
##' x <- c("2011-12-31 12:59", "2010-01-01 12", "2010-01-01")
##' ymd_hm(x, truncated = 2)
##' ## [1] "2011-12-31 12:59:00 UTC" "2010-01-01 12:00:00 UTC"
##' ## [3] "2010-01-01 00:00:00 UTC"
##' ## ** What lubridate might not handle **
##' ## Extremely weird cases when one of the separators is "" and some of the
##' ## formats are not in double digits might not be parsed correctly:
##' \dontrun{
##' ymd_hm("20100201 07-01", "20100201 07-1", "20100201 7-01")}
##' ## "2010-02-01 07:01:00 UTC" "2010-02-01 07:01:00 UTC"   NA
##'
ymd_hms <- function(..., quiet = FALSE, tz = "UTC", locale = Sys.getlocale("LC_TIME"),  truncated = 0){
  .parse_xxx_hms(..., orders = c("ymdTz", "ymdT"), quiet = quiet, tz = tz, locale = locale,  truncated = truncated)
}
ymd_hm <- function(..., quiet = FALSE, tz = "UTC", locale = Sys.getlocale("LC_TIME"),  truncated = 0)
  .parse_xxx_hms(..., orders =  "ymdR", quiet = quiet, tz = tz, locale = locale,  truncated = truncated)
ymd_h <- function(..., quiet = FALSE, tz = "UTC", locale = Sys.getlocale("LC_TIME"),  truncated = 0)
  .parse_xxx_hms(..., orders = "ymdr", quiet = quiet, tz = tz, locale = locale,  truncated = truncated)

dmy_hms <- function(..., quiet = FALSE, tz = "UTC", locale = Sys.getlocale("LC_TIME"),  truncated = 0)
  .parse_xxx_hms(..., orders = c("dmyTz", "dmyT"), quiet = quiet, tz = tz, locale = locale,  truncated = truncated)
dmy_hm <- function(..., quiet = FALSE, tz = "UTC", locale = Sys.getlocale("LC_TIME"),  truncated = 0)
  .parse_xxx_hms(..., orders = "dmyR", quiet = quiet, tz = tz, locale = locale,  truncated = truncated)
dmy_h <- function(..., quiet = FALSE, tz = "UTC", locale = Sys.getlocale("LC_TIME"),  truncated = 0)
  .parse_xxx_hms(..., orders = "dmyR", quiet = quiet, tz = tz, locale = locale,  truncated = truncated)

mdy_hms <- function(..., quiet = FALSE, tz = "UTC", locale = Sys.getlocale("LC_TIME"),  truncated = 0)
  .parse_xxx_hms(..., orders = c("mdyTz", "mdyT"), quiet = quiet, tz = tz, locale = locale,  truncated = truncated)
mdy_hm <- function(..., quiet = FALSE, tz = "UTC", locale = Sys.getlocale("LC_TIME"),  truncated = 0)
  .parse_xxx_hms(..., orders = "mdyR", quiet = quiet, tz = tz, locale = locale,  truncated = truncated)
mdy_h <- function(..., quiet = FALSE, tz = "UTC", locale = Sys.getlocale("LC_TIME"),  truncated = 0)
  .parse_xxx_hms(..., orders = "mdyr", quiet = quiet, tz = tz, locale = locale,  truncated = truncated)

ydm_hms <- function(..., quiet = FALSE, tz = "UTC", locale = Sys.getlocale("LC_TIME"),  truncated = 0)
  .parse_xxx_hms(..., orders = c("ydmTz", "ydmT"), quiet = quiet, tz = tz, locale = locale,  truncated = truncated)
ydm_hm <- function(..., quiet = FALSE, tz = "UTC", locale = Sys.getlocale("LC_TIME"),  truncated = 0)
  .parse_xxx_hms(..., orders = "ydmR", quiet = quiet, tz = tz, locale = locale,  truncated = truncated)
ydm_h <- function(..., quiet = FALSE, tz = "UTC", locale = Sys.getlocale("LC_TIME"),  truncated = 0)
  .parse_xxx_hms(..., orders = "ydmR", quiet = quiet, tz = tz, locale = locale,  truncated = truncated)


##' Create a period with the specified number of minutes and seconds
##'
##' Transforms character or numeric vectors into a period object with the
##' specified number of minutes and seconds. ms() Arbitrary text can separate
##' minutes and seconds. Fractional separator is assumed to be ".". After
##' minutes and seconds have been parsed, all numeric input is ignored.
##'
##' @export ms
##' @param ... character or numeric vectors of minute second pairs
##' @param quiet logical. When TRUE function evalueates without displaying customary messages.
##' @return a vector of class \code{Period}
##' @seealso \code{\link{hms}, \link{hm}}
##' @keywords period
##' @examples
##' x <- c("09:10", "09:02", "1:10")
##' ms(x)
##' # [1] 9 minutes and 10 seconds   9 minutes and 2 seconds   1 minute and 10 seconds
##' ms("7 6")
##' # [1] 7 minutes and 6 seconds
##' ms("6,5")
##' # 6 minutes and 5 seconds
ms <- function(..., quiet = FALSE) {
  out <- .parse_hms(..., order = "MS", quiet = quiet)
  new_period(minute = out["M", ], second = out["S", ])
}


##' Create a period with the specified number of hours and minutes
##'
##' Transforms a character or numeric vectors into a period object with the
##' specified number of hours and minutes. Arbitrary non-numeric text can
##' separate hours and minutes.  After hours and minutes have been parsed, the
##' remaining input is ignored.
##'
##' @export hm
##' @param ... character or numeric vectors of hour minute pairs
##' @param quiet logical. When TRUE function evalueates without displaying customary messages.
##' @return a vector of class \code{Period}
##' @seealso \code{\link{hms}, \link{ms}}
##' @keywords period
##' @examples
##' x <- c("09:10", "09:02", "1:10")
##' hm(x)
##' # [1] 9 hours and 10 minutes   9 hours and 2 minutes   1 hour and 10 minutes
##' hm("7 6")
##' # [1] 7 hours and 6 minutes
##' hm("6,5")
##' # [1] 6 hours and 5 minutes
hm <- function(..., quiet = FALSE) {
  out <- .parse_hms(..., order = "HM", quiet = quiet)
  new_period(hour = out["H", ], minute = out["M", ])
}

##' Create a period with the specified hours, minutes, and seconds
##'
##' Transforms a character or numeric vector into a period object with the
##' specified number of hours, minutes, and seconds. hms() recognizes all
##' non-numeric separators. After hours, minutes and seconds have been parsed,
##' the remaining input is ingored.
##'
##' @export hms
##' @param ... a character vector of hour minute second triples
##' @param quiet logical. When TRUE function evalueates without displaying customary messages.
##' @return a vector of period objects
##' @seealso \code{\link{hm}, \link{ms}}
##' @keywords period
##' @useDynLib lubridate parse_hms
##' @examples
##'
##' x <- c("09:10:01", "09:10:02", "09:10:03", "Collided at 9:20:04 pm")
##' hms(x)
##' # [1] 9 hours, 10 minutes and 1 second
##' # [2] 9 hours, 10 minutes and 2 seconds
##' # [3] 9 hours, 10 minutes and 3 seconds
##'
##' hms("7 6 5", "3-23---2", "2 : 23 : 33")
##' ## [1] 7 hours, 6 minutes and 5 seconds
##' ## [2] 3 hours, 23 minutes and 2 seconds
##' ## [3] 2 hours, 23 minutes and 33 seconds
hms <- function(..., quiet = FALSE) {
  out <- .parse_hms(..., order = "HMS", quiet = quiet)
  new_period(hour = out["H", ], minute = out["M", ], second = out["S", ])
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
##' \code{parse_date_time}, and hence all the derived functions, such as
##' \code{ymd_hms}, \code{ymd} etc, will drop into \code{fast_strptime} instead
##' of \code{strptime} whenever the trained from input data formats are all
##' numeric.
##'
##' Here are all the formats recognized by lubridate. For numeric formats
##' leading 0s are optional. As compared to \code{strptime}, some of the formats
##' have been extended for efficiency reasons. They are marked with "*". Formats
##' accepted by \code{parse_date_time2} and \code{fast_strptime} are marked with
##' "!".
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
##' \item{\code{b}}{Abbreviated month name in the current locale.  (Also matches full name.)}
##' 
##' \item{\code{B}}{Full month name in the current locale.  (Also matches abbreviated name.)}
##'
##' \item{\code{d!}}{Day of the month as decimal number (01--31 or 0--31)}
##' 
##' \item{\code{H!}}{Hours as decimal number (00--24 or 0--24).}
##' 
##' \item{\code{I}}{Hours as decimal number (01--12 or 0--12).}
##' 
##' \item{\code{j}}{Day of year as decimal number (001--366 or 1--366).}
##' 
##' \item{\code{m*!}}{Month as decimal number (01--12 or 1--12). For
##' \code{parse_date_time}, also matches abbreviated and full months names as
##' \code{b} and \code{B} formats.}
##' 
##' \item{\code{M!}}{Minute as decimal number (00--59 or 0--59).}
##' 
##' \item{\code{p}}{AM/PM indicator in the locale.  Used in
##'                   conjunction with \code{I} and \bold{not} with \code{H}.  An
##'                   empty string in some locales.}
##' 
##' \item{\code{S!}}{Second as decimal number (00--61 or 0--61), allowing for up
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
##' \item{\code{y*!}}{Year without century (00--99 or 0--99).  In
##' \code{parse_date_time} also matches year with century (Y format).}
##' 
##' \item{\code{Y!}}{Year with century.}
##'
##' \item{\code{z*!}}{ISO8601 signed offset in hours and minutes from UTC. For
##' example \code{-0800}, \code{-08:00} or \code{-08}, all represent 8 hours
##' behind UTC. This format also matches the Z (Zulu) UTC indicator. Because
##' strptime doesn't fully support ISO8601, lubridate represents this format
##' internally as an union of 4 different orders: Ou (Z), Oz (-0800), OO
##' (-08:00) and Oo (-08). You can use this formats as any other but it is
##' rarely necessary. \code{parse_date_time2} and \code{fast_strptime} support
##' all of the timezone formats.}
##' 
##' \item{\code{r*}}{Matches \code{Ip} and \code{H} orders.}
##' \item{\code{R*}}{Matches \code{HM} and\code{IMp} orders.}
##' \item{\code{T*}}{Matches \code{IMSp}, \code{HMS}, and \code{HMOS} orders.}
##' }
##'
##' @export parse_date_time
##' @aliases parse_date_time2 fast_strptime
##' @param x a character or numeric vector of dates
##' @param orders a character vector of date-time formats. Each order string is
##' series of formatting characters as listed \code{\link[base]{strptime}} but
##' might not include the "\%" prefix, for example "ymd" will match all the
##' possible dates in year, month, day order.  Formatting orders might include
##' arbitrary separators. These are discarded.  See details for implemented
##' formats.
##' @param tz a character string that specifies the time zone with which to
##' parse the dates
##' @param truncated integer, number of formats that can be missing. The most
##' common type of irregularity in date-time data is the truncation due to
##' rounding or unavailability of the time stamp. If \code{truncated} parameter is
##' non-zero \code{parse_date_time} also checks for truncated formats. For
##' example,  if the format order is "ymdhms" and \code{truncated = 3},
##' \code{parse_date_time} will correctly parse incomplete dates like
##' \code{2012-06-01 12:23}, \code{2012-06-01 12} and \code{2012-06-01}. \bold{NOTE:}
##' \code{ymd} family of functions are based on \code{strptime} which currently
##' fails to parse \code{\%y-\%m} formats.
##' @param quiet logical. When TRUE progress messages are not printed, and "no
##' formats found" error is surpresed and the function simply returns a vector
##' of NAs.  This mirrors the behavior of base R functions \code{strptime} and
##' \code{as.POSIXct}. Default is FALSE.
##' @param locale locale to be used, see \link{locales}. On linux systems you
##' can use \code{system("locale -a")} to list all the installed locales.
##' @param select_formats A function to select actual formats for parsing from a
##' set of formats which matched a training subset of \code{x}. it receives a
##' named integer vector and returns a character vector of selected
##' formats. Names of the input vector are formats (not orders) that matched the
##' training set. Numeric values are the number of dates (in the training set)
##' that matched the corresponding format. You should use this argument if the
##' default selection method fails to select the formats in the right order. By
##' default the formats with most formating tockens (\%) are selected and \%Y
##' counts as 2.5 tockens (so that it has a priority over \%y\%m). Se examples.
##' @return a vector of POSIXct date-time objects
##' @seealso \code{strptime}, \code{\link{ymd}}, \code{\link{ymd_hms}}
##' @keywords chron
##' @examples
##' x <- c("09-01-01", "09-01-02", "09-01-03")
##' parse_date_time(x, "ymd")
##' parse_date_time(x, "%y%m%d")
##' parse_date_time(x, "%y %m %d")
##' #  "2009-01-01 UTC" "2009-01-02 UTC" "2009-01-03 UTC"
##'
##' ## ** heterogenuous formats **
##' x <- c("09-01-01", "090102", "09-01 03", "09-01-03 12:02")
##' parse_date_time(x, c("%y%m%d", "%y%m%d %H%M"))
##'
##' ## different ymd orders:
##' x <- c("2009-01-01", "02022010", "02-02-2010")
##' parse_date_time(x, c("%d%m%Y", "ymd"))
##' ##  "2009-01-01 UTC" "2010-02-02 UTC" "2010-02-02 UTC"
##'
##' ## ** truncated time-dates **
##' x <- c("2011-12-31 12:59:59", "2010-01-01 12:11", "2010-01-01 12", "2010-01-01")
##' parse_date_time(x, "%Y%m%d %H%M%S", truncated = 3)
##' parse_date_time(x, "ymd_hms", truncated = 3)
##' ## [1] "2011-12-31 12:59:59 UTC" "2010-01-01 12:11:00 UTC"
##' ## [3] "2010-01-01 12:00:00 UTC" "2010-01-01 00:00:00 UTC"
##'
##' ## ** fast parsing **
##' \dontrun{
##'   options(digits.secs = 3)
##'   ## random times between 1400 and 3000
##'   tt <- as.character(.POSIXct(runif(1e6, -17987443200, 32503680000)))
##'   system.time(out <- as.POSIXct(tt, tz = "UTC"))
##'   system.time(out1 <- ymd_hms(tt)) ## format learning overhead
##'   system.time(out2 <- parse_date_time2(tt, "YmdHMOS"))
##'   system.time(out3 <- fast_strptime(tt, "%Y-%m-%d %H:%M:%OS"))
##'   all.equal(out, out1)
##'   all.equal(out, out2)
##'   all.equal(out, out3)
##' }
##' 
##' ## ** how to use select_formats **
##' ## By default %Y has precedence:
##' parse_date_time(c("27-09-13", "27-09-2013"), "dmy")
##' ## [1] "13-09-27 UTC"   "2013-09-27 UTC"
##'
##' ## to give priority to %y format, define your own select_format function:
##'
##' my_select <-   function(trained){
##'    n_fmts <- nchar(gsub("[^%]", "", names(trained))) + grepl("%y", names(trained))*1.5
##'    names(trained[ which.max(n_fmts) ])
##' }
##'
##' parse_date_time(c("27-09-13", "27-09-2013"), "dmy", select_formats = my_select)
##' ## '[1] "2013-09-27 UTC" "2013-09-27 UTC"
parse_date_time <- function(x, orders, tz = "UTC", truncated = 0, quiet = FALSE,
  locale = Sys.getlocale("LC_TIME"), select_formats = .select_formats){

  orig_locale <- Sys.getlocale("LC_TIME")
  Sys.setlocale("LC_TIME", locale)
  on.exit(Sys.setlocale("LC_TIME", orig_locale))

  x <- as.character(.num_to_date(x))
  if( truncated != 0 )
    orders <- .add_truncated(orders, truncated)

  .local_parse <- function(x, first = FALSE){
    train <- .get_train_set(x)
    formats <- .best_formats(train, orders, locale = locale, select_formats)
    if( length(formats) > 0 ){
      out <- .parse_date_time(x, formats, tz = tz, quiet = quiet)
      new_na <- is.na(out)
      if( any(new_na) )
        out[new_na] <- .local_parse(x[new_na])
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
##' @export parse_date_time2
parse_date_time2 <- function(x, orders, tz = "UTC"){
  if( length(orders) > 1) warning("Multiple orders supplied. Only the first one is used")
  orders <- gsub("[^[:alpha:]]+", "", as.character(orders[[1]])) ## remove all separators
  .POSIXct(.Call("parse_dt", x, orders, FALSE), tz = tz)
}

##' @useDynLib lubridate parse_dt
##' @rdname parse_date_time
##' @export fast_strptime
##' @param format a character string of formats. It should include all the
##' separators and each format must be prefixed with %, just as in the format
##' argument of \code{strptime}.
fast_strptime <- function(x, format, tz = "UTC"){
  if( length(format) > 1 ) warning("Multiple formats supplied. Only the first one is used")
  format <- as.character(format[[1]])
  .POSIXct(.Call("parse_dt", x, format, TRUE), tz = tz)
}

### INTERNAL
.parse_date_time <- function(x, formats, tz, quiet){
  ## recursive parsing
  out <- .strptime(x, formats[[1]], tz = tz, quiet = quiet)
  na <- is.na(out)
  newx <- x[na]

  verbose <- getOption("lubridate.verbose")
  if( !is.null(verbose) && verbose )
    message(" ", sum(!na) , " parsed with ", gsub("^@|@$", "", formats[[1]]))

  if( length(formats) > 1 && length(newx) > 0 )
    out[na] <- .parse_date_time(newx, formats[-1], tz = tz, quiet = quiet)

  ## return POSIXlt
  out
}

.strptime <- function(x, fmt, tz = "UTC", quiet = FALSE){

  ## Depending on fmt we might need to preprocess x.
  ## ISO8601 and fasttime are the only cases so far.
  ## %Ou: "2013-04-16T04:59:59Z"
  ## %Oo: "2013-04-16T04:59:59+01"
  ## %Oz: "2013-04-16T04:59:59+0100"
  ## %OO: "2013-04-16T04:59:59+01:00"

  ## is_posix <-  0 < regexpr("^[^%]*%Y[^%]+%m[^%]+%d[^%]+(%H[^%](%M[^%](%S)?)?)?[^%Z]*$", fmt)

  num_only <-  0 < regexpr("^[^%0-9]*(%([YymdHMSz]|O[SzuoO])[^%0-9Z]*)+$", fmt)
  zpos <- regexpr("%O((?<z>z)|(?<u>u)|(?<o>o)|(?<O>O))", fmt, perl = TRUE)

  if ( num_only ){
    ## C PARSER:

    if ( tz != "UTC" ){
      if( zpos > 0 ){
        if( !quiet )
          message("Date in ISO8601 format; converting timezone from UTC to \"", tz,  "\".")
        with_tz(fast_strptime(x, fmt, tz = "UTC"), tzone = tz)
      } else {
        ## as compared to the parsing, this is so unbelievably slow  :(
        force_tz(fast_strptime(x, fmt, tz = "UTC"), tzone = tz)
      }
    } else {
      fast_strptime(x, fmt, tz = tz)
    }

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

    as.POSIXct(strptime(.enclose(x), .enclose(fmt), tz))
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
  if( truncated > 0 ){
    ## Take first 3 formats and append formats from .xxx_hms_truncations
    ## co responding to the 4th format letter in order[[1]] -- T, R or r.
    xxx <- substr(orders[[1]], 1, 3) ##
    add <- paste(xxx, .xxx_hms_truncations[[substr(orders[[1]], 4, 4)]], sep = "")
    rest <- length(add) - truncated
    if( rest  < 0 )
      orders <- c(orders, add, .add_truncated(xxx, abs(rest)))
    else
      orders <- c(orders, add[1:truncated], sep = "")
  }
  dates <- unlist(lapply(list(...), .num_to_date), use.names = FALSE)
  parse_date_time(dates, orders, tz = tz, quiet = quiet, locale = locale)
}

.parse_xxx <- function(..., orders, quiet, tz, locale = locale,  truncated){
  dates <- unlist(lapply(list(...), .num_to_date), use.names = FALSE)
  parse_date_time(dates, orders, quiet = quiet, tz = tz,
                  locale = locale, truncated = truncated)
}


.num_to_date <- function(x) {
  if (is.numeric(x)) {
    out <- rep.int(as.character(NA), length(x))
    nnas <- !is.na(x)
    x <- as.character(x[nnas])
    x <- paste(ifelse(nchar(x) %% 2 == 1, "0", ""), x, sep = "")
    out[nnas] <- x
    out
  }else as.character(x)
}

## parse.r ends here
