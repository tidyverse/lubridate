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
92 packages

## aemo (0.2.0)
Maintainer: Imanuel Costigan <i.costigan@me.com>

0 errors | 0 warnings | 0 notes

## alm (0.4.0)
Maintainer: Scott Chamberlain <myrmecocystus@gmail.com>  
Bug reports: http://www.github.com/ropensci/alm/issues

0 errors | 0 warnings | 1 note 

```
checking files in ‘vignettes’ ... NOTE
The following directory looks like a leftover from 'knitr':
  ‘figure’
Please remove from your package.
```

## aoristic (0.6)
Maintainer: George Kikuchi <gkikuchi@csufresno.edu>

1 error  | 0 warnings | 0 notes

```
checking package dependencies ... ERROR
Package required but not available: ‘spatstat’

See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
manual.
```

## APSIM (0.9.0)
Maintainer: Justin Fainges <Justin.Fainges@csiro.au>

0 errors | 0 warnings | 0 notes

## apsimr (1.2)
Maintainer: Bryan Stanfill <bstanfill2003@gmail.com>  
Bug reports: https://github.com/stanfill/apsimr/issues

0 errors | 0 warnings | 1 note 

```
checking Rd cross-references ... NOTE
Packages unavailable to check Rd xrefs: ‘sensitivity’, ‘APSIMBatch’
```

## archivist (2.1)
Maintainer: Przemyslaw Biecek <przemyslaw.biecek@gmail.com>  
Bug reports: https://github.com/pbiecek/archivist/issues

0 errors | 0 warnings | 2 notes

```
checking package dependencies ... NOTE
Package which this enhances but not available for checking: ‘archivist.github’

checking Rd cross-references ... NOTE
Package unavailable to check Rd xrefs: ‘archivist.github’
```

## Biograph (2.0.6)
Maintainer: Frans Willekens <willekens@nidi.nl>

0 errors | 0 warnings | 0 notes

## boxoffice (0.1.1)
Maintainer: Jacob Kaplan <jacobkap@sas.upenn.edu>

0 errors | 0 warnings | 0 notes

## cardioModel (1.4)
Maintainer: Daniela J Conrado <dconrado@ymail.com>

0 errors | 0 warnings | 0 notes

## clifro (3.0-0)
Maintainer: Blake Seers <blake.seers@gmail.com>  
Bug reports: https://github.com/ropensci/clifro/issues

0 errors | 0 warnings | 0 notes

## climwin (1.0.0)
Maintainer: Liam D. Bailey <liam.bailey@anu.edu.au>  
Bug reports: https://github.com/LiamDBailey/climwin/issues

0 errors | 0 warnings | 0 notes

## countytimezones (0.1.0)
Maintainer: Brooke Anderson <brooke.anderson@colostate.edu>  
Bug reports: https://github.com/geanders/countytimezones/issues

0 errors | 0 warnings | 0 notes

## crawl (2.0.1)
Maintainer: Devin S. Johnson <devin.johnson@noaa.gov>

0 errors | 0 warnings | 1 note 

```
checking installed package size ... NOTE
  installed size is  9.4Mb
  sub-directories of 1Mb or more:
    doc    2.2Mb
    libs   6.5Mb
```

## cricketr (0.0.13)
Maintainer: Tinniam V Ganesh <tvganesh.85@gmail.com>  
Bug reports: https://github.com/tvganesh/cricketr/issues

0 errors | 0 warnings | 0 notes

## cruts (0.3)
Maintainer: Benjamin M. Taylor <b.taylor1@lancaster.ac.uk>

0 errors | 0 warnings | 0 notes

## dataonderivatives (0.2.1)
Maintainer: Imanuel Costigan <i.costigan@me.com>  
Bug reports: https://github.com/imanuelcostigan/dataonderivatives/issues

0 errors | 0 warnings | 0 notes

## dataRetrieval (2.5.10)
Maintainer: Laura DeCicco <ldecicco@usgs.gov>  
Bug reports: https://github.com/USGS-R/dataRetrieval/issues

0 errors | 0 warnings | 0 notes

