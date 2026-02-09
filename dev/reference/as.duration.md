# Change an object to a duration

as.duration changes Interval, Period and numeric class objects to
Duration objects. Numeric objects are changed to Duration objects with
the seconds unit equal to the numeric value.

## Usage

``` r
as.duration(x, ...)
```

## Arguments

- x:

  Object to be coerced to a duration

- ...:

  Parameters passed to other methods. Currently unused.

## Value

A duration object

## Details

Durations are exact time measurements, whereas periods are relative time
measurements. See
[Period](https://lubridate.tidyverse.org/dev/reference/Period-class.md).
The length of a period depends on when it occurs. Hence, a one to one
mapping does not exist between durations and periods. When used with a
period object, as.duration provides an inexact estimate of the length of
the period; each time unit is assigned its most common number of
seconds. A period of one month is converted to 2628000 seconds
(approximately 30.42 days). This ensures that 12 months will sum to 365
days, or one normal year. For an exact transformation, first transform
the period to an interval with
[`as.interval()`](https://lubridate.tidyverse.org/dev/reference/as.interval.md).

## See also

[Duration](https://lubridate.tidyverse.org/dev/reference/Duration-class.md),
[`duration()`](https://lubridate.tidyverse.org/dev/reference/duration.md)

## Examples

``` r
span <- interval(ymd("2009-01-01"), ymd("2009-08-01")) # interval
as.duration(span)
#> [1] "18316800s (~30.29 weeks)"
as.duration(10) # numeric
#> [1] "10s"
dur <- duration(hours = 10, minutes = 6)
as.numeric(dur, "hours")
#> [1] 10.1
as.numeric(dur, "minutes")
#> [1] 606
```
