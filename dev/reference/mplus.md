# Add and subtract months to a date without exceeding the last day of the new month

Adding months frustrates basic arithmetic because consecutive months
have different lengths. With other elements, it is helpful for
arithmetic to perform automatic roll over. For example, 12:00:00 + 61
seconds becomes 12:01:01. However, people often prefer that this
behavior NOT occur with months. For example, we sometimes want January
31 + 1 month = February 28 and not March 3. `%m+%` performs this type of
arithmetic. Date `%m+%` months(n) always returns a date in the nth month
after Date. If the new date would usually spill over into the n + 1th
month, `%m+%` will return the last day of the nth month
([`rollback()`](https://lubridate.tidyverse.org/dev/reference/rollbackward.md)).
Date `%m-%` months(n) always returns a date in the nth month before
Date.

## Usage

``` r
e1 %m+% e2

add_with_rollback(e1, e2, roll_to_first = FALSE, preserve_hms = TRUE)
```

## Arguments

- e1:

  A period or a date-time object of class
  [POSIXlt](https://rdrr.io/r/base/DateTimeClasses.html),
  [POSIXct](https://lubridate.tidyverse.org/dev/reference/posix_utils.md)
  or
  [Date](https://lubridate.tidyverse.org/dev/reference/date_utils.md).

- e2:

  A period or a date-time object of class
  [POSIXlt](https://rdrr.io/r/base/DateTimeClasses.html),
  [POSIXct](https://lubridate.tidyverse.org/dev/reference/posix_utils.md)
  or
  [Date](https://lubridate.tidyverse.org/dev/reference/date_utils.md).
  Note that one of e1 and e2 must be a period and the other a date-time
  object.

- roll_to_first:

  rollback to the first day of the month instead of the last day of the
  previous month (passed to
  [`rollback()`](https://lubridate.tidyverse.org/dev/reference/rollbackward.md))

- preserve_hms:

  retains the same hour, minute, and second information? If FALSE, the
  new date will be at 00:00:00 (passed to
  [`rollback()`](https://lubridate.tidyverse.org/dev/reference/rollbackward.md))

## Value

A date-time object of class POSIXlt, POSIXct or Date

## Details

`%m+%` and `%m-%` handle periods with components less than a month by
first adding/subtracting months and then performing usual arithmetic
with smaller units.

`%m+%` and `%m-%` should be used with caution as they are not one-to-one
operations and results for either will be sensitive to the order of
operations.

## Examples

``` r
jan <- ymd_hms("2010-01-31 03:04:05")
jan + months(1:3) # Feb 31 and April 31 returned as NA
#> [1] NA                        "2010-03-31 03:04:05 UTC"
#> [3] NA                       
# NA "2010-03-31 03:04:05 UTC" NA
jan %m+% months(1:3) # No rollover
#> [1] "2010-02-28 03:04:05 UTC" "2010-03-31 03:04:05 UTC"
#> [3] "2010-04-30 03:04:05 UTC"

leap <- ymd("2012-02-29")
"2012-02-29 UTC"
#> [1] "2012-02-29 UTC"
leap %m+% years(1)
#> [1] "2013-02-28"
leap %m+% years(-1)
#> [1] "2011-02-28"
leap %m-% years(1)
#> [1] "2011-02-28"

x <- ymd_hms("2019-01-29 01:02:03")
add_with_rollback(x, months(1))
#> [1] "2019-02-28 01:02:03 UTC"
add_with_rollback(x, months(1), preserve_hms = FALSE)
#> [1] "2019-02-28 UTC"
add_with_rollback(x, months(1), roll_to_first = TRUE)
#> [1] "2019-03-01 01:02:03 UTC"
add_with_rollback(x, months(1), roll_to_first = TRUE, preserve_hms = FALSE)
#> [1] "2019-03-01 UTC"
```
