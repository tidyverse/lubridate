# Get/set time zone component of a date-time

Conveniently get and set the time zone of a date-time.

`tz<-` is an alias for
[`force_tz()`](https://lubridate.tidyverse.org/reference/force_tz.md),
which preserves the local time, creating a different instant in time.
Use [`with_tz()`](https://lubridate.tidyverse.org/reference/with_tz.md)
if you want keep the instant the same, but change the printed
representation.

## Usage

``` r
tz(x)

tz(x) <- value
```

## Arguments

- x:

  A date-time vector, usually of class `POSIXct` or `POSIXlt`.

- value:

  New value of time zone.

## Value

A character vector of length 1. An empty string (`""`) represents your
current time zone.

For backward compatibility, the time zone of a date, `NA`, or character
vector is `"UTC"`.

## Valid time zones

Time zones are stored in system specific database, so are not guaranteed
to be the same on every system (however, they are usually pretty similar
unless your system is very out of date). You can see a complete list
with [`OlsonNames()`](https://rdrr.io/r/base/timezones.html).

## See also

See [DateTimeClasses](https://rdrr.io/r/base/DateTimeClasses.html) for a
description of the underlying `tzone` attribute..

## Examples

``` r
x <- y <- ymd_hms("2012-03-26 10:10:00", tz = "UTC")
tz(x)
#> [1] "UTC"

# Note that setting tz() preserved the clock time, which implies
# that the actual instant in time is changing
tz(y) <- "Pacific/Auckland"
y
#> [1] "2012-03-26 10:10:00 NZDT"
x - y
#> Time difference of 13 hours

# This is the same as force_tz()
force_tz(x, "Pacific/Auckland")
#> [1] "2012-03-26 10:10:00 NZDT"

# Use with_tz() if you want to change the time zone, leave
# the instant in time the same
with_tz(x, "Pacific/Auckland")
#> [1] "2012-03-26 23:10:00 NZDT"
```
