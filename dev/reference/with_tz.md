# Get date-time in a different time zone

with_tz returns a date-time as it would appear in a different time zone.
The actual moment of time measured does not change, just the time zone
it is measured in. with_tz defaults to the Universal Coordinated time
zone (UTC) when an unrecognized time zone is inputted. See
[`Sys.timezone()`](https://rdrr.io/r/base/timezones.html) for more
information on how R recognizes time zones.

## Usage

``` r
with_tz(time, tzone = "", ...)

# Default S3 method
with_tz(time, tzone = "", ...)
```

## Arguments

- time:

  a POSIXct, POSIXlt, Date, chron date-time object or a data.frame
  object. When a data.frame all POSIXt elements of a data.frame are
  processed with `with_tz()` and new data.frame is returned.

- tzone:

  a character string containing the time zone to convert to. R must
  recognize the name contained in the string as a time zone on your
  system.

- ...:

  Parameters passed to other methods.

## Value

a POSIXct object in the updated time zone

## See also

[`force_tz()`](https://lubridate.tidyverse.org/dev/reference/force_tz.md)

## Examples

``` r
x <- ymd_hms("2009-08-07 00:00:01", tz = "America/New_York")
with_tz(x, "GMT")
#> [1] "2009-08-07 04:00:01 GMT"
```
