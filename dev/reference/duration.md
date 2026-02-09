# Create a duration object.

`duration()` creates a duration object with the specified values.
Entries for different units are cumulative. durations display as the
number of seconds in a time span. When this number is large, durations
also display an estimate in larger units, however, the underlying object
is always recorded as a fixed number of seconds. For display and
creation purposes, units are converted to seconds using their most
common lengths in seconds. Minutes = 60 seconds, hours = 3600 seconds,
days = 86400 seconds, weeks = 604800. Units larger than weeks are not
used due to their variability.

## Usage

``` r
duration(num = NULL, units = "seconds", ...)

dseconds(x = 1)

dminutes(x = 1)

dhours(x = 1)

ddays(x = 1)

dweeks(x = 1)

dmonths(x = 1)

dyears(x = 1)

dmilliseconds(x = 1)

dmicroseconds(x = 1)

dnanoseconds(x = 1)

dpicoseconds(x = 1)

is.duration(x)
```

## Arguments

- num:

  the number or a character vector of time units. In string
  representation all unambiguous name units and abbreviations and ISO
  8601 formats are supported; 'm' stands for month and 'M' for minutes
  unless ISO 8601 "P" modifier is present (see examples). Fractional
  units are supported.

- units:

  a character string that specifies the type of units that `num` refers
  to. When `num` is character, this argument is ignored.

- ...:

  a list of time units to be included in the duration and their amounts.
  Seconds, minutes, hours, days, weeks, months and years are supported.
  Durations of months and years assume that year consists of 365.25
  days.

- x:

  numeric value of the number of units to be contained in the duration.

## Value

a duration object

## Details

Durations record the exact number of seconds in a time span. They
measure the exact passage of time but do not always align with
measurements made in larger units of time such as hours, months and
years. This is because the length of larger time units can be affected
by conventions such as leap years and Daylight Savings Time. Base R
provides a second class for measuring durations, the difftime class.

Duration objects can be easily created with the helper functions
`dweeks()`, `ddays()`, `dminutes()`, `dseconds()`. These objects can be
added to and subtracted to date- times to create a user interface
similar to object oriented programming.

## See also

[`as.duration()`](https://lubridate.tidyverse.org/dev/reference/as.duration.md)
[Duration](https://lubridate.tidyverse.org/dev/reference/Duration-class.md)

## Examples

``` r
### Separate period and units vectors

duration(90, "seconds")
#> [1] "90s (~1.5 minutes)"
duration(1.5, "minutes")
#> [1] "90s (~1.5 minutes)"
duration(-1, "days")
#> [1] "-86400s (~-1 days)"

### Units as arguments

duration(day = -1)
#> [1] "-86400s (~-1 days)"
duration(second = 90)
#> [1] "90s (~1.5 minutes)"
duration(minute = 1.5)
#> [1] "90s (~1.5 minutes)"
duration(mins = 1.5)
#> [1] "90s (~1.5 minutes)"
duration(second = 3, minute = 1.5, hour = 2, day = 6, week = 1)
#> [1] "1130493s (~1.87 weeks)"
duration(hour = 1, minute = -60)
#> [1] "0s"

### Parsing

duration("2M 1sec")
#> [1] "121s (~2.02 minutes)"
duration("2hours 2minutes 1second")
#> [1] "7321s (~2.03 hours)"
duration("2d 2H 2M 2S")
#> [1] "180122s (~2.08 days)"
duration("2days 2hours 2mins 2secs")
#> [1] "180122s (~2.08 days)"
# Missing numerals default to 1. Repeated units are added up.
duration("day day")
#> [1] "172800s (~2 days)"

### ISO 8601 parsing

duration("P3Y6M4DT12H30M5S")
#> [1] "110842205s (~3.51 years)"
duration("P23DT23H") # M stands for months
#> [1] "2070000s (~3.42 weeks)"
duration("10DT10M") # M stands for minutes
#> [1] "864600s (~1.43 weeks)"
duration("P23DT60H 20min 100 sec") # mixing ISO and lubridate style parsing
#> [1] "2204500s (~3.65 weeks)"

# Comparison with characters (from v1.6.0)

duration("day 2 sec") > "day 1sec"
#> [1] TRUE


## ELEMENTARY CONSTRUCTORS:

dseconds(1)
#> [1] "1s"
dminutes(3.5)
#> [1] "210s (~3.5 minutes)"

x <- ymd("2009-08-03", tz = "America/Chicago")
x + ddays(1) + dhours(6) + dminutes(30)
#> [1] "2009-08-04 06:30:00 CDT"
x + ddays(100) - dhours(8)
#> [1] "2009-11-10 15:00:00 CST"

class(as.Date("2009-08-09") + ddays(1)) # retains Date class
#> [1] "Date"
as.Date("2009-08-09") + dhours(12)
#> [1] "2009-08-09 12:00:00 UTC"
class(as.Date("2009-08-09") + dhours(12))
#> [1] "POSIXct" "POSIXt" 
# converts to POSIXt class to accomodate time units

dweeks(1) - ddays(7)
#> [1] "0s"
c(1:3) * dhours(1)
#> [1] "3600s (~1 hours)"  "7200s (~2 hours)"  "10800s (~3 hours)"

# compare DST handling to durations
boundary <- ymd_hms("2009-03-08 01:59:59", tz = "America/Chicago")
boundary + days(1) # period
#> [1] "2009-03-09 01:59:59 CDT"
boundary + ddays(1) # duration
#> [1] "2009-03-09 02:59:59 CDT"
is.duration(as.Date("2009-08-03")) # FALSE
#> [1] FALSE
is.duration(duration(days = 12.4)) # TRUE
#> [1] TRUE
```
