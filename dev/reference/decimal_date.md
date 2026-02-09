# Converts a date to a decimal of its year

Converts a date to a decimal of its year

## Usage

``` r
decimal_date(date)
```

## Arguments

- date:

  a POSIXt or Date object

## Value

a numeric object where the date is expressed as a fraction of its year

## Examples

``` r
date <- ymd("2009-02-10")
decimal_date(date) # 2009.11
#> [1] 2009.11
```
