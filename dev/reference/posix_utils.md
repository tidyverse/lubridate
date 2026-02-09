# Various POSIX utilities

`POSIXct()` mirrors primitive constructors in base R
([`double()`](https://rdrr.io/r/base/double.html),
[`character()`](https://rdrr.io/r/base/character.html) etc.)

## Usage

``` r
is.POSIXt(x)

is.POSIXlt(x)

is.POSIXct(x)

POSIXct(length = 0L, tz = "UTC")

NA_POSIXct_
```

## Format

An object of class `POSIXct` (inherits from `POSIXt`) of length 1.

## Arguments

- x:

  an R object

- length:

  A non-negative number specifying the desired length. Supplying an
  argument of length other than one is an error.

- tz:

  a timezone (defaults to "utc")

## Value

TRUE if x is a POSIXct or POSIXlt object, FALSE otherwise.

## See also

[`is.instant()`](https://lubridate.tidyverse.org/dev/reference/is.instant.md),
[`is.timespan()`](https://lubridate.tidyverse.org/dev/reference/is.timespan.md),
[`is.Date()`](https://lubridate.tidyverse.org/dev/reference/date_utils.md)

## Examples

``` r
is.POSIXt(as.Date("2009-08-03"))
#> [1] FALSE
is.POSIXt(as.POSIXct("2009-08-03"))
#> [1] TRUE
```
