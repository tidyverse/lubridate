# Does a date (or interval) fall within an interval?

Check whether `a` lies within the interval `b`, inclusive of the
endpoints.

## Usage

``` r
a %within% b
```

## Arguments

- a:

  An interval or date-time object.

- b:

  Either an interval vector, or a list of intervals.

  If `b` is an interval (or interval vector) it is recycled to the same
  length as `a`. If `b` is a list of intervals, `a` is checked if it
  falls within *any* of the intervals, i.e.
  `a %within% list(int1, int2)` is equivalent to
  `a %within% int1 | a %within% int2`.

## Value

A logical vector.

## Examples

``` r
int <- interval(ymd("2001-01-01"), ymd("2002-01-01"))
int2 <- interval(ymd("2001-06-01"), ymd("2002-01-01"))

ymd("2001-05-03") %within% int # TRUE
#> [1] TRUE
int2 %within% int # TRUE
#> [1] TRUE
ymd("1999-01-01") %within% int # FALSE
#> [1] FALSE

## recycling (carefully note the difference between using a vector of
## intervals and list of intervals for the second argument)
dates <- ymd(c("2014-12-20", "2014-12-30", "2015-01-01", "2015-01-03"))
blackout_vector <- c(
  interval(ymd("2014-12-30"), ymd("2014-12-31")),
  interval(ymd("2014-12-30"), ymd("2015-01-03"))
)
dates %within% blackout_vector
#> [1] FALSE  TRUE FALSE  TRUE

## within ANY of the intervals of a list
dates <- ymd(c("2014-12-20", "2014-12-30", "2015-01-01", "2015-01-03"))
lst <- list(
  interval(ymd("2014-12-30"), ymd("2014-12-31")),
  interval(ymd("2014-12-30"), ymd("2015-01-03"))
)
dates %within% lst
#> [1] FALSE  TRUE  TRUE  TRUE

## interval within a list of intervals
int <- interval(
  ymd("2014-12-20", "2014-12-30"),
  ymd("2015-01-01", "2015-01-03")
)
int %within% lst
#> [1] FALSE  TRUE
```
