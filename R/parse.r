##' Lubridate format orders used in \code{ymd}, \code{hms} and \code{ymd_hms}
##' family of functions.
##'
##' These orders are passed to \code{parseDateTime} low level parsing function.
##' @export lubridate_formats
##' @format Named list with formats.
##' @docType data
##' @seealso \code{\link{parseDateTime}}, \code{\link{ymd}}, \code{\link{ymd_hms}}
##' @keywords chron
##' @examples
##' str(lubridate_formats)
lubridate_formats <- local({
    xxx <- c( "ymd", "ydm", "mdy", "myd", "dmy", "dym")
    names(xxx) <- xxx    
    out <- character()
    for(D in xxx){
        out[[paste(D, "_hms", sep = "")]] <- paste(xxx[[D]], "T", sep = "")
        out[[paste(D, "_hm", sep = "")]] <- paste(xxx[[D]], "R", sep = "")
        out[[paste(D, "_h", sep = "")]] <- paste(xxx[[D]], "r", sep = "")
    }    
    
    out <- c(out, xxx, my = "my", ym = "ym", md = "md", dm = "dm", 
             hms = "T", hm = "R", ms = "MS", h = "r", m = "m", y = "y")
    out
})

##' Parse dates according to the order that year, month, and day elements appear
##' in the input vector.
##'
##' Transforms dates stored in character and numeric vectors to POSIXct
##' objects. These functions recognize arbitrary non-digit separators as well as
##' no separator. As long as the order of formats is correct, these functions
##' will parse dates correctly even when the input vectors contain differently
##' formatted dates. See examples. For even more flexibility in treatment of
##' heterogeneous formats see low level parser \code{\link{parseDateTime}}.
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
##' @export ymd myd dym ydm mdy dmy
##' @aliases yearmonthdate ymd myd dym ydm mdy dmy
##' @param ... a character or numeric vector of suspected dates 
##' @param quiet logical. When TRUE function evalueates without displaying
##' customary messages.
##' @param tz a character string that specifies which time zone to parse the
##' date with. The string must be a time zone that is recognized by the user's
##' OS.
##' @param truncated integer. Number of formats that can be truncated. 
##' @return a vector of class POSIXct 
##' @seealso \code{\link{parseDateTime}} for underlying mechanism.
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
##'        "2009-1, 5", "Created on 2009 1 6", "200901 !!! 07", "200901-8")
##' ymd(x)
##' 
##' ## What lubridate might not handle:
##' 
##' ## Extremely weird cases when one of the separators is "" and some of the
##' ## formats are not in double digits might not be parsed correctly:
##' ymd("201002-01", "201002-1", "20102-1")
##' dmy("0312-2010", "312-2010")
##' 
ymd <- function(..., quiet = FALSE, tz = "UTC", truncated = 0)
    .parse_xxx(..., orders = "ymd", quiet = quiet, tz = tz, truncated = truncated)

ydm <- function(..., quiet = FALSE, tz = "UTC", truncated = 0) 
    .parse_xxx(..., orders = "ydm", quiet = quiet, tz = tz, truncated = truncated)

mdy <- function(..., quiet = FALSE, tz = "UTC", truncated = 0) 
    .parse_xxx(..., orders = "mdy", quiet = quiet, tz = tz, truncated = truncated)

 
myd <- function(..., quiet = FALSE, tz = "UTC", truncated = 0) 
    .parse_xxx(..., orders = "myd", quiet = quiet, tz = tz, truncated = truncated)

dmy <- function(..., quiet = FALSE, tz = "UTC", truncated = 0) 
    .parse_xxx(..., orders = "dmy", quiet = quiet, tz = tz, truncated = truncated)

dym <- function(..., quiet = FALSE, tz = "UTC", truncated = 0) 
    .parse_xxx(..., orders = "dym", quiet = quiet, tz = tz, truncated = truncated)


