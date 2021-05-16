# kiwisR

<details>

* Version: 0.2.0
* GitHub: https://github.com/rywhale/kiwisR
* Source code: https://github.com/cran/kiwisR
* Date/Publication: 2020-07-13 14:20:02 UTC
* Number of recursive dependencies: 72

Run `revdep_details(, "kiwisR")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Complete output:
      > library(testthat)
      > library(kiwisR)
      > 
      > test_check("kiwisR")
      ══ Failed tests ════════════════════════════════════════════════════════════════
      ── Failure (test_ki_station_list.R:71:3): ki_station_list accepts custom return fields (vector or string) ──
      `stn_cust_retr` not equal to `stn_cust_retr2`.
      Component "station_id": 90 string mismatches
      Component "station_no": 90 string mismatches
      
      [ FAIL 1 | WARN 0 | SKIP 0 | PASS 54 ]
      Error: Test failures
      Execution halted
    ```

