# Round, floor and ceiling methods for date-time objects

`round_date()` takes a date-time object and time unit, and rounds it to
the nearest value of the specified time unit. For rounding date-times
which are exactly halfway between two consecutive units, the convention
is to round up. Note that this is in line with the behavior of R's
[`base::round.POSIXt()`](https://rdrr.io/r/base/round.POSIXt.html)
function but does not follow the convention of the base
[`base::round()`](https://rdrr.io/r/base/Round.html) function which
"rounds to the even digit", as per IEC 60559.

Rounding to the nearest unit or multiple of a unit is supported. All
meaningful specifications in the English language are supported - secs,
min, mins, 2 minutes, 3 years etc.

Rounding to fractional seconds is also supported. Please note that
rounding to fractions smaller than 1 second can lead to large precision
errors due to the floating point representation of the POSIXct objects.
See examples.

`floor_date()` takes a date-time object and rounds it down to the
nearest boundary of the specified time unit.

`ceiling_date()` takes a date-time object and rounds it up to the
nearest boundary of the specified time unit.

## Usage

``` r
round_date(
  x,
  unit = "second",
  week_start = getOption("lubridate.week.start", 7)
)

floor_date(
  x,
  unit = "seconds",
  week_start = getOption("lubridate.week.start", 7)
)

ceiling_date(
  x,
  unit = "seconds",
  change_on_boundary = NULL,
  week_start = getOption("lubridate.week.start", 7)
)
```

## Arguments

- x:

  a vector of date-time objects

- unit:

  a string, `Period` object or a date-time object. When a singleton
  string, it specifies a time unit or a multiple of a unit to be rounded
  to. Valid base units are `second`, `minute`, `hour`, `day`, `week`,
  `month`, `bimonth`, `quarter`, `season`, `halfyear` and `year`.
  Arbitrary unique English abbreviations as in the
  [`period()`](https://lubridate.tidyverse.org/dev/reference/period.md)
  constructor are allowed. Rounding to multiples of units (except weeks)
  is supported.

  When `unit` is a `Period` object, it is first converted to a string
  representation which might not be in the same units as the
  constructor. For example `weeks(1)` is converted to "7d 0H 0M 0S".
  Thus, always check the string representation of the period before
  passing to this function.

  When `unit` is a date-time object rounding is done to the nearest of
  the elements in `unit`. If range of `unit` vector does not cover the
  range of `x` `ceiling_date()` and `floor_date()` round to the `max(x)`
  and `min(x)` for elements that fall outside of `range(unit)`.

- week_start:

  week start day (Default is 7, Sunday. Set `lubridate.week.start` to
  override). Full or abbreviated names of the days of the week can be in
  English or as provided by the current locale.

- change_on_boundary:

  if this is `NULL` (the default), instants on the boundary remain
  unchanged, but `Date` objects are rounded up to the next boundary. If
  this is `TRUE`, instants on the boundary are rounded up to the next
  boundary. If this is `FALSE`, nothing on the boundary is rounded up at
  all. This was the default for lubridate prior to `v1.6.0`. See section
  `Rounding Up Date Objects` below for more details.

## Value

When `unit` is a string, return a Date object if `x` is a Date and
`unit` is larger or equal than "day", otherwise a POSIXct object. When
`unit` is a date-time object, return a date-time object of the same
class and same time zone as `unit`.

## Details

In lubridate, functions that round date-time objects try to preserve the
class of the input object whenever possible. This is done by first
rounding to an instant, and then converting to the original class as per
usual R conventions.

## Rounding Up Date Objects

By default, rounding up `Date` objects follows 3 steps:

1.  Convert to an instant representing lower bound of the Date:
    `2000-01-01` –\> `2000-01-01 00:00:00`

2.  Round up to the **next** closest rounding unit boundary. For
    example, if the rounding unit is `month` then next closest boundary
    of `2000-01-01` is `2000-02-01 00:00:00`.

    The motivation for this is that the "partial" `2000-01-01` is
    conceptually an interval (`2000-01-01 00:00:00` –
    `2000-01-02 00:00:00`) and the day hasn't started clocking yet at
    the exact boundary `00:00:00`. Thus, it seems wrong to round a day
    to its lower boundary.

    Behavior on the boundary can be changed by setting
    `change_on_boundary` to `TRUE` or `FALSE`.

3.  If the rounding unit is smaller than a day, return the instant from
    step 2 (`POSIXct`), otherwise convert to and return a `Date` object.

## See also

[`base::round()`](https://rdrr.io/r/base/Round.html)

## Examples

``` r
## print fractional seconds
options(digits.secs = 6)

x <- ymd_hms("2009-08-03 12:01:59.23")
round_date(x, ".5s")
#> [1] "2009-08-03 12:01:59 UTC"
round_date(x, "sec")
#> [1] "2009-08-03 12:01:59 UTC"
round_date(x, "second")
#> [1] "2009-08-03 12:01:59 UTC"
round_date(x, "minute")
#> [1] "2009-08-03 12:02:00 UTC"
round_date(x, "5 mins")
#> [1] "2009-08-03 12:00:00 UTC"
round_date(x, "hour")
#> [1] "2009-08-03 12:00:00 UTC"
round_date(x, "2 hours")
#> [1] "2009-08-03 12:00:00 UTC"
round_date(x, "day")
#> [1] "2009-08-04 UTC"
round_date(x, "week")
#> [1] "2009-08-02 UTC"
round_date(x, "month")
#> [1] "2009-08-01 UTC"
round_date(x, "bimonth")
#> [1] "2009-09-01 UTC"
round_date(x, "quarter") == round_date(x, "3 months")
#> [1] TRUE
round_date(x, "halfyear")
#> [1] "2009-07-01 UTC"
round_date(x, "year")
#> [1] "2010-01-01 UTC"

x <- ymd_hms("2009-08-03 12:01:59.23")
floor_date(x, ".1s")
#> [1] "2009-08-03 12:01:59.2 UTC"
floor_date(x, "second")
#> [1] "2009-08-03 12:01:59 UTC"
floor_date(x, "minute")
#> [1] "2009-08-03 12:01:00 UTC"
floor_date(x, "hour")
#> [1] "2009-08-03 12:00:00 UTC"
floor_date(x, "day")
#> [1] "2009-08-03 UTC"
floor_date(x, "week")
#> [1] "2009-08-02 UTC"
floor_date(x, "month")
#> [1] "2009-08-01 UTC"
floor_date(x, "bimonth")
#> [1] "2009-07-01 UTC"
floor_date(x, "quarter")
#> [1] "2009-07-01 UTC"
floor_date(x, "season")
#> [1] "2009-06-01 UTC"
floor_date(x, "halfyear")
#> [1] "2009-07-01 UTC"
floor_date(x, "year")
#> [1] "2009-01-01 UTC"

x <- ymd_hms("2009-08-03 12:01:59.23")
ceiling_date(x, ".1 sec") # imprecise representation at 0.1 sec !!!
#> [1] "2009-08-03 12:01:59.299999 UTC"
ceiling_date(x, "second")
#> [1] "2009-08-03 12:02:00 UTC"
ceiling_date(x, "minute")
#> [1] "2009-08-03 12:02:00 UTC"
ceiling_date(x, "5 mins")
#> [1] "2009-08-03 12:05:00 UTC"
ceiling_date(x, "hour")
#> [1] "2009-08-03 13:00:00 UTC"
ceiling_date(x, "day")
#> [1] "2009-08-04 UTC"
ceiling_date(x, "week")
#> [1] "2009-08-09 UTC"
ceiling_date(x, "month")
#> [1] "2009-09-01 UTC"
ceiling_date(x, "bimonth") == ceiling_date(x, "2 months")
#> [1] TRUE
ceiling_date(x, "quarter")
#> [1] "2009-10-01 UTC"
ceiling_date(x, "season")
#> [1] "2009-09-01 UTC"
ceiling_date(x, "halfyear")
#> [1] "2010-01-01 UTC"
ceiling_date(x, "year")
#> [1] "2010-01-01 UTC"

## Period unit argument
floor_date(x, days(2))
#> [1] "2009-08-03 UTC"
floor_date(x, years(1))
#> [1] "2009-01-01 UTC"

## As of R 3.4.2 POSIXct printing of fractional numbers is wrong
as.POSIXct("2009-08-03 12:01:59.3") ## -> "2009-08-03 12:01:59.2 CEST"
#> [1] "2009-08-03 12:01:59.299999 UTC"
ceiling_date(x, ".1 sec") ## -> "2009-08-03 12:01:59.2 CEST"
#> [1] "2009-08-03 12:01:59.299999 UTC"

## behaviour of `change_on_boundary`
## As per default behaviour `NULL`, instants on the boundary remain the
## same but dates are rounded up
ceiling_date(ymd_hms("2000-01-01 00:00:00"), "month")
#> [1] "2000-01-01 UTC"
ceiling_date(ymd("2000-01-01"), "month")
#> [1] "2000-02-01"

## If `TRUE`, both instants and dates on the boundary are rounded up
ceiling_date(ymd_hms("2000-01-01 00:00:00"), "month", change_on_boundary = TRUE)
#> [1] "2000-02-01 UTC"
ceiling_date(ymd("2000-01-01"), "month")
#> [1] "2000-02-01"

## If `FALSE`, both instants and dates on the boundary remain the same
ceiling_date(ymd_hms("2000-01-01 00:00:00"), "month", change_on_boundary = FALSE)
#> [1] "2000-01-01 UTC"
ceiling_date(ymd("2000-01-01"), "month")
#> [1] "2000-02-01"

x <- ymd_hms("2000-01-01 00:00:00")
ceiling_date(x, "month")
#> [1] "2000-01-01 UTC"
ceiling_date(x, "month", change_on_boundary = TRUE)
#> [1] "2000-02-01 UTC"

## For Date objects first day of the month is not on the
## "boundary". change_on_boundary applies to instants only.
x <- ymd("2000-01-01")
ceiling_date(x, "month")
#> [1] "2000-02-01"
ceiling_date(x, "month", change_on_boundary = TRUE)
#> [1] "2000-02-01"
```
