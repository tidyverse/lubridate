# Convert an object to a date or date-time

Convert an object to a date or date-time

## Usage

``` r
as_date(x, ...)

# S4 method for class 'ANY'
as_date(x, ...)

# S4 method for class 'POSIXt'
as_date(x, tz = NULL)

# S4 method for class 'numeric'
as_date(x, origin = lubridate::origin)

# S4 method for class 'character'
as_date(x, tz = NULL, format = NULL)

as_datetime(x, ...)

# S4 method for class 'ANY'
as_datetime(x, tz = lubridate::tz(x))

# S4 method for class 'POSIXt'
as_datetime(x, tz = lubridate::tz(x))

# S4 method for class 'numeric'
as_datetime(x, origin = lubridate::origin, tz = "UTC")

# S4 method for class 'character'
as_datetime(x, tz = "UTC", format = NULL)

# S4 method for class 'Date'
as_datetime(x, tz = "UTC")
```

## Arguments

- x:

  a vector of [POSIXt](https://rdrr.io/r/base/DateTimeClasses.html),
  numeric or character objects

- ...:

  further arguments to be passed to specific methods (see above).

- tz:

  a time zone name (default: time zone of the POSIXt object `x`). See
  [`OlsonNames()`](https://rdrr.io/r/base/timezones.html).

- origin:

  a Date object, or something which can be coerced by
  `as.Date(origin, ...)` to such an object (default: the Unix epoch of
  "1970-01-01"). Note that in this instance, `x` is assumed to reflect
  the number of days since `origin` at `"UTC"`.

- format:

  format argument for character methods. When supplied parsing is
  performed by `parse_date_time(x, orders = formats, exact = TRUE)`.
  Thus, multiple formats are supported and are tried in turn.

## Value

a vector of
[Date](https://lubridate.tidyverse.org/dev/reference/date_utils.md)
objects corresponding to `x`.

## Compare to base R

These are drop in replacements for
[`as.Date()`](https://rdrr.io/r/base/as.Date.html) and
[`as.POSIXct()`](https://rdrr.io/r/base/as.POSIXlt.html), with a few
tweaks to make them work more intuitively.

- Called on a `POSIXct` object, `as_date()` uses the tzone attribute of
  the object to return the same date as indicated by the printed
  representation of the object. This differs from as.Date, which ignores
  the attribute and uses only the tz argument to
  [`as.Date()`](https://rdrr.io/r/base/as.Date.html) ("UTC" by default).

- Both functions provide a default origin argument for numeric vectors.

- Both functions will generate NAs for invalid date format. Valid
  formats are those described by ISO8601 standard. A warning message
  will provide a count of the elements that were not converted.

- `as_datetime()` defaults to using UTC.

## Examples

``` r
dt_utc <- ymd_hms("2010-08-03 00:50:50")
dt_europe <- ymd_hms("2010-08-03 00:50:50", tz = "Europe/London")
c(as_date(dt_utc), as.Date(dt_utc))
#> [1] "2010-08-03" "2010-08-03"
c(as_date(dt_europe), as.Date(dt_europe))
#> [1] "2010-08-03" "2010-08-02"
## need not supply origin
as_date(10)
#> [1] "1970-01-11"
## Will replace invalid date format with NA
dt_wrong <- c("2009-09-29", "2012-11-29", "2015-29-12")
as_date(dt_wrong)
#> Warning:  1 failed to parse.
#> [1] "2009-09-29" "2012-11-29" NA          
```
