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

## crawl (2.0.1)
Maintainer: Devin S. Johnson <devin.johnson@noaa.gov>

1 error  | 0 warnings | 0 notes

```
checking whether package ‘crawl’ can be installed ... ERROR
Installation failed.
See ‘/store/Dropbox/dev/lubridate/revdep/checks/crawl.Rcheck/00install.out’ for details.
```

## drsmooth (1.9.0)
Maintainer: Anne Bichteler <abichteler@toxstrategies.com>

2 errors | 0 warnings | 0 notes

```
checking examples ... ERROR
Running examples in ‘drsmooth-Ex.R’ failed
The error most likely occurred in:

> base::assign(".ptime", proc.time(), pos = "CheckExEnv")
> ### Name: noel
> ### Title: No/Lowest Observed Effect Levels
> ### Aliases: noel
> 
> ### ** Examples
> 
> # Prints all available tests of no/lowest observed effect levels at default alpha=.05:
> data(DRdata)
> noel("dose", "MF_Log", data=DRdata)
Error in loadNamespace(name) : there is no package called ‘multcomp’
Calls: noel ... tryCatch -> tryCatchList -> tryCatchOne -> <Anonymous>
Execution halted

checking tests ... ERROR
Running the tests in ‘tests/test-all.R’ failed.
Last 13 lines of output:
  
  Attaching package: 'drsmooth'
  
  The following object is masked from 'package:stats':
  
      smooth
  
  > 
  > # test scripts do not seem to recognize loaded libraries:
  > library(car)
  > library(multcomp)
  Error in library(multcomp) : there is no package called 'multcomp'
  Execution halted
```

## dtwSat (0.2.1)
Maintainer: Victor Maus <vwmaus1@gmail.com>

1 error  | 0 warnings | 0 notes

```
checking whether package ‘dtwSat’ can be installed ... ERROR
Installation failed.
See ‘/store/Dropbox/dev/lubridate/revdep/checks/dtwSat.Rcheck/00install.out’ for details.
```

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

## ggvis (0.4.3)
Maintainer: Winston Chang <winston@rstudio.com>

1 error  | 0 warnings | 0 notes

```
checking whether package ‘ggvis’ can be installed ... ERROR
Installation failed.
See ‘/store/Dropbox/dev/lubridate/revdep/checks/ggvis.Rcheck/00install.out’ for details.
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

## iClick (1.2)
Maintainer: Ho Tsung-wu <tsungwu@mail.shu.edu.tw>

1 error  | 0 warnings | 0 notes

```
checking package dependencies ... ERROR
Package required but not available: ‘openair’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## ie2misc (0.8.5)
Maintainer: Irucka Embry <iembry@usgs.gov>  
Bug reports: https://github.com/iembry-USGS/ie2misc/issues

1 error  | 0 warnings | 0 notes

```
checking whether package ‘ie2misc’ can be installed ... ERROR
Installation failed.
See ‘/store/Dropbox/dev/lubridate/revdep/checks/ie2misc.Rcheck/00install.out’ for details.
```

## iki.dataclim (1.0)
Maintainer: Boris Orlowsky <boris@climate-babel.org>

1 error  | 0 warnings | 0 notes

```
checking package dependencies ... ERROR
Package required but not available: ‘climdex.pcic’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## photobiologyInOut (0.4.9)
Maintainer: Pedro J. Aphalo <pedro.aphalo@helsinki.fi>  
Bug reports: https://bitbucket.org/aphalo/photobiologyinout/

2 errors | 0 warnings | 1 note 

```
checking examples ... ERROR
Running examples in ‘photobiologyInOut-Ex.R’ failed
The error most likely occurred in:

> base::assign(".ptime", proc.time(), pos = "CheckExEnv")
> ### Name: rspec2mspct
> ### Title: Convert "pavo::rspec" objects
> ### Aliases: rspec2mspct rspec2spct
> 
> ### ** Examples
> 
> 
> library(pavo)
Loading required package: rgl
Error in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]) : 
  there is no package called ‘httpuv’
Error: package ‘rgl’ could not be loaded
Execution halted

