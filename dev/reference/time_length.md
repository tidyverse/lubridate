# Compute the exact length of a time span

Compute the exact length of a time span

## Usage

``` r
time_length(x, unit = "second")

# S4 method for class 'Interval'
time_length(x, unit = "second")
```

## Arguments

- x:

  a duration, period, difftime or interval

- unit:

  a character string that specifies with time units to use

## Value

the length of the interval in the specified unit. A negative number
connotes a negative interval or duration

## Details

When `x` is an
[Interval](https://lubridate.tidyverse.org/dev/reference/Interval-class.md)
object and `unit` are years or months, `time_length()` takes into
account the fact that all months and years don't have the same number of
days.

When `x` is a
[Duration](https://lubridate.tidyverse.org/dev/reference/Duration-class.md),
[Period](https://lubridate.tidyverse.org/dev/reference/Period-class.md)
or [`difftime()`](https://rdrr.io/r/base/difftime.html) object, length
in months or years is based on their most common lengths in seconds (see
[`timespan()`](https://lubridate.tidyverse.org/dev/reference/timespan.md)).

## See also

[`timespan()`](https://lubridate.tidyverse.org/dev/reference/timespan.md)

## Examples

``` r
int <- interval(ymd("1980-01-01"), ymd("2014-09-18"))
time_length(int, "week")
#> [1] 1811.286

# Exact age
time_length(int, "year")
#> [1] 34.71233

# Age at last anniversary
trunc(time_length(int, "year"))
#> [1] 34

# Example of difference between intervals and durations
int <- interval(ymd("1900-01-01"), ymd("1999-12-31"))
time_length(int, "year")
#> [1] 99.99726
time_length(as.duration(int), "year")
#> [1] 99.99452
```
