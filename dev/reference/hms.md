# Parse periods with **h**our, **m**inute, and **s**econd components

Transforms a character or numeric vector into a period object with the
specified number of hours, minutes, and seconds. `hms()` recognizes all
non-numeric characters except '-' as separators ('-' is used for
negative `durations`). After hours, minutes and seconds have been
parsed, the remaining input is ignored.

## Usage

``` r
ms(..., quiet = FALSE, roll = FALSE)

hm(..., quiet = FALSE, roll = FALSE)

hms(..., quiet = FALSE, roll = FALSE)
```

## Arguments

- ...:

  a character vector of hour minute second triples

- quiet:

  logical. If `TRUE`, function evaluates without displaying customary
  messages.

- roll:

  logical. If `TRUE`, smaller units are rolled over to higher units if
  they exceed the conventional limit. For example,
  `hms("01:59:120", roll = TRUE)` produces period "2H 1M 0S".

## Value

a vector of period objects

## See also

`hm()`, `ms()`

## Examples

``` r
ms(c("09:10", "09:02", "1:10"))
#> [1] "9M 10S" "9M 2S"  "1M 10S"
ms("7 6")
#> [1] "7M 6S"
ms("6,5")
#> [1] "6M 5S"
hm(c("09:10", "09:02", "1:10"))
#> [1] "9H 10M 0S" "9H 2M 0S"  "1H 10M 0S"
hm("7 6")
#> [1] "7H 6M 0S"
hm("6,5")
#> [1] "6H 5M 0S"

x <- c("09:10:01", "09:10:02", "09:10:03")
hms(x)
#> [1] "9H 10M 1S" "9H 10M 2S" "9H 10M 3S"

hms("7 6 5", "3:23:::2", "2 : 23 : 33", "Finished in 9 hours, 20 min and 4 seconds")
#> [1] "7H 6M 5S"   "3H 23M 2S"  "2H 23M 33S" "9H 20M 4S" 
```
