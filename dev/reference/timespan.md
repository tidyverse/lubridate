# Description of time span classes in lubridate

A time span can be measured in three ways: as a duration, an interval,
or a period.

- [duration](https://lubridate.tidyverse.org/dev/reference/duration.md)s
  record the exact number of seconds in a time span. They measure the
  exact passage of time but do not always align with human measurements
  like hours, months and years.

- [period](https://lubridate.tidyverse.org/dev/reference/period.md)s
  record the change in the clock time between two date-times. They are
  measured in human units: years, months, days, hours, minutes, and
  seconds.

- [intervals](https://lubridate.tidyverse.org/dev/reference/Interval-class.md)
  are time spans bound by two real date-times. Intervals can be
  accurately converted to periods and durations.

## Examples

``` r
duration(3690, "seconds")
#> [1] "3690s (~1.02 hours)"
period(3690, "seconds")
#> [1] "3690S"
period(second = 30, minute = 1, hour = 1)
#> [1] "1H 1M 30S"
interval(ymd_hms("2009-08-09 13:01:30"), ymd_hms("2009-08-09 12:00:00"))
#> [1] 2009-08-09 13:01:30 UTC--2009-08-09 12:00:00 UTC

date <- ymd_hms("2009-03-08 01:59:59") # DST boundary
date + days(1)
#> [1] "2009-03-09 01:59:59 UTC"
date + ddays(1)
#> [1] "2009-03-09 01:59:59 UTC"

date2 <- ymd_hms("2000-02-29 12:00:00")
date2 + years(1)
#> [1] NA
# self corrects to next real day

date3 <- ymd_hms("2009-01-31 01:00:00")
date3 + c(0:11) * months(1)
#>  [1] "2009-01-31 01:00:00 UTC" NA                       
#>  [3] "2009-03-31 01:00:00 UTC" NA                       
#>  [5] "2009-05-31 01:00:00 UTC" NA                       
#>  [7] "2009-07-31 01:00:00 UTC" "2009-08-31 01:00:00 UTC"
#>  [9] NA                        "2009-10-31 01:00:00 UTC"
#> [11] NA                        "2009-12-31 01:00:00 UTC"

span <- date2 %--% date # creates interval

date <- ymd_hms("2009-01-01 00:00:00")
date + years(1)
#> [1] "2010-01-01 UTC"
date - days(3) + hours(6)
#> [1] "2008-12-29 06:00:00 UTC"
date + 3 * seconds(10)
#> [1] "2009-01-01 00:00:30 UTC"

months(6) + days(1)
#> [1] "6m 1d 0H 0M 0S"
```
