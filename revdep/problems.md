# CLVTools

<details>

* Version: 0.8.0
* GitHub: https://github.com/bachmannpatrick/CLVTools
* Source code: https://github.com/cran/CLVTools
* Date/Publication: 2021-03-23 16:40:08 UTC
* Number of recursive dependencies: 80

Run `revdep_details(, "CLVTools")` for more info

</details>

## Newly broken

*   R CMD check timed out
    

## In both

*   checking installed package size ... NOTE
    ```
      installed size is 10.7Mb
      sub-directories of 1Mb or more:
        libs   9.4Mb
    ```

# heatwaveR

<details>

* Version: 0.4.5
* GitHub: https://github.com/robwschlegel/heatwaveR
* Source code: https://github.com/cran/heatwaveR
* Date/Publication: 2021-01-07 16:10:16 UTC
* Number of recursive dependencies: 138

Run `revdep_details(, "heatwaveR")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘heatwaveR-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: block_average
    > ### Title: Calculate yearly means for event metrics.
    > ### Aliases: block_average
    > 
    > ### ** Examples
    > 
    > ts <- ts2clm(sst_WA, climatologyPeriod = c("1983-01-01", "2012-12-31"))
    Error in clim_calc_cpp(ts_wide, windowHalfWidth, pctile) : 
      function 'enterRNGScope' not provided by package 'Rcpp'
    Calls: ts2clm -> clim_calc_cpp
    Execution halted
    ```

*   R CMD check timed out
    

# mudata2

<details>

* Version: 1.1.2
* GitHub: https://github.com/paleolimbot/mudata2
* Source code: https://github.com/cran/mudata2
* Date/Publication: 2020-03-20 20:20:03 UTC
* Number of recursive dependencies: 95

Run `revdep_details(, "mudata2")` for more info

</details>

## Newly broken

*   R CMD check timed out
    

## Newly fixed

*   checking tests ...
    ```
      Running ‘test-all.R’
     ERROR
    Running the tests in ‘tests/test-all.R’ failed.
    Last 13 lines of output:
        1. ├─tibble::tibble(...) test-types.R:323:2
        2. │ └─tibble:::tibble_quos(xs, .rows, .name_repair)
        3. │   └─rlang::eval_tidy(xs[[j]], mask)
        4. └─sf::st_as_sfc
        5.   └─base::getExportedValue(pkg, name)
        6.     └─base::asNamespace(ns)
        7.       └─base::getNamespace(ns)
        8.         └─base::loadNamespace(name)
        9.           └─base::withRestarts(stop(cond), retry_loadNamespace = function() NULL)
       10.             └─base:::withOneRestart(expr, restarts[[1L]])
       11.               └─base:::doWithOneRestart(return(expr), restart)
      
      [ FAIL 12 | WARN 9 | SKIP 2 | PASS 881 ]
      Error: Test failures
      Execution halted
    ```

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘sf’
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘ggplot2’
      All declared Imports should be used.
    ```

