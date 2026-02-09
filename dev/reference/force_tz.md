# Replace time zone to create new date-time

`force_tz` returns the date-time that has the same clock time as input
time, but in the new time zone. `force_tzs` is the parallel version of
`force_tz`, meaning that every element from `time` argument is matched
with the corresponding time zone in `tzones` argument.

## Usage

``` r
force_tz(time, tzone = "", ...)

# Default S3 method
force_tz(time, tzone = "", roll_dst = c("NA", "post"), roll = NULL, ...)

force_tzs(
  time,
  tzones,
  tzone_out = "UTC",
  roll_dst = c("NA", "post"),
  roll = NULL
)
```

## Arguments

- time:

  a POSIXct, POSIXlt, Date, chron date-time object, or a data.frame
  object. When a data.frame all POSIXt elements of a data.frame are
  processed with `force_tz()` and new data.frame is returned.

- tzone:

  a character string containing the time zone to convert to. R must
  recognize the name contained in the string as a time zone on your
  system.

- ...:

  Parameters passed to other methods.

- roll_dst:

  is a string vector of length one or two. When two values are supplied
  they specify how to roll date-times when they fall into "skipped" and
  "repeated" DST transitions respectively. A single value is replicated
  to the length of two. Possible values are:

      * `pre` - Use the time before the transition boundary.
      * `boundary` - Use the time exactly at the boundary transition.
      * `post` - Use the time after the boundary transition.
      * `xfirst` - crossed-first: First time which occurred when crossing the
         boundary. For addition with positive units pre interval is crossed first and
         post interval last. With negative units post interval is crossed first, pre -
         last. For subtraction the logic is reversed.
      * `xlast` - crossed-last.
      * `NA` - Produce NAs when the resulting time falls inside the problematic interval.

  For example \`roll_dst = c("NA", "pre") indicates that for skipped
  intervals return NA and for repeated times return the earlier time.

  When multiple units are supplied the meaning of "negative period" is
  determined by the largest unit. For example
  `time_add(t, days = -1, hours = 2, roll_dst = "xfirst")` would operate
  as if with negative period, thus crossing the boundary from the "post"
  to "pre" side and "xfirst" and hence resolving to "post" time. As this
  might result in confusing behavior. See examples.

  "xfirst" and "xlast" make sense for addition and subtraction only. An
  error is raised if an attempt is made to use them with other
  functions.

- roll:

  deprecated, same as `roll_dst` parameter.

- tzones:

  character vector of timezones to be "enforced" on `time` time stamps.
  If `time` and `tzones` lengths differ, the smaller one is recycled in
  accordance with usual R conventions.

- tzone_out:

  timezone of the returned date-time vector (for `force_tzs`).

## Value

a POSIXct object in the updated time zone

## Details

Although the new date-time has the same clock time (e.g. the same values
in the year, month, days, etc. elements) it is a different moment of
time than the input date-time.

As R date-time vectors cannot hold elements with non-uniform time zones,
`force_tzs` returns a vector with time zone `tzone_out`, UTC by default.

## See also

[`with_tz()`](https://lubridate.tidyverse.org/dev/reference/with_tz.md),
[`local_time()`](https://lubridate.tidyverse.org/dev/reference/local_time.md)

## Examples

``` r
x <- ymd_hms("2009-08-07 00:00:01", tz = "America/New_York")
force_tz(x, "UTC")
#> [1] "2009-08-07 00:00:01 UTC"
force_tz(x, "Europe/Amsterdam")
#> [1] "2009-08-07 00:00:01 CEST"

## DST skip:
y <- ymd_hms("2010-03-14 02:05:05 UTC")
force_tz(y, "America/New_York", roll_dst = "NA")
#> [1] NA
force_tz(y, "America/New_York", roll_dst = "pre")
#> [1] "2010-03-14 01:05:05 EST"
force_tz(y, "America/New_York", roll_dst = "boundary")
#> [1] "2010-03-14 03:00:00 EDT"
force_tz(y, "America/New_York", roll_dst = "post")
#> [1] "2010-03-14 03:05:05 EDT"

## DST repeat
y <- ymd_hms("2014-11-02 01:35:00", tz = "UTC")
force_tz(y, "America/New_York", roll_dst = "NA")
#> [1] NA
force_tz(y, "America/New_York", roll_dst = "pre")
#> [1] "2014-11-02 01:35:00 EDT"
force_tz(y, "America/New_York", roll_dst = "boundary")
#> [1] "2014-11-02 01:00:00 EST"
force_tz(y, "America/New_York", roll_dst = "post")
#> [1] "2014-11-02 01:35:00 EST"

## DST skipped and repeated
y <- ymd_hms("2010-03-14 02:05:05 UTC", "2014-11-02 01:35:00", tz = "UTC")
force_tz(y, "America/New_York", roll_dst = c("NA", "pre"))
#> [1] NA                        "2014-11-02 01:35:00 EDT"
force_tz(y, "America/New_York", roll_dst = c("boundary", "post"))
#> [1] "2010-03-14 03:00:00 EDT" "2014-11-02 01:35:00 EST"

## Heterogeneous time-zones:

x <- ymd_hms(c("2009-08-07 00:00:01", "2009-08-07 01:02:03"))
force_tzs(x, tzones = c("America/New_York", "Europe/Amsterdam"))
#> [1] "2009-08-07 04:00:01 UTC" "2009-08-06 23:02:03 UTC"
force_tzs(x, tzones = c("America/New_York", "Europe/Amsterdam"), tzone_out = "America/New_York")
#> [1] "2009-08-07 00:00:01 EDT" "2009-08-06 19:02:03 EDT"

x <- ymd_hms("2009-08-07 00:00:01")
force_tzs(x, tzones = c("America/New_York", "Europe/Amsterdam"))
#> [1] "2009-08-07 04:00:01 UTC" "2009-08-06 22:00:01 UTC"
```
