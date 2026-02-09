# User friendly date-time parsing functions

`parse_date_time()` parses an input vector into POSIXct date-time
object. It differs from
[`base::strptime()`](https://rdrr.io/r/base/strptime.html) in two
respects. First, it allows specification of the order in which the
formats occur without the need to include separators and the `%` prefix.
Such a formatting argument is referred to as "order". Second, it allows
the user to specify several format-orders to handle heterogeneous
date-time character representations.

`parse_date_time2()` is a fast C parser of numeric orders.

`fast_strptime()` is a fast C parser of numeric formats only that
accepts explicit format arguments, just like
[`base::strptime()`](https://rdrr.io/r/base/strptime.html).

## Usage

``` r
parse_date_time(
  x,
  orders,
  tz = "UTC",
  truncated = 0,
  quiet = FALSE,
  locale = Sys.getlocale("LC_TIME"),
  select_formats = .select_formats,
  exact = FALSE,
  train = TRUE,
  drop = FALSE
)

parse_date_time2(
  x,
  orders,
  tz = "UTC",
  exact = FALSE,
  lt = FALSE,
  cutoff_2000 = 68L
)

fast_strptime(x, format, tz = "UTC", lt = TRUE, cutoff_2000 = 68L)
```

## Arguments

- x:

  a character or numeric vector of dates

- orders:

  a character vector of date-time formats. Each order string is a series
  of formatting characters as listed in
  [`base::strptime()`](https://rdrr.io/r/base/strptime.html) but might
  not include the `"%"` prefix. For example, "ymd" will match all the
  possible dates in year, month, day order. Formatting orders might
  include arbitrary separators. These are discarded. See details for the
  implemented formats. If multiple order strings are supplied, they are
  applied in turn for `parse_date_time2()` and `fast_strptime()`. For
  `parse_date_time()` the order of applied formats is determined by
  `select_formats` parameter.

- tz:

  a character string that specifies the time zone with which to parse
  the dates

- truncated:

  integer, number of formats that can be missing. The most common type
  of irregularity in date-time data is the truncation due to rounding or
  unavailability of the time stamp. If the `truncated` parameter is
  non-zero `parse_date_time()` also checks for truncated formats. For
  example, if the format order is "ymdHMS" and `truncated = 3`,
  `parse_date_time()` will correctly parse incomplete date-times like
  `2012-06-01 12:23`, `2012-06-01 12` and `2012-06-01`. **NOTE:** The
  [`ymd()`](https://lubridate.tidyverse.org/dev/reference/ymd.md) family
  of functions is based on
  [`base::strptime()`](https://rdrr.io/r/base/strptime.html) which
  currently fails to parse `%Y-%m` formats.

- quiet:

  logical. If `TRUE`, progress messages are not printed, and
  `No formats found` error is suppressed and the function simply returns
  a vector of NAs. This mirrors the behavior of base R functions
  [`base::strptime()`](https://rdrr.io/r/base/strptime.html) and
  [`base::as.POSIXct()`](https://rdrr.io/r/base/as.POSIXlt.html).

- locale:

  locale to be used, see [locales](https://rdrr.io/r/base/locales.html).
  On Linux systems you can use `system("locale -a")` to list all the
  installed locales.

- select_formats:

  A function to select actual formats for parsing from a set of formats
  which matched a training subset of `x`. It receives a named integer
  vector and returns a character vector of selected formats. Names of
  the input vector are formats (not orders) that matched the training
  set. Numeric values are the number of dates (in the training set) that
  matched the corresponding format. You should use this argument if the
  default selection method fails to select the formats in the right
  order. By default the formats with most formatting tokens (`%`) are
  selected and `%Y` counts as 2.5 tokens (so that it has a priority over
  `%y%m`). See examples.

- exact:

  logical. If `TRUE`, the `orders` parameter is interpreted as an exact
  [`base::strptime()`](https://rdrr.io/r/base/strptime.html) format and
  no training or guessing are performed (i.e. `train`, `drop` parameters
  are ignored).

- train:

  logical, default `TRUE`. Whether to train formats on a subset of the
  input vector. As a result the supplied orders are sorted according to
  performance on this training set, which commonly results in increased
  performance. Please note that even when `train = FALSE` (and
  `exact = FALSE`) guessing of the actual formats is still performed on
  the training set (a pseudo-random subset of the original input
  vector). This might result in `All formats failed to parse` error. See
  notes below.

- drop:

  logical, default `FALSE`. Whether to drop formats that didn't match on
  the training set. If `FALSE`, unmatched on the training set formats
  are tried as a last resort at the end of the parsing queue. Applies
  only when `train = TRUE`. Setting this parameter to `TRUE` might
  slightly speed up parsing in situations involving many formats. Prior
  to v1.7.0 this parameter was implicitly `TRUE`, which resulted in
  occasional surprising behavior when rare patterns where not present in
  the training set.

- lt:

  logical. If `TRUE`, returned object is of class POSIXlt, and POSIXct
  otherwise. For compatibility with
  [`base::strptime()`](https://rdrr.io/r/base/strptime.html) the default
  is `TRUE` for `fast_strptime()` and `FALSE` for `parse_date_time2()`.

- cutoff_2000:

  integer. For `y` format, two-digit numbers smaller or equal to
  `cutoff_2000` are parsed as though starting with `20`, otherwise
  parsed as though starting with `19`. Available only for functions
  relying on `lubridate`s internal parser.

- format:

  a vector of formats. If multiple formats supplied they are applied in
  turn till success. The formats should include all the separators and
  each format letter must be prefixed with %, just as in the format
  argument of
  [`base::strptime()`](https://rdrr.io/r/base/strptime.html).

## Value

a vector of POSIXct date-time objects

## Details

When several format-orders are specified, `parse_date_time()` selects
(guesses) format-orders based on a training subset of the input strings.
After guessing the formats are ordered according to the performance on
the training set and applied recursively on the entire input vector. You
can disable training with `train = FALSE`.

`parse_date_time()`, and all derived functions, such as
[`ymd_hms()`](https://lubridate.tidyverse.org/dev/reference/ymd_hms.md),
[`ymd()`](https://lubridate.tidyverse.org/dev/reference/ymd.md), etc.,
will drop into `fast_strptime()` instead of
[`base::strptime()`](https://rdrr.io/r/base/strptime.html) whenever the
guessed from the input data formats are all numeric.

The list below contains formats recognized by lubridate. For numeric
formats leading 0s are optional. As compared to
[`base::strptime()`](https://rdrr.io/r/base/strptime.html), some of the
formats are new or have been extended for efficiency reasons. These
formats are marked with "(\*)" below. Fast parsers `parse_date_time2()`
and `fast_strptime()` accept only formats marked with "(!)".

- `a`:

  Abbreviated weekday name in the current locale. (Also matches full
  name)

- `A`:

  Full weekday name in the current locale. (Also matches abbreviated
  name).

  You don't need to specify `a` and `A` formats explicitly. Wday is
  automatically handled if `preproc_wday = TRUE`

- `b` (!):

  Abbreviated or full month name in the current locale. The C parser
  currently understands only English month names.

- `B` (!):

  Same as b.

- `d` (!):

  Day of the month as decimal number (01–31 or 0–31)

- `H` (!):

  Hours as decimal number (00–24 or 0–24).

- `I` (!):

  Hours as decimal number (01–12 or 1–12).

- `j`:

  Day of year as decimal number (001–366 or 1–366).

- `q` (!\*):

  Quarter (1–4). The quarter month is added to the parsed month if `m`
  element is present.

- `m` (!\*):

  Month as decimal number (01–12 or 1–12). For `parse_date_time` also
  matches abbreviated and full months names as `b` and `B` formats. C
  parser understands only English month names.

- `M` (!):

  Minute as decimal number (00–59 or 0–59).

- `p` (!):

  AM/PM indicator in the locale. Commonly used in conjunction with `I`
  and **not** with `H`. But lubridate's C parser accepts H format as
  long as hour is not greater than 12. C parser understands only English
  locale AM/PM indicator.

- `S` (!):

  Second as decimal number (00–61 or 0–61), allowing for up to two
  leap-seconds (but POSIX-compliant implementations will ignore leap
  seconds).

- `OS`:

  Fractional second.

- `U`:

  Week of the year as decimal number (00–53 or 0–53) using Sunday as the
  first day 1 of the week (and typically with the first Sunday of the
  year as day 1 of week 1). The US convention.

- `w`:

  Weekday as decimal number (0–6, Sunday is 0).

- `W`:

  Week of the year as decimal number (00–53 or 0–53) using Monday as the
  first day of week (and typically with the first Monday of the year as
  day 1 of week 1). The UK convention.

- `y` (!\*):

  Year without century (00–99 or 0–99). In `parse_date_time()` also
  matches year with century (Y format).

- `Y` (!):

  Year with century.

- `z` (!\*):

  ISO8601 signed offset in hours and minutes from UTC. For example
  `-0800`, `-08:00` or `-08`, all represent 8 hours behind UTC. This
  format also matches the Z (Zulu) UTC indicator. Because
  [`base::strptime()`](https://rdrr.io/r/base/strptime.html) doesn't
  fully support ISO8601 this format is implemented as an union of 4
  formats: Ou (Z), Oz (-0800), OO (-08:00) and Oo (-08). You can use
  these formats as any other but it is rarely necessary.
  `parse_date_time2()` and `fast_strptime()` support all of these
  formats.

- `Om` (!\*):

  Matches numeric month and English alphabetic months (Both, long and
  abbreviated forms).

- `Op` (!\*):

  Matches AM/PM English indicator.

- `r` (\*):

  Matches `Ip` and `H` orders.

- `R` (\*):

  Matches `HM` and`IMp` orders.

- `T` (\*):

  Matches `IMSp`, `HMS`, and `HMOS` orders.

## Note

`parse_date_time()` (and the derivatives
[`ymd()`](https://lubridate.tidyverse.org/dev/reference/ymd.md),
[`ymd_hms()`](https://lubridate.tidyverse.org/dev/reference/ymd_hms.md),
etc.) relies on a sparse guesser that takes at most 501 elements from
the supplied character vector in order to identify appropriate formats
from the supplied orders. If you get the error
`All formats failed to parse` and you are confident that your vector
contains valid dates, you should either set `exact` argument to `TRUE`
or use functions that don't perform format guessing (`fast_strptime()`,
`parse_date_time2()` or
[`base::strptime()`](https://rdrr.io/r/base/strptime.html)).

For performance reasons, when timezone is not UTC, `parse_date_time2()`
and `fast_strptime()` perform no validity checks for daylight savings
time. Thus, if your input string contains an invalid date time which
falls into DST gap and `lt = TRUE` you will get an `POSIXlt` object with
a non-existent time. If `lt = FALSE` your time instant will be adjusted
to a valid time by adding an hour. See examples. If you want to get NA
for invalid date-times use
[`fit_to_timeline()`](https://lubridate.tidyverse.org/dev/reference/fit_to_timeline.md)
explicitly.

## See also

[`base::strptime()`](https://rdrr.io/r/base/strptime.html),
[`ymd()`](https://lubridate.tidyverse.org/dev/reference/ymd.md),
[`ymd_hms()`](https://lubridate.tidyverse.org/dev/reference/ymd_hms.md)

## Examples

``` r
## ** orders are much easier to write **
x <- c("09-01-01", "09-01-02", "09-01-03")
parse_date_time(x, "ymd")
#> [1] "2009-01-01 UTC" "2009-01-02 UTC" "2009-01-03 UTC"
parse_date_time(x, "y m d")
#> [1] "2009-01-01 UTC" "2009-01-02 UTC" "2009-01-03 UTC"
parse_date_time(x, "%y%m%d")
#> [1] "2009-01-01 UTC" "2009-01-02 UTC" "2009-01-03 UTC"
#  "2009-01-01 UTC" "2009-01-02 UTC" "2009-01-03 UTC"

## ** heterogeneous date-times **
x <- c("09-01-01", "090102", "09-01 03", "09-01-03 12:02")
parse_date_time(x, c("ymd", "ymd HM"))
#> [1] "2009-01-01 00:00:00 UTC" "2009-01-02 00:00:00 UTC"
#> [3] "2009-01-03 00:00:00 UTC" "2009-01-03 12:02:00 UTC"

## ** different ymd orders **
x <- c("2009-01-01", "02022010", "02-02-2010")
parse_date_time(x, c("dmY", "ymd"))
#> [1] "2009-01-01 UTC" "2010-02-02 UTC" "2010-02-02 UTC"
##  "2009-01-01 UTC" "2010-02-02 UTC" "2010-02-02 UTC"

## ** truncated time-dates **
x <- c("2011-12-31 12:59:59", "2010-01-01 12:11", "2010-01-01 12", "2010-01-01")
parse_date_time(x, "Ymd HMS", truncated = 3)
#> [1] "2011-12-31 12:59:59 UTC" "2010-01-01 12:11:00 UTC"
#> [3] "2010-01-01 12:00:00 UTC" "2010-01-01 00:00:00 UTC"

## ** specifying exact formats and avoiding training and guessing **
parse_date_time(x, c("%m-%d-%y", "%m%d%y", "%m-%d-%y %H:%M"), exact = TRUE)
#> Warning:  4 failed to parse.
#> [1] NA NA NA NA
parse_date_time(c('12/17/1996 04:00:00','4/18/1950 0130'),
                c('%m/%d/%Y %I:%M:%S','%m/%d/%Y %H%M'), exact = TRUE)
#> [1] "1996-12-17 04:00:00 UTC" "1950-04-18 01:30:00 UTC"

## ** quarters and partial dates **
parse_date_time(c("2016.2", "2016-04"), orders = "Yq")
#> [1] "2016-04-01 UTC" "2016-10-01 UTC"
parse_date_time(c("2016", "2016-04"), orders = c("Y", "Ym"))
#> [1] "2016-01-01 UTC" "2016-04-01 UTC"

## ** fast parsing **
if (FALSE) { # \dontrun{
  options(digits.secs = 3)
  ## random times between 1400 and 3000
  tt <- as.character(.POSIXct(runif(1000, -17987443200, 32503680000)))
  tt <- rep.int(tt, 1000)

  system.time(out <- as.POSIXct(tt, tz = "UTC"))
  system.time(out1 <- ymd_hms(tt)) # constant overhead on long vectors
  system.time(out2 <- parse_date_time2(tt, "YmdHMOS"))
  system.time(out3 <- fast_strptime(tt, "%Y-%m-%d %H:%M:%OS"))

  all.equal(out, out1)
  all.equal(out, out2)
  all.equal(out, out3)
} # }

## ** how to use `select_formats` argument **
## By default %Y has precedence:
parse_date_time(c("27-09-13", "27-09-2013"), "dmy")
#> [1] "2013-09-27 UTC" "2013-09-27 UTC"

## to give priority to %y format, define your own select_format function:

my_select <-   function(trained, drop=FALSE, ...){
   n_fmts <- nchar(gsub("[^%]", "", names(trained))) + grepl("%y", names(trained))*1.5
   names(trained[ which.max(n_fmts) ])
}

parse_date_time(c("27-09-13", "27-09-2013"), "dmy", select_formats = my_select)
#> [1] "2013-09-27 UTC" "2013-09-27 UTC"

## ** invalid times with "fast" parsing **
parse_date_time("2010-03-14 02:05:06",  "YmdHMS", tz = "America/New_York")
#> Warning:  1 failed to parse.
#> [1] NA
parse_date_time2("2010-03-14 02:05:06",  "YmdHMS", tz = "America/New_York")
#> [1] "2010-03-14 03:05:06 EDT"
parse_date_time2("2010-03-14 02:05:06",  "YmdHMS", tz = "America/New_York", lt = TRUE)
#> [1] "2010-03-14 02:05:06 America/New_York"
```
