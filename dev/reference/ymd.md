# Parse dates with **y**ear, **m**onth, and **d**ay components

Transforms dates stored in character and numeric vectors to Date or
POSIXct objects (see `tz` argument). These functions recognize arbitrary
non-digit separators as well as no separator. As long as the order of
formats is correct, these functions will parse dates correctly even when
the input vectors contain differently formatted dates. See examples.

## Usage

``` r
ymd(
  ...,
  quiet = FALSE,
  tz = NULL,
  locale = Sys.getlocale("LC_TIME"),
  truncated = 0
)

ydm(
  ...,
  quiet = FALSE,
  tz = NULL,
  locale = Sys.getlocale("LC_TIME"),
  truncated = 0
)

mdy(
  ...,
  quiet = FALSE,
  tz = NULL,
  locale = Sys.getlocale("LC_TIME"),
  truncated = 0
)

myd(
  ...,
  quiet = FALSE,
  tz = NULL,
  locale = Sys.getlocale("LC_TIME"),
  truncated = 0
)

dmy(
  ...,
  quiet = FALSE,
  tz = NULL,
  locale = Sys.getlocale("LC_TIME"),
  truncated = 0
)

dym(
  ...,
  quiet = FALSE,
  tz = NULL,
  locale = Sys.getlocale("LC_TIME"),
  truncated = 0
)

yq(..., quiet = FALSE, tz = NULL, locale = Sys.getlocale("LC_TIME"))

ym(..., quiet = FALSE, tz = NULL, locale = Sys.getlocale("LC_TIME"))

my(..., quiet = FALSE, tz = NULL, locale = Sys.getlocale("LC_TIME"))
```

## Arguments

- ...:

  a character or numeric vector of suspected dates

- quiet:

  logical. If `TRUE`, function evaluates without displaying customary
  messages.

- tz:

  Time zone indicator. If `NULL` (default), a Date object is returned.
  Otherwise a POSIXct with time zone attribute set to `tz`.

- locale:

  locale to be used, see [locales](https://rdrr.io/r/base/locales.html).
  On Linux systems you can use `system("locale -a")` to list all the
  installed locales.

- truncated:

  integer. Number of formats that can be truncated.

## Value

a vector of class POSIXct if `tz` argument is non-`NULL` or Date if tz
is `NULL` (default)

## Details

In case of heterogeneous date formats, the `ymd()` family guesses
formats based on a subset of the input vector. If the input vector
contains many missing values or non-date strings, the subset might not
contain meaningful dates and the date-time format won't be guessed
resulting in `All formats failed to parse` error. In such cases please
see
[`parse_date_time()`](https://lubridate.tidyverse.org/dev/reference/parse_date_time.md)
for a more flexible parsing interface.

If the `truncated` parameter is non-zero, the `ymd()` functions also
check for truncated formats. For example, `ymd()` with `truncated = 2`
will also parse incomplete dates like `2012-06` and `2012`.

NOTE: The `ymd()` family of functions is based on
[`parse_date_time()`](https://lubridate.tidyverse.org/dev/reference/parse_date_time.md)
and thus directly drop to the internal C parser for numeric months, but
uses [`base::strptime()`](https://rdrr.io/r/base/strptime.html) for
alphabetic months. This implies that some of
[`base::strptime()`](https://rdrr.io/r/base/strptime.html)'s limitations
are inherited by lubridate's parser. For example, truncated formats
(like `%Y-%b`) will not be parsed. Numeric truncated formats (like
`%Y-%m`) are handled correctly by lubridate's C parser.

As of version 1.3.0, lubridate's parse functions no longer return a
message that displays which format they used to parse their input. You
can change this by setting the `lubridate.verbose` option to `TRUE` with
`options(lubridate.verbose = TRUE)`.

## See also

[`parse_date_time()`](https://lubridate.tidyverse.org/dev/reference/parse_date_time.md)
for an even more flexible low level mechanism.

## Examples

``` r
x <- c("09-01-01", "09-01-02", "09-01-03")
ymd(x)
#> [1] "2009-01-01" "2009-01-02" "2009-01-03"
x <- c("2009-01-01", "2009-01-02", "2009-01-03")
ymd(x)
#> [1] "2009-01-01" "2009-01-02" "2009-01-03"
ymd(090101, 90102)
#> [1] "2009-01-01" "2009-01-02"
now() > ymd(20090101)
#> [1] TRUE
## TRUE
dmy(010210)
#> [1] "2010-02-01"
mdy(010210)
#> [1] "2010-01-02"

yq('2014.2')
#> [1] "2014-04-01"

## heterogeneous formats in a single vector:
x <- c(20090101, "2009-01-02", "2009 01 03", "2009-1-4",
       "2009-1, 5", "Created on 2009 1 6", "200901 !!! 07")
ymd(x)
#> [1] "2009-01-01" "2009-01-02" "2009-01-03" "2009-01-04" "2009-01-05"
#> [6] "2009-01-06" "2009-01-07"

## What lubridate might not handle:

## Extremely weird cases when one of the separators is "" and some of the
## formats are not in double digits might not be parsed correctly:
if (FALSE) ymd("201002-01", "201002-1", "20102-1")
dmy("0312-2010", "312-2010") # \dontrun{}
#> Warning:  1 failed to parse.
#> [1] "2010-12-03" NA          
```
