# Efficient creation of date-times from numeric representations

`make_datetime()` is a very fast drop-in replacement for
[`base::ISOdate()`](https://rdrr.io/r/base/ISOdatetime.html) and
[`base::ISOdatetime()`](https://rdrr.io/r/base/ISOdatetime.html).
`make_date()` produces objects of class `Date`.

## Usage

``` r
make_datetime(
  year = 1970L,
  month = 1L,
  day = 1L,
  hour = 0L,
  min = 0L,
  sec = 0,
  tz = "UTC"
)

make_date(year = 1970L, month = 1L, day = 1L)
```

## Arguments

- year:

  numeric year

- month:

  numeric month

- day:

  numeric day

- hour:

  numeric hour

- min:

  numeric minute

- sec:

  numeric second

- tz:

  time zone. Defaults to UTC.

## Details

Input vectors are silently recycled. All inputs except `sec` are
silently converted to integer vectors; `sec` can be either integer or
double.

## Examples

``` r
make_datetime(year = 1999, month = 12, day = 22, sec = 10)
#> [1] "1999-12-22 00:00:10 UTC"
make_datetime(year = 1999, month = 12, day = 22, sec = c(10, 11))
#> [1] "1999-12-22 00:00:10 UTC" "1999-12-22 00:00:11 UTC"
```
