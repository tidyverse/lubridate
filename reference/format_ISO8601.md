# Format in ISO8601 character format

Format in ISO8601 character format

## Usage

``` r
format_ISO8601(x, usetz = FALSE, precision = NULL, ...)
```

## Arguments

- x:

  An object to convert to ISO8601 character format.

- usetz:

  Include the time zone in the formatting. If `usetz` is `TRUE`, the
  time zone is included. If `usetz` is `"Z"`, the time is converted to
  "UTC" and the time zone is indicated with "Z" ISO8601 notation.

- precision:

  The amount of precision to represent with substrings of "ymdhms", as
  year, month, day, hour, minute, and second. (e.g. "ymd" is days
  precision, "ymdhm" is minute precision. When `NULL`, full precision
  for the object is shown.

- ...:

  Additional arguments to methods.

## Value

A character vector of ISO8601-formatted text.

## References

<https://en.wikipedia.org/wiki/ISO_8601>

## Examples

``` r
format_ISO8601(as.Date("02-01-2018", format = "%m-%d-%Y"))
#> [1] "2018-02-01"
format_ISO8601(as.POSIXct("2018-02-01 03:04:05", tz = "America/New_York"), usetz = TRUE)
#> [1] "2018-02-01T03:04:05-0500"
format_ISO8601(as.POSIXct("2018-02-01 03:04:05", tz = "America/New_York"), precision = "ymdhm")
#> [1] "2018-02-01T03:04"
```
