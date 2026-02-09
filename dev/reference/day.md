# Get/set days component of a date-time

Get/set days component of a date-time

## Usage

``` r
day(x)

mday(x)

wday(
  x,
  label = FALSE,
  abbr = TRUE,
  week_start = getOption("lubridate.week.start", 7),
  locale = Sys.getlocale("LC_TIME")
)

qday(x)

yday(x)

day(x) <- value

mday(x) <- value

qday(x) <- value

qday(x) <- value

wday(x, week_start = getOption("lubridate.week.start", 7)) <- value

yday(x) <- value
```

## Arguments

- x:

  a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, zooreg,
  timeDate, xts, its, ti, jul, timeSeries, or fts object.

- label:

  logical. Only available for wday. TRUE will display the day of the
  week as an ordered factor of character strings, such as "Sunday."
  FALSE will display the day of the week as a number.

- abbr:

  logical. Only available for wday. FALSE will display the day of the
  week as an ordered factor of character strings, such as "Sunday." TRUE
  will display an abbreviated version of the label, such as "Sun". abbr
  is disregarded if label = FALSE.

- week_start:

  day on which week starts following ISO conventions: 1 means Monday and
  7 means Sunday (default). When `label = FALSE` and `week_start = 7`,
  the number returned for Sunday is 1, for Monday is 2, etc. When
  `label = TRUE`, the returned value is a factor with the first level
  being the week start (e.g. Sunday if `week_start = 7`). You can set
  `lubridate.week.start` option to control this parameter globally.

- locale:

  locale to use for day names. Default to current locale.

- value:

  (for `wday<-`) a numeric or a string giving the name of the day in the
  current locale or in English. Can be abbreviated. When a string, the
  value of `week_start` is ignored.

## Value

`wday()` returns the day of the week as a decimal number or an ordered
factor if label is `TRUE`.

## Details

`mday()` and `yday()` return the day of the month and day of the year
respectively. `day()` and `day<-()` are aliases for `mday()` and
`mday<-()`.

## Examples

``` r
x <- as.Date("2009-09-02")
wday(x) # 4
#> [1] 4
wday(x, label = TRUE) # Wed
#> [1] Wed
#> Levels: Sun < Mon < Tue < Wed < Thu < Fri < Sat

wday(x, week_start = 1) # 3
#> [1] 3
wday(x, week_start = 7) # 4
#> [1] 4

wday(x, label = TRUE, week_start = 7) # Wed (Sun is the first level)
#> [1] Wed
#> Levels: Sun < Mon < Tue < Wed < Thu < Fri < Sat
wday(x, label = TRUE, week_start = 1) # Wed (Mon is the first level)
#> [1] Wed
#> Levels: Mon < Tue < Wed < Thu < Fri < Sat < Sun

wday(ymd(080101))
#> [1] 3
wday(ymd(080101), label = TRUE, abbr = FALSE)
#> [1] Tuesday
#> 7 Levels: Sunday < Monday < Tuesday < Wednesday < ... < Saturday
wday(ymd(080101), label = TRUE, abbr = TRUE)
#> [1] Tue
#> Levels: Sun < Mon < Tue < Wed < Thu < Fri < Sat
wday(ymd(080101) + days(-2:4), label = TRUE, abbr = TRUE)
#> [1] Sun Mon Tue Wed Thu Fri Sat
#> Levels: Sun < Mon < Tue < Wed < Thu < Fri < Sat

x <- as.Date("2009-09-02")
yday(x) # 245
#> [1] 245
mday(x) # 2
#> [1] 2
yday(x) <- 1 # "2009-01-01"
yday(x) <- 366 # "2010-01-01"
mday(x) > 3
#> [1] FALSE
```
