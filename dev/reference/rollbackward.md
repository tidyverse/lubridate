# Roll backward or forward a date the previous, current or next month

`rollbackward()` changes a date to the last day of the previous month or
to the first day of the month. `rollforward()` rolls to the last day of
the current month or to the first day of the next month. Optionally, the
new date can retain the same hour, minute, and second information.
`rollback()` is a synonym for `rollbackward()`.

## Usage

``` r
rollbackward(dates, roll_to_first = FALSE, preserve_hms = TRUE)

rollback(dates, roll_to_first = FALSE, preserve_hms = TRUE)

rollforward(dates, roll_to_first = FALSE, preserve_hms = TRUE)
```

## Arguments

- dates:

  A POSIXct, POSIXlt or Date class object.

- roll_to_first:

  Rollback to the first day of the month instead of the last day of the
  month

- preserve_hms:

  Retains the same hour, minute, and second information? If FALSE, the
  new date will be at 00:00:00.

## Value

A date-time object of class POSIXlt, POSIXct or Date, whose day has been
adjusted to the last day of the previous month, or to the first day of
the month.

## Examples

``` r
date <- ymd("2010-03-03")
rollbackward(date)
#> [1] "2010-02-28"

dates <- date + months(0:2)
rollbackward(dates)
#> [1] "2010-02-28" "2010-03-31" "2010-04-30"

date <- ymd_hms("2010-03-03 12:44:22")
rollbackward(date)
#> [1] "2010-02-28 12:44:22 UTC"
rollbackward(date, roll_to_first = TRUE)
#> [1] "2010-03-01 12:44:22 UTC"
rollbackward(date, preserve_hms = FALSE)
#> [1] "2010-02-28 UTC"
rollbackward(date, roll_to_first = TRUE, preserve_hms = FALSE)
#> [1] "2010-03-01 UTC"
```
