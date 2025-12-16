# Is x a difftime object?

Is x a difftime object?

## Usage

``` r
is.difftime(x)
```

## Arguments

- x:

  an R object

## Value

TRUE if x is a difftime object, FALSE otherwise.

## See also

[`is.instant()`](https://lubridate.tidyverse.org/reference/is.instant.md),
[`is.timespan()`](https://lubridate.tidyverse.org/reference/is.timespan.md),
[`is.interval()`](https://lubridate.tidyverse.org/reference/interval.md),
[`is.period()`](https://lubridate.tidyverse.org/reference/period.md).

## Examples

``` r
is.difftime(as.Date("2009-08-03")) # FALSE
#> [1] FALSE
is.difftime(make_difftime(days = 12.4)) # TRUE
#> [1] TRUE
```
