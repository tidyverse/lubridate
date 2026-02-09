# Contrive a period to/from a given number of seconds

`period_to_seconds()` approximately converts a period to seconds
assuming there are 365.25 days in a calendar year and 365.25/12 days in
a month.

`seconds_to_period()` create a period that has the maximum number of
non-zero elements (days, hours, minutes, seconds). This computation is
exact because it doesn't involve years or months.

## Usage

``` r
period_to_seconds(x)

seconds_to_period(x)
```

## Arguments

- x:

  A numeric object. The number of seconds to coerce into a period.

## Value

A number (period) that roughly equates to the period (seconds) given.
