# Get **d**aylight **s**avings **t**ime indicator of a date-time

Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr,
zoo, zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects.

## Usage

``` r
dst(x)
```

## Arguments

- x:

  a date-time object

## Value

A logical. TRUE if DST is in force, FALSE if not, NA if unknown.

## Details

A date-time's daylight savings flag can not be set because it depends on
the date-time's year, month, day, and hour values.

## Examples

``` r
x <- ymd("2012-03-26")
dst(x)
#> [1] FALSE
```
