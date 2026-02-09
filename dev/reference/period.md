# Create or parse period objects

`period()` creates or parses a period object with the specified values.

## Usage

``` r
period(num = NULL, units = "second", ...)

is.period(x)

seconds(x = 1)

minutes(x = 1)

hours(x = 1)

days(x = 1)

weeks(x = 1)

years(x = 1)

milliseconds(x = 1)

microseconds(x = 1)

nanoseconds(x = 1)

picoseconds(x = 1)

# S3 method for class 'numeric'
months(x, abbreviate)
```

## Arguments

- num:

  a numeric or character vector. A character vector can specify periods
  in a convenient shorthand format or ISO 8601 specification. All
  unambiguous name units and abbreviations are supported, "m" stands for
  months, "M" for minutes unless ISO 8601 "P" modifier is present (see
  examples). Fractional units are supported but the fractional part is
  always converted to seconds.

- units:

  a character vector that lists the type of units to be used. The units
  in units are matched to the values in num according to their order.
  When `num` is character, this argument is ignored.

- ...:

  a list of time units to be included in the period and their amounts.
  Seconds, minutes, hours, days, weeks, months, and years are supported.
  Normally only one of `num` or `...` are present. If both are present,
  the periods are concatenated.

- x:

  Any R object for `is.periods` and a numeric value of the number of
  units for elementary constructors. With the exception of seconds(), x
  must be an integer.

- abbreviate:

  Ignored. For consistency with S3 generic in base namespace.

## Value

a period object

## Details

Within a Period object, time units do not have a fixed length (except
for seconds) until they are added to a date-time. The length of each
time unit will depend on the date-time to which it is added. For
example, a year that begins on 2009-01-01 will be 365 days long. A year
that begins on 2012-01-01 will be 366 days long. When math is performed
with a period object, each unit is applied separately. How the length of
a period is distributed among its units is non-trivial. For example,
when leap seconds occur 1 minute is longer than 60 seconds.

Periods track the change in the "clock time" between two date-times.
They are measured in common time related units: years, months, days,
hours, minutes, and seconds. Each unit except for seconds must be
expressed in integer values.

Besides the main constructor and parser `period()`, period objects can
also be created with the specialized functions `years()`,
[`months()`](https://rdrr.io/r/base/weekday.POSIXt.html), `weeks()`,
`days()`, `hours()`, `minutes()`, and `seconds()`. These objects can be
added to and subtracted to date-times to create a user interface similar
to object oriented programming.

Note: Arithmetic with periods can result in undefined behavior when
non-existent dates are involved (such as February 29th in non-leap
years). Please see
[Period](https://lubridate.tidyverse.org/dev/reference/Period-class.md)
for more details and
[`%m+%`](https://lubridate.tidyverse.org/dev/reference/mplus.md) and
[`add_with_rollback()`](https://lubridate.tidyverse.org/dev/reference/mplus.md)
for alternative operations.

## See also

[Period](https://lubridate.tidyverse.org/dev/reference/Period-class.md),
`period()`,
[`%m+%`](https://lubridate.tidyverse.org/dev/reference/mplus.md),
[`add_with_rollback()`](https://lubridate.tidyverse.org/dev/reference/mplus.md)

## Examples

``` r
### Separate period and units vectors

period(c(90, 5), c("second", "minute"))
#> [1] "5M 90S"
#  "5M 90S"
period(-1, "days")
#> [1] "-1d 0H 0M 0S"
period(c(3, 1, 2, 13, 1), c("second", "minute", "hour", "day", "week"))
#> [1] "20d 2H 1M 3S"
period(c(1, -60), c("hour", "minute"))
#> [1] "1H -60M 0S"
period(0, "second")
#> [1] "0S"

### Units as arguments

period(second = 90, minute = 5)
#> [1] "5M 90S"
period(day = -1)
#> [1] "-1d 0H 0M 0S"
period(second = 3, minute = 1, hour = 2, day = 13, week = 1)
#> [1] "20d 2H 1M 3S"
period(hour = 1, minute = -60)
#> [1] "1H -60M 0S"
period(second = 0)
#> [1] "0S"
period(c(1, -60), c("hour", "minute"), hour = c(1, 2), minute = c(3, 4))
#> [1] "1H -60M 0S" "1H 3M 0S"   "2H 4M 0S"  

### Lubridate style parsing

period("2M 1sec")
#> [1] "2M 1S"
period("2hours 2minutes 1second")
#> [1] "2H 2M 1S"
period("2d 2H 2M 2S")
#> [1] "2d 2H 2M 2S"
period("2days 2hours 2mins 2secs")
#> [1] "2d 2H 2M 2S"
period("2 days, 2 hours, 2 mins, 2 secs")
#> [1] "2d 2H 2M 2S"
# Missing numerals default to 1. Repeated units are added up.
period("day day")
#> [1] "2d 0H 0M 0S"

### ISO 8601 parsing

period("P10M23DT23H") # M stands for months
#> [1] "10m 23d 23H 0M 0S"
period("10DT10M") # M stands for minutes
#> [1] "10d 0H 10M 0S"
period("P3Y6M4DT12H30M5S") # M for both minutes and months
#> [1] "3y 6m 4d 12H 30M 5S"
period("P23DT60H 20min 100 sec") # mixing ISO and lubridate style parsing
#> [1] "23d 60H 20M 100S"

### Comparison with characters (from v1.6.0)

period("day 2 sec") > "day 1sec"
#> [1] TRUE

### Elementary Constructors

x <- ymd("2009-08-03")
x + days(1) + hours(6) + minutes(30)
#> [1] "2009-08-04 06:30:00 UTC"
x + days(100) - hours(8)
#> [1] "2009-11-10 16:00:00 UTC"

class(as.Date("2009-08-09") + days(1)) # retains Date class
#> [1] "Date"
as.Date("2009-08-09") + hours(12)
#> [1] "2009-08-09 12:00:00 UTC"
class(as.Date("2009-08-09") + hours(12))
#> [1] "POSIXct" "POSIXt" 
# converts to POSIXt class to accomodate time units

years(1) - months(7)
#> [1] "1y -7m 0d 0H 0M 0S"
c(1:3) * hours(1)
#> [1] "1H 0M 0S" "2H 0M 0S" "3H 0M 0S"
hours(1:3)
#> [1] "1H 0M 0S" "2H 0M 0S" "3H 0M 0S"

# sequencing
y <- ymd(090101) # "2009-01-01 CST"
y + months(0:11)
#>  [1] "2009-01-01" "2009-02-01" "2009-03-01" "2009-04-01" "2009-05-01"
#>  [6] "2009-06-01" "2009-07-01" "2009-08-01" "2009-09-01" "2009-10-01"
#> [11] "2009-11-01" "2009-12-01"

# compare DST handling to durations
boundary <- ymd_hms("2009-03-08 01:59:59", tz = "America/Chicago")
boundary + days(1) # period
#> [1] "2009-03-09 01:59:59 CDT"
boundary + ddays(1) # duration
#> [1] "2009-03-09 02:59:59 CDT"
is.period(as.Date("2009-08-03")) # FALSE
#> [1] FALSE
is.period(period(months = 1, days = 15)) # TRUE
#> [1] TRUE
```
