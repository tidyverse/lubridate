# Get/set minutes component of a date-time

Date-time must be a POSIXct, POSIXlt, Date, Period, chron, yearmon,
yearqtr, zoo, zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts
objects.

## Usage

``` r
minute(x)

minute(x) <- value
```

## Arguments

- x:

  a date-time object

- value:

  numeric value to be assigned

## Value

the minutes element of x as a decimal number

## Examples

``` r
x <- ymd("2012-03-26")
minute(x)
#> [1] 0
minute(x) <- 1
minute(x) <- 61
minute(x) > 2
#> [1] FALSE
```