##' Parse dates that have hours, minutes, or seconds elements.
##'
##' Transform dates stored as character or numeric vectors to POSIXct
##' objects. ymd_hms family of functions recognize all non-alphanumeric
##' separators (with the exception of "." if \code{frac = TRUE}) and correctly
##' handle heterogeneous date-time representations. For more flexibility in
##' treatment of heterogeneous formats, see low level parser
##' \code{\link{parseDateTime}}.
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
##' ymdThms() specifically handles combined dates and times written in the ISO
##' 8601 format.
##'
##' @export ymd_hms ymd_hm ymd_h dmy_hms dmy_hm dmy_h mdy_hms mdy_hm mdy_h ydm_hms ydm_hm ydm_h ymdThms
##' @aliases ymd_hms ymd_hm ymd_h dmy_hms dmy_hm dmy_h mdy_hms mdy_hm mdy_h ydm_hms ydm_hm ydm_h ymdThms
##' @param ... a character vector of dates in year, month, day, hour, minute, 
##'   second format 
##' @param quiet logical. When TRUE function evalueates without displaying customary messages.
##' @param tz a character string that specifies which time zone to parse the date with. The string must be a time zone that is recognized by the user's OS.
##' @param truncated integer, indicating how many formats can be missing. See details.
##' @param frac If \code{TRUE}, fractional seconds are allowed. It is assumed
##' that fractional seconds are separated by ".". In this case "." cannot be
##' used as a separator between other fields.
##' @return a vector of POSIXct date-time objects
##' @seealso \code{\link{ymd}}, \code{\link{hms}}. \code{\link{parseDateTime}}
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
##' ## ** truncated time-dates **
##' x <- c("2011-12-31 12:59:59", "2010-01-01 12:11", "2010-01-01 12", "2010-01-01")
##' ymd_hms(x, truncated = 3)
##' ## "2011-12-31 12:59:59 UTC" "2010-01-01 12:11:00 UTC" "2010-01-01 12:00:00 UTC" "2010-01-01 00:00:00 UTC"
##' x <- c("2011-12-31 12:59", "2010-01-01 12", "2010-01-01")
##' ymd_hm(x, truncated = 2)
##' ## "2011-12-31 12:59:00 UTC" "2010-01-01 12:00:00 UTC" "2010-01-01 00:00:00 UTC"
##' 
##' ## ** fractional seconds **
##' options(digits.secs = 3)
##' x <- c("2011-12-31 12:59:59.23", "2010-01-01 12:11:10")
##' ymd_hms(x, frac = TRUE)
##' ## "2011-12-31 12:59:59.23 UTC" "2010-01-01 12:11:10.00 UTC" 
##' 
##' ## ** What lubridate might not handle **
##' ## Extremely weird cases when one of the separators is "" and some of the
##' ## formats are not in double digits might not be parsed correctly:
##' ymd_hm("20100201 07-01", "20100201 07-1", "20100201 7-01")
##' ## "2010-02-01 07:01:00 UTC" "2010-02-01 07:01:00 UTC"   NA
##' 
ymd_hms <- function(..., quiet = FALSE, tz = "UTC", truncated = 0){
    .parse_xxx_hms(..., orders = "ymdT", quiet = quiet, tz = tz, truncated = truncated)
}
ymd_hm <- function(..., quiet = FALSE, tz = "UTC", truncated = 0)
    .parse_xxx_hms(..., orders =  "ymdR", quiet = quiet, tz = tz, truncated = truncated)
ymd_h <- function(..., quiet = FALSE, tz = "UTC", truncated = 0)
    .parse_xxx_hms(..., orders = "ymdr", quiet = quiet, tz = tz, truncated = truncated)
dmy_hms <- function(..., quiet = FALSE, tz = "UTC", truncated = 0)
    .parse_xxx_hms(..., orders = "dmyT", quiet = quiet, tz = tz, truncated = truncated)
dmy_hm <- function(..., quiet = FALSE, tz = "UTC", truncated = 0)
    .parse_xxx_hms(..., orders = "dmyR", quiet = quiet, tz = tz, truncated = truncated)
dmy_h <- function(..., quiet = FALSE, tz = "UTC", truncated = 0)
    .parse_xxx_hms(..., orders = "dmyR", quiet = quiet, tz = tz, truncated = truncated)
