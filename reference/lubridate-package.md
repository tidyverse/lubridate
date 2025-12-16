# Dates and times made easy with lubridate

Lubridate provides tools that make it easier to parse and manipulate
dates. These tools are grouped below by common purpose. More information
about each function can be found in its help documentation.

## Parsing dates

Lubridate's parsing functions read strings into R as POSIXct date-time
objects. Users should choose the function whose name models the order in
which the year ('y'), month ('m') and day ('d') elements appear the
string to be parsed:
[`dmy()`](https://lubridate.tidyverse.org/reference/ymd.md),
[`myd()`](https://lubridate.tidyverse.org/reference/ymd.md),
[`ymd()`](https://lubridate.tidyverse.org/reference/ymd.md),
[`ydm()`](https://lubridate.tidyverse.org/reference/ymd.md),
[`dym()`](https://lubridate.tidyverse.org/reference/ymd.md),
[`mdy()`](https://lubridate.tidyverse.org/reference/ymd.md),
[`ymd_hms()`](https://lubridate.tidyverse.org/reference/ymd_hms.md)). A
very flexible and user friendly parser is provided by
[`parse_date_time()`](https://lubridate.tidyverse.org/reference/parse_date_time.md).

Lubridate can also parse partial dates from strings into
[Period](https://lubridate.tidyverse.org/reference/Period-class.md)
objects with the functions
[`hm()`](https://lubridate.tidyverse.org/reference/hms.md),
[`hms()`](https://lubridate.tidyverse.org/reference/hms.md) and
[`ms()`](https://lubridate.tidyverse.org/reference/hms.md).

Lubridate has an inbuilt very fast POSIX parser. Most of the
[`strptime()`](https://rdrr.io/r/base/strptime.html) formats and various
extensions are supported for English locales. See
[`parse_date_time()`](https://lubridate.tidyverse.org/reference/parse_date_time.md)
for more details.

## Manipulating dates

Lubridate distinguishes between moments in time (known as
[`instants()`](https://lubridate.tidyverse.org/reference/is.instant.md))
and spans of time (known as time spans, see
[Timespan](https://lubridate.tidyverse.org/reference/Timespan-class.md)).
Time spans are further separated into
[Duration](https://lubridate.tidyverse.org/reference/Duration-class.md),
[Period](https://lubridate.tidyverse.org/reference/Period-class.md) and
[Interval](https://lubridate.tidyverse.org/reference/Interval-class.md)
objects.

## Instants

Instants are specific moments of time. Date, POSIXct, and POSIXlt are
the three object classes Base R recognizes as instants.
[`is.Date()`](https://lubridate.tidyverse.org/reference/date_utils.md)
tests whether an object inherits from the Date class.
[`is.POSIXt()`](https://lubridate.tidyverse.org/reference/posix_utils.md)
tests whether an object inherits from the POSIXlt or POSIXct classes.
[`is.instant()`](https://lubridate.tidyverse.org/reference/is.instant.md)
tests whether an object inherits from any of the three classes.

[`now()`](https://lubridate.tidyverse.org/reference/now.md) returns the
current system time as a POSIXct object.
[`today()`](https://lubridate.tidyverse.org/reference/now.md) returns
the current system date. For convenience, 1970-01-01 00:00:00 is saved
to [origin](https://lubridate.tidyverse.org/reference/origin.md). This
is the instant from which POSIXct times are calculated. Try
`unclass(now())` to see the numeric structure that underlies POSIXct
objects. Each POSIXct object is saved as the number of seconds it
occurred after 1970-01-01 00:00:00.

Conceptually, instants are a combination of measurements on different
units (i.e, years, months, days, etc.). The individual values for these
units can be extracted from an instant and set with the accessor
functions
[`second()`](https://lubridate.tidyverse.org/reference/second.md),
[`minute()`](https://lubridate.tidyverse.org/reference/minute.md),
[`hour()`](https://lubridate.tidyverse.org/reference/hour.md),
[`day()`](https://lubridate.tidyverse.org/reference/day.md),
[`yday()`](https://lubridate.tidyverse.org/reference/day.md),
[`mday()`](https://lubridate.tidyverse.org/reference/day.md),
[`wday()`](https://lubridate.tidyverse.org/reference/day.md),
[`week()`](https://lubridate.tidyverse.org/reference/week.md),
[`month()`](https://lubridate.tidyverse.org/reference/month.md),
[`year()`](https://lubridate.tidyverse.org/reference/year.md),
[`tz()`](https://lubridate.tidyverse.org/reference/tz.md), and
[`dst()`](https://lubridate.tidyverse.org/reference/dst.md). Note: the
accessor functions are named after the singular form of an element. They
shouldn't be confused with the period helper functions that have the
plural form of the units as a name (e.g,
[`seconds()`](https://lubridate.tidyverse.org/reference/period.md)).

## Rounding dates

Instants can be rounded to a convenient unit using the functions
[`ceiling_date()`](https://lubridate.tidyverse.org/reference/round_date.md),
[`floor_date()`](https://lubridate.tidyverse.org/reference/round_date.md)
and
[`round_date()`](https://lubridate.tidyverse.org/reference/round_date.md).

## Time zones

Lubridate provides two helper functions for working with time zones.
[`with_tz()`](https://lubridate.tidyverse.org/reference/with_tz.md)
changes the time zone in which an instant is displayed. The clock time
displayed for the instant changes, but the moment of time described
remains the same.
[`force_tz()`](https://lubridate.tidyverse.org/reference/force_tz.md)
changes only the time zone element of an instant. The clock time
displayed remains the same, but the resulting instant describes a new
moment of time.

## Timespans

A timespan is a length of time that may or may not be connected to a
particular instant. For example, three months is a timespan. So is an
hour and a half. Base R uses difftime class objects to record timespans.
However, people are not always consistent in how they expect time to
behave. Sometimes the passage of time is a monotone progression of
instants that should be as mathematically reliable as the number line.
On other occasions time must follow complex conventions and rules so
that the clock times we see reflect what we expect to observe in terms
of daylight, season, and congruence with the atomic clock. To better
navigate the nuances of time, lubridate creates three additional
timespan classes, each with its own specific and consistent behavior:
[Interval](https://lubridate.tidyverse.org/reference/Interval-class.md),
[Period](https://lubridate.tidyverse.org/reference/Period-class.md) and
[Duration](https://lubridate.tidyverse.org/reference/Duration-class.md).

[`is.difftime()`](https://lubridate.tidyverse.org/reference/is.difftime.md)
tests whether an object inherits from the difftime class.
[`is.timespan()`](https://lubridate.tidyverse.org/reference/is.timespan.md)
tests whether an object inherits from any of the four timespan classes.

## Durations

Durations measure the exact amount of time that occurs between two
instants. This can create unexpected results in relation to clock times
if a leap second, leap year, or change in daylight savings time (DST)
occurs in the interval.

Functions for working with durations include
[`is.duration()`](https://lubridate.tidyverse.org/reference/duration.md),
[`as.duration()`](https://lubridate.tidyverse.org/reference/as.duration.md)
and
[`duration()`](https://lubridate.tidyverse.org/reference/duration.md).
[`dseconds()`](https://lubridate.tidyverse.org/reference/duration.md),
[`dminutes()`](https://lubridate.tidyverse.org/reference/duration.md),
[`dhours()`](https://lubridate.tidyverse.org/reference/duration.md),
[`ddays()`](https://lubridate.tidyverse.org/reference/duration.md),
[`dweeks()`](https://lubridate.tidyverse.org/reference/duration.md) and
[`dyears()`](https://lubridate.tidyverse.org/reference/duration.md)
convenient lengths.

## Periods

Periods measure the change in clock time that occurs between two
instants. Periods provide robust predictions of clock time in the
presence of leap seconds, leap years, and changes in DST.

Functions for working with periods include
[`is.period()`](https://lubridate.tidyverse.org/reference/period.md),
[`as.period()`](https://lubridate.tidyverse.org/reference/as.period.md)
and [`period()`](https://lubridate.tidyverse.org/reference/period.md).
[`seconds()`](https://lubridate.tidyverse.org/reference/period.md),
[`minutes()`](https://lubridate.tidyverse.org/reference/period.md),
[`hours()`](https://lubridate.tidyverse.org/reference/period.md),
[`days()`](https://lubridate.tidyverse.org/reference/period.md),
[`weeks()`](https://lubridate.tidyverse.org/reference/period.md),
[`months()`](https://rdrr.io/r/base/weekday.POSIXt.html) and
[`years()`](https://lubridate.tidyverse.org/reference/period.md) quickly
create periods of convenient lengths.

## Intervals

Intervals are timespans that begin at a specific instant and end at a
specific instant. Intervals retain complete information about a
timespan. They provide the only reliable way to convert between periods
and durations.

Functions for working with intervals include
[`is.interval()`](https://lubridate.tidyverse.org/reference/interval.md),
[`as.interval()`](https://lubridate.tidyverse.org/reference/as.interval.md),
[`interval()`](https://lubridate.tidyverse.org/reference/interval.md),
[`int_shift()`](https://lubridate.tidyverse.org/reference/interval.md),
[`int_flip()`](https://lubridate.tidyverse.org/reference/interval.md),
[`int_aligns()`](https://lubridate.tidyverse.org/reference/interval.md),
[`int_overlaps()`](https://lubridate.tidyverse.org/reference/interval.md),
and
[`%within%`](https://lubridate.tidyverse.org/reference/within-interval.md).
Intervals can also be manipulated with intersect, union, and setdiff().

## Miscellaneous

[`decimal_date()`](https://lubridate.tidyverse.org/reference/decimal_date.md)
converts an instant to a decimal of its year.
[`leap_year()`](https://lubridate.tidyverse.org/reference/leap_year.md)
tests whether an instant occurs during a leap year.
[`pretty_dates()`](https://lubridate.tidyverse.org/reference/pretty_dates.md)
provides a method of making pretty breaks for date-times.
[lakers](https://lubridate.tidyverse.org/reference/lakers.md) is a data
set that contains information about the Los Angeles Lakers 2008-2009
basketball season.

## References

Garrett Grolemund, Hadley Wickham (2011). Dates and Times Made Easy with
lubridate. Journal of Statistical Software, 40(3), 1-25.
<https://www.jstatsoft.org/v40/i03/>.

## See also

Useful links:

- <https://lubridate.tidyverse.org>

- <https://github.com/tidyverse/lubridate>

- Report bugs at <https://github.com/tidyverse/lubridate/issues>

## Author

**Maintainer**: Vitalie Spinu <spinuvit@gmail.com>

Authors:

- Garrett Grolemund

- Hadley Wickham

Other contributors:

- Davis Vaughan \[contributor\]

- Ian Lyttle \[contributor\]

- Imanuel Costigan \[contributor\]

- Jason Law \[contributor\]

- Doug Mitarotonda \[contributor\]

- Joseph Larmarange \[contributor\]

- Jonathan Boiser \[contributor\]

- Chel Hee Lee \[contributor\]
