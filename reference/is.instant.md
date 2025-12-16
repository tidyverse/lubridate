# Is x a date-time object?

An instant is a specific moment in time. Most common date-time objects
(e.g, POSIXct, POSIXlt, and Date objects) are instants.

## Usage

``` r
is.instant(x)

is.timepoint(x)
```

## Arguments

- x:

  an R object

## Value

TRUE if x is a POSIXct, POSIXlt, or Date object, FALSE otherwise.

## See also

[`is.timespan()`](https://lubridate.tidyverse.org/reference/is.timespan.md),
[`is.POSIXt()`](https://lubridate.tidyverse.org/reference/posix_utils.md),
[`is.Date()`](https://lubridate.tidyverse.org/reference/date_utils.md)

## Examples

``` r
is.instant(as.Date("2009-08-03")) # TRUE
#> [1] TRUE
is.timepoint(5) # FALSE
#> [1] FALSE
```
