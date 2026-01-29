# The current day and time

The current day and time

## Usage

``` r
now(tzone = "")

today(tzone = "")
```

## Arguments

- tzone:

  a character vector specifying which time zone you would like the
  current time in. tzone defaults to your computer's system timezone.
  You can retrieve the current time in the Universal Coordinated Time
  (UTC) with now("UTC").

## Value

`now` - the current datetime as a `POSIXct` object

## Examples

``` r
now()
#> [1] "2026-01-29 20:40:17 UTC"
now("GMT")
#> [1] "2026-01-29 20:40:17 GMT"
now("")
#> [1] "2026-01-29 20:40:17 UTC"
now() == now() # would be TRUE if computer processed both at the same instant
#> [1] FALSE
now() < now() # TRUE
#> [1] TRUE
now() > now() # FALSE
#> [1] FALSE
today()
#> [1] "2026-01-29"
today("GMT")
#> [1] "2026-01-29"
today() == today("GMT") # not always true
#> [1] TRUE
today() < as.Date("2999-01-01") # TRUE  (so far)
#> [1] TRUE
```
