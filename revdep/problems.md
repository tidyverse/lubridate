# alphavantager

Version: 0.1.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘devtools’
      All declared Imports should be used.
    ```

# antaresViz

Version: 0.11

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘geojsonio’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# aoristic

Version: 0.6

## In both

*   checking DESCRIPTION meta-information ... NOTE
    ```
    Malformed Description field: should contain one or more complete sentences.
    ```

*   checking R code for possible problems ... NOTE
    ```
    ...
      ‘slot’
    aoristic.grid: no visible global function definition for ‘browseURL’
    aoristic.shp: no visible global function definition for ‘aggregate’
    aoristic.shp: no visible global function definition for ‘slot’
    aoristic.shp : <anonymous>: no visible global function definition for
      ‘as’
    aoristic.shp : <anonymous>: no visible global function definition for
      ‘slot’
    aoristic.shp: no visible global function definition for ‘browseURL’
    Undefined global functions or variables:
      aggregate as browseURL colorRampPalette contourLines dev.off image
      par png quantile slot
    Consider adding
      importFrom("grDevices", "colorRampPalette", "contourLines", "dev.off",
                 "png")
      importFrom("graphics", "image", "par")
      importFrom("methods", "as", "slot")
      importFrom("stats", "aggregate", "quantile")
      importFrom("utils", "browseURL")
    to your NAMESPACE file (and ensure that your DESCRIPTION Imports field
    contains 'methods').
    ```

# apsimr

Version: 1.2

## In both

*   checking Rd cross-references ... NOTE
    ```
    Packages unavailable to check Rd xrefs: ‘sensitivity’, ‘APSIMBatch’
    ```

# archivist

Version: 2.1.2

## In both

*   checking package dependencies ... NOTE
    ```
    Package which this enhances but not available for checking: ‘archivist.github’
    ```

*   checking Rd cross-references ... NOTE
    ```
    Packages unavailable to check Rd xrefs: ‘rmarkdown’, ‘archivist.github’
    ```

# basictabler

Version: 0.1.0

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Warning in engine$weave(file, quiet = quiet, encoding = enc) :
      Pandoc (>= 1.12.3) and/or pandoc-citeproc not available. Falling back to R Markdown v1.
    Quitting from lines 46-49 (v01-introduction.Rmd) 
    Error: processing vignette 'v01-introduction.Rmd' failed with diagnostics:
    there is no package called 'webshot'
    Execution halted
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘dplyr’
      All declared Imports should be used.
    ```

# bikedata

Version: 0.0.4

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  7.0Mb
      sub-directories of 1Mb or more:
        libs   5.6Mb
    ```

# bsam

Version: 1.1.2

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘rjags’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# bsplus

Version: 0.1.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘methods’
      All declared Imports should be used.
    ```

# congressbr

Version: 0.1.1

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 1 marked UTF-8 string
    ```

# countyfloods

Version: 0.0.2

## In both

*   R CMD check timed out
    

# countytimezones

Version: 1.0.0

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Warning in engine$weave(file, quiet = quiet, encoding = enc) :
      Pandoc (>= 1.12.3) and/or pandoc-citeproc not available. Falling back to R Markdown v1.
    Quitting from lines 111-123 (countytimezones.Rmd) 
    Error: processing vignette 'countytimezones.Rmd' failed with diagnostics:
    there is no package called 'choroplethr'
    Execution halted
    ```

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘choroplethr’
    ```

# countyweather

Version: 0.1.0

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘tigris’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# CRANsearcher

Version: 1.0.0

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 11 marked Latin-1 strings
      Note: found 57 marked UTF-8 strings
    ```

# crawl

Version: 2.1.1

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘sf’
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  7.5Mb
      sub-directories of 1Mb or more:
        libs   6.9Mb
    ```

# dataonderivatives

Version: 0.3.0

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      `df2` inherits from `NULL` not `data.frame`.
      
      
      3. Failure: BSDR API accesible (@test-bsdr.R#9) --------------------------------
      nrow(df1) <= nrow(df2) isn't true.
      
      
      testthat results ================================================================
      OK: 24 SKIPPED: 0 FAILED: 3
      1. Failure: BSDR API accesible (@test-bsdr.R#6) 
      2. Failure: BSDR API accesible (@test-bsdr.R#8) 
      3. Failure: BSDR API accesible (@test-bsdr.R#9) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘stats’
      All declared Imports should be used.
    ```

# dataPreparation

Version: 0.2

## In both

