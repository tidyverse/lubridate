# Format dates and times based on human-friendly templates

Stamps are just like [`format()`](https://rdrr.io/r/base/format.html),
but based on human-friendly templates like "Recorded at 10 am, September
2002" or "Meeting, Sunday May 1, 2000, at 10:20 pm".

## Usage

``` r
stamp(
  x,
  orders = lubridate_formats,
  locale = Sys.getlocale("LC_TIME"),
  quiet = FALSE,
  exact = FALSE
)

stamp_date(x, locale = Sys.getlocale("LC_TIME"), quiet = FALSE)

stamp_time(x, locale = Sys.getlocale("LC_TIME"), quiet = FALSE)
```

## Arguments

- x:

  a character vector of templates.

- orders:

  orders are sequences of formatting characters which might be used for
  disambiguation. For example "ymd hms", "aym" etc. See
  [`guess_formats()`](https://lubridate.tidyverse.org/dev/reference/guess_formats.md)
  for a list of available formats.

- locale:

  locale in which `x` is encoded. On Linux-like systems use `locale -a`
  in the terminal to list available locales.

- quiet:

  whether to output informative messages.

- exact:

  logical. If `TRUE`, the `orders` parameter is interpreted as an exact
  [`base::strptime()`](https://rdrr.io/r/base/strptime.html) format and
  no format guessing is performed.

## Value

a function to be applied on a vector of dates

## Details

`stamp()` is a stamping function date-time templates mainly, though it
correctly handles all date and time formats as long as they are
unambiguous. `stamp_date()`, and `stamp_time()` are the specialized
stamps for dates and times (MHS). These function might be useful when
the input template is unambiguous and matches both a time and a date
format.

Lubridate tries hard to guess the formats, but often a given format can
be interpreted in multiple ways. One way to deal with such cases is to
provide unambiguous formats like 22/05/81 instead of 10/05/81 for d/m/y
format. Another way is to use a more specialized `stamp_date` and
`stamp_time`. The core function `stamp()` prioritizes longer date-time
formats.

If `x` is a vector of values lubridate will choose the format which
"fits" `x` the best. Note that longer formats are preferred. If you have
"22:23:00 PM" then "HMSp" format will be given priority to shorter "HMS"
order which also fits the supplied string.

Finally, you can give desired format order directly as `orders`
argument.

## See also

[`guess_formats()`](https://lubridate.tidyverse.org/dev/reference/guess_formats.md),
[`parse_date_time()`](https://lubridate.tidyverse.org/dev/reference/parse_date_time.md),
[`strptime()`](https://rdrr.io/r/base/strptime.html)

## Examples

``` r
D <- ymd("2010-04-05") - days(1:5)
stamp("March 1, 1999")(D)
#> Multiple formats matched: "%Om %d, %Y"(1), "March %Om, %Y"(1), "%B %d, %Y"(1), "March %m, %Y"(1)
#> Using: "%B %d, %Y"
#> [1] "April 04, 2010" "April 03, 2010" "April 02, 2010" "April 01, 2010"
#> [5] "March 31, 2010"
sf <- stamp("Created on Sunday, Jan 1, 1999 3:34 pm")
#> Multiple formats matched: "Created on %A, %b %d, %Y %I:%M %p"(1), "Created on Sunday, %b %d, %Y %I:%M %p"(1), "Created on %A, %Om %d, %Y %I:%M %p"(0), "Created on Sunday, %Om %d, %Y %I:%M %p"(0)
#> Using: "Created on %A, %b %d, %Y %I:%M %p"
sf(D)
#> [1] "Created on Sunday, Apr 04, 2010 12:00 AM"   
#> [2] "Created on Saturday, Apr 03, 2010 12:00 AM" 
#> [3] "Created on Friday, Apr 02, 2010 12:00 AM"   
#> [4] "Created on Thursday, Apr 01, 2010 12:00 AM" 
#> [5] "Created on Wednesday, Mar 31, 2010 12:00 AM"
stamp("Jan 01")(D)
#> Multiple formats matched: "%Om %y"(1), "%Om %d"(1), "Jan %Om"(1), "%b %d"(1), "Jan %H"(1), "Jan %m"(1), "Jan %y"(1), "%b %y"(0)
#> Using: "%Om %y"
#> [1] "04 10" "04 10" "04 10" "04 10" "03 10"
stamp("Sunday, May 1, 2000", locale = "C")(D)
#> Multiple formats matched: "%A, %b %d, %Y"(1), "Sunday, %Om %d, %Y"(1), "Sunday, May %Om, %Y"(1), "Sunday, %b %d, %Y"(1), "Sunday, May %m, %Y"(1), "%A, %Om %d, %Y"(0), "%A, May %Om, %Y"(0), "%A, May %m, %Y"(0)
#> Using: "%A, %b %d, %Y"
#> [1] "Sunday, Apr 04, 2010"    "Saturday, Apr 03, 2010" 
#> [3] "Friday, Apr 02, 2010"    "Thursday, Apr 01, 2010" 
#> [5] "Wednesday, Mar 31, 2010"
stamp("Sun Aug 5")(D) #=> "Sun Aug 04" "Sat Aug 04" "Fri Aug 04" "Thu Aug 04" "Wed Aug 03"
#> Multiple formats matched: "%a %b %d"(1), "%a Aug %H"(1), "Sun %Om %d"(1), "Sun Aug %Om"(1), "Sun %b %d"(1), "Sun Aug %H"(1), "Sun Aug %m"(1), "%a %Om %d"(0), "%a Aug %Om"(0), "%a Aug %m"(0)
#> Using: "%a %b %d"
#> [1] "Sun Apr 04" "Sat Apr 03" "Fri Apr 02" "Thu Apr 01" "Wed Mar 31"
stamp("12/31/99")(D)              #=> "06/09/11"
#> Multiple formats matched: "%Om/%d/%y"(1), "%m/%d/%y"(1)
#> Using: "%Om/%d/%y"
#> [1] "04/04/10" "04/03/10" "04/02/10" "04/01/10" "03/31/10"
stamp("Sunday, May 1, 2000 22:10", locale = "C")(D)
#> Multiple formats matched: "%A, May %Om, %Y %d:%H"(1), "%A, %b %d, %Y %H:%M"(1), "%A, May %m, %Y %d:%H"(1), "Sunday, %Om %d, %Y %H:%M"(1), "Sunday, May %Om, %Y %d:%H"(1), "Sunday, %b %d, %Y %H:%M"(1), "Sunday, May %m, %Y %d:%H"(1), "%A, %Om %d, %Y %H:%M"(0)
#> Using: "%A, %b %d, %Y %H:%M"
#> [1] "Sunday, Apr 04, 2010 00:00"    "Saturday, Apr 03, 2010 00:00" 
#> [3] "Friday, Apr 02, 2010 00:00"    "Thursday, Apr 01, 2010 00:00" 
#> [5] "Wednesday, Mar 31, 2010 00:00"
stamp("2013-01-01T06:00:00Z")(D)
#> Multiple formats matched: "%Y-%Om-%dT%H:%M:%S%Ou"(1), "%Y-%Om-%dT%H:%M:%SZ"(1), "%Y-%d-%OmT%H:%M:%SZ"(1), "%Y-%m-%dT%H:%M:%S%Ou"(1), "%Y-%m-%dT%H:%M:%SZ"(1), "%Y-%d-%mT%H:%M:%SZ"(1)
#> Using: "%Y-%Om-%dT%H:%M:%S%Ou"
#> [1] "2010-04-04T00:00:00Z" "2010-04-03T00:00:00Z"
#> [3] "2010-04-02T00:00:00Z" "2010-04-01T00:00:00Z"
#> [5] "2010-03-31T00:00:00Z"
stamp("2013-01-01T00:00:00-06")(D)
#> Multiple formats matched: "%Y-%Om-%dT%H:%M:%S%Oo"(1), "%Y-%m-%dT%H:%M:%S%Oo"(1)
#> Using: "%Y-%Om-%dT%H:%M:%S%Oo"
#> [1] "2010-04-04T00:00:00+00" "2010-04-03T00:00:00+00"
#> [3] "2010-04-02T00:00:00+00" "2010-04-01T00:00:00+00"
#> [5] "2010-03-31T00:00:00+00"
stamp("2013-01-01T00:00:00-08:00")(force_tz(D, "America/Chicago"))
#> Multiple formats matched: "%Y-%Om-%dT%H:%M:%S%OO"(1), "%Y-%m-%dT%H:%M:%S%OO"(1)
#> Using: "%Y-%Om-%dT%H:%M:%S%OO"
#> [1] "2010-04-04T00:00:00-05:00" "2010-04-03T00:00:00-05:00"
#> [3] "2010-04-02T00:00:00-05:00" "2010-04-01T00:00:00-05:00"
#> [5] "2010-03-31T00:00:00-05:00"
```