mdy_hms <- function(..., quiet = FALSE, tz = "UTC", truncated = 0)
    .parse_xxx_hms(..., orders = "mdyT", quiet = quiet, tz = tz, truncated = truncated)    
mdy_hm <- function(..., quiet = FALSE, tz = "UTC", truncated = 0)
    .parse_xxx_hms(..., orders = "mdyR", quiet = quiet, tz = tz, truncated = truncated)
mdy_h <- function(..., quiet = FALSE, tz = "UTC", truncated = 0)
    .parse_xxx_hms(..., orders = "mdyr", quiet = quiet, tz = tz, truncated = truncated)
ydm_hms <- function(..., quiet = FALSE, tz = "UTC", truncated = 0)
    .parse_xxx_hms(..., orders = "ydmT", quiet = quiet, tz = tz, truncated = truncated)
ydm_hm <- function(..., quiet = FALSE, tz = "UTC", truncated = 0)
    .parse_xxx_hms(..., orders = "ydmR", quiet = quiet, tz = tz, truncated = truncated)
ydm_h <- function(..., quiet = FALSE, tz = "UTC", truncated = 0)
    .parse_xxx_hms(..., orders = "ydmR", quiet = quiet, tz = tz, truncated = truncated)


ymdThms <- function(..., quiet = FALSE, tz = "UTC", truncated = 0){
    dates <- unlist(list(...), use.names= FALSE)
    as.POSIXct(parseDateTime(dates, stop(), tz = tz, 
                          sep_regexp= sep, truncated = truncated, quiet = quiet))
}



##' Create a period with the specified number of minutes and seconds
##'
##' Transforms character or numeric vectors into a period object with the
##' specified number of minutes and seconds. ms() Arbitrary text can separate
##' minutes and seconds. Fractional separator is assumed to be ".".
##'
##' @export ms
##' @param ... character or numeric vectors of minute second pairs
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
ms <- function(...) {
    hms <- .parse_hms(..., orders = "MS")
    new_period(minute = hms$min, second = hms$sec)
}


##' Create a period with the specified number of hours and minutes
##'
##' Transforms a character or numeric vectors into a period object with the
##' specified number of hours and minutes. Arbitrary text can separate hours and
##' minutes.
##'
##' @export hm
##' @param ... character or numeric vectors of hour minute pairs
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
hm <- function(...) {
    time <- .parse_hms(..., orders = "R")
    new_period(hour = time$hour, minute = time$min)
}

##' Create a period with the specified hours, minutes, and seconds
##'
##' Transforms a character or numeric vector into a period object with the
##' specified number of hours, minutes, and seconds. hms() recognizes all
##' non-alphanumeric separators, as well as no separator.
##'
##' @export hms
##' @param ... a character vector of hour minute second triples
##' @param truncated integer, number of formats that can be missing. See
##' \code{\link{parseDateTime}}.
##' @param frac If \code{TRUE}, fractional seconds are allowed. It is assumed
##' that fractional seconds are separated by ".". If \code{TRUE}, "." cannot be
##' used as a separator between minutes and seconds.
##' @return a vector of period objects
##' @seealso \code{\link{hm}, \link{ms}}
##' @keywords period
##' @examples
##'
##' x <- c("09:10:01", "09:10:02", "09:10:03", "Collided at 9:20:04 pm")
##' hms(x)
##' # [1] 9 hours, 10 minutes and 1 second   9 hours, 10 minutes and 2 seconds   9 hours, 10 minutes and 3 seconds
##' hms("7 6 5", "3-23---2", "2 : 23 : 33")
##' ## 7 hours, 6 minutes and 5 seconds    3 hours, 23 minutes and 2 seconds  2 hours, 23 minutes and 33 seconds 
hms <- function(..., truncated = 0) {
    time <- .parse_hms(..., orders = "T", truncated = truncated)
    new_period(hour = time$hour, minute = time$min, second = time$sec)
}


