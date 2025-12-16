# Get/set weeks component of a date-time

`week()` returns the number of complete seven day periods that have
occurred between the date and January 1st, plus one.

`isoweek()` returns the week as it would appear in the ISO 8601 system,
which uses a reoccurring leap week.

`epiweek()` is the US CDC version of epidemiological week. It follows
same rules as `isoweek()` but starts on Sunday. In other parts of the
world the convention is to start epidemiological weeks on Monday, which
is the same as `isoweek`.

## Usage

``` r
week(x)

week(x) <- value

isoweek(x)

epiweek(x)
```

## Arguments

- x:

  a date-time object. Must be a POSIXct, POSIXlt, Date, chron, yearmon,
  yearqtr, zoo, zooreg, timeDate, xts, its, ti, jul, timeSeries, or fts
  object.

- value:

  a numeric object

## Value

the weeks element of x as an integer number

## References

<https://en.wikipedia.org/wiki/ISO_week_date>

## See also

[`isoyear()`](https://lubridate.tidyverse.org/reference/year.md)

## Examples

``` r
x <- ymd("2012-03-26")
week(x)
#> [1] 13
week(x) <- 1
week(x) <- 54
week(x) > 3
#> [1] FALSE
```
