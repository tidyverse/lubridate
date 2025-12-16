# Is a year a leap year?

If x is a recognized date-time object, leap_year will return whether x
occurs during a leap year. If x is a number, leap_year returns whether
it would be a leap year under the Gregorian calendar.

## Usage

``` r
leap_year(date)
```

## Arguments

- date:

  a date-time object or a year

## Value

TRUE if x is a leap year, FALSE otherwise

## Examples

``` r
x <- as.Date("2009-08-02")
leap_year(x) # FALSE
#> [1] FALSE
leap_year(2009) # FALSE
#> [1] FALSE
leap_year(2008) # TRUE
#> [1] TRUE
leap_year(1900) # FALSE
#> [1] FALSE
leap_year(2000) # TRUE
#> [1] TRUE
```
