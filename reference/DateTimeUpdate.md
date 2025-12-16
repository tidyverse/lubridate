# Changes the components of a date object

`update.Date()` and `update.POSIXt()` return a date with the specified
elements updated. Elements not specified will be left unaltered.
update.Date and update.POSIXt do not add the specified values to the
existing date, they substitute them for the appropriate parts of the
existing date.

## Usage

``` r
# S3 method for class 'POSIXt'
update(
  object,
  ...,
  roll_dst = c("NA", "post"),
  week_start = getOption("lubridate.week.start", 7),
  roll = NULL,
  simple = NULL
)
```

## Arguments

- object:

  a date-time object

- ...:

  named arguments: years, months, ydays, wdays, mdays, days, hours,
  minutes, seconds, tzs (time zone component)

- roll_dst:

  is a string vector of length one or two. When two values are supplied
  they specify how to roll date-times when they fall into "skipped" and
  "repeated" DST transitions respectively. A single value is replicated
  to the length of two. Possible values are:

      * `pre` - Use the time before the transition boundary.
      * `boundary` - Use the time exactly at the boundary transition.
      * `post` - Use the time after the boundary transition.
      * `xfirst` - crossed-first: First time which occurred when crossing the
         boundary. For addition with positive units pre interval is crossed first and
         post interval last. With negative units post interval is crossed first, pre -
         last. For subtraction the logic is reversed.
      * `xlast` - crossed-last.
      * `NA` - Produce NAs when the resulting time falls inside the problematic interval.

  For example \`roll_dst = c("NA", "pre") indicates that for skipped
  intervals return NA and for repeated times return the earlier time.

  When multiple units are supplied the meaning of "negative period" is
  determined by the largest unit. For example
  `time_add(t, days = -1, hours = 2, roll_dst = "xfirst")` would operate
  as if with negative period, thus crossing the boundary from the "post"
  to "pre" side and "xfirst" and hence resolving to "post" time. As this
  might result in confusing behavior. See examples.

  "xfirst" and "xlast" make sense for addition and subtraction only. An
  error is raised if an attempt is made to use them with other
  functions.

- week_start:

  week start day (Default is 7, Sunday. Set `lubridate.week.start` to
  override). Full or abbreviated names of the days of the week can be in
  English or as provided by the current locale.

- simple, roll:

  deprecated

## Value

a date object with the requested elements updated. The object will
retain its original class unless an element is updated which the
original class does not support. In this case, the date returned will be
a POSIXlt date object.

## Examples

``` r
date <- ymd("2009-02-10")
update(date, year = 2010, month = 1, mday = 1)
#> [1] "2010-01-01"

update(date, year = 2010, month = 13, mday = 1)
#> [1] "2011-01-01"

update(date, minute = 10, second = 3)
#> [1] "2009-02-10 00:10:03 UTC"
```
