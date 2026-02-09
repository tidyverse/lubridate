# Get/set date component of a date-time

Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr,
zoo, zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects.

## Usage

``` r
date(x)

date(x) <- value
```

## Arguments

- x:

  a date-time object

- value:

  an object for which the `date()` function is defined

## Value

the date of x as a Date

## Details

`date()` does not yet support years before 0 C.E. Also `date()` is not
defined for Period objects.

## Base compatibility

`date()` can be called without any arguments to return a string
representing the current date-time. This provides compatibility with
`base:date()` which it overrides.

## Examples

``` r
x <- ymd_hms("2012-03-26 23:12:13", tz = "America/New_York")
date(x)
#> [1] "2012-03-26"
as.Date(x) # by default as.Date assumes you want to know the date in UTC
#> [1] "2012-03-27"
as.Date(x, tz = "America/New_York")
#> [1] "2012-03-26"
date(x) <- as.Date("2000-01-02")
x
#> [1] "2000-01-02 23:12:13 EST"
```