## diversitree (0.9-8)
Maintainer: Richard G. FitzJohn <rich.fitzjohn@gmail.com>

0 errors | 0 warnings | 1 note 

```
checking installed package size ... NOTE
  installed size is  5.7Mb
  sub-directories of 1Mb or more:
    libs   4.9Mb
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

0 errors | 0 warnings | 0 notes

## dynatopmodel (1.1)
Maintainer: Peter Metcalfe <p.metcalfe@lancaster.ac.uk>

0 errors | 0 warnings | 0 notes

## ecoengine (1.10.0)
Maintainer: Karthik Ram <karthik.ram@gmail.com>  
Bug reports: https://github.com/ropensci/ecoengine/issues

0 errors | 0 warnings | 1 note 

```
checking dependencies in R code ... NOTE
Namespace in Imports field not imported from: ‘magrittr’
  All declared Imports should be used.
```

## edeaR (0.4.3)
Maintainer: Gert Janssenswillen <gert.janssenswillen@uhasselt.be>

0 errors | 0 warnings | 0 notes

## EGRETci (1.0.2)
Maintainer: Laura DeCicco <ldecicco@usgs.gov>  
Bug reports: https://github.com/USGS-R/EGRETci/issues

0 errors | 0 warnings | 0 notes

## EGRET (2.6.0)
Maintainer: Laura DeCicco <ldecicco@usgs.gov>

0 errors | 0 warnings | 0 notes

## etl (0.3.3)
Maintainer: Ben Baumer <ben.baumer@gmail.com>  
Bug reports: https://github.com/beanumber/etl/issues

0 errors | 0 warnings | 0 notes

## feedeR (0.0.4)
Maintainer: Andrew Collier <andrew@exegetic.biz>

0 errors | 0 warnings | 0 notes

## ggpmisc (0.2.10)
Maintainer: Pedro J. Aphalo <pedro.aphalo@helsinki.fi>  
Bug reports: https://bitbucket.org/aphalo/ggpmisc

0 errors | 0 warnings | 1 note 

```
checking Rd cross-references ... NOTE
Package unavailable to check Rd xrefs: ‘ggrepel’
```

## ggspectra (0.1.8)
Maintainer: Pedro J. Aphalo <pedro.aphalo@helsinki.fi>  
Bug reports: https://bitbucket.org/aphalo/ggspectra

0 errors | 0 warnings | 1 note 

```
checking Rd cross-references ... NOTE
Package unavailable to check Rd xrefs: ‘ggrepel’
```

## ggvis (0.4.3)
Maintainer: Winston Chang <winston@rstudio.com>

0 errors | 0 warnings | 0 notes

## githubinstall (0.1.0)
Maintainer: Koji Makiyama <hoxo.smile@gmail.com>  
Bug reports: https://github.com/hoxo-m/githubinstall/issues

0 errors | 0 warnings | 0 notes

## GSODR (0.1.9)
Maintainer: Adam Sparks <adamhsparks@gmail.com>  
Bug reports: https://github.com/adamhsparks/GSODR/issues

0 errors | 0 warnings | 0 notes

## highcharter (0.4.0)
Maintainer: Joshua Kunst <jbkunst@gmail.com>  
Bug reports: https://github.com/jbkunst/highcharter/issues

0 errors | 0 warnings | 1 note 

```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Warning: It seems you should call rmarkdown::render() instead of knitr::knit2html() because replicating-highcharts-demos.Rmd appears to be an R Markdown v2 document.
Quitting from lines 58-81 (replicating-highcharts-demos.Rmd) 
Error: processing vignette 'replicating-highcharts-demos.Rmd' failed with diagnostics:
there is no package called 'webshot'
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

## ie2miscdata (1.0.1)
Maintainer: Irucka Embry <iembry@usgs.gov>  
Bug reports: https://github.com/iembry-USGS/ie2miscdata/issues

0 errors | 0 warnings | 3 notes

