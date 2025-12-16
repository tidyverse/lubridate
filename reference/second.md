# Get/set seconds component of a date-time

Date-time must be a POSIXct, POSIXlt, Date, Period, chron, yearmon,
yearqtr, zoo, zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts
objects.

## Usage

``` r
second(x)

second(x) <- value
```

## Arguments

- x:

  a date-time object

- value:

  numeric value to be assigned

## Value

the seconds element of x as a decimal number

## Examples

``` r
x <- ymd("2012-03-26")
second(x)
#> [1] 0
second(x) <- 1
second(x) <- 61
second(x) > 2
#> [1] FALSE
```
