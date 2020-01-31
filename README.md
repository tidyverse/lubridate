
<!-- README.md is generated from README.Rmd. Please edit that file -->

# lubridate <img src="man/figures/logo.png" align="right" />

[![Build
Status](https://travis-ci.org/tidyverse/lubridate.svg?branch=master)](https://travis-ci.org/tidyverse/lubridate)
[![R build
status](https://github.com/tidyverse/lubridate/workflows/R-CMD-check/badge.svg)](https://github.com/tidyverse/lubridate)
[![Coverage
Status](https://codecov.io/gh/tidyverse/lubridate/branch/master/graph/badge.svg)](https://codecov.io/gh/tidyverse/lubridate)
[![CRAN RStudio mirror
downloads](http://cranlogs.r-pkg.org/badges/lubridate)](https://cran.r-project.org/package=lubridate)
[![Development
version](https://img.shields.io/badge/devel-1.7.4.9000-orange.svg)](https://github.com/tidyverse/lubridate)
[![CRAN
version](http://www.r-pkg.org/badges/version/lubridate)](https://cran.r-project.org/package=lubridate)

## Overview

Date-time data can be frustrating to work with in R. R commands for
date-times are generally unintuitive and change depending on the type of
date-time object being used. Moreover, the methods we use with
date-times must be robust to time zones, leap days, daylight savings
times, and other time related quirks, and R lacks these capabilities in
some situations. Lubridate makes it easier to do the things R does with
date-times and possible to do the things R does not.

If you are new to lubridate, the best place to start is the [date and
times chapter](http://r4ds.had.co.nz/dates-and-times.html) in R for data
science.

## Installation

``` r
# The easiest way to get lubridate is to install the whole tidyverse:
install.packages("tidyverse")

# Alternatively, install just lubridate:
install.packages("lubridate")

# Or the the development version from GitHub:
# install.packages("devtools")
devtools::install_github("tidyverse/lubridate")
```

## Cheatsheet

<a href="https://rawgit.com/rstudio/cheatsheets/master/lubridate.pdf"><img src="https://raw.githubusercontent.com/rstudio/cheatsheets/master/pngs/thumbnails/lubridate-cheatsheet-thumbs.png" width="630" height="252"/></a>

## Features

  - Easy and fast parsing of date-times: `ymd()`, `ymd_hms`, `dmy()`,
    `dmy_hms`, `mdy()`, …
    
    ``` r
    ymd(20101215)
    #> [1] "2010-12-15"
    mdy("4/1/17")
    #> [1] "2017-04-01"
    ```

  - Simple functions to get and set components of a date-time, such as
    `year()`, `month()`, `mday()`, `hour()`, `minute()` and `second()`:
    
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

  - Helper functions for handling time zones: `with_tz()`, `force_tz()`
    
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
classes borrowed from <http://joda.org>.

  - `durations`, which measure the exact amount of time between two
    points

  - `periods`, which accurately track clock times despite leap years,
    leap seconds, and day light savings time

  - `intervals`, a protean summary of the time information between two
    points

## Code of Conduct

Please note that the lubridate project is released with a [Contributor
Code of Conduct](http://lubridate.tidyverse.org/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
