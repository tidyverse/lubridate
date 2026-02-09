# Converts a decimal to a date

Converts a decimal to a date

## Usage

``` r
date_decimal(decimal, tz = "UTC")
```

## Arguments

- decimal:

  a numeric object

- tz:

  the time zone required

## Value

a POSIXct object, whose year corresponds to the integer part of decimal.
The months, days, hours, minutes and seconds elements are picked so the
date-time will accurately represent the fraction of the year expressed
by decimal.

## Examples

``` r
date <- ymd("2009-02-10")
decimal <- decimal_date(date) # 2009.11
date_decimal(decimal) # "2009-02-10 UTC"
#> [1] "2009-02-10 UTC"
```
