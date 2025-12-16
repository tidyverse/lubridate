# Get/set hours component of a date-time

Date-time must be a POSIXct, POSIXlt, Date, Period, chron, yearmon,
yearqtr, zoo, zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts
objects.

## Usage

``` r
hour(x)

hour(x) <- value
```

## Arguments

- x:

  a date-time object

- value:

  numeric value to be assigned to the `hour` component

## Value

the hours element of x as a decimal number

## Examples

``` r
x <- ymd("2012-03-26")
hour(x)
#> [1] 0
hour(x) <- 1
hour(x) <- 25
hour(x) > 2
#> [1] FALSE
```
