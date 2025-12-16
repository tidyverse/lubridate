# Change an object to an `interval`

as.interval changes difftime, Duration, Period and numeric class objects
to intervals that begin at the specified date-time. Numeric objects are
first coerced to timespans equal to the numeric value in seconds.

## Usage

``` r
as.interval(x, start, ...)
```

## Arguments

- x:

  a duration, difftime, period, or numeric object that describes the
  length of the interval

- start:

  a POSIXt or Date object that describes when the interval begins

- ...:

  additional arguments to pass to as.interval

## Value

an interval object

## Details

as.interval can be used to create accurate transformations between
Period objects, which measure time spans in variable length units, and
Duration objects, which measure timespans as an exact number of seconds.
A start date- time must be supplied to make the conversion. Lubridate
uses this start date to look up how many seconds each variable length
unit (e.g. month, year) lasted for during the time span described. See
[`as.duration()`](https://lubridate.tidyverse.org/reference/as.duration.md),
[`as.period()`](https://lubridate.tidyverse.org/reference/as.period.md).

## See also

[`interval()`](https://lubridate.tidyverse.org/reference/interval.md)

## Examples

``` r
diff <- make_difftime(days = 31) # difftime
as.interval(diff, ymd("2009-01-01"))
#> [1] 2009-01-01 UTC--2009-02-01 UTC
as.interval(diff, ymd("2009-02-01"))
#> [1] 2009-02-01 UTC--2009-03-04 UTC

dur <- duration(days = 31) # duration
as.interval(dur, ymd("2009-01-01"))
#> [1] 2009-01-01 UTC--2009-02-01 UTC
as.interval(dur, ymd("2009-02-01"))
#> [1] 2009-02-01 UTC--2009-03-04 UTC

per <- period(months = 1) # period
as.interval(per, ymd("2009-01-01"))
#> [1] 2009-01-01 UTC--2009-02-01 UTC
as.interval(per, ymd("2009-02-01"))
#> [1] 2009-02-01 UTC--2009-03-01 UTC

as.interval(3600, ymd("2009-01-01")) # numeric
#> [1] 2009-01-01 UTC--2018-11-10 UTC
```