```
checking package dependencies ... NOTE
Packages suggested but not available for checking: ‘states2k’ ‘spatstat’

checking data for non-ASCII characters ... NOTE
  Note: found 4 marked UTF-8 strings

checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Warning: It seems you should call rmarkdown::render() instead of knitr::knit2html() because US-Engineering-Weather-Map.Rmd appears to be an R Markdown v2 document.
Error in (function (package, help, pos = 2, lib.loc = NULL, character.only = FALSE,  : 
  there is no package called 'states2k'
Error in (function (package, help, pos = 2, lib.loc = NULL, character.only = FALSE,  : 
  there is no package called 'spatstat'
Quitting from lines 24-109 (US-Engineering-Weather-Map.Rmd) 
Error: processing vignette 'US-Engineering-Weather-Map.Rmd' failed with diagnostics:
object 'states2k_map' not found
Execution halted

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

0 errors | 0 warnings | 0 notes

## Lock5withR (1.2.2)
Maintainer: Randall Pruim <rpruim@calvin.edu>

0 errors | 0 warnings | 0 notes

## machina (0.1.5)
Maintainer: Norton Tim <tnorton@machi.na>

0 errors | 0 warnings | 0 notes

## macleish (0.3.0)
Maintainer: Ben Baumer <ben.baumer@gmail.com>

0 errors | 0 warnings | 0 notes

## mdsr (0.1.3)
Maintainer: Ben Baumer <ben.baumer@gmail.com>  
Bug reports: https://github.com/beanumber/mdsr/issues

0 errors | 0 warnings | 2 notes

```
checking installed package size ... NOTE
  installed size is  5.4Mb
  sub-directories of 1Mb or more:
    data   5.3Mb

checking data for non-ASCII characters ... NOTE
  Note: found 2698 marked UTF-8 strings
```

## mosaic (0.14.4)
Maintainer: Randall Pruim <rpruim@calvin.edu>  
Bug reports: https://github.com/ProjectMOSAIC/mosaic/issues

0 errors | 0 warnings | 2 notes

```
checking installed package size ... NOTE
  installed size is  9.5Mb
  sub-directories of 1Mb or more:
    R     2.0Mb
    doc   6.9Mb

checking Rd cross-references ... NOTE
Package unavailable to check Rd xrefs: ‘cubature’
```

## MRMR (0.1.4)
Maintainer: Brian A. Fannin <FanninQED@Yahoo.com>

0 errors | 0 warnings | 0 notes

## musica (0.1.3)
Maintainer: Martin Hanel <hanel@fzp.czu.cz>

0 errors | 0 warnings | 0 notes

## openair (1.8-6)
Maintainer: David Carslaw <david.carslaw@york.ac.uk>  
Bug reports: https://github.com/davidcarslaw/openair/issues

0 errors | 0 warnings | 0 notes

## OptiQuantR (0.0.1)
Maintainer: Joao Pinelo Silva <j.pinelo@mac.com>

0 errors | 0 warnings | 0 notes

## orgR (0.9.0)
Maintainer: Yi Tang <yi.tang.uk@me.com>

0 errors | 0 warnings | 0 notes

## pdfetch (0.1.7)
Maintainer: Abiel Reinhart <abielr@gmail.com>

0 errors | 0 warnings | 0 notes

## photobiology (0.9.11)
Maintainer: Pedro J. Aphalo <pedro.aphalo@helsinki.fi>  
Bug reports: https://bitbucket.org/aphalo/photobiology/issues

0 errors | 0 warnings | 0 notes

## PhysActBedRest (1.0)
Maintainer: J. Dustin Tracy <jtracy2@student.gsu.edu>

0 errors | 0 warnings | 0 notes

## plusser (0.4-0)
Maintainer: Christoph Waldhauser <chw@kdss.at>

0 errors | 0 warnings | 0 notes

## primerTree (1.0.3)
Maintainer: Jim Hester <james.f.hester@gmail.com>

0 errors | 0 warnings | 0 notes

## ProjectTemplate (0.7)
Maintainer: Kenton White <jkentonwhite@gmail.com>  
Bug reports: https://github.com/johnmyleswhite/ProjectTemplate/issues

0 errors | 0 warnings | 0 notes

## raw (0.1.2)
Maintainer: Brian A. Fannin <FanninQED@yahoo.com>

0 errors | 0 warnings | 1 note 

```
checking package dependencies ... NOTE
Packages suggested but not available for checking: ‘actuar’ ‘ChainLadder’
```

## RefManageR (0.11.0)
Maintainer: Mathew W. McLean <mathew.w.mclean@gmail.com>  
Bug reports: https://github.com/mwmclean/RefManageR/issues

0 errors | 0 warnings | 1 note 

```
checking foreign function calls ... NOTE
Foreign function call to a different package:
  .External("do_read_bib", ..., PACKAGE = "bibtex")
