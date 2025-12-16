# Computes attractive axis breaks for date-time data

`pretty_dates()` identifies which unit of time the sub-intervals should
be measured in to provide approximately n breaks, then chooses a
"pretty" length for the sub-intervals and sets start and end points
that 1) span the entire range of the data, and 2) allow the breaks to
occur on important date-times (i.e. on the hour, on the first of the
month, etc.)

## Usage

``` r
pretty_dates(x, n, ...)
```

## Arguments

- x:

  a vector of POSIXct, POSIXlt, Date, or chron date-time objects

- n:

  integer value of the desired number of breaks

- ...:

  additional arguments to pass to function

## Value

a vector of date-times that can be used as axis tick marks or bin breaks

## Examples

``` r
x <- seq.Date(as.Date("2009-08-02"), by = "year", length.out = 2)
pretty_dates(x, 12)
#>  [1] "2009-08-01 UTC" "2009-09-01 UTC" "2009-10-01 UTC"
#>  [4] "2009-11-01 UTC" "2009-12-01 UTC" "2010-01-01 UTC"
#>  [7] "2010-02-01 UTC" "2010-03-01 UTC" "2010-04-01 UTC"
#> [10] "2010-05-01 UTC" "2010-06-01 UTC" "2010-07-01 UTC"
#> [13] "2010-08-01 UTC" "2010-09-01 UTC"
```
