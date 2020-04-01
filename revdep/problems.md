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
# sweep

<details>

* Version: 0.2.2
* Source code: https://github.com/cran/sweep
* URL: https://github.com/business-science/sweep
* BugReports: https://github.com/business-science/sweep/issues
* Date/Publication: 2019-10-08 13:50:02 UTC
* Number of recursive dependencies: 127

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

# timetk

<details>

* Version: 0.1.3
* Source code: https://github.com/cran/timetk
* URL: https://github.com/business-science/timetk
* BugReports: https://github.com/business-science/timetk/issues
* Date/Publication: 2020-03-18 15:20:09 UTC
* Number of recursive dependencies: 145

Run `revdep_details(,"timetk")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 265 | SKIPPED: 0 | WARNINGS: 1 | FAILED: 21 ]
      1. Failure: tk_index(ts) test returns correct format. (@test_tk_index.R#38) 
      2. Failure: tk_index(xts) test returns correct format. (@test_tk_index.R#93) 
      3. Failure: tk_index(zoo) test returns correct format. (@test_tk_index.R#106) 
      4. Failure: tk_index(decomposed.ts) test returns correct format. (@test_tk_index.R#326) 
      5. Failure: tk_make_future_timeseries(date) test returns correct format. (@test_tk_make_future_timeseries.R#56) 
      6. Failure: tk_make_future_timeseries(date) test returns correct format. (@test_tk_make_future_timeseries.R#62) 
      7. Failure: tk_make_future_timeseries(date) test returns correct format. (@test_tk_make_future_timeseries.R#69) 
      8. Failure: tk_make_future_timeseries(date) test returns correct format. (@test_tk_make_future_timeseries.R#76) 
      9. Failure: tk_make_future_timeseries(date) test returns correct format. (@test_tk_make_future_timeseries.R#83) 
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