See chapter ‘System and foreign language interfaces’ in the ‘Writing R
Extensions’ manual.
```

## respirometry (0.1.0)
Maintainer: Matthew A. Birk <matthewabirk@gmail.com>

0 errors | 0 warnings | 0 notes

## RGA (0.4.2)
Maintainer: Artem Klevtsov <a.a.klevtsov@gmail.com>  
Bug reports: https://github.com/artemklevtsov/RGA/issues

0 errors | 0 warnings | 0 notes

## RGoogleAnalyticsPremium (0.1.1)
Maintainer: Jalpa Joshi Dave <jalpa@tatvic.com>

0 errors | 0 warnings | 0 notes

## RGoogleAnalytics (0.1.1)
Maintainer: Kushan Shah <kushan@tatvic.com>  
Bug reports: https://github.com/Tatvic/RGoogleAnalytics/issues

0 errors | 0 warnings | 1 note 

```
checking DESCRIPTION meta-information ... NOTE
Malformed Description field: should contain one or more complete sentences.
```

## riem (0.1.1)
Maintainer: Maëlle Salmon <maelle.salmon@yahoo.se>  
Bug reports: http://github.com/ropenscilabs/riem/issues

0 errors | 0 warnings | 0 notes

## RmarineHeatWaves (0.13.1)
Maintainer: Albertus J. Smit <albertus.smit@gmail.com>

0 errors | 0 warnings | 0 notes

## rnoaa (0.6.0)
Maintainer: Scott Chamberlain <myrmecocystus@gmail.com>  
Bug reports: http://www.github.com/ropensci/rnoaa/issues

0 errors | 0 warnings | 1 note 

```
checking installed package size ... NOTE
  installed size is  5.2Mb
  sub-directories of 1Mb or more:
    doc    3.0Mb
    vign   1.2Mb
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

## rpdo (0.2.0)
Maintainer: Joe Thorley <joe@poissonconsulting.ca>

0 errors | 0 warnings | 0 notes

## rplexos (1.1.8)
Maintainer: Clayton Barrows <clayton.barrows@nrel.gov>  
Bug reports: https://github.com/NREL/rplexos/issues

0 errors | 0 warnings | 0 notes

## rplos (0.6.0)
Maintainer: Scott Chamberlain <myrmecocystus@gmail.com>  
Bug reports: https://github.com/ropensci/rplos/issues

0 errors | 0 warnings | 0 notes

## RSQLServer (0.2.0)
Maintainer: Imanuel Costigan <i.costigan@me.com>  
Bug reports: https://github.com/imanuelcostigan/RSQLServer/issues

1 error  | 0 warnings | 0 notes

```
checking whether package ‘RSQLServer’ can be installed ... ERROR
Installation failed.
See ‘/store/Dropbox/dev/lubridate/revdep/checks/RSQLServer.Rcheck/00install.out’ for details.
```

## rtimes (0.3.0)
Maintainer: Scott Chamberlain <myrmecocystus@gmail.com>  
Bug reports: https://github.com/ropengov/rtimes/issues

0 errors | 0 warnings | 0 notes

## SciencesPo (1.4.1)
Maintainer: Daniel Marcelino <dmarcelino@live.com>  
Bug reports: http://github.com/danielmarcelino/SciencesPo/issues

0 errors | 0 warnings | 1 note 

