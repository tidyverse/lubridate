# Setup

## Platform

|setting  |value                                  |
|:--------|:--------------------------------------|
|version  |R version 3.2.4 RC (2016-03-02 r70278) |
|system   |x86_64, linux-gnu                      |
|ui       |X11                                    |
|language |                                       |
|collate  |en_GB.UTF-8                            |
|tz       |Europe/Amsterdam                       |
|date     |2016-08-25                             |

## Packages

|package   |*  |version    |date       |source                   |
|:---------|:--|:----------|:----------|:------------------------|
|covr      |   |2.2.1      |2016-08-10 |cran (@2.2.1)            |
|knitr     |   |1.14       |2016-08-13 |cran (@1.14)             |
|lubridate |*  |1.5.6.9000 |2016-08-25 |local (hadley/lubridate) |
|stringr   |   |1.1.0      |2016-08-19 |cran (@1.1.0)            |
|testthat  |*  |1.0.2      |2016-04-23 |CRAN (R 3.2.4)           |

# Check results
18 packages with problems

## ggspectra (0.1.8)
Maintainer: Pedro J. Aphalo <pedro.aphalo@helsinki.fi>
Bug reports: https://bitbucket.org/aphalo/ggspectra

1 error  | 0 warnings | 2 notes

```
checking examples ... ERROR
Running examples in ‘ggspectra-Ex.R’ failed
The error most likely occurred in:

> base::assign(".ptime", proc.time(), pos = "CheckExEnv")
> ### Name: plot.source_spct
> ### Title: Plot method for light-source spectra.
> ### Aliases: plot.source_spct
> ### Keywords: hplot
>
> ### ** Examples
>
> library(photobiology)
> plot(sun.spct)
> plot(sun.spct, unit.out = "photon")
> plot(sun.daily.spct)
Error: Incompatible duration classes (character, Duration). Please coerce with `as.duration`.
Execution halted

checking Rd cross-references ... NOTE
Package unavailable to check Rd xrefs: ‘ggrepel’

checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Warning: It seems you should call rmarkdown::render() instead of knitr::knit2html() because user-guide.Rmd appears to be an R Markdown v2 document.
Quitting from lines 791-792 (user-guide.Rmd)
Error: processing vignette 'user-guide.Rmd' failed with diagnostics:
Incompatible duration classes (character, Duration). Please coerce with `as.duration`.
Execution halted

```

## hms (0.2)
Maintainer: Kirill Müller <krlmlr+r@mailbox.org>
Bug reports: https://github.com/rstats-db/hms/issues

1 error  | 0 warnings | 0 notes

```
checking tests ... ERROR
Running the tests in ‘tests/testthat.R’ failed.
Last 13 lines of output:
  > library(hms)
  >
  > test_check("hms")
  1. Failure: period (@test-lubridate.R#18) --------------------------------------
  expect_identical(...) showed 0 messages


  testthat results ================================================================
  OK: 94 SKIPPED: 0 FAILED: 1
  1. Failure: period (@test-lubridate.R#18)

  Error: testthat unit tests failed
  Execution halted
```


## photobiology (0.9.9)
Maintainer: Pedro J. Aphalo <pedro.aphalo@helsinki.fi>
Bug reports: https://bitbucket.org/aphalo/photobiology/issues

1 error  | 0 warnings | 0 notes

```
checking examples ... ERROR
Running examples in ‘photobiology-Ex.R’ failed
The error most likely occurred in:

> base::assign(".ptime", proc.time(), pos = "CheckExEnv")
> ### Name: setTimeUnit
> ### Title: Set the "time.unit" attribute of an existing source_spct object
> ### Aliases: setTimeUnit
>
> ### ** Examples
>
> my.spct <- sun.spct
> setTimeUnit(my.spct, time.unit = "second")
> setTimeUnit(my.spct, time.unit = lubridate::duration(1, "seconds"))
Error: Incompatible duration classes (character, Duration). Please coerce with `as.duration`.
Execution halted
```

## ropenaq (0.1.1)
Maintainer: Maëlle Salmon <maelle.salmon@yahoo.se>
Bug reports: http://github.com/ropenscilabs/ropenaq/issues

1 error  | 0 warnings | 1 note

```
checking tests ... ERROR
Running the tests in ‘tests/testthat.R’ failed.
Last 13 lines of output:
  test_that("leap_year handles various classes of date-time object",{
                                                                    ^
  tests/testthat/test-utilities.R:22:1: style: Trailing whitespace is superfluous.

  ^~


  testthat results ================================================================
  OK: 3 SKIPPED: 15 FAILED: 1
  1. Failure: Package Style (@tests.R#7)

  Error: testthat unit tests failed
  Execution halted

checking package dependencies ... NOTE
Package suggested but not available for checking: ‘openair’
```

## sweidnumbr (1.2.0)
Maintainer: Mans Magnusson <mons.magnusson@gmail.com>
Bug reports: https://github.com/rOpenGov/sweidnumbr/issues

1 error  | 0 warnings | 0 notes

```
checking tests ... ERROR
Running the tests in ‘tests/testthat.R’ failed.
Last 13 lines of output:
  sweidnumbr: R tools to handle swedish identity numbers.
  https://github.com/rOpenGov/sweidnumbr

  1. Failure: Negative ages (@test-pin_age.R#36) ---------------------------------
  pin_age(pin = c("200002281234", "200002281234"), date = c("2000-01-01")) showed 0 warnings


  testthat results ================================================================
  OK: 179 SKIPPED: 0 FAILED: 1
  1. Failure: Negative ages (@test-pin_age.R#36)

  Error: testthat unit tests failed
  Execution halted
```
