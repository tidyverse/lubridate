# Interval class

Interval is an S4 class that extends the
[Timespan](https://lubridate.tidyverse.org/dev/reference/Timespan-class.md)
class. An Interval object records one or more spans of time. Intervals
record these timespans as a sequence of seconds that begin at a
specified date. Since intervals are anchored to a precise moment of
time, they can accurately be converted to
[Period](https://lubridate.tidyverse.org/dev/reference/Period-class.md)
or
[Duration](https://lubridate.tidyverse.org/dev/reference/Duration-class.md)
class objects. This is because we can observe the length in seconds of
each period that begins on a specific date. Contrast this to a
generalized period, which may not have a consistent length in seconds
(e.g. the number of seconds in a year will change if it is a leap year).

## Details

Intervals can be both negative and positive. Negative intervals progress
backwards from the start date; positive intervals progress forwards.

Interval class objects have two slots: .Data, a numeric object equal to
the number of seconds in the interval; and start, a POSIXct object that
specifies the time when the interval starts.
