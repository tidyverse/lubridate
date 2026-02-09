# Parse date-times with **y**ear, **m**onth, and **d**ay, **h**our, **m**inute, and **s**econd components.

Transform dates stored as character or numeric vectors to POSIXct
objects. The `ymd_hms()` family of functions recognizes all
non-alphanumeric separators (with the exception of "." if `frac = TRUE`)
and correctly handles heterogeneous date-time representations. For more
flexibility in treatment of heterogeneous formats, see low level parser
[`parse_date_time()`](https://lubridate.tidyverse.org/dev/reference/parse_date_time.md).

## Usage

``` r
ymd_hms(
  ...,
  quiet = FALSE,
  tz = "UTC",
  locale = Sys.getlocale("LC_TIME"),
  truncated = 0
)

ymd_hm(
  ...,
  quiet = FALSE,
  tz = "UTC",
  locale = Sys.getlocale("LC_TIME"),
  truncated = 0
)

ymd_h(
  ...,
  quiet = FALSE,
  tz = "UTC",
  locale = Sys.getlocale("LC_TIME"),
  truncated = 0
)

dmy_hms(
  ...,
  quiet = FALSE,
  tz = "UTC",
  locale = Sys.getlocale("LC_TIME"),
  truncated = 0
)

dmy_hm(
  ...,
  quiet = FALSE,
  tz = "UTC",
  locale = Sys.getlocale("LC_TIME"),
  truncated = 0
)

dmy_h(
  ...,
  quiet = FALSE,
  tz = "UTC",
  locale = Sys.getlocale("LC_TIME"),
  truncated = 0
)

mdy_hms(
  ...,
  quiet = FALSE,
  tz = "UTC",
  locale = Sys.getlocale("LC_TIME"),
  truncated = 0
)

mdy_hm(
  ...,
  quiet = FALSE,
  tz = "UTC",
  locale = Sys.getlocale("LC_TIME"),
  truncated = 0
)

mdy_h(
  ...,
  quiet = FALSE,
  tz = "UTC",
  locale = Sys.getlocale("LC_TIME"),
  truncated = 0
)

ydm_hms(
  ...,
  quiet = FALSE,
  tz = "UTC",
  locale = Sys.getlocale("LC_TIME"),
  truncated = 0
)

ydm_hm(
  ...,
  quiet = FALSE,
  tz = "UTC",
  locale = Sys.getlocale("LC_TIME"),
  truncated = 0
)

ydm_h(
  ...,
  quiet = FALSE,
  tz = "UTC",
  locale = Sys.getlocale("LC_TIME"),
  truncated = 0
)
```

## Arguments

- ...:

  a character vector of dates in year, month, day, hour, minute, second
  format

- quiet:

  logical. If `TRUE`, function evaluates without displaying customary
  messages.

- tz:

  a character string that specifies which time zone to parse the date
  with. The string must be a time zone that is recognized by the user's
  OS.

- locale:

  locale to be used, see [locales](https://rdrr.io/r/base/locales.html).
  On Linux systems you can use `system("locale -a")` to list all the
  installed locales.

- truncated:

  integer, indicating how many formats can be missing. See details.

## Value

a vector of
[POSIXct](https://lubridate.tidyverse.org/dev/reference/posix_utils.md)
date-time objects

## Details

The `ymd_hms()` functions automatically assign the Universal Coordinated
Time Zone (UTC) to the parsed date. This time zone can be changed with
[`force_tz()`](https://lubridate.tidyverse.org/dev/reference/force_tz.md).

The most common type of irregularity in date-time data is the truncation
due to rounding or unavailability of the time stamp. If the `truncated`
parameter is non-zero, the `ymd_hms()` functions also check for
truncated formats. For example, `ymd_hms()` with `truncated = 3` will
also parse incomplete dates like `2012-06-01 12:23`, `2012-06-01 12` and
`2012-06-01`. NOTE: The
[`ymd()`](https://lubridate.tidyverse.org/dev/reference/ymd.md) family
of functions is based on
[`base::strptime()`](https://rdrr.io/r/base/strptime.html) which
currently fails to parse `%y-%m` formats.

In case of heterogeneous date formats the `ymd_hms()` family guesses
formats based on a subset of the input vector. If the input vector
contains many missing values or non-date strings, the subset might not
contain meaningful dates and the date-time format won't be guessed
resulting in `All formats failed to parse` error. In such cases please
see
[`parse_date_time()`](https://lubridate.tidyverse.org/dev/reference/parse_date_time.md)
for a more flexible parsing interface.

As of version 1.3.0, lubridate's parse functions no longer return a
message that displays which format they used to parse their input. You
can change this by setting the `lubridate.verbose` option to `TRUE` with
`options(lubridate.verbose = TRUE)`.

## See also

- [`ymd()`](https://lubridate.tidyverse.org/dev/reference/ymd.md),
  [`hms()`](https://lubridate.tidyverse.org/dev/reference/hms.md)

- [`parse_date_time()`](https://lubridate.tidyverse.org/dev/reference/parse_date_time.md)
  for the underlying mechanism

## Examples

``` r
x <- c("2010-04-14-04-35-59", "2010-04-01-12-00-00")
ymd_hms(x)
#> [1] "2010-04-14 04:35:59 UTC" "2010-04-01 12:00:00 UTC"
x <- c("2011-12-31 12:59:59", "2010-01-01 12:00:00")
ymd_hms(x)
#> [1] "2011-12-31 12:59:59 UTC" "2010-01-01 12:00:00 UTC"


## ** heterogeneous formats **
x <- c(20100101120101, "2009-01-02 12-01-02", "2009.01.03 12:01:03",
       "2009-1-4 12-1-4",
       "2009-1, 5 12:1, 5",
       "200901-08 1201-08",
       "2009 arbitrary 1 non-decimal 6 chars 12 in between 1 !!! 6",
       "OR collapsed formats: 20090107 120107 (as long as prefixed with zeros)",
       "Automatic wday, Thu, detection, 10-01-10 10:01:10 and p format: AM",
       "Created on 10-01-11 at 10:01:11 PM")
ymd_hms(x)
#>  [1] "2010-01-01 12:01:01 UTC" "2009-01-02 12:01:02 UTC"
#>  [3] "2009-01-03 12:01:03 UTC" "2009-01-04 12:01:04 UTC"
#>  [5] "2009-01-05 12:01:05 UTC" "2009-01-08 12:01:08 UTC"
#>  [7] "2009-01-06 12:01:06 UTC" "2009-01-07 12:01:07 UTC"
#>  [9] "2010-01-10 10:01:10 UTC" "2010-01-11 22:01:11 UTC"

## ** fractional seconds **
op <- options(digits.secs=3)
dmy_hms("20/2/06 11:16:16.683")
#> [1] "2006-02-20 11:16:16.683 UTC"
options(op)

## ** different formats for ISO8601 timezone offset **
ymd_hms(c("2013-01-24 19:39:07.880-0600",
"2013-01-24 19:39:07.880", "2013-01-24 19:39:07.880-06:00",
"2013-01-24 19:39:07.880-06", "2013-01-24 19:39:07.880Z"))
#> [1] "2013-01-25 01:39:07.88 UTC" "2013-01-24 19:39:07.88 UTC"
#> [3] "2013-01-25 01:39:07.88 UTC" "2013-01-25 01:39:07.88 UTC"
#> [5] "2013-01-24 19:39:07.88 UTC"

## ** internationalization **
if (FALSE) { # \dontrun{
x_RO <- "Ma 2012 august 14 11:28:30 "
  ymd_hms(x_RO, locale = "ro_RO.utf8")
} # }

## ** truncated time-dates **
x <- c("2011-12-31 12:59:59", "2010-01-01 12:11", "2010-01-01 12", "2010-01-01")
ymd_hms(x, truncated = 3)
#> [1] "2011-12-31 12:59:59 UTC" "2010-01-01 12:11:00 UTC"
#> [3] "2010-01-01 12:00:00 UTC" "2010-01-01 00:00:00 UTC"
x <- c("2011-12-31 12:59", "2010-01-01 12", "2010-01-01")
ymd_hm(x, truncated = 2)
#> [1] "2011-12-31 12:59:00 UTC" "2010-01-01 12:00:00 UTC"
#> [3] "2010-01-01 00:00:00 UTC"
## ** What lubridate might not handle **
## Extremely weird cases when one of the separators is "" and some of the
## formats are not in double digits might not be parsed correctly:
if (FALSE) { # \dontrun{
ymd_hm("20100201 07-01", "20100201 07-1", "20100201 7-01")} # }
```