##' Function to parse character and numeric date-time vectors with user friendly
##' order formats.
##'
##'
##' As compared to \code{strptime} parser, \code{parseDateTime} allows to
##' specify only the order in which the formats occur instead of the full
##' format.  As it was specifically designed to handle heterogeneous date-time
##' formats at once, you can specify several alternative
##' orders. \code{parseDateTime} sorts the supplied formats based on a training
##' set and then applies them recursively on the input vector.
##'
##' Below are all the implemented formats recognized by lubridate. For all
##' numeric formats leading 0s are optional. All formats are case
##' insensitive. As compared to \code{strptime}, some of the formats have been
##' extended for efficiency reasons. They are marked with "*"
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
##' \item{\code{B}}{Full month name in the current locale.  (Also matches abbreviated name.)}
##' 
##' \item{\code{d}}{Day of the month as decimal number (01--31 or 0--31)}
##' \item{\code{H}}{Hours as decimal number (00--24 or 0--24).}
##' \item{\code{I}}{Hours as decimal number (01--12 or 0--12).}
##' \item{\code{j}}{Day of year as decimal number (001--366 or 1--366).}
##' \item{\code{m}*}{Month as decimal number (01--12 or 1--12). Also matches abbreviated and full months names as \code{b} and \code{B} formats}
##' \item{\code{M}}{Minute as decimal number (00--59 or 0--59).}
##' \item{\code{p}}{AM/PM indicator in the locale.  Used in
##'                   conjunction with \code{I} and \bold{not} with \code{H}.  An
##'                   empty string in some locales.}
##' \item{\code{S}}{Second as decimal number (00--61 or 0--61), allowing for
##'                   up to two leap-seconds (but POSIX-compliant implementations
##'                                           will ignore leap seconds).}
##' \item{\code{OS}}{Fractional second.}
##' 
##' \item{\code{U}}{Week of the year as decimal number (00--53 or 0-53) using
##'                   Sunday as the first day 1 of the week (and typically with the
##'                                                          first Sunday of the year as day 1 of week 1).  The US convention.}
##' \item{\code{w}}{Weekday as decimal number (0--6, Sunday is 0).}
##' \item{\code{W}}{Week of the year as decimal number (00--53 or 0-53) using
##'                   Monday as the first day of week (and typically with the
##'                                                    first Monday of the year as day 1 of week 1).  The UK convention.}
##' \item{\code{y}*}{Year without century (00--99 or 0--99).  Also matches year with century (Y format).}
##' \item{\code{Y}}{Year with century.} 
##' \item{\code{z}}{Signed offset in hours and minutes from UTC, so
##'                   \code{-0800} is 8 hours behind UTC.}
##'
##' \item{\code{r}*}{Matches \code{Ip} and \code{H} orders.}
##' \item{\code{R}*}{Matches \code{HM} and\code{IMp} orders.}
##' \item{\code{T}*}{Matches \code{IMSp}, \code{HMS}, and \code{HMOS} orders.}
##' 
##'   }
##'
##' @export parseDateTime
##' @param x a character or numeric vector of dates
##' @param tz a character string that specifies the time zone with which to
##' parse the dates
##' @param locale locale to be used, see \link{locales}. On linux systems you
##' can use \code{system("locale -a")} to list all the installed locales.
##' @param truncated integer, number of formats that can be missing. The most
##' common type of irregularity in date-time data is the truncation due to
##' rounding or unavailability of the time stamp. If \code{truncated} parameter is
##' non-zero \code{parseDateTime} also checks for truncated formats. For
##' example,  if the format order is "ymdhms" and \code{truncated = 3},
##' \code{parseDateTime} will correctly parse incomplete dates like
##' \code{2012-06-01 12:23}, \code{2012-06-01 12} and \code{2012-06-01}. \bold{NOTE:}
##' \code{ymd} family of functions are based on \code{strptime} which currently
##' fails to parse \code{\%y-\%m} formats.
##' @param quiet logical. When TRUE function evalueates without displaying
##' customary messages.
##' @param orders a character vector of date-time formats. Each order string is
##' series of formatting characters as listed \code{\link[base]{strptime}} but
##' might not include the "\%" prefix, for example "ymd" will match all the
##' possible dates in year, month, day order.  Formatting orders might include
##' arbitrary separators. These are discarded.  See details for implemented
##' formats.
##' @return a vector of POSIXct date-time objects
##' @seealso \code{strptime}, \code{\link{ymd}}, \code{\link{ymd_hms}}
##' @keywords chron
##' @examples
##' x <- c("09-01-01", "09-01-02", "09-01-03")
##' parseDateTime(x, "%y%m%d")
##' parseDateTime(x, "%y %m %d")
##' #  "2009-01-01 UTC" "2009-01-02 UTC" "2009-01-03 UTC"
##'
##' ## ** heterogenuous formats **
##' x <- c("09-01-01", "090102", "09-01 03", "09-01-03 12:02")
##' parseDateTime(x, c("%y%m%d", "%y%m%d %H%M"))
##' ## Avoid training for small vectors (all the formats are just tried in turn):
##' parseDateTime(x, c("%y%m%d", "%y%m%d %H%M"), train = NULL)
##'
##' ## different ymd orders:
##' x <- c("2009-01-01", "02022010", "02-02-2010")
##' parseDateTime(x, c("%d%m%Y", "%Y%m%d"), train = NULL)
##' ##  "2009-01-01 UTC" "2010-02-02 UTC" "2010-02-02 UTC"
##'
##' ## ** truncated time-dates **
##' x <- c("2011-12-31 12:59:59", "2010-01-01 12:11", "2010-01-01 12", "2010-01-01")
##' parseDateTime(x, "%Y%m%d %H%M%S", truncated = 3)
##' ## "2011-12-31 12:59:59 UTC" "2010-01-01 12:11:00 UTC" "2010-01-01 12:00:00 UTC" "2010-01-01 00:00:00 UTC"
##'
##' ## ** custom formats **
##' x <- c("July 8th, 2004, 10:30")
##' strptime(x, "%b %dth, %Y, %H:%M")
##' parseDateTime(x, "%b %dth, %Y, %H:%M", sep_regexp=NULL)
##' ## or just
##' parseDateTime(x, "%b%dth%Y %H%M")
##'
##' x <- c("Thu, 1 July 2004 22:30:00", "July 8th, 2004, 10:30")
##' parseDateTime(x, c("%a%d%b%Y %H%M%%S", "%b %dth %Y %H%M"))
parseDateTime <- function(x, orders, tz = "UTC", truncated = 0, quiet = FALSE,
                          locale = Sys.getlocale("LC_TIME")){

  x <- .num_to_date(x)
  if( truncated != 0 )
    orders <- c(orders, .add_truncated(orders, truncated))


  .local_parse <- function(x){
    train <- .get_train_set(x)
    formats <- .best_formats(train, orders, locale = locale)
    if( length(formats) > 0 ){
      out <- .parseDateTime(x, formats, locale = locale, quiet = quiet, tz = tz)
      new_na <- is.na(out)
      if( any(new_na) )
        out[new_na] <- .local_parse(x[new_na])
      out
    }else{
      failed <<- length(x)
      NA
    }
  }

  failed <- 0L
  to_parse <- !is.na(x)
  x <- .enclose(x)
  train <- .get_train_set(x[to_parse])
  formats <- .best_formats(train, orders, locale = locale)
  if( !is.null(formats) ){
    out <- .parseDateTime(x, formats, locale = locale, quiet = quiet, tz = tz)
    to_parse <- is.na(out) & to_parse
    out[to_parse] <- .local_parse(x[to_parse])
  }else{
    out <- as.POSIXlt(rep.int(NA, length(x)), tz = tz)
    failed <- sum(to_parse)
  }
  
  if( failed > 0 && !quiet )
    message(failed, " failed to parse.")
  
  out
}


