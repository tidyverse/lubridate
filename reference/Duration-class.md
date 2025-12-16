# Duration class

Duration is an S4 class that extends the
[Timespan](https://lubridate.tidyverse.org/reference/Timespan-class.md)
class. Durations record the exact number of seconds in a time span. They
measure the exact passage of time but do not always align with
measurements made in larger units of time such as hours, months and
years. This is because the exact length of larger time units can be
affected by conventions such as leap years and Daylight Savings Time.

## Details

Durations provide a method for measuring generalized timespans when we
wish to treat time as a mathematical quantity that increases in a
uniform, monotone manner along a continuous number line. They allow
exact comparisons with other durations. See
[Period](https://lubridate.tidyverse.org/reference/Period-class.md) for
an alternative way to measure timespans that better preserves clock
times.

Durations class objects have one slot: .Data, a numeric object equal to
the number of seconds in the duration.
