# Is x a length of time?

Is x a length of time?

## Usage

``` r
is.timespan(x)
```

## Arguments

- x:

  an R object

## Value

TRUE if x is a period, interval, duration, or difftime object, FALSE
otherwise.

## See also

[`is.instant()`](https://lubridate.tidyverse.org/dev/reference/is.instant.md),
[`is.duration()`](https://lubridate.tidyverse.org/dev/reference/duration.md),
[`is.difftime()`](https://lubridate.tidyverse.org/dev/reference/is.difftime.md),
[`is.period()`](https://lubridate.tidyverse.org/dev/reference/period.md),
[`is.interval()`](https://lubridate.tidyverse.org/dev/reference/interval.md)

## Examples

``` r
is.timespan(as.Date("2009-08-03")) # FALSE
#> [1] FALSE
is.timespan(duration(second = 1)) # TRUE
#> [1] TRUE
```