```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
    opponent.vote, turnout, winner, winner.bmi, winner.height,
    winner.party, winner.vote

The following objects are masked from stature (pos = 5):

    election, opponent, opponent.height, opponent.party,
    opponent.vote, turnout, winner, winner.bmi, winner.height,
... 8 lines ...

The following object is masked from package:SciencesPo:

    turnout

.data was converted to a dataframe
Warning: New theme missing the following elements: axis.line.x, axis.line.y, panel.grid.major, panel.grid.minor
Quitting from lines 1090-1091 (SciencesPo.Rmd) 
Error: processing vignette 'SciencesPo.Rmd' failed with diagnostics:
invalid 'times' argument
Execution halted
```

## seawaveQ (1.0.0)
Maintainer: Karen R. Ryberg <kryberg@usgs.gov>

0 errors | 0 warnings | 3 notes

```
checking DESCRIPTION meta-information ... NOTE
Malformed Description field: should contain one or more complete sentences.

checking dependencies in R code ... NOTE
Packages in Depends field not imported from:
  ‘NADA’ ‘lubridate’ ‘survival’
  These packages need to be imported from (in the NAMESPACE file)
  for when this namespace is loaded but not attached.

checking R code for possible problems ... NOTE
fitMod: no visible global function definition for ‘survreg’
fitswavecav: no visible global function definition for ‘year’
prepData: no visible global function definition for ‘year’
prepData: no visible global function definition for ‘month’
prepData: no visible global function definition for ‘day’
rosBoxPlot: no visible global function definition for ‘ros’
```

## SensusR (2.0.0)
Maintainer: Matthew S. Gerber <gerber.matthew@gmail.com>

0 errors | 0 warnings | 1 note 

```
checking dependencies in R code ... NOTE
Namespace in Imports field not imported from: ‘sp’
  All declared Imports should be used.
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

## spocc (0.5.0)
Maintainer: Scott Chamberlain <myrmecocystus@gmail.com>  
Bug reports: https://github.com/ropensci/spocc/issues

0 errors | 0 warnings | 0 notes

## ss3sim (0.9.2)
Maintainer: Sean Anderson <sean@seananderson.ca>

0 errors | 1 warning  | 0 notes

```
checking whether package ‘ss3sim’ can be installed ... WARNING
Found the following significant warnings:
  Warning: no DISPLAY variable so Tk is not available
See ‘/store/Dropbox/dev/lubridate/revdep/checks/ss3sim.Rcheck/00install.out’ for details.
```

## statar (0.6.2)
Maintainer: Matthieu Gomez <mattg@princeton.edu>  
Bug reports: https://github.com/matthieugomez/statar/issues

0 errors | 0 warnings | 0 notes

## stationaRy (0.4.1)
Maintainer: Richard Iannone <riannone@me.com>  
Bug reports: https://github.com/rich-iannone/stationaRy/issues

0 errors | 0 warnings | 1 note 

```
checking installed package size ... NOTE
  installed size is  8.1Mb
```

## stplanr (0.1.4)
Maintainer: Robin Lovelace <rob00x@gmail.com>  
Bug reports: https://github.com/ropensci/stplanr/issues

0 errors | 0 warnings | 1 note 

```
checking re-building of vignette outputs ... NOTE
Error in re-building vignettes:
  ...
Warning: It seems you should call rmarkdown::render() instead of knitr::knit2html() because introducing-stplanr.Rmd appears to be an R Markdown v2 document.
trying URL 'http://www.google.com'
Content type 'text/html; charset=ISO-8859-1' length unknown
.......... 
downloaded 10 KB

Quitting from lines 208-219 (introducing-stplanr.Rmd) 
Error: processing vignette 'introducing-stplanr.Rmd' failed with diagnostics:
there is no package called 'webshot'
Execution halted

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

## tidyverse (1.0.0)
Maintainer: Hadley Wickham <hadley@rstudio.com>  
Bug reports: https://github.com/hadley/tidyverse/issues

0 errors | 0 warnings | 1 note 

```
checking dependencies in R code ... NOTE
Namespaces in Imports field not imported from:
  ‘DBI’ ‘broom’ ‘forcats’ ‘ggplot2’ ‘haven’ ‘hms’ ‘httr’ ‘jsonlite’
  ‘lubridate’ ‘modelr’ ‘readr’ ‘readxl’ ‘rvest’ ‘stringr’ ‘tidyr’
  ‘xml2’
  All declared Imports should be used.
```

