# Provide a format for ISO8601 dates and times with the requested precision.

Provide a format for ISO8601 dates and times with the requested
precision.

## Usage

``` r
format_ISO8601_precision_check(precision, max_precision, usetz = FALSE)
```

## Arguments

- precision:

  The amount of precision to represent with substrings of "ymdhms", as
  year, month, day, hour, minute, and second. (e.g. "ymd" is days
  precision, "ymdhm" is minute precision. When `NULL`, full precision
  for the object is shown.

- max_precision:

  The maximum precision allowed to be output.

- usetz:

  Include the time zone in the formatting. If `usetz` is `TRUE`, the
  time zone is included. If `usetz` is `"Z"`, the time is converted to
  "UTC" and the time zone is indicated with "Z" ISO8601 notation.