*   checking whether package ‘dataPreparation’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/store/Dropbox/dev/lubridate/revdep/checks/dataPreparation/new/dataPreparation.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘dataPreparation’ ...
** package ‘dataPreparation’ successfully unpacked and MD5 sums checked
** R
** data
*** moving datasets to lazyload DB
** inst
** preparing package for lazy loading
Warning: S3 methods ‘as.character.tclObj’, ‘as.character.tclVar’, ‘as.double.tclObj’, ‘as.integer.tclObj’, ‘as.logical.tclObj’, ‘as.raw.tclObj’, ‘print.tclObj’, ‘[[.tclArray’, ‘[[<-.tclArray’, ‘$.tclArray’, ‘$<-.tclArray’, ‘names.tclArray’, ‘names<-.tclArray’, ‘length.tclArray’, ‘length<-.tclArray’, ‘tclObj.tclVar’, ‘tclObj<-.tclVar’, ‘tclvalue.default’, ‘tclvalue.tclObj’, ‘tclvalue.tclVar’, ‘tclvalue<-.default’, ‘tclvalue<-.tclVar’, ‘close.tkProgressBar’ were declared in NAMESPACE but not found
Error : .onLoad failed in loadNamespace() for 'tcltk', details:
  call: fun(libname, pkgname)
  error: Tcl/Tk support is not available on this system
ERROR: lazy loading failed for package ‘dataPreparation’
* removing ‘/store/Dropbox/dev/lubridate/revdep/checks/dataPreparation/new/dataPreparation.Rcheck/dataPreparation’

```
### CRAN

```
* installing *source* package ‘dataPreparation’ ...
** package ‘dataPreparation’ successfully unpacked and MD5 sums checked
** R
** data
*** moving datasets to lazyload DB
** inst
** preparing package for lazy loading
Warning: S3 methods ‘as.character.tclObj’, ‘as.character.tclVar’, ‘as.double.tclObj’, ‘as.integer.tclObj’, ‘as.logical.tclObj’, ‘as.raw.tclObj’, ‘print.tclObj’, ‘[[.tclArray’, ‘[[<-.tclArray’, ‘$.tclArray’, ‘$<-.tclArray’, ‘names.tclArray’, ‘names<-.tclArray’, ‘length.tclArray’, ‘length<-.tclArray’, ‘tclObj.tclVar’, ‘tclObj<-.tclVar’, ‘tclvalue.default’, ‘tclvalue.tclObj’, ‘tclvalue.tclVar’, ‘tclvalue<-.default’, ‘tclvalue<-.tclVar’, ‘close.tkProgressBar’ were declared in NAMESPACE but not found
Error : .onLoad failed in loadNamespace() for 'tcltk', details:
  call: fun(libname, pkgname)
  error: Tcl/Tk support is not available on this system
ERROR: lazy loading failed for package ‘dataPreparation’
* removing ‘/store/Dropbox/dev/lubridate/revdep/checks/dataPreparation/old/dataPreparation.Rcheck/dataPreparation’

```
# dataRetrieval

Version: 2.7.3

## In both

*   R CMD check timed out
    

# dgo

Version: 0.2.10

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘rstan’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# diversitree

Version: 0.9-10

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  6.3Mb
      sub-directories of 1Mb or more:
        libs   5.5Mb
    ```

# ecoengine

Version: 1.11.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘magrittr’
      All declared Imports should be used.
    ```

# FedData

Version: 2.4.6

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      Attaching package: 'raster'
      
      The following objects are masked from 'package:aqp':
      
          metadata, metadata<-
      
      testthat results ================================================================
      OK: 24 SKIPPED: 0 FAILED: 1
      1. Error: ITRDB version files are available (@test.ITRDB.R#23) 
      
      Error: testthat unit tests failed
      In addition: Warning message:
      In paste0(strrep(char, width - nchar(x)), x) :
        closing unused connection 3 (ftp://ftp.ncdc.noaa.gov/pub/data/paleo/treering/chronologies/)
      Execution halted
    ```

# fivethirtyeight

Version: 0.3.0

## In both

*   checking package dependencies ... NOTE
    ```
    Packages suggested but not available for checking:
      ‘fivethirtyeight’ ‘ggraph’
    ```

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 371 marked UTF-8 strings
    ```

# fmdates

Version: 0.1.2

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      
      testthat results ================================================================
      OK: 152 SKIPPED: 0 FAILED: 9
      1. Failure: Melbourne calendar is correct (@test-calendars.R#48) 
      2. Failure: Melbourne calendar is correct (@test-calendars.R#49) 
      3. Failure: NYC calendar is correct (@test-calendars.R#77) 
      4. Failure: NYC calendar is correct (@test-calendars.R#78) 
      5. Failure: Auckland and Wellington calendars are correct (@test-calendars.R#150) 
      6. Failure: Auckland and Wellington calendars are correct (@test-calendars.R#151) 
      7. Failure: Toyko calendars are correct (@test-calendars.R#181) 
      8. Failure: Hong Kong calendars are correct (@test-calendars.R#232) 
      9. Failure: Joint calendars work effectively (@test-calendars.R#266) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# ggvis

Version: 0.4.3

## In both

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘plyr’
    ```

# grattan

Version: 1.5.1.2

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘taxstats’
    ```

# hansard

Version: 0.5.2

## In both

*   R CMD check timed out
    

# highcharter

Version: 0.5.0

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Warning in engine$weave(file, quiet = quiet, encoding = enc) :
      Pandoc (>= 1.12.3) and/or pandoc-citeproc not available. Falling back to R Markdown v1.
    Highcharts (www.highcharts.com) is a Highsoft software product which is
    not free for commercial and Governmental use
    Quitting from lines 45-46 (charting-data-frames.Rmd) 
    Error: processing vignette 'charting-data-frames.Rmd' failed with diagnostics:
    there is no package called 'webshot'
    Execution halted
    ```

*   checking installed package size ... NOTE
    ```
      installed size is 16.5Mb
      sub-directories of 1Mb or more:
        doc          13.7Mb
        htmlwidgets   1.9Mb
    ```

# HistData

Version: 0.8-2

## In both

*   checking Rd cross-references ... NOTE
    ```
    Packages unavailable to check Rd xrefs: ‘psych’, ‘Guerry’, ‘alr3’, ‘agridat’, ‘coin’
    ```

# htmlTable

Version: 1.9

## In both

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘pxweb’
    ```

# hurricaneexposure

Version: 0.0.1

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘hurricaneexposuredata’
    ```

# iClick

Version: 1.2

## In both

*   checking whether package ‘iClick’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/store/Dropbox/dev/lubridate/revdep/checks/iClick/new/iClick.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘iClick’ ...
** package ‘iClick’ successfully unpacked and MD5 sums checked
** R
** data
*** moving datasets to lazyload DB
** preparing package for lazy loading
Warning: S3 methods ‘as.character.tclObj’, ‘as.character.tclVar’, ‘as.double.tclObj’, ‘as.integer.tclObj’, ‘as.logical.tclObj’, ‘as.raw.tclObj’, ‘print.tclObj’, ‘[[.tclArray’, ‘[[<-.tclArray’, ‘$.tclArray’, ‘$<-.tclArray’, ‘names.tclArray’, ‘names<-.tclArray’, ‘length.tclArray’, ‘length<-.tclArray’, ‘tclObj.tclVar’, ‘tclObj<-.tclVar’, ‘tclvalue.default’, ‘tclvalue.tclObj’, ‘tclvalue.tclVar’, ‘tclvalue<-.default’, ‘tclvalue<-.tclVar’, ‘close.tkProgressBar’ were declared in NAMESPACE but not found
Error: package or namespace load failed for ‘tcltk’:
 .onLoad failed in loadNamespace() for 'tcltk', details:
  call: fun(libname, pkgname)
  error: Tcl/Tk support is not available on this system
Error : package ‘tcltk’ could not be loaded
ERROR: lazy loading failed for package ‘iClick’
* removing ‘/store/Dropbox/dev/lubridate/revdep/checks/iClick/new/iClick.Rcheck/iClick’

```
### CRAN

```
* installing *source* package ‘iClick’ ...
** package ‘iClick’ successfully unpacked and MD5 sums checked
** R
** data
*** moving datasets to lazyload DB
** preparing package for lazy loading
Warning: S3 methods ‘as.character.tclObj’, ‘as.character.tclVar’, ‘as.double.tclObj’, ‘as.integer.tclObj’, ‘as.logical.tclObj’, ‘as.raw.tclObj’, ‘print.tclObj’, ‘[[.tclArray’, ‘[[<-.tclArray’, ‘$.tclArray’, ‘$<-.tclArray’, ‘names.tclArray’, ‘names<-.tclArray’, ‘length.tclArray’, ‘length<-.tclArray’, ‘tclObj.tclVar’, ‘tclObj<-.tclVar’, ‘tclvalue.default’, ‘tclvalue.tclObj’, ‘tclvalue.tclVar’, ‘tclvalue<-.default’, ‘tclvalue<-.tclVar’, ‘close.tkProgressBar’ were declared in NAMESPACE but not found
Error: package or namespace load failed for ‘tcltk’:
 .onLoad failed in loadNamespace() for 'tcltk', details:
  call: fun(libname, pkgname)
  error: Tcl/Tk support is not available on this system
Error : package ‘tcltk’ could not be loaded
ERROR: lazy loading failed for package ‘iClick’
* removing ‘/store/Dropbox/dev/lubridate/revdep/checks/iClick/old/iClick.Rcheck/iClick’

```
# ie2misc

Version: 0.8.5

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘gWidgets2tcltk’
    
    Package suggested but not available for checking: ‘ie2miscdata’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# iki.dataclim

Version: 1.0

## In both

*   checking R code for possible problems ... NOTE
    ```
    ...
    plotWalterLieth,matrix: no visible global function definition for
      ‘approx’
    plotWalterLieth,matrix: no visible global function definition for
      ‘segments’
    plotWalterLieth,matrix: no visible global function definition for
      ‘rect’
    plotWalterLieth,matrix: no visible global function definition for
      ‘lines’
    summary,dataclim: no visible binding for global variable ‘sd’
    summary,dataclim: no visible binding for global variable ‘aggregate’
    summary,dataclim: no visible global function definition for ‘time’
    summary,dataclim : <anonymous>: no visible global function definition
      for ‘lm’
    Undefined global functions or variables:
      abline aggregate approx axis coef lines lm mtext par plot polygon
      rect sd segments time
    Consider adding
      importFrom("graphics", "abline", "axis", "lines", "mtext", "par",
                 "plot", "polygon", "rect", "segments")
      importFrom("stats", "aggregate", "approx", "coef", "lm", "sd", "time")
    to your NAMESPACE file.
    ```

# incR

Version: 0.3.1

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘dplyr’ ‘rgeos’
      All declared Imports should be used.
    ```

# itunesr

Version: 0.1

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘curl’
      All declared Imports should be used.
    ```

# macleish

Version: 0.3.1

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘DBI’
      All declared Imports should be used.
    ```

# MazamaSpatialUtils

Version: 0.5.1

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘rmapshaper’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# mdsr

Version: 0.1.4

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.5Mb
      sub-directories of 1Mb or more:
        data   5.4Mb
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘tidyverse’
      All declared Imports should be used.
    ```

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 2698 marked UTF-8 strings
    ```

# mosaic

Version: 1.1.0

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘fastR’
    
    Package which this enhances but not available for checking: ‘manipulate’
    ```

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘cubature’
    ```

# noaastormevents

Version: 0.1.0

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘choroplethr’
    
    Package suggested but not available for checking: ‘hurricaneexposuredata’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# npphen

Version: 1.1-0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘rts’
      All declared Imports should be used.
    ```

# oce

Version: 0.9-22

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.7Mb
      sub-directories of 1Mb or more:
        help   2.2Mb
    ```

# openair

Version: 2.1-5

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘openair-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: selectByDate
    > ### Title: Subset a data frame based on date
    > ### Aliases: selectByDate
    > ### Keywords: methods
    > 
    > ### ** Examples
    > 
    > 
    > ## select all of 1999
    > data.1999 <- selectByDate(mydata, start = "1/1/1999", end = "31/12/1999")
    Warning: All formats failed to parse. No formats found.
    Warning: All formats failed to parse. No formats found.
    Error in C_force_tz(time, tz = tzone, roll) : 
      CCTZ: Unrecognized output timezone: "%d/%m/%Y"
    Calls: selectByDate ... >=.Date -> date_to_posix -> force_tz -> C_force_tz -> .Call
    Execution halted
    ```

# opendotaR

Version: 0.1.4

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘dplyr’
      All declared Imports should be used.
    ```

# osmdata

Version: 0.0.5

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      6: tryCatchList(expr, classes, parentenv, handlers)
      7: tryCatchOne(expr, names, parentenv, handlers[[1L]])
      8: value[[3L]](cond)
      
      testthat results ================================================================
      OK: 94 SKIPPED: 0 FAILED: 6
      1. Error: multipolygon (@test-sf-osm.R#9) 
      2. Error: multilinestring (@test-sf-osm.R#47) 
      3. Error: ways (@test-sf-osm.R#77) 
      4. Error: multipolygon (@test-sp-osm.R#4) 
      5. Error: multilinestring (@test-sp-osm.R#55) 
      6. Error: ways (@test-sp-osm.R#87) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘sf’
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  8.0Mb
      sub-directories of 1Mb or more:
        doc    2.8Mb
        libs   5.0Mb
    ```

# pivottabler

Version: 0.4.0

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Warning in engine$weave(file, quiet = quiet, encoding = enc) :
      Pandoc (>= 1.12.3) and/or pandoc-citeproc not available. Falling back to R Markdown v1.
    Quitting from lines 65-68 (v01-introduction.Rmd) 
    Error: processing vignette 'v01-introduction.Rmd' failed with diagnostics:
    there is no package called 'webshot'
    Execution halted
    ```

# pointblank

Version: 0.1

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘Hmisc’ ‘digest’ ‘htmltools’ ‘knitr’ ‘lazyWeave’ ‘lubridate’ ‘rJava’
      All declared Imports should be used.
    ```

# primerTree

Version: 1.0.3

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Error in .requirePackage(package) : 
        unable to find required package 'RCurl'
      Calls: <Anonymous> ... .extendsForS3 -> extends -> getClassDef -> .requirePackage
      Execution halted
    ```

# PWFSLSmoke

Version: 0.99.9

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘MazamaSpatialUtils’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# quanteda

Version: 0.99.12

## In both

*   checking installed package size ... NOTE
    ```
      installed size is 22.1Mb
      sub-directories of 1Mb or more:
        libs  19.8Mb
    ```

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 1415 marked UTF-8 strings
    ```

# radiant.model

Version: 0.8.0

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 2 marked UTF-8 strings
    ```

# rAmCharts

Version: 2.1.5

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  7.8Mb
      sub-directories of 1Mb or more:
        htmlwidgets   6.4Mb
    ```

# RDML

Version: 0.9-9

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘V8’
    ```

# rdpla

Version: 0.2.0

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/test-all.R’ failed.
    Last 13 lines of output:
      testthat results ================================================================
      OK: 5 SKIPPED: 0 FAILED: 24
      1. Error: dpla_collections basic functionality works (@test-dpla_collections.R#6) 
      2. Error: dpla_items - pagination works (@test-dpla_collections.R#20) 
      3. Error: dpla_items - fields requests work (@test-dpla_collections.R#35) 
      4. Failure: dpla_items fails well (@test-dpla_collections.R#46) 
      5. Failure: dpla_items fails well (@test-dpla_collections.R#49) 
      6. Error: dpla_collections_ basic functionality works (@test-dpla_collections_.R#6) 
      7. Error: dpla_items - pagination works (@test-dpla_collections_.R#22) 
      8. Error: dpla_items - fields requests work (@test-dpla_collections_.R#37) 
      9. Failure: dpla_items fails well (@test-dpla_collections_.R#48) 
      1. ...
      
      Error: testthat unit tests failed
      Execution halted
    ```

# RGoogleAnalytics

Version: 0.1.1

## In both

*   checking DESCRIPTION meta-information ... NOTE
    ```
    Malformed Description field: should contain one or more complete sentences.
    ```

# rnoaa

Version: 0.7.0

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      testthat results ================================================================
      OK: 163 SKIPPED: 1 FAILED: 10
      1.  Error: check_response returns an error (@test-check_response.r#7) 
      2.  Error: check_response returns the correct error messages (@test-check_response.r#26) 
      3.  Error: homr works (@test-homr.R#11) 
      4.  Error: ncdc returns the correct ... (@test-ncdc.r#8) 
      5.  Error: ncdc_datacats returns the correct ... (@test-ncdc_datacats.r#7) 
      6.  Error: ncdc_datasets returns the correct class (@test-ncdc_datasets.r#7) 
      7.  Error: ncdc_datatypes returns the correct class (@test-ncdc_datatypes.r#7) 
      8.  Error: ncdc_locs returns the correct class (@test-ncdc_locs.r#7) 
      9.  Error: ncdc_locs_cats returns the correct ... (@test-ncdc_locs_cats.r#7) 
      10. Error: ncdc_stations returns the correct... (@test-ncdc_stations.r#7) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# rols

Version: 2.4.0

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      Testing term SO:0001076 
      Testing term SO:0000025 
      Testing term SO:1000151 
      Testing term SO:0001198 
      Testing term SO:0000039 
      Testing term SO:0002157 
      Testing term SO:0001901 
      Testing term SO:0001141 
      Testing term SO:1000083 
      testthat results ================================================================
      OK: 196 SKIPPED: 0 FAILED: 1
      1. Failure: constructors (@test_Terms.R#57) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Warning in engine$weave(file, quiet = quiet, encoding = enc) :
      Pandoc (>= 1.12.3) and/or pandoc-citeproc not available. Falling back to R Markdown v1.
    Quitting from lines 76-77 (rols.Rmd) 
    Error: processing vignette 'rols.Rmd' failed with diagnostics:
    there is no package called 'webshot'
    Execution halted
    ```

# rplos

Version: 0.6.4

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/test-all.R’ failed.
    Last 13 lines of output:
      1: searchplos(q = "*:*", fl = "id", fq = "cross_published_journal_key:PLoSONE", start = 0, 
             limit = 15) at testthat/test-searchplos.R:8
      2: check_response(tt)
      3: stop(sprintf("(%s) - %s", x$status_code, jsonlite::fromJSON(utf8cont(x), FALSE)$error$msg), 
             call. = FALSE)
      
      testthat results ================================================================
      OK: 224 SKIPPED: 0 FAILED: 4
      1. Error: journalnamekey returns the correct value (@test-journalnamekey.R#7) 
      2. Error: journalnamekey returns the correct class (@test-journalnamekey.R#13) 
      3. Error: journalnamekey returns the correct length vector (@test-journalnamekey.R#19) 
      4. Error: searchplos returns the correct (@test-searchplos.R#8) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

*   checking package dependencies ... NOTE
    ```
    Package which this enhances but not available for checking: ‘tm’
    ```

# rsoi

Version: 0.3.0

## In both

*   checking examples ... ERROR
    ```
    Running examples in ‘rsoi-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: download_soi
    > ### Title: Download Southern Oscillation Index data
    > ### Aliases: download_soi
    > 
    > ### ** Examples
    > 
    > soi <- download_soi()
    Error in open.connection(con, "rb") : HTTP error 502.
    Calls: download_soi ... read_delimited -> read_connection -> open -> open.connection
    Execution halted
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘utils’
      All declared Imports should be used.
    ```

# rtimes

Version: 0.5.0

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/test-all.R’ failed.
    Last 13 lines of output:
      6: Filter(Negate(is.null), x)
      7: unlist(lapply(x, f))
      8: lapply(x, f)
      9: check_key(key)
      10: stop("need an API key for ", y, call. = FALSE)
      
      testthat results ================================================================
      OK: 2 SKIPPED: 0 FAILED: 4
      1. Error: returns the correct stuff (@test-as_search.R#8) 
      2. Error: returns the correct stuff (@test-geo_search.R#8) 
      3. Failure: fails well (@test-geo_search.R#48) 
      4. Error: fails well (@test-geo_search.R#50) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# rtimicropem

Version: 1.3

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘R6’
      All declared Imports should be used.
    ```

# rtrends

Version: 0.1.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘dplyr’
      All declared Imports should be used.
    ```

# SanFranBeachWater

Version: 0.1.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘tibble’
      All declared Imports should be used.
    ```

# SciencesPo

Version: 1.4.1

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    ...
    Warning: `legend.margin` must be specified using `margin()`. For the old behavior use legend.spacing
    Warning: `panel.margin` is deprecated. Please use `panel.spacing` property instead
    Warning: `legend.margin` must be specified using `margin()`. For the old behavior use legend.spacing
    Warning: New theme missing the following elements: axis.title.x.top, axis.title.y.right, axis.text.x.top, axis.text.y.right, axis.line.x, axis.line.y, legend.spacing.x, legend.spacing.y, legend.box.margin, legend.box.background, legend.box.spacing, panel.spacing.x, panel.spacing.y, panel.grid.major, panel.grid.minor, plot.subtitle, plot.caption, strip.placement
    Warning: `panel.margin` is deprecated. Please use `panel.spacing` property instead
    Warning: `legend.margin` must be specified using `margin()`. For the old behavior use legend.spacing
    Warning: `panel.margin` is deprecated. Please use `panel.spacing` property instead
    Warning: `legend.margin` must be specified using `margin()`. For the old behavior use legend.spacing
    Warning: `panel.margin` is deprecated. Please use `panel.spacing` property instead
    Warning: `legend.margin` must be specified using `margin()`. For the old behavior use legend.spacing
    Warning: `panel.margin` is deprecated. Please use `panel.spacing` property instead
    Warning: `legend.margin` must be specified using `margin()`. For the old behavior use legend.spacing
    Warning: `panel.margin` is deprecated. Please use `panel.spacing` property instead
    Warning: `legend.margin` must be specified using `margin()`. For the old behavior use legend.spacing
    Warning: `panel.margin` is deprecated. Please use `panel.spacing` property instead
    Warning: `legend.margin` must be specified using `margin()`. For the old behavior use legend.spacing
    Warning: `panel.margin` is deprecated. Please use `panel.spacing` property instead
    Quitting from lines 1090-1091 (SciencesPo.Rmd) 
    Error: processing vignette 'SciencesPo.Rmd' failed with diagnostics:
    invalid 'times' argument
    Execution halted
    ```

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘gmodels’
    ```

# seawaveQ

Version: 1.0.0

## In both

*   checking DESCRIPTION meta-information ... NOTE
    ```
    Malformed Description field: should contain one or more complete sentences.
    ```

*   checking dependencies in R code ... NOTE
    ```
    Packages in Depends field not imported from:
      ‘NADA’ ‘lubridate’ ‘survival’
      These packages need to be imported from (in the NAMESPACE file)
      for when this namespace is loaded but not attached.
    ```

*   checking R code for possible problems ... NOTE
    ```
    ...
    seawaveQPlots: no visible global function definition for ‘runif’
    seawaveQPlots: no visible global function definition for ‘pnorm’
    seawaveQPlots: no visible global function definition for ‘plot’
    seawaveQPlots: no visible global function definition for ‘points’
    seawaveQPlots: no visible global function definition for ‘lines’
    seawaveQPlots: no visible global function definition for ‘mtext’
    seawaveQPlots: no visible global function definition for ‘text’
    seawaveQPlots: no visible global function definition for ‘quantile’
    seawaveQPlots: no visible global function definition for ‘dev.off’
    Undefined global functions or variables:
      boxplot day dev.off extractAIC legend lines month mtext par pdf plot
      pnorm points qnorm quantile ros runif sessionInfo supsmu survreg text
      title year
    Consider adding
      importFrom("grDevices", "dev.off", "pdf")
      importFrom("graphics", "boxplot", "legend", "lines", "mtext", "par",
                 "plot", "points", "text", "title")
      importFrom("stats", "extractAIC", "pnorm", "qnorm", "quantile",
                 "runif", "supsmu")
      importFrom("utils", "sessionInfo")
    to your NAMESPACE file.
    ```

# SpaDES.core

Version: 0.1.0

## In both

*   checking whether package ‘SpaDES.core’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/store/Dropbox/dev/lubridate/revdep/checks/SpaDES.core/new/SpaDES.core.Rcheck/00install.out’ for details.
    ```

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘tkrplot’
    ```

## Installation

### Devel

```
* installing *source* package ‘SpaDES.core’ ...
** package ‘SpaDES.core’ successfully unpacked and MD5 sums checked
** R
** inst
** byte-compile and prepare package for lazy loading
Warning: S3 methods ‘as.character.tclObj’, ‘as.character.tclVar’, ‘as.double.tclObj’, ‘as.integer.tclObj’, ‘as.logical.tclObj’, ‘as.raw.tclObj’, ‘print.tclObj’, ‘[[.tclArray’, ‘[[<-.tclArray’, ‘$.tclArray’, ‘$<-.tclArray’, ‘names.tclArray’, ‘names<-.tclArray’, ‘length.tclArray’, ‘length<-.tclArray’, ‘tclObj.tclVar’, ‘tclObj<-.tclVar’, ‘tclvalue.default’, ‘tclvalue.tclObj’, ‘tclvalue.tclVar’, ‘tclvalue<-.default’, ‘tclvalue<-.tclVar’, ‘close.tkProgressBar’ were declared in NAMESPACE but not found
Error : .onLoad failed in loadNamespace() for 'tcltk', details:
  call: fun(libname, pkgname)
  error: Tcl/Tk support is not available on this system
ERROR: lazy loading failed for package ‘SpaDES.core’
* removing ‘/store/Dropbox/dev/lubridate/revdep/checks/SpaDES.core/new/SpaDES.core.Rcheck/SpaDES.core’

```
### CRAN

```
* installing *source* package ‘SpaDES.core’ ...
** package ‘SpaDES.core’ successfully unpacked and MD5 sums checked
** R
** inst
** byte-compile and prepare package for lazy loading
Warning: S3 methods ‘as.character.tclObj’, ‘as.character.tclVar’, ‘as.double.tclObj’, ‘as.integer.tclObj’, ‘as.logical.tclObj’, ‘as.raw.tclObj’, ‘print.tclObj’, ‘[[.tclArray’, ‘[[<-.tclArray’, ‘$.tclArray’, ‘$<-.tclArray’, ‘names.tclArray’, ‘names<-.tclArray’, ‘length.tclArray’, ‘length<-.tclArray’, ‘tclObj.tclVar’, ‘tclObj<-.tclVar’, ‘tclvalue.default’, ‘tclvalue.tclObj’, ‘tclvalue.tclVar’, ‘tclvalue<-.default’, ‘tclvalue<-.tclVar’, ‘close.tkProgressBar’ were declared in NAMESPACE but not found
Error : .onLoad failed in loadNamespace() for 'tcltk', details:
  call: fun(libname, pkgname)
  error: Tcl/Tk support is not available on this system
ERROR: lazy loading failed for package ‘SpaDES.core’
* removing ‘/store/Dropbox/dev/lubridate/revdep/checks/SpaDES.core/old/SpaDES.core.Rcheck/SpaDES.core’

```
# splashr

Version: 0.4.0

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/test-all.R’ failed.
    Last 13 lines of output:
       /usr/bin/python3
       /home/vspinu/.pyenvs/cv/bin/python
      
      1: install_splash() at testthat/test-splash.R:25
      2: docker::docker$from_env
      3: `$.python.builtin.module`(docker::docker, from_env)
      4: py_resolve_module_proxy(x)
      5: stop(message, call. = FALSE)
      
      testthat results ================================================================
      OK: 0 SKIPPED: 0 FAILED: 1
      1. Error: we can do something (@test-splash.R#25) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# spocc

Version: 0.7.0

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      
      5. Failure: taxize based searches works with get_tsn input (@test-taxize-integration.R#66) 
      Names of ee$bison$data ('') don't match '175304'
      
      
      testthat results ================================================================
      OK: 246 SKIPPED: 0 FAILED: 5
      1. Failure: occ works for each data source (@test-occ.R#71) 
      2. Failure: passing in options to occ works (@test-options.R#39) 
      3. Failure: passing in options to occ works (@test-options.R#40) 
      4. Failure: taxize based searches works with get_tsn input (@test-taxize-integration.R#64) 
      5. Failure: taxize based searches works with get_tsn input (@test-taxize-integration.R#66) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# ss3sim

Version: 0.9.5

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘r4ss’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# stacomiR

Version: 0.5.3

## In both

*   checking whether package ‘stacomiR’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/store/Dropbox/dev/lubridate/revdep/checks/stacomiR/new/stacomiR.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘stacomiR’ ...
** package ‘stacomiR’ successfully unpacked and MD5 sums checked
** R
** data
*** moving datasets to lazyload DB
** inst
** preparing package for lazy loading
R session is headless; GTK+ not initialized.

(R:8899): Gtk-WARNING **: gtk_disable_setlocale() must be called before gtk_init()
Error : .onLoad failed in loadNamespace() for 'cairoDevice', details:
  call: fun(libname, pkgname)
  error: GDK display not found - please make sure X11 is running
ERROR: lazy loading failed for package ‘stacomiR’
* removing ‘/store/Dropbox/dev/lubridate/revdep/checks/stacomiR/new/stacomiR.Rcheck/stacomiR’

```
### CRAN

```
* installing *source* package ‘stacomiR’ ...
** package ‘stacomiR’ successfully unpacked and MD5 sums checked
** R
** data
*** moving datasets to lazyload DB
** inst
** preparing package for lazy loading
R session is headless; GTK+ not initialized.

(R:8811): Gtk-WARNING **: gtk_disable_setlocale() must be called before gtk_init()
Error : .onLoad failed in loadNamespace() for 'cairoDevice', details:
  call: fun(libname, pkgname)
  error: GDK display not found - please make sure X11 is running
ERROR: lazy loading failed for package ‘stacomiR’
* removing ‘/store/Dropbox/dev/lubridate/revdep/checks/stacomiR/old/stacomiR.Rcheck/stacomiR’

```
# stationaRy

Version: 0.4.1

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  8.1Mb
    ```

# statsDK

Version: 0.1.1

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘dplyr’ ‘ggplot2’ ‘stringr’
      All declared Imports should be used.
    ```

# stormwindmodel

Version: 0.1.0

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    ...
    
        intersect, setdiff, setequal, union
    
    
    Attaching package: 'gridExtra'
    
    The following object is masked from 'package:dplyr':
    
        combine
    
    Map from URL : http://maps.googleapis.com/maps/api/staticmap?center=georgia&zoom=5&size=640x640&scale=2&maptype=terrain&language=en-EN&sensor=false
    Information from URL : http://maps.googleapis.com/maps/api/geocode/json?address=georgia&sensor=false
    Warning: Removed 703 rows containing missing values (geom_point).
    Warning: Removed 89 rows containing missing values (geom_point).
    Warning: Removed 1 rows containing missing values (geom_path).
    Warning in engine$weave(file, quiet = quiet, encoding = enc) :
      Pandoc (>= 1.12.3) and/or pandoc-citeproc not available. Falling back to R Markdown v1.
    Quitting from lines 98-100 (Overview.Rmd) 
    Error: processing vignette 'Overview.Rmd' failed with diagnostics:
    there is no package called 'tigris'
    Execution halted
    ```

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘tigris’
    ```

# stplanr

Version: 0.1.9

## Newly fixed

*   checking examples ... ERROR
    ```
    Running examples in ‘stplanr-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: geo_code
    > ### Title: Convert text strings into points on the map
    > ### Aliases: geo_code
    > 
    > ### ** Examples
    > 
    > address = "LS7 3HB"
    > geo_code(address = address)
          lon       lat 
    -1.534372 53.819472 
    > geo_code(address = address, return_all = TRUE)
    Error: is.data.frame(x) is not TRUE
    Execution halted
    ```

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘tmap’
    ```

# sweep

Version: 0.2.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘devtools’ ‘lazyeval’ ‘lubridate’ ‘tidyr’
      All declared Imports should be used.
    ```

# tidyquant

Version: 0.5.3

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘broom’ ‘curl’ ‘devtools’ ‘rvest’ ‘timeSeries’ ‘tseries’ ‘zoo’
      All declared Imports should be used.
    ```

# tidyRSS

Version: 1.2.2

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘testthat’
      All declared Imports should be used.
    ```

# timelineS

Version: 0.1.1

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘base’
      All declared Imports should be used.
    ```

# TimeProjection

Version: 0.2.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    'library' or 'require' calls in package code:
      ‘ggplot2’ ‘plyr’
      Please use :: or requireNamespace() instead.
      See section 'Suggested packages' in the 'Writing R Extensions' manual.
    Packages in Depends field not imported from:
      ‘Matrix’ ‘lubridate’ ‘timeDate’
      These packages need to be imported from (in the NAMESPACE file)
      for when this namespace is loaded but not attached.
    ```

*   checking R code for possible problems ... NOTE
    ```
    ...
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
    Undefined global functions or variables:
      . aes ddply facet_grid geom_tile ggplot holidayNYSE isWeekday month
      monthweek scale_fill_gradientn sparse.model.matrix week weekday year
    ```

# timetk

Version: 0.1.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘devtools’ ‘forecast’
      All declared Imports should be used.
    ```

# TTAinterfaceTrendAnalysis

Version: 1.5.3

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘tcltk2’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# twilio

Version: 0.1.0

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      3. Error: tw_send_message() can send messages (@test_tw_send_message.R#11) -----
      Please set environmental variable TWILIO_SID.
      1: tw_send_message("2127872000", "+15005550006", "Half a pound of whitefish salad please.") at testthat/test_tw_send_message.R:11
      2: paste("2010-04-01", "Accounts", get_sid(), "Messages.json", sep = "/")
      3: get_sid()
      4: stop("Please set environmental variable TWILIO_SID.", call. = FALSE)
      
      testthat results ================================================================
      OK: 4 SKIPPED: 0 FAILED: 3
      1. Error: tw_get_message_media() can retrieve a photo (@test_tw_get_message_media.R#6) 
      2. Error: Test that tw_get_messages_list() will retrieve messages (@test_tw_get_messages_list.R#6) 
      3. Error: tw_send_message() can send messages (@test_tw_send_message.R#11) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# unvotes

Version: 0.2.0

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 4494 marked UTF-8 strings
    ```

# UsingR

Version: 2.0-5

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘aplpack’
    ```

# vetools

Version: 1.3-28

## In both

*   checking R code for possible problems ... NOTE
    ```
    ...
    tssum: no visible global function definition for ‘ts’
    tssum: no visible global function definition for ‘window’
    tssum: no visible global function definition for ‘window<-’
    xts2ts: no visible global function definition for ‘ts’
    xts2ts: no visible global function definition for ‘start’
    xts2ts: no visible global function definition for ‘end’
    Undefined global functions or variables:
      abline axis colorRamp cov end frequency image kmeans layout legend
      lines median par points read.csv rgb rnorm sd slot start text time
      title ts ts.union window window<-
    Consider adding
      importFrom("grDevices", "colorRamp", "rgb")
      importFrom("graphics", "abline", "axis", "image", "layout", "legend",
                 "lines", "par", "points", "text", "title")
      importFrom("methods", "slot")
      importFrom("stats", "cov", "end", "frequency", "kmeans", "median",
                 "rnorm", "sd", "start", "time", "ts", "ts.union", "window",
                 "window<-")
      importFrom("utils", "read.csv")
    to your NAMESPACE file (and ensure that your DESCRIPTION Imports field
    contains 'methods').
    ```

# waccR

Version: 0.1.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘lubridate’ ‘tibble’
      All declared Imports should be used.
    ```

# Wats

Version: 0.10.3

## In both

*   checking installed package size ... NOTE
    ```
      installed size is 12.3Mb
      sub-directories of 1Mb or more:
        doc  12.1Mb
    ```

# wbstats

Version: 0.1.1

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 1371 marked UTF-8 strings
    ```

# xtractomatic

Version: 3.3.2

## In both

*   R CMD check timed out
    

# ztype

Version: 0.1.0

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘dplyr’ ‘ggplot2’ ‘lubridate’
      All declared Imports should be used.
    ```

