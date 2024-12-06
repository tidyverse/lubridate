# CohortGenerator

<details>

* Version: 0.11.2
* GitHub: https://github.com/OHDSI/CohortGenerator
* Source code: https://github.com/cran/CohortGenerator
* Date/Publication: 2024-09-30 19:40:02 UTC
* Number of recursive dependencies: 92

Run `revdepcheck::revdep_details(, "CohortGenerator")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      • On CRAN (1): 'test-dbms-platforms.R:89:3'
      
      ══ Failed tests ════════════════════════════════════════════════════════════════
      ── Error ('test-ResultsDataModel.R:9:3'): (code run outside of `test_that()`) ──
      Error in `DatabaseConnector::downloadJdbcDrivers("postgresql", pathToDriver = jdbcDriverFolder)`: Downloading and unzipping of postgresql JDBC driver to '/Users/vitalie/.jdbcDrivers' has failed.
      Backtrace:
          ▆
       1. └─DatabaseConnector::downloadJdbcDrivers("postgresql", pathToDriver = jdbcDriverFolder) at test-ResultsDataModel.R:9:3
       2.   └─rlang::abort(...)
      
      [ FAIL 1 | WARN 1 | SKIP 1 | PASS 405 ]
      Error: Test failures
      In addition: Warning message:
      call dbDisconnect() when finished working with a connection 
      Execution halted
    ```

# ntdr

<details>

* Version: 0.4.0
* GitHub: https://github.com/vgXhc/ntdr
* Source code: https://github.com/cran/ntdr
* Date/Publication: 2024-10-25 14:10:02 UTC
* Number of recursive dependencies: 87

Run `revdepcheck::revdep_details(, "ntdr")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      Backtrace:
          ▆
       1. ├─ntdr::get_ntd(agency = "City of Madison", modes = "MB") at test-get_ntd.R:60:3
       2. │ └─ntdr:::read_ntd_data(...)
       3. │   └─readxl::read_excel(path, sheet = sheet)
       4. │     └─readxl:::read_excel_(...)
       5. │       ├─readxl:::set_readxl_names(...)
       6. │       │ └─tibble::as_tibble(l, .name_repair = .name_repair)
       7. │       └─readxl (local) read_fun(...)
       8. └─readxl (local) `<fn>`(...)
       9.   └─utils::unzip(zip_path, list = TRUE)
      
      [ FAIL 4 | WARN 0 | SKIP 0 | PASS 5 ]
      Error: Test failures
      Execution halted
    ```

# tntpr

<details>

* Version: 1.2.1
* GitHub: https://github.com/tntp/tntpr
* Source code: https://github.com/cran/tntpr
* Date/Publication: 2024-11-26 23:00:02 UTC
* Number of recursive dependencies: 159

Run `revdepcheck::revdep_details(, "tntpr")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      [ FAIL 1 | WARN 10 | SKIP 0 | PASS 122 ]
      
      ══ Failed tests ════════════════════════════════════════════════════════════════
      ── Error ('test-tntp_cred.R:10:3'): Credentials can be retrieved with tntp_cred() ──
      Error in `b_macos_set_with_value(self, private, service, username, password, 
          keyring)`: keyring error (macOS Keychain), cannot set password: The specified item already exists in the keychain.
      Backtrace:
          ▆
       1. └─keyring::key_set_with_value(cred, password = pw) at test-tntp_cred.R:10:3
       2.   └─default_backend()$set_with_value(...)
       3.     └─keyring:::b_macos_set_with_value(...)
      
      [ FAIL 1 | WARN 10 | SKIP 0 | PASS 122 ]
      Error: Test failures
      Execution halted
    ```

## In both

*   checking running R code from vignettes ...
    ```
      ‘visualization-cookbook.Rmd’ using ‘UTF-8’... failed
     ERROR
    Errors in running code in vignettes:
    when running code in ‘visualization-cookbook.Rmd’
      ...
    Warning in grid.Call.graphics(C_text, as.graphicsAnnot(x$label), x$x, x$y,  :
      font family 'Halyard Display' not found in PostScript font database
    Warning in grid.Call.graphics(C_text, as.graphicsAnnot(x$label), x$x, x$y,  :
      font family 'Halyard Display' not found in PostScript font database
    Warning in grid.Call.graphics(C_text, as.graphicsAnnot(x$label), x$x, x$y,  :
      font family 'Halyard Display' not found in PostScript font database
    
      When sourcing ‘visualization-cookbook.R’:
    Error: invalid font type
    Execution halted
    ```

