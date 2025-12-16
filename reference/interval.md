# Utilities for creation and manipulation of `Interval` objects

`interval()` creates an
[Interval](https://lubridate.tidyverse.org/reference/Interval-class.md)
object with the specified start and end dates. If the start date occurs
before the end date, the interval will be positive. Otherwise, it will
be negative. Character vectors in ISO 8601 format are supported from
v1.7.2.

`int_start()`/`int_end()` and `int_start<-()`/`int_end<-()` are
"accessors" and "setters" respectively of the start/end date of an
interval.

`int_flip()` reverses the order of the start date and end date in an
interval. The new interval takes place during the same timespan as the
original interval, but has the opposite direction.

`int_shift()` shifts the start and end dates of an interval up or down
the timeline by a specified amount. Note that this may change the exact
length of the interval if the interval is shifted by a Period object.
Intervals shifted by a Duration or difftime object will retain their
exact length in seconds.

`int_overlaps()` tests if two intervals overlap.

`int_standardize()` ensures all intervals in an interval object are
positive. If an interval is not positive, flip it so that it retains its
endpoints but becomes positive.

`int_aligns()` tests if two intervals share an endpoint. The direction
of each interval is ignored. int_align tests whether the earliest or
latest moments of each interval occur at the same time.

`int_diff()` returns the intervals that occur between the elements of a
vector of date-times. `int_diff()` is similar to the POSIXt and Date
methods of [`diff()`](https://rdrr.io/r/base/diff.html), but returns an
[Interval](https://lubridate.tidyverse.org/reference/Interval-class.md)
object instead of a difftime object.

## Usage

``` r
interval(start = NULL, end = NULL, tzone = tz(start))

start %--% end

is.interval(x)

int_start(int)

int_start(int) <- value

int_end(int)

int_end(int) <- value

int_length(int)

int_flip(int)

int_shift(int, by)

int_overlaps(int1, int2)

int_standardize(int)

int_aligns(int1, int2)

int_diff(times)
```

## Arguments

- start, end:

  POSIXt, Date or a character vectors. When `start` is a character
  vector and end is `NULL`, ISO 8601 specification is assumed but with
  much more permissive lubridate style parsing both for dates and
  periods (see examples).

- tzone:

  a recognized timezone to display the interval in

- x:

  an R object

- int:

  an interval object

- value:

  interval's start/end to be assigned to `int`

- by:

  A period or duration object to shift by (for `int_shift`)

- int1:

  an Interval object (for `int_overlaps()`, `int_aligns()`)

- int2:

  an Interval object (for `int_overlaps()`, `int_aligns()`)

- times:

  A vector of POSIXct, POSIXlt or Date class date-times (for
  `int_diff()`)

## Value

`interval()` –
[Interval](https://lubridate.tidyverse.org/reference/Interval-class.md)
object.

`int_start()` and `int_end()` return a POSIXct date object when used as
an accessor. Nothing when used as a setter.

`int_length()` – numeric length of the interval in seconds. A negative
number connotes a negative interval.

`int_flip()` – flipped interval object

`int_shift()` – an Interval object

`int_overlaps()` – logical, TRUE if int1 and int2 overlap by at least
one second. FALSE otherwise

`int_aligns()` – logical, TRUE if int1 and int2 begin or end on the same
moment. FALSE otherwise

`int_diff()` – interval object that contains the n-1 intervals between
the n date-time in times

## Details

Intervals are time spans bound by two real date-times. Intervals can be
accurately converted to either period or duration objects using
[`as.period()`](https://lubridate.tidyverse.org/reference/as.period.md),
[`as.duration()`](https://lubridate.tidyverse.org/reference/as.duration.md).
Since an interval is anchored to a fixed history of time, both the exact
number of seconds that passed and the number of variable length time
units that occurred during the interval can be calculated.

## See also

[Interval](https://lubridate.tidyverse.org/reference/Interval-class.md),
[`as.interval()`](https://lubridate.tidyverse.org/reference/as.interval.md),
[`%within%`](https://lubridate.tidyverse.org/reference/within-interval.md)

## Examples

``` r
interval(ymd(20090201), ymd(20090101))
#> [1] 2009-02-01 UTC--2009-01-01 UTC

date1 <- ymd_hms("2009-03-08 01:59:59")
date2 <- ymd_hms("2000-02-29 12:00:00")
interval(date2, date1)
#> [1] 2000-02-29 12:00:00 UTC--2009-03-08 01:59:59 UTC
interval(date1, date2)
#> [1] 2009-03-08 01:59:59 UTC--2000-02-29 12:00:00 UTC
span <- interval(ymd(20090101), ymd(20090201))

### ISO Intervals

interval("2007-03-01T13:00:00Z/2008-05-11T15:30:00Z")
#> [1] 2007-03-01 13:00:00 UTC--2008-05-11 15:30:00 UTC
interval("2007-03-01T13:00:00Z/P1Y2M10DT2H30M")
#> [1] 2007-03-01 13:00:00 UTC--2008-05-11 15:30:00 UTC
interval("P1Y2M10DT2H30M/2008-05-11T15:30:00Z")
#> [1] 2007-03-01 13:00:00 UTC--2008-05-11 15:30:00 UTC
interval("2008-05-11/P2H30M")
#> [1] 2008-05-11 UTC--2010-11-11 02:00:00 UTC

### More permissive parsing (as long as there are no intermittent / characters)
interval("2008 05 11/P2hours 30minutes")
#> [1] 2008-05-11 UTC--2008-05-11 02:30:00 UTC
interval("08 05 11/P 2h 30m")
#> [1] 2008-05-11 UTC--2010-11-11 02:00:00 UTC

is.interval(period(months = 1, days = 15)) # FALSE
#> [1] FALSE
is.interval(interval(ymd(20090801), ymd(20090809))) # TRUE
#> [1] TRUE
int <- interval(ymd("2001-01-01"), ymd("2002-01-01"))
int_start(int)
#> [1] "2001-01-01 UTC"
int_start(int) <- ymd("2001-06-01")
int
#> [1] 2001-06-01 UTC--2002-01-01 UTC

int <- interval(ymd("2001-01-01"), ymd("2002-01-01"))
int_end(int)
#> [1] "2002-01-01 UTC"
int_end(int) <- ymd("2002-06-01")
int
#> [1] 2001-01-01 UTC--2002-06-01 UTC
int <- interval(ymd("2001-01-01"), ymd("2002-01-01"))
int_length(int)
#> [1] 31536000
int <- interval(ymd("2001-01-01"), ymd("2002-01-01"))
int_flip(int)
#> [1] 2002-01-01 UTC--2001-01-01 UTC
int <- interval(ymd("2001-01-01"), ymd("2002-01-01"))
int_shift(int, duration(days = 11))
#> [1] 2001-01-12 UTC--2002-01-12 UTC
int_shift(int, duration(hours = -1))
#> [1] 2000-12-31 23:00:00 UTC--2001-12-31 23:00:00 UTC
int1 <- interval(ymd("2001-01-01"), ymd("2002-01-01"))
int2 <- interval(ymd("2001-06-01"), ymd("2002-06-01"))
int3 <- interval(ymd("2003-01-01"), ymd("2004-01-01"))

int_overlaps(int1, int2) # TRUE
#> [1] TRUE
int_overlaps(int1, int3) # FALSE
#> [1] FALSE
int <- interval(ymd("2002-01-01"), ymd("2001-01-01"))
int_standardize(int)
#> [1] 2001-01-01 UTC--2002-01-01 UTC
int1 <- interval(ymd("2001-01-01"), ymd("2002-01-01"))
int2 <- interval(ymd("2001-06-01"), ymd("2002-01-01"))
int3 <- interval(ymd("2003-01-01"), ymd("2004-01-01"))

int_aligns(int1, int2) # TRUE
#> [1] TRUE
int_aligns(int1, int3) # FALSE
#> [1] FALSE
dates <- now() + days(1:10)
int_diff(dates)
#> [1] 2025-12-17 16:00:12 UTC--2025-12-18 16:00:12 UTC
#> [2] 2025-12-18 16:00:12 UTC--2025-12-19 16:00:12 UTC
#> [3] 2025-12-19 16:00:12 UTC--2025-12-20 16:00:12 UTC
#> [4] 2025-12-20 16:00:12 UTC--2025-12-21 16:00:12 UTC
#> [5] 2025-12-21 16:00:12 UTC--2025-12-22 16:00:12 UTC
#> [6] 2025-12-22 16:00:12 UTC--2025-12-23 16:00:12 UTC
#> [7] 2025-12-23 16:00:12 UTC--2025-12-24 16:00:12 UTC
#> [8] 2025-12-24 16:00:12 UTC--2025-12-25 16:00:12 UTC
#> [9] 2025-12-25 16:00:12 UTC--2025-12-26 16:00:12 UTC
```