### INTERNAL

.parseDateTime <- function(x, formats, locale, quiet, tz){
  
  out <- strptime(x, formats[[1]], tz = tz)
  na <- is.na(out$year)
  newx <- x[na]
  
  if(!quiet &  sum(!na) > 0)
    message(" ", sum(!na), " parsed with ", gsub("^@|@$", "", formats[[1]]))

  if( length(formats) > 1 && length(newx) > 0 )
    out[na] <- .parseDateTime(newx, formats[-1], quiet, tz)

  ## return POSIXlt
  out
}


.add_truncated <- function(orders, truncated){    
    out <- c()
    
    if(truncated > 0){
      for (i in 1:truncated)
        out <- c(out, substr(orders, 1, nchar(orders) - i))
    }else{
      for (i in 1:abs(truncated))
        out <- c(out, substr(orders, i + 1, 100000))
    }
    out[nzchar(out)]
}


## .add_truncated <- function(formats, truncated){    
##     stopifnot(is.character(formats))

##     split <- strsplit(formats, "%")
##     out <- list()
##     for (fmt in split){
##         out[[length(out) + 1L]] <- fmt
##         lenout <- length(out)
##         if(nchar(fmt[1]) == 0L) fmt <- fmt[-1]
##         if(truncated > 0){
##             lenfmt <- length(fmt)
##             mis <- min(truncated, lenfmt-1)
##             for (i in 1:mis)
##                 out[[lenout + i]] <- c("", fmt[1:(lenfmt - i)])
##         }else{
##             lenfmt <- length(fmt)
##             mis <- min(-truncated, lenfmt - 1)
##             for (i in 1:mis){
##                 out[[lenout + i]] <- c("", fmt[(i + 1):lenfmt])
##             }
##         }
##     }

