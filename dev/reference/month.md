# Get/set months component of a date-time

Date-time must be a POSIXct, POSIXlt, Date, Period, chron, yearmon,
yearqtr, zoo, zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts
objects.

## Usage

``` r
month(x, label = FALSE, abbr = TRUE, locale = Sys.getlocale("LC_TIME"))

month(x) <- value
```

## Arguments

- x:

  a date-time object

- label:

  logical. TRUE will display the month as a character string such as
  "January." FALSE will display the month as a number.

- abbr:

  logical. FALSE will display the month as a character string label,
  such as "January". TRUE will display an abbreviated version of the
  label, such as "Jan". abbr is disregarded if label = FALSE.

- locale:

  for month, locale to use for month names. Default to current locale.

- value:

  a numeric object

## Value

If `label = FALSE`: month as number (1-12, 1 = January, 12 = December),
otherwise as an ordered factor.

## Examples

``` r
x <- ymd("2012-03-26")
month(x)
#> [1] 3
month(x) <- 1
month(x) <- 13
month(x) > 3
#> [1] FALSE

month(ymd(080101))
#> [1] 1
month(ymd(080101), label = TRUE)
#> [1] Jan
#> 12 Levels: Jan < Feb < Mar < Apr < May < Jun < Jul < Aug < ... < Dec
month(ymd(080101), label = TRUE, abbr = FALSE)
#> [1] January
#> 12 Levels: January < February < March < April < May < ... < December
month(ymd(080101) + months(0:11), label = TRUE)
#>  [1] Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
#> 12 Levels: Jan < Feb < Mar < Apr < May < Jun < Jul < Aug < ... < Dec
```
