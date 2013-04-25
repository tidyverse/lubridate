\name{parse_date_time}
\alias{parse_date_time}
\title{Parse character and numeric date-time vectors with user friendly order
formats.}
\usage{
  parse_date_time(x, orders, tz = "UTC", truncated = 0,
    quiet = FALSE, locale = Sys.getlocale("LC_TIME"),
    select_formats = .select_formats)
}
\arguments{
  \item{x}{a character or numeric vector of dates}

  \item{orders}{a character vector of date-time formats.
  Each order string is series of formatting characters as
  listed \code{\link[base]{strptime}} but might not include
  the "\%" prefix, for example "ymd" will match all the
  possible dates in year, month, day order.  Formatting
  orders might include arbitrary separators. These are
  discarded.  See details for implemented formats.}

  \item{tz}{a character string that specifies the time zone
  with which to parse the dates}

  \item{truncated}{integer, number of formats that can be
  missing. The most common type of irregularity in
  date-time data is the truncation due to rounding or
  unavailability of the time stamp. If \code{truncated}
  parameter is non-zero \code{parse_date_time} also checks
  for truncated formats. For example, if the format order
  is "ymdhms" and \code{truncated = 3},
  \code{parse_date_time} will correctly parse incomplete
  dates like \code{2012-06-01 12:23}, \code{2012-06-01 12}
  and \code{2012-06-01}. \bold{NOTE:} \code{ymd} family of
  functions are based on \code{strptime} which currently
  fails to parse \code{\%y-\%m} formats.}

  \item{quiet}{logical. When TRUE progress messages are not
  printed, and "no formats found" error is surpresed and
  the function simply returns a vector of NAs.  This
  mirrors the behavior of base R functions \code{strptime}
  and \code{as.POSIXct}. Default is FALSE.}

  \item{locale}{locale to be used, see \link{locales}. On
  linux systems you can use \code{system("locale -a")} to
  list all the installed locales.}

  \item{select_formats}{A function to select actual formats
  for parsing from a set of formats which matched a
  training subset of \code{x}. This should be function
  receiving a named integer vector and returning a
  character vector of selected formats. Names of the input
  vector are explicit formats (not orders) which matched
  the training set and numeric values are the number of
  dates which matched the corresponding format. You should
  use this argument if the default selection method fails
  to select the formats in the right order. By default the
  formats with most formating tockens (\%) are selected and
  \%Y counts as 2.5 tockens (so that it can have priority
  over \%y\%m).}
}
\value{
  a vector of POSIXct date-time objects
}
\description{
  As \code{strptime} \code{parse_date_time} parses a
  character vector into POSIXct date-time object but with
  two major differences. First, it allows the user to
  specify only the order in which the formats occur, with
  no need to include separators and "\%" prefix. Second, it
  allows the user to specify several format-orders to
  handle heterogeneous date-time character representations.
  See examples.
}
\details{
  When several format-orders are specified
  \code{parse_date_time} sorts the supplied format-orders
  based on a training set and then applies them recursively
  on the input vector.

  Below are all the implemented formats recognized by
  lubridate. For numeric formats leading 0s are optional.
  All formats are case insensitive.

  As compared to \code{strptime}, some of the formats have
  been extended for efficiency reasons. They are marked
  with "*"

  \describe{ \item{\code{a}}{Abbreviated weekday name in
  the current locale. (Also matches full name)}

  \item{\code{A}}{Full weekday name in the current locale.
  (Also matches abbreviated name).

  You need not specify \code{a} and \code{A} formats
  explicitly. Wday is automatically handled if
  \code{preproc_wday = TRUE}}

  \item{\code{b}}{Abbreviated month name in the current
  locale.  (Also matches full name.)} \item{\code{B}}{Full
  month name in the current locale.  (Also matches
  abbreviated name.)}

  \item{\code{d}}{Day of the month as decimal number
  (01--31 or 0--31)} \item{\code{H}}{Hours as decimal
  number (00--24 or 0--24).} \item{\code{I}}{Hours as
  decimal number (01--12 or 0--12).} \item{\code{j}}{Day of
  year as decimal number (001--366 or 1--366).}
  \item{\code{m*}}{Month as decimal number (01--12 or
  1--12). Also matches abbreviated and full months names as
  \code{b} and \code{B} formats} \item{\code{M}}{Minute as
  decimal number (00--59 or 0--59).} \item{\code{p}}{AM/PM
  indicator in the locale.  Used in conjunction with
  \code{I} and \bold{not} with \code{H}.  An empty string
  in some locales.} \item{\code{S}}{Second as decimal
  number (00--61 or 0--61), allowing for up to two
  leap-seconds (but POSIX-compliant implementations will
  ignore leap seconds).} \item{\code{OS}}{Fractional
  second.}

  \item{\code{U}}{Week of the year as decimal number
  (00--53 or 0-53) using Sunday as the first day 1 of the
  week (and typically with the first Sunday of the year as
  day 1 of week 1).  The US convention.}
  \item{\code{w}}{Weekday as decimal number (0--6, Sunday
  is 0).} \item{\code{W}}{Week of the year as decimal
  number (00--53 or 0-53) using Monday as the first day of
  week (and typically with the first Monday of the year as
  day 1 of week 1).  The UK convention.}
  \item{\code{y*}}{Year without century (00--99 or 0--99).
  Also matches year with century (Y format).}
  \item{\code{Y}}{Year with century.}

  \item{\code{z*}}{ISO8601 signed offset in hours and
  minutes from UTC. For example \code{-0800}, \code{-08:00}
  or \code{-08}, all represent 8 hours behind UTC. This
  format also matches the Z (Zulu) UTC indicator. Because
  strptime doesn't fully support ISO8601, lubridate
  represents this format internally as an union of 4
  different orders: Ou (Z), Oz (-0800), OO (-08:00) and Oo
  (-08). You can use this formats as any other but it is
  rarely necessary.}.

  \item{\code{r*}}{Matches \code{Ip} and \code{H} orders.}
  \item{\code{R*}}{Matches \code{HM} and\code{IMp} orders.}
  \item{\code{T*}}{Matches \code{IMSp}, \code{HMS}, and
  \code{HMOS} orders.}

  }
}
\examples{
x <- c("09-01-01", "09-01-02", "09-01-03")
parse_date_time(x, "ymd")
parse_date_time(x, "\%y\%m\%d")
parse_date_time(x, "\%y \%m \%d")
#  "2009-01-01 UTC" "2009-01-02 UTC" "2009-01-03 UTC"

## ** heterogenuous formats **
x <- c("09-01-01", "090102", "09-01 03", "09-01-03 12:02")
parse_date_time(x, c("\%y\%m\%d", "\%y\%m\%d \%H\%M"))

## different ymd orders:
x <- c("2009-01-01", "02022010", "02-02-2010")
parse_date_time(x, c("\%d\%m\%Y", "ymd"))
##  "2009-01-01 UTC" "2010-02-02 UTC" "2010-02-02 UTC"

## ** truncated time-dates **
x <- c("2011-12-31 12:59:59", "2010-01-01 12:11", "2010-01-01 12", "2010-01-01")
parse_date_time(x, "\%Y\%m\%d \%H\%M\%S", truncated = 3)
parse_date_time(x, "ymd_hms", truncated = 3)
## "2011-12-31 12:59:59 UTC" "2010-01-01 12:11:00 UTC" "2010-01-01 12:00:00 UTC" "2010-01-01 00:00:00 UTC"
}
\seealso{
  \code{strptime}, \code{\link{ymd}}, \code{\link{ymd_hms}}
}
\keyword{chron}

