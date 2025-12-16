# Does date time occur in the am or pm?

Does date time occur in the am or pm?

## Usage

``` r
am(x)

pm(x)
```

## Arguments

- x:

  a date-time object

## Value

TRUE or FALSE depending on whether x occurs in the am or pm

## Examples

``` r
x <- ymd("2012-03-26")
am(x)
#> [1] TRUE
pm(x)
#> [1] FALSE
```
