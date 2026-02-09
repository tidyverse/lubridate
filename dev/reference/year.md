# Get/set years component of a date-time

Date-time must be a POSIXct, POSIXlt, Date, Period or any other object
convertible to POSIXlt.

`isoyear()` returns years according to the ISO 8601 week calendar.

`epiyear()` returns years according to the epidemiological week
calendars.

## Usage

``` r
year(x)

year(x) <- value

isoyear(x)

epiyear(x)
```

## Arguments

- x:

  a date-time object

- value:

  a numeric object

## Value

the years element of x as a decimal number

## Details

year does not yet support years before 0 C.E.

## References

<https://en.wikipedia.org/wiki/ISO_week_date>

## Examples

``` r
x <- ymd("2012-03-26")
year(x)
#> [1] 2012
year(x) <- 2001
year(x) > 1995
#> [1] TRUE
```
