# Biograph

<details>

* Version: 2.0.6
* Source code: https://github.com/cran/Biograph
* Date/Publication: 2016-03-31 17:50:43
* Number of recursive dependencies: 64

Run `revdep_details(,"Biograph")` for more info

</details>

## Newly broken

*   checking whether package ‘Biograph’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/home/vspinu/Dropbox/dev/lubridate/revdep/checks/Biograph/new/Biograph.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘Biograph’ ...
** package ‘Biograph’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** data
** inst
** byte-compile and prepare package for lazy loading
Error: object ‘new_interval’ is not exported by 'namespace:lubridate'
Execution halted
ERROR: lazy loading failed for package ‘Biograph’
* removing ‘/home/vspinu/Dropbox/dev/lubridate/revdep/checks/Biograph/new/Biograph.Rcheck/Biograph’

```
### CRAN

```
* installing *source* package ‘Biograph’ ...
** package ‘Biograph’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** data
** inst
** byte-compile and prepare package for lazy loading
** help
*** installing help indices
** building package indices
** testing if installed package can be loaded from temporary location
** testing if installed package can be loaded from final location
** testing if installed package keeps a record of temporary installation path
* DONE (Biograph)

```
# corporaexplorer

<details>

* Version: 0.8.2
* Source code: https://github.com/cran/corporaexplorer
* URL: https://kgjerde.github.io/corporaexplorer, https://github.com/kgjerde/corporaexplorer
* BugReports: https://github.com/kgjerde/corporaexplorer/issues
* Date/Publication: 2020-03-07 19:40:02 UTC
* Number of recursive dependencies: 96

Run `revdep_details(,"corporaexplorer")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      > library(corporaexplorer)
      > 
      > test_check("corporaexplorer")
      ── 1. Failure: prepare_data() works (@test_prep_func.R#12)  ────────────────────
      `test_obj` not equal to corporaexplorer::test_data.
      Component "original_data": Component "data_dok": Incompatible type for column `Year`: x integer, y numeric
      Component "original_data": Component "data_365": Incompatible type for column `Year`: x integer, y numeric
      Component "original_data": Component "data_365": Incompatible type for column `Weekday_n`: x integer, y numeric
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 0 | SKIPPED: 2 | WARNINGS: 0 | FAILED: 1 ]
      1. Failure: prepare_data() works (@test_prep_func.R#12) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘RColorBrewer’ ‘ggplot2’ ‘rmarkdown’ ‘shinyWidgets’ ‘shinydashboard’
      ‘shinyjs’
      All declared Imports should be used.
    ```

# fmdates

<details>

* Version: 0.1.4
* Source code: https://github.com/cran/fmdates
* URL: https://github.com/imanuelcostigan/fmdates, https://imanuelcostigan.github.io/fmdates/
* BugReports: https://github.com/imanuelcostigan/fmdates/issues
* Date/Publication: 2018-01-04 23:07:49 UTC
* Number of recursive dependencies: 47

Run `revdep_details(,"fmdates")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      > library(testthat)
      > library(fmdates)
      > 
      > test_check("fmdates")
      ── 1. Failure: Easter Monday calculations work: (@test-epochs.R#6)  ────────────
      easter_monday(c(1963, 2013)) not identical to yday(ymd(19630415, 20130401)).
      Objects equal but not identical
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 160 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 1 ]
      1. Failure: Easter Monday calculations work: (@test-epochs.R#6) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# gravitas

<details>

* Version: 0.1.2
* Source code: https://github.com/cran/gravitas
* URL: https://github.com/Sayani07/gravitas/
* BugReports: https://github.com/Sayani07/gravitas/issues
* Date/Publication: 2020-02-17 09:20:02 UTC
* Number of recursive dependencies: 93

Run `revdep_details(,"gravitas")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
       4. gravitas:::day_semester(x)
       5. dplyr::if_else(which_sem == 1, day_x, day_x - div_indx + 1)
       6. dplyr:::replace_with(...)
       7. dplyr:::check_type(val, x, name)
       8. dplyr:::glubort(header, "must be {friendly_type_of(template)}, not {friendly_type_of(x)}")
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 123 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 4 ]
      1. Error: build_gran expected output week_semester (@test-build_gran.R#43) 
      2. Error: day_semester outputs a numeric value (@test-day-order-up.R#32) 
      3. Error: day_semester expected output (@test-day-order-up.R#36) 
      4. Error: day_semester output length equals input length (@test-day-order-up.R#40) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# highfrequency

<details>

* Version: 0.6.4
* Source code: https://github.com/cran/highfrequency
* Date/Publication: 2020-02-26 14:20:03 UTC
* Number of recursive dependencies: 90

Run `revdep_details(,"highfrequency")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘highfrequency-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: aggregatePrice
    > ### Title: Aggregate a time series but keep first and last observation
    > ### Aliases: aggregatePrice
    > ### Keywords: data internal manipulation
    > 
    > ### ** Examples
    > 
    > # aggregate price data to the 30 second frequency
    > aggregatePrice(sample_tdata_microseconds, on = "secs", k = 30)
    Error: Don't know how to compute timezone for object of class data.table/data.frame
    Execution halted
    ```

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      Don't know how to compute timezone for object of class data.table/data.frame
      Backtrace:
        1. testthat::expect_identical(...)
        4. highfrequency::spotDrift(...)
        5. highfrequency::aggregatePrice(...)
        7. data.table:::`[.data.table`(pdata, , `:=`(DATE, as.Date(DT, tz = tz(pdata))))
        8. [ base::eval(...) ] with 1 more call
       13. lubridate:::tz.default(pdata)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 52 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 1 ]
      1. Error: (unknown) (@tests_spotvol_and_drift.R#1) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  8.2Mb
      sub-directories of 1Mb or more:
        data   5.9Mb
        libs   1.6Mb
    ```

# npphen

<details>

* Version: 1.1-0
* Source code: https://github.com/cran/npphen
* Date/Publication: 2017-08-31 10:05:45 UTC
* Number of recursive dependencies: 28

Run `revdep_details(,"npphen")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘npphen-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: Phen
    > ### Title: Phen
    > ### Aliases: Phen
    > 
    > ### ** Examples
    > 
    > ## Don't show: 
    > ## Testing function with time series of Slovenian data (EVI)
    > # Load data
    > phents<-read.table(system.file("extdata/date_tables/datats",package="npphen"),
    + dec='.',sep='\t',header=TRUE)
    > # Phenology for the given data
    > Phen(x=as.vector(phents$x),dates=phents$dates,h=1,nGS=23,rge=c(0,10000))
    Error: Don't know how to compute timezone for object of class factor
    Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘rts’
      All declared Imports should be used.
    ```

# pollen

<details>

* Version: 0.71.0
* Source code: https://github.com/cran/pollen
* URL: https://github.com/Nowosad/pollen
* BugReports: https://github.com/Nowosad/pollen/issues
* Date/Publication: 2018-10-07 07:50:03 UTC
* Number of recursive dependencies: 57

Run `revdep_details(,"pollen")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Complete output:
      > library("testthat")
      > library("pollen")
      > 
      > test_check("pollen")
      ── 1. Failure: results are proper (@test-seasons.R#11)  ────────────────────────
      `x` inherits from `integer` not `numeric`.
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 11 | SKIPPED: 0 | WARNINGS: 7 | FAILED: 1 ]
      1. Failure: results are proper (@test-seasons.R#11) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# Sojourn

<details>

* Version: 0.1.0
* Source code: https://github.com/cran/Sojourn
* URL: http://github.com/paulhibbing/Sojourn
* BugReports: http://github.com/paulhibbing/Sojourn/issues
* Date/Publication: 2019-05-06 09:00:06 UTC
* Number of recursive dependencies: 115

Run `revdep_details(,"Sojourn")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘Sojourn-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: enhance_actigraph
    > ### Title: Combine ActiGraph and activPAL data
    > ### Aliases: enhance_actigraph
    > 
    > ### ** Examples
    > 
    > data(SIP_ag, package = "Sojourn")
    > data(SIP_ap, package = "Sojourn")
    > combined_data <- enhance_actigraph(SIP_ag, SIP_ap)
    Error: Don't know how to compute timezone for object of class NULL
    Execution halted
    ```

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      > library(Sojourn)
      > 
      > test_check("Sojourn")
      ── 1. Error: SIP returns as expected (@test_sojOutput.R#33)  ───────────────────
      Don't know how to compute timezone for object of class NULL
      Backtrace:
       1. Sojourn::enhance_actigraph(SIP_ag, SIP_ap)
       4. lubridate:::tz.default(ag$Timestamp)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 3 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 1 ]
      1. Error: SIP returns as expected (@test_sojOutput.R#33) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘AGread’ ‘caret’
      All declared Imports should be used.
    ```

# stationaRy

<details>

* Version: 0.5.1
* Source code: https://github.com/cran/stationaRy
* URL: https://github.com/rich-iannone/stationaRy
* BugReports: https://github.com/rich-iannone/stationaRy/issues
* Date/Publication: 2020-01-12 06:00:06 UTC
* Number of recursive dependencies: 57

Run `revdep_details(,"stationaRy")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      
      ── 2. Failure: The `station_coverage()` fcn can provide an additional data repor
      `.` inherits from `integer` not `numeric`.
      
      ── 3. Failure: The `station_coverage()` fcn can provide an additional data repor
      `.` inherits from `integer` not `numeric`.
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 36 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 3 ]
      1. Failure: The `station_coverage()` fcn can provide an additional data report (@test-get_met_station_data.R#139) 
      2. Failure: The `station_coverage()` fcn can provide an additional data report (@test-get_met_station_data.R#167) 
      3. Failure: The `station_coverage()` fcn can provide an additional data report (@test-get_met_station_data.R#171) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# sweep

<details>

* Version: 0.2.2
* Source code: https://github.com/cran/sweep
* URL: https://github.com/business-science/sweep
* BugReports: https://github.com/business-science/sweep/issues
* Date/Publication: 2019-10-08 13:50:02 UTC
* Number of recursive dependencies: 116

Run `revdep_details(,"sweep")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 186 | SKIPPED: 0 | WARNINGS: 2 | FAILED: 17 ]
      1. Failure: sw_sweep test returns tibble with correct rows and columns. (@test_sw_sweep.R#157) 
      2. Failure: sw_sweep test returns tibble with correct rows and columns. (@test_sw_sweep.R#160) 
      3. Failure: sw_sweep test returns tibble with correct rows and columns. (@test_sw_sweep.R#163) 
      4. Failure: sw_*.StructTS test returns tibble with correct rows and columns. (@test_tidiers_StructTS.R#56) 
      5. Failure: sw_*.Arima test returns tibble with correct rows and columns. (@test_tidiers_arima.R#86) 
      6. Failure: sw_*.Arima test returns tibble with correct rows and columns. (@test_tidiers_arima.R#95) 
      7. Failure: sw_*.Arima test returns tibble with correct rows and columns. (@test_tidiers_arima.R#98) 
      8. Failure: sw_*.bats test returns tibble with correct rows and columns. (@test_tidiers_bats_tbats.R#91) 
      9. Failure: sw_*.bats test returns tibble with correct rows and columns. (@test_tidiers_bats_tbats.R#98) 
      1. ...
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘lazyeval’ ‘lubridate’ ‘tidyr’
      All declared Imports should be used.
    ```

# sweidnumbr

<details>

* Version: 1.4.1
* Source code: https://github.com/cran/sweidnumbr
* URL: https://github.com/rOpenGov/sweidnumbr/
* BugReports: https://github.com/rOpenGov/sweidnumbr/issues
* Date/Publication: 2016-09-14 19:44:25
* Number of recursive dependencies: 39

Run `revdep_details(,"sweidnumbr")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      
      ── 1. Error: age at leapyear (@test-pin_age.R#23)  ─────────────────────────────
      'new_period' is not an exported object from 'namespace:lubridate'
      Backtrace:
       1. testthat::expect_equal(...)
       6. sweidnumbr::pin_age(...)
       7. lubridate::new_period
       8. base::getExportedValue(pkg, name)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 193 | SKIPPED: 1 | WARNINGS: 0 | FAILED: 1 ]
      1. Error: age at leapyear (@test-pin_age.R#23) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

*   checking dependencies in R code ... NOTE
    ```
    Missing or unexported object: ‘lubridate::new_period’
    ```

# tbrf

<details>

* Version: 0.1.3
* Source code: https://github.com/cran/tbrf
* URL: https://mps9506.github.io/tbrf/
* BugReports: https://github.com/mps9506/tbrf/issues
* Date/Publication: 2019-11-15 21:30:02 UTC
* Number of recursive dependencies: 90

Run `revdep_details(,"tbrf")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      > library(testthat)
      > library(tbrf)
      > 
      > test_check("tbrf")
      ── 1. Failure: tbr_sum provides expected values (@test-expectedValues.R#64)  ───
      sum(x1$sum) not equal to 40.
      1/1 mismatches
      [1] 44 - 40 == 4
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 29 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 1 ]
      1. Failure: tbr_sum provides expected values (@test-expectedValues.R#64) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# timetk

<details>

* Version: 0.1.2
* Source code: https://github.com/cran/timetk
* URL: https://github.com/business-science/timetk
* BugReports: https://github.com/business-science/timetk/issues
* Date/Publication: 2019-09-25 13:50:02 UTC
* Number of recursive dependencies: 116

Run `revdep_details(,"timetk")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
       <yea>     <int>   <int> <int>    <int> <int>   <int> <int>     <int>
     1 Jan …    1.45e9      NA  2016     2015     1       1     1         0
     2 Feb …    1.45e9 2678400  2016     2016     1       1     2         1
     3 Mar …    1.46e9 2505600  2016     2016     1       1     3         2
     4 Apr …    1.46e9 2678400  2016     2016     1       2     4         3
     5 May …    1.46e9 2592000  2016     2016     1       2     5         4
     6 Jun …    1.46e9 2678400  2016     2016     1       2     6         5
     7 Jul …    1.47e9 2592000  2016     2016     2       3     7         6
     8 Aug …    1.47e9 2678400  2016     2016     2       3     8         7
     9 Sep …    1.47e9 2678400  2016     2016     2       3     9         8
    10 Oct …    1.48e9 2592000  2016     2016     2       4    10         9
    11 Nov …    1.48e9 2678400  2016     2016     2       4    11        10
    12 Dec …    1.48e9 2592000  2016     2016     2       4    12        11
    # … with 20 more variables: month.lbl <ord>, day <int>, hour <int>,
    #   minute <int>, second <int>, hour12 <int>, am.pm <int>, wday <int>,
    #   wday.xts <int>, wday.lbl <ord>, mday <int>, qday <int>, yday <int>,
    #   mweek <int>, week <int>, week.iso <int>, week2 <int>, week3 <int>,
    #   week4 <int>, mday7 <int>
    > tk_get_timeseries_summary(idx_yearmon)
    Error: Don't know how to compute timezone for object of class yearmon
    Execution halted
    ```

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 246 | SKIPPED: 0 | WARNINGS: 28 | FAILED: 26 ]
      1. Error: tk_get_timeseries_summary(yearmon) test returns correct format. (@test_tk_get_timeseries.R#103) 
      2. Error: tk_get_timeseries_summary(yearqtr) test returns correct format. (@test_tk_get_timeseries.R#116) 
      3. Failure: tk_index(ts) test returns correct format. (@test_tk_index.R#38) 
      4. Failure: tk_index(xts) test returns correct format. (@test_tk_index.R#97) 
      5. Failure: tk_index(zoo) test returns correct format. (@test_tk_index.R#111) 
      6. Failure: tk_index(decomposed.ts) test returns correct format. (@test_tk_index.R#331) 
      7. Failure: tk_make_future_timeseries(date) test returns correct format. (@test_tk_make_future_timeseries.R#56) 
      8. Failure: tk_make_future_timeseries(date) test returns correct format. (@test_tk_make_future_timeseries.R#62) 
      9. Failure: tk_make_future_timeseries(date) test returns correct format. (@test_tk_make_future_timeseries.R#69) 
      1. ...
      
      Error: testthat unit tests failed
      Execution halted
    ```

# tolBasis

<details>

* Version: 1.0
* Source code: https://github.com/cran/tolBasis
* URL: https://www.tol-project.org/browser/tolp/Rprojects/tolBasis
* Date/Publication: 2015-11-05 13:38:39
* Number of recursive dependencies: 10

Run `revdep_details(,"tolBasis")` for more info

</details>

## Newly broken

*   checking whether package ‘tolBasis’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/home/vspinu/Dropbox/dev/lubridate/revdep/checks/tolBasis/new/tolBasis.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘tolBasis’ ...
** package ‘tolBasis’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** byte-compile and prepare package for lazy loading
Error: object ‘new_interval’ is not exported by 'namespace:lubridate'
Execution halted
ERROR: lazy loading failed for package ‘tolBasis’
* removing ‘/home/vspinu/Dropbox/dev/lubridate/revdep/checks/tolBasis/new/tolBasis.Rcheck/tolBasis’

```
### CRAN

```
* installing *source* package ‘tolBasis’ ...
** package ‘tolBasis’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** byte-compile and prepare package for lazy loading
** help
*** installing help indices
** building package indices
** testing if installed package can be loaded from temporary location
** testing if installed package can be loaded from final location
** testing if installed package keeps a record of temporary installation path
* DONE (tolBasis)

```
# weathercan

<details>

* Version: 0.3.3
* Source code: https://github.com/cran/weathercan
* URL: https://docs.ropensci.org/weathercan, https://github.com/ropensci/weathercan
* BugReports: https://github.com/ropensci/weathercan/issues
* Date/Publication: 2020-02-05 14:10:02 UTC
* Number of recursive dependencies: 128

Run `revdep_details(,"weathercan")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      > library(testthat)
      > library(weathercan)
      > 
      > Sys.setenv("R_TESTS" = "")
      > 
      > test_check("weathercan")
      ── 1. Failure: normals_format()/frost_format() format data to correct class (@te
      f_fmt[["prob_first_fall_temp_below_0_on_date"]] inherits from `integer` not `numeric`.
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 495 | SKIPPED: 17 | WARNINGS: 0 | FAILED: 1 ]
      1. Failure: normals_format()/frost_format() format data to correct class (@test_08_normals.R#94) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘sf’
    ```

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 72 marked UTF-8 strings
    ```