##     out <- unlist(lapply(out, paste, collapse = "%"), use.names = FALSE)
##     ## replace  garbage at the end of string
##     out <- gsub("[^[:alnum:]]+$", "", out)
##     out
## }


.parse_hms <- function(..., orders,  truncated = 0){
    hms <- unlist(lapply(list(...), .num_to_date), use.names= FALSE)
    orders <- paste("Ymd", orders, sep = "")
    hms <- paste("1970-01-01", hms, sep = "-")
    ## ugly hack, but what can we do :(
    tryCatch(parseDateTime(hms, orders, truncated =  truncated, quiet = TRUE),
             error = function(e){
                 e$message <- gsub("%Y-%m-%d", "", e$message)
                 stop(e)
             })
}


.xxx_hms_truncations <- list(T = c("R", "r", ""), R = c("r", ""), r = "")

.parse_xxx_hms <- function(..., orders, truncated, quiet, tz){
  if( truncated > 0 ){
    xxx <- substr(orders, 1, 3)
    add <- paste(xxx, .xxx_hms_truncations[[substr(orders, 4, 4)]], sep = "")
    rest <- length(add) - truncated
    if( rest  < 0 )
      orders <- c(orders, add, .add_truncated(xxx, abs(rest)))
    else
      orders <- c(orders, add[1:truncated], sep = "")
  }
  dates <- unlist(lapply(list(...), .num_to_date), use.names = FALSE)
  as.POSIXct(parseDateTime(dates, orders, tz = tz,  quiet = quiet))
}

.parse_xxx <- function(..., orders, quiet, tz, truncated){
  dates <- unlist(lapply(list(...), .num_to_date), use.names = FALSE)
  as.POSIXct(parseDateTime(.num_to_date(dates), orders, quiet = quiet, tz = tz, truncated = truncated))
}


.num_to_date <- function(x) {
  if (is.numeric(x)) {
    x <- as.character(x)
    x <- paste(ifelse(nchar(x) %% 2 == 1, "0", ""), x, sep = "")
  }
  x
}


##' Deprecated internal function, use \code{\link{parseDateTime}} instead.
##'
##'
##' @export parse_date
##' @param x -
##' @param formats -
##' @param quiet -
##' @param seps -
##' @param tz - 
parse_date <- function(x, formats, quiet = FALSE, seps = NULL, tz = "UTC") {

  stop("Internal function parse_date has been removed from lubridate package. Plese use parseDateTime instead.")
}

## parse.r ends here
