# Various date utilities

`Date()` mirrors primitive constructors in base R
([`double()`](https://rdrr.io/r/base/double.html),
[`character()`](https://rdrr.io/r/base/character.html) etc.)

## Usage

``` r
is.Date(x)

Date(length = 0L)

NA_Date_
```

## Format

An object of class `Date` of length 1.

## Arguments

- x:

  an R object

- length:

  A non-negative number specifying the desired length. Supplying an
  argument of length other than one is an error.

## See also

[`is.instant()`](https://lubridate.tidyverse.org/dev/reference/is.instant.md),
[`is.timespan()`](https://lubridate.tidyverse.org/dev/reference/is.timespan.md),
[`is.POSIXt()`](https://lubridate.tidyverse.org/dev/reference/posix_utils.md),
[`POSIXct()`](https://lubridate.tidyverse.org/dev/reference/posix_utils.md)

## Examples

``` r
is.Date(as.Date("2009-08-03")) # TRUE
#> [1] TRUE
is.Date(difftime(now() + 5, now())) # FALSE
#> [1] FALSE
```