checking tests ... ERROR
Running the tests in ‘tests/testthat.R’ failed.
Last 13 lines of output:
  Read 4 items
  testthat results ================================================================
  OK: 101 SKIPPED: 0 FAILED: 7
  1. Error: single spectrum (quantum) (@test-licor.R#9) 
  2. Error: jazz (@test-oo.R#11) 
  3. Error: jazz_raw (@test-oo.R#37) 
  4. Error: SpectraSuite (@test-oo.R#62) 
  5. Error: jazz-comma (@test-oo.R#90) 
  6. Error: jazz_raw (@test-oo.R#117) 
  7. Error: SpectraSuite (@test-oo.R#144) 
  
  Error: testthat unit tests failed
  Execution halted

checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Read 3 items
Read 16 items
Quitting from lines 172-174 (user-guide.Rnw) 
Error: processing vignette 'user-guide.Rnw' failed with diagnostics:
invalid regular expression '^\D*?\b((((?<m>1[0-2]|0?[1-9](?!\d))|(((?<b_m>Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)|(?<B_m>January|February|March|April|May|June|July|August|September|October|November|December))(?![[:alpha:]])))\D*?(?<d>[012]?[1-9]|3[01]|[12]0)(?!\d)\D*?(?<H>2[0-4]|[01]?\d)(?!\d)\D*?((?<m>1[0-2]|0?[1-9](?!\d))|(((?<b_m>Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)|(?<B_m>January|February|March|April|May|June|July|August|September|October|November|December))(?![[:alpha:]])))\D*?((?<OS_S>[0-5]?\d\.\d+)|(?<S>[0-6]?\d))(?!\d)\D*?((?<Y_y>\d{4})|(?<y>\d{2}))(?!\d))|(((?<m_e>1[0-2]|0[1-9])|(((?<b_m_e>Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)|(?<B_m_e>January|February|March|April|May|June|July|August|September|October|November|December))(?![[:alpha:]])))\D*?(?<d_e>[012][1-9]|3[01]|[12]0)\D*?(?<H_e>2[0-4]|[01]\d)\D*?((?<m_e>1[0-2]|0[1-9])|(((?<b_m_e>Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|
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

## RSQLServer (0.2.0)
Maintainer: Imanuel Costigan <i.costigan@me.com>  
Bug reports: https://github.com/imanuelcostigan/RSQLServer/issues

1 error  | 0 warnings | 0 notes

```
checking whether package ‘RSQLServer’ can be installed ... ERROR
Installation failed.
See ‘/store/Dropbox/dev/lubridate/revdep/checks/RSQLServer.Rcheck/00install.out’ for details.
```

## SpaDES (1.2.0)
Maintainer: Alex M Chubaty <alexander.chubaty@canada.ca>  
Bug reports: https://github.com/PredictiveEcology/SpaDES/issues

1 error  | 0 warnings | 1 note 

```
checking whether package ‘SpaDES’ can be installed ... ERROR
Installation failed.
See ‘/store/Dropbox/dev/lubridate/revdep/checks/SpaDES.Rcheck/00install.out’ for details.

checking package dependencies ... NOTE
Packages suggested but not available for checking: ‘fastshp’ ‘tkrplot’
```

## spatsurv (0.9-12)
Maintainer: Benjamin M. Taylor <b.taylor1@lancaster.ac.uk>

1 error  | 0 warnings | 0 notes

```
checking package dependencies ... ERROR
Package required but not available: ‘spatstat’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## ss3sim (0.9.2)
Maintainer: Sean Anderson <sean@seananderson.ca>

0 errors | 1 warning  | 0 notes

```
checking whether package ‘ss3sim’ can be installed ... WARNING
Found the following significant warnings:
  Warning: no DISPLAY variable so Tk is not available
See ‘/store/Dropbox/dev/lubridate/revdep/checks/ss3sim.Rcheck/00install.out’ for details.
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

## TTAinterfaceTrendAnalysis (1.5.2)
Maintainer: Alain LEFEBVRE <Alain.Lefebvre@ifremer.fr>

1 error  | 0 warnings | 0 notes

```
checking whether package ‘TTAinterfaceTrendAnalysis’ can be installed ... ERROR
Installation failed.
See ‘/store/Dropbox/dev/lubridate/revdep/checks/TTAinterfaceTrendAnalysis.Rcheck/00install.out’ for details.
```

