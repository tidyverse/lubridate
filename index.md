# lubridate

## Overview

Date-time data can be frustrating to work with in R. R commands for
date-times are generally unintuitive and change depending on the type of
date-time object being used. Moreover, the methods we use with
date-times must be robust to time zones, leap days, daylight savings
times, and other time related quirks, and R lacks these capabilities in
some situations. Lubridate makes it easier to do the things R does with
date-times and possible to do the things R does not.

If you are new to lubridate, the best place to start is the [date and
times chapter](https://r4ds.had.co.nz/dates-and-times.html) in R for
data science.

## Installation

``` r
# The easiest way to get lubridate is to install the whole tidyverse:
install.packages("tidyverse")

# Alternatively, install just lubridate:
install.packages("lubridate")

# Or the development version from GitHub:
# install.packages("devtools")
devtools::install_github("tidyverse/lubridate")
```

## Cheatsheet

[![](https://raw.githubusercontent.com/rstudio/cheatsheets/main/pngs/thumbnails/lubridate-cheatsheet-thumbs.png)](https://rawgit.com/rstudio/cheatsheets/main/lubridate.pdf)

## Features

``` r
library(lubridate, warn.conflicts = FALSE)
```

- Easy and fast parsing of date-times:
  [`ymd()`](https://lubridate.tidyverse.org/reference/ymd.md),
  `ymd_hms`,
  [`dmy()`](https://lubridate.tidyverse.org/reference/ymd.md),
  `dmy_hms`,
  [`mdy()`](https://lubridate.tidyverse.org/reference/ymd.md), …

  ``` r
  ymd(20101215)
  #> [1] "2010-12-15"
  mdy("4/1/17")
  #> [1] "2017-04-01"
  ```

- Simple functions to get and set components of a date-time, such as
  [`year()`](https://lubridate.tidyverse.org/reference/year.md),
  [`month()`](https://lubridate.tidyverse.org/reference/month.md),
  [`mday()`](https://lubridate.tidyverse.org/reference/day.md),
  [`hour()`](https://lubridate.tidyverse.org/reference/hour.md),
  [`minute()`](https://lubridate.tidyverse.org/reference/minute.md) and
  [`second()`](https://lubridate.tidyverse.org/reference/second.md):

  ``` r
  bday <- dmy("14/10/1979")
  month(bday)
  #> [1] 10
  wday(bday, label = TRUE)
  #> [1] Sun
  #> Levels: Sun < Mon < Tue < Wed < Thu < Fri < Sat

  year(bday) <- 2016
  wday(bday, label = TRUE)
  #> [1] Fri
  #> Levels: Sun < Mon < Tue < Wed < Thu < Fri < Sat
  ```

- Helper functions for handling time zones:
  [`with_tz()`](https://lubridate.tidyverse.org/reference/with_tz.md),
  [`force_tz()`](https://lubridate.tidyverse.org/reference/force_tz.md)

  ``` r
  time <- ymd_hms("2010-12-13 15:30:30")
  time
  #> [1] "2010-12-13 15:30:30 UTC"

  # Changes printing
  with_tz(time, "America/Chicago")
  #> [1] "2010-12-13 09:30:30 CST"

  # Changes time
  force_tz(time, "America/Chicago")
  #> [1] "2010-12-13 15:30:30 CST"
  ```

Lubridate also expands the type of mathematical operations that can be
performed with date-time objects. It introduces three new time span
classes borrowed from <https://www.joda.org>.

- `durations`, which measure the exact amount of time between two points

- `periods`, which accurately track clock times despite leap years, leap
  seconds, and day light savings time

- `intervals`, a protean summary of the time information between two
  points

## Code of Conduct

Please note that the lubridate project is released with a [Contributor
Code of Conduct](https://lubridate.tidyverse.org/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