## timelineS (0.1.1)
Maintainer: Dahee Lee <dhlee99@gmail.com>  
Bug reports: https://github.com/daheelee/timelineS/issues

0 errors | 0 warnings | 1 note 

```
checking dependencies in R code ... NOTE
Namespace in Imports field not imported from: ‘base’
  All declared Imports should be used.
```

## TimeProjection (0.2.0)
Maintainer: Jeffrey Wong <jeff.ct.wong@gmail.com>

0 errors | 0 warnings | 2 notes

```
checking dependencies in R code ... NOTE
'library' or 'require' calls in package code:
  ‘ggplot2’ ‘plyr’
  Please use :: or requireNamespace() instead.
  See section 'Suggested packages' in the 'Writing R Extensions' manual.
Packages in Depends field not imported from:
  ‘Matrix’ ‘lubridate’ ‘timeDate’
  These packages need to be imported from (in the NAMESPACE file)
  for when this namespace is loaded but not attached.

checking R code for possible problems ... NOTE
is.Bizday: no visible global function definition for ‘isWeekday’
plotCalendarHeatmap: no visible global function definition for ‘ddply’
plotCalendarHeatmap: no visible global function definition for ‘.’
plotCalendarHeatmap: no visible binding for global variable ‘year’
plotCalendarHeatmap: no visible binding for global variable ‘month’
plotCalendarHeatmap: no visible binding for global variable ‘week’
plotCalendarHeatmap: no visible global function definition for ‘ggplot’
plotCalendarHeatmap: no visible global function definition for ‘aes’
plotCalendarHeatmap: no visible binding for global variable ‘monthweek’
plotCalendarHeatmap: no visible binding for global variable ‘weekday’
plotCalendarHeatmap: no visible global function definition for
  ‘geom_tile’
plotCalendarHeatmap: no visible global function definition for
  ‘facet_grid’
plotCalendarHeatmap: no visible global function definition for
  ‘scale_fill_gradientn’
projectDate: no visible global function definition for ‘holidayNYSE’
projectDate: no visible global function definition for
  ‘sparse.model.matrix’
```

## tolBasis (1.0)
Maintainer: Pedro Gea <pgea@bayesforecast.com>

0 errors | 0 warnings | 0 notes

## TTAinterfaceTrendAnalysis (1.5.3)
Maintainer: David DEVREKER <David.Devreker@ifremer.fr>

1 error  | 0 warnings | 0 notes

```
checking whether package ‘TTAinterfaceTrendAnalysis’ can be installed ... ERROR
Installation failed.
See ‘/store/Dropbox/dev/lubridate/revdep/checks/TTAinterfaceTrendAnalysis.Rcheck/00install.out’ for details.
```

## unvotes (0.1.0)
Maintainer: David Robinson <admiral.david@gmail.com>  
Bug reports: http://github.com/dgrtwo/unvotes/issues

0 errors | 0 warnings | 1 note 

```
checking data for non-ASCII characters ... NOTE
  Note: found 10 marked UTF-8 strings
```

## UsingR (2.0-5)
Maintainer: John Verzani <verzani@math.csi.cuny.edu>

0 errors | 0 warnings | 0 notes

## vetools (1.3-28)
Maintainer: Andrew Sajo-Castelli <asajo@usb.ve>  
Bug reports: https://github.com/talassio/vetools/issues

0 errors | 0 warnings | 0 notes

## Wats (0.10.3)
Maintainer: Will Beasley <wibeasley@hotmail.com>  
Bug reports: https://github.com/OuhscBbmc/Wats/issues

0 errors | 0 warnings | 0 notes

## wbstats (0.1)
Maintainer: Jesse Piburn <piburnjo@ornl.gov>

0 errors | 0 warnings | 1 note 

```
checking data for non-ASCII characters ... NOTE
  Note: found 1317 marked UTF-8 strings
```

## weatherr (0.1.2)
Maintainer: Stan Yip <stanyip101@gmail.com>

0 errors | 0 warnings | 0 notes

## wingui (0.2)
Maintainer: Andrew Redd <amredd@gmail.com>

0 errors | 0 warnings | 0 notes

