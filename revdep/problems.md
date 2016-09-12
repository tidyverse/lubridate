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
|date     |2016-09-12                             |

## Packages

|package   |*  |version |date       |source                   |
|:---------|:--|:-------|:----------|:------------------------|
|covr      |   |2.2.1   |2016-08-10 |cran (@2.2.1)            |
|knitr     |   |1.14    |2016-08-13 |cran (@1.14)             |
|lubridate |*  |1.6.0   |2016-09-12 |local (hadley/lubridate) |
|stringr   |   |1.1.0   |2016-08-19 |cran (@1.1.0)            |
|testthat  |*  |1.0.2   |2016-04-23 |CRAN (R 3.2.4)           |

# Check results
12 packages with problems

## aoristic (0.6)
Maintainer: George Kikuchi <gkikuchi@csufresno.edu>

1 error  | 0 warnings | 0 notes

```
checking package dependencies ... ERROR
Package required but not available: ‘spatstat’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
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

1 error  | 1 warning  | 0 notes

```
checking examples ... ERROR
Running examples in ‘iClick-Ex.R’ failed
The error most likely occurred in:

> base::assign(".ptime", proc.time(), pos = "CheckExEnv")
> ### Name: iClick.ARIMA
> ### Title: iClick GUI for ARIMA
> ### Aliases: iClick.ARIMA
> 
> ### ** Examples
> 
> 
> ##External data
> #data("returnsDaily24")
> #y=returnsDaily24[,c(1,5)]
> 
> ## Simulation data
> dat=rnorm(100,5,1)
> y=ts(dat, start = c(1970, 1), frequency = 12)
> 
> iClick.ARIMA(y)
Error in structure(.External(.C_dotTclObjv, objv), class = "tclObj") : 
  [tcl] invalid command name "toplevel".
Calls: iClick.ARIMA ... tktoplevel -> tkwidget -> tcl -> .Tcl.objv -> structure
Execution halted

checking whether package ‘iClick’ can be installed ... WARNING
Found the following significant warnings:
  Warning: no DISPLAY variable so Tk is not available
See ‘/store/Dropbox/dev/lubridate/revdep/checks/iClick.Rcheck/00install.out’ for details.
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

## ropenaq (0.1.1)
Maintainer: Maëlle Salmon <maelle.salmon@yahoo.se>  
Bug reports: http://github.com/ropenscilabs/ropenaq/issues

1 error  | 0 warnings | 0 notes

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

1 error  | 1 warning  | 2 notes

```
checking tests ... ERROR
Running the tests in ‘tests/test-all.R’ failed.
Last 13 lines of output:
  names for target but not for current
  
  
  testthat results ================================================================
  OK: 976 SKIPPED: 16 FAILED: 3
  1. Failure: simulation runs with simInit and spades (@test-simulation.R#82) 
  2. Failure: simulation runs with simInit and spades (@test-simulation.R#83) 
  3. Failure: simulation runs with simInit and spades (@test-simulation.R#84) 
  
  Error: testthat unit tests failed
  In addition: Warning message:
  no DISPLAY variable so Tk is not available 
  Execution halted

checking whether package ‘SpaDES’ can be installed ... WARNING
Found the following significant warnings:
  Warning: no DISPLAY variable so Tk is not available
See ‘/store/Dropbox/dev/lubridate/revdep/checks/SpaDES.Rcheck/00install.out’ for details.

checking package dependencies ... NOTE
Packages suggested but not available for checking: ‘fastshp’ ‘tkrplot’

checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...

    RFoptions

The following object is masked from 'package:raster':

    atan2

... 8 lines ...

Attaching package: 'grid'

The following object is masked from 'package:SpaDES':

    gpar

Quitting from lines 347-351 (ii-modules.Rmd) 
Error: processing vignette 'ii-modules.Rmd' failed with diagnostics:
there is no package called 'webshot'
Execution halted
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
  OK: 180 SKIPPED: 0 FAILED: 1
  1. Failure: Negative ages (@test-pin_age.R#36) 
  
  Error: testthat unit tests failed
  Execution halted
```

## TTAinterfaceTrendAnalysis (1.5.3)
Maintainer: David DEVREKER <David.Devreker@ifremer.fr>

1 error  | 0 warnings | 0 notes

```
checking whether package ‘TTAinterfaceTrendAnalysis’ can be installed ... ERROR
Installation failed.
See ‘/store/Dropbox/dev/lubridate/revdep/checks/TTAinterfaceTrendAnalysis.Rcheck/00install.out’ for details.
```

