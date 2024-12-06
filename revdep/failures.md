# admiralonco

<details>

* Version: 1.1.0
* GitHub: https://github.com/pharmaverse/admiralonco
* Source code: https://github.com/cran/admiralonco
* Date/Publication: 2024-06-19 14:10:30 UTC
* Number of recursive dependencies: 126

Run `revdepcheck::revdep_details(, "admiralonco")` for more info

</details>

## Error before installation

### Devel

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/admiralonco/new/admiralonco.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘admiralonco/DESCRIPTION’ ... OK
...
  ‘adtte.Rmd’ using ‘UTF-8’... OK
  ‘irecist.Rmd’ using ‘UTF-8’... OK
  ‘nactdt.Rmd’ using ‘UTF-8’... OK
 OK
* checking re-building of vignette outputs ... SKIPPED
* DONE

Status: OK







```
### CRAN

```






```
# anipaths

<details>

* Version: 0.10.3
* GitHub: NA
* Source code: https://github.com/cran/anipaths
* Date/Publication: 2024-02-02 09:30:06 UTC
* Number of recursive dependencies: 102

Run `revdepcheck::revdep_details(, "anipaths")` for more info

</details>

## Error before installation

### Devel

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/anipaths/new/anipaths.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘anipaths/DESCRIPTION’ ... OK
...
* checking re-building of vignette outputs ... SKIPPED
* DONE

Status: 1 WARNING, 1 NOTE
See
  ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/anipaths/new/anipaths.Rcheck/00check.log’
for details.








```
### CRAN

```






```
# arrow

<details>

* Version: 18.1.0
* GitHub: https://github.com/apache/arrow
* Source code: https://github.com/cran/arrow
* Date/Publication: 2024-12-05 06:20:02 UTC
* Number of recursive dependencies: 76

Run `revdepcheck::revdep_details(, "arrow")` for more info

</details>

## In both

*   checking whether package ‘arrow’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/arrow/new/arrow.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘arrow’ ...
** package ‘arrow’ successfully unpacked and MD5 sums checked
** using staged installation
*** pkg-config found.
*** Found local C++ source: 'tools/cpp'
*** Building libarrow from source
    For build options and troubleshooting, see the install guide:
    https://arrow.apache.org/docs/r/articles/install.html
**** cmake 3.20.0: /usr/local/adyen/bin/cmake
****  S3  support  requires libcurl-devel (rpm) or libcurl4-openssl-dev (deb) ; building with  ARROW_S3=OFF 
...

Test compile error: <stdin>:1:10: fatal error: 'arrow/api.h' file not found
#include <arrow/api.h>
         ^~~~~~~~~~~~~
1 error generated.
Failing compile command: clang++ -arch arm64 -E -I/opt/R/arm64/include  -falign-functions=64 -Wall -g -O2 -std=gnu++17 -xc++ -
PKG_CFLAGS=
PKG_LIBS=
ERROR: configuration failed for package ‘arrow’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/arrow/new/arrow.Rcheck/arrow’


```
### CRAN

```
* installing *source* package ‘arrow’ ...
** package ‘arrow’ successfully unpacked and MD5 sums checked
** using staged installation
*** pkg-config found.
*** Found local C++ source: 'tools/cpp'
*** Building libarrow from source
    For build options and troubleshooting, see the install guide:
    https://arrow.apache.org/docs/r/articles/install.html
**** cmake 3.20.0: /usr/local/adyen/bin/cmake
****  S3  support  requires libcurl-devel (rpm) or libcurl4-openssl-dev (deb) ; building with  ARROW_S3=OFF 
...

Test compile error: <stdin>:1:10: fatal error: 'arrow/api.h' file not found
#include <arrow/api.h>
         ^~~~~~~~~~~~~
1 error generated.
Failing compile command: clang++ -arch arm64 -E -I/opt/R/arm64/include  -falign-functions=64 -Wall -g -O2 -std=gnu++17 -xc++ -
PKG_CFLAGS=
PKG_LIBS=
ERROR: configuration failed for package ‘arrow’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/arrow/old/arrow.Rcheck/arrow’


```
# AutoPlots

<details>

* Version: 
* GitHub: https://github.com/tidyverse/lubridate
* Source code: NA
* Number of recursive dependencies: 0

</details>

## Error before installation

### Devel

```






```
### CRAN

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/AutoPlots/old/AutoPlots.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘AutoPlots/DESCRIPTION’ ... OK
...
* checking for code/documentation mismatches ... OK
* checking Rd \usage sections ... OK
* checking Rd contents ... OK
* checking for unstated dependencies in examples ... OK
* checking examples ... OK
* DONE

Status: OK







```
# baytrends

<details>

* Version: 2.0.12
* GitHub: https://github.com/tetratech/baytrends
* Source code: https://github.com/cran/baytrends
* Date/Publication: 2024-07-26 14:40:02 UTC
* Number of recursive dependencies: 150

Run `revdepcheck::revdep_details(, "baytrends")` for more info

</details>

## Error before installation

### Devel

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/baytrends/new/baytrends.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘baytrends/DESCRIPTION’ ... OK
...
* checking running R code from vignettes ...
  ‘Detrending_Flow_and_Salinity_Data.Rmd’ using ‘UTF-8’... OK
  ‘Processing_Censored_Data.Rmd’ using ‘UTF-8’... OK
 OK
* checking re-building of vignette outputs ... SKIPPED
* DONE

Status: OK







```
### CRAN

```






```
# BeeBDC

<details>

* Version: 1.2.1
* GitHub: https://github.com/jbdorey/BeeBDC
* Source code: https://github.com/cran/BeeBDC
* Date/Publication: 2024-11-04 04:10:02 UTC
* Number of recursive dependencies: 218

Run `revdepcheck::revdep_details(, "BeeBDC")` for more info

</details>

## Newly fixed

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
        3.     └─taxadb:::cache_urls(meta$url, meta$id)
        4.       └─base::vapply(...)
        5.         └─contentid (local) FUN(X[[i]], ...)
        6.           └─contentid::sources(...)
        7.             └─contentid:::generic_source(...)
        8.               └─base::lapply(...)
        9.                 └─contentid (local) FUN(X[[i]], ...)
       10.                   └─base::tryCatch(...)
       11.                     └─base (local) tryCatchList(expr, classes, parentenv, handlers)
       12.                       └─base (local) tryCatchOne(expr, names, parentenv, handlers[[1L]])
       13.                         └─value[[3L]](cond)
      
      [ FAIL 1 | WARN 6 | SKIP 0 | PASS 246 ]
      Error: Test failures
      Execution halted
    ```

## In both

*   R CMD check timed out
    

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 219 marked UTF-8 strings
    ```

# BEKKs

<details>

* Version: 1.4.5
* GitHub: NA
* Source code: https://github.com/cran/BEKKs
* Date/Publication: 2024-11-25 08:50:06 UTC
* Number of recursive dependencies: 85

Run `revdepcheck::revdep_details(, "BEKKs")` for more info

</details>

## In both

*   checking whether package ‘BEKKs’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/BEKKs/new/BEKKs.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘BEKKs’ ...
** package ‘BEKKs’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using C++17
using SDK: ‘MacOSX12.3.sdk’
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/BEKKs/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/BEKKs/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c BekkFunctions.cpp -o BekkFunctions.o
BekkFunctions.cpp:304:7: warning: unused variable 'numb_of_vars' [-Wunused-variable]
  int numb_of_vars = 2 * pow(N, 2) + N * (N + 1)/2;
...
8 warnings generated.
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/BEKKs/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/BEKKs/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c YLagCr.cpp -o YLagCr.o
clang++ -arch arm64 -std=gnu++17 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/opt/R/arm64/lib -o BEKKs.so BekkFunctions.o BekkSim.o IndicatorFunction.o RcppExports.o ScalarBEKK.o YLagCr.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0 -L/opt/gfortran/lib -lgfortran -lemutls_w -lquadmath -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0'
ld: warning: directory not found for option '-L/opt/gfortran/lib'
ld: library not found for -lgfortran
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [BEKKs.so] Error 1
ERROR: compilation failed for package ‘BEKKs’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/BEKKs/new/BEKKs.Rcheck/BEKKs’


```
### CRAN

```
* installing *source* package ‘BEKKs’ ...
** package ‘BEKKs’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using C++17
using SDK: ‘MacOSX12.3.sdk’
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/BEKKs/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/BEKKs/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c BekkFunctions.cpp -o BekkFunctions.o
BekkFunctions.cpp:304:7: warning: unused variable 'numb_of_vars' [-Wunused-variable]
  int numb_of_vars = 2 * pow(N, 2) + N * (N + 1)/2;
...
8 warnings generated.
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/BEKKs/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/BEKKs/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c YLagCr.cpp -o YLagCr.o
clang++ -arch arm64 -std=gnu++17 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/opt/R/arm64/lib -o BEKKs.so BekkFunctions.o BekkSim.o IndicatorFunction.o RcppExports.o ScalarBEKK.o YLagCr.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0 -L/opt/gfortran/lib -lgfortran -lemutls_w -lquadmath -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0'
ld: warning: directory not found for option '-L/opt/gfortran/lib'
ld: library not found for -lgfortran
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [BEKKs.so] Error 1
ERROR: compilation failed for package ‘BEKKs’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/BEKKs/old/BEKKs.Rcheck/BEKKs’


```
# bsam

<details>

* Version: 1.1.3
* GitHub: https://github.com/ianjonsen/bsam
* Source code: https://github.com/cran/bsam
* Date/Publication: 2020-09-01 13:40:03 UTC
* Number of recursive dependencies: 43

Run `revdepcheck::revdep_details(, "bsam")` for more info

</details>

## In both

*   checking whether package ‘bsam’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/bsam/new/bsam.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘bsam’ ...
** package ‘bsam’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
Error: package or namespace load failed for ‘rjags’:
 .onLoad failed in loadNamespace() for 'rjags', details:
...
  call: dyn.load(file, DLLpath = DLLpath, ...)
  error: unable to load shared object '/Users/vitalie/dev/lubridate/revdep/library.noindex/bsam/rjags/libs/rjags.so':
  dlopen(/Users/vitalie/dev/lubridate/revdep/library.noindex/bsam/rjags/libs/rjags.so, 0x000A): Library not loaded: /usr/local/lib/libjags.4.dylib
  Referenced from: <72E8DB98-CB80-3F9D-8F16-765FE7AB59EF> /Users/vitalie/dev/lubridate/revdep/library.noindex/bsam/rjags/libs/rjags.so
  Reason: tried: '/usr/local/lib/libjags.4.dylib' (no such file), '/System/Volumes/Preboot/Cryptexes/OS/usr/local/lib/libjags.4.dylib' (no such file), '/usr/local/lib/libjags.4.dylib' (no such file), '/Library/Frameworks/R.framework/Resources/lib/libjags.4.dylib' (no such file), '/Library/Java/JavaVirtualMachines/jdk-11.0.18+10/Contents/Home/lib/server/libjags.4.dylib' (no such file)
In addition: Warning message:
package ‘rjags’ was built under R version 4.3.3 
Execution halted
ERROR: lazy loading failed for package ‘bsam’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/bsam/new/bsam.Rcheck/bsam’


```
### CRAN

```
* installing *source* package ‘bsam’ ...
** package ‘bsam’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
Error: package or namespace load failed for ‘rjags’:
 .onLoad failed in loadNamespace() for 'rjags', details:
...
  call: dyn.load(file, DLLpath = DLLpath, ...)
  error: unable to load shared object '/Users/vitalie/dev/lubridate/revdep/library.noindex/bsam/rjags/libs/rjags.so':
  dlopen(/Users/vitalie/dev/lubridate/revdep/library.noindex/bsam/rjags/libs/rjags.so, 0x000A): Library not loaded: /usr/local/lib/libjags.4.dylib
  Referenced from: <72E8DB98-CB80-3F9D-8F16-765FE7AB59EF> /Users/vitalie/dev/lubridate/revdep/library.noindex/bsam/rjags/libs/rjags.so
  Reason: tried: '/usr/local/lib/libjags.4.dylib' (no such file), '/System/Volumes/Preboot/Cryptexes/OS/usr/local/lib/libjags.4.dylib' (no such file), '/usr/local/lib/libjags.4.dylib' (no such file), '/Library/Frameworks/R.framework/Resources/lib/libjags.4.dylib' (no such file), '/Library/Java/JavaVirtualMachines/jdk-11.0.18+10/Contents/Home/lib/server/libjags.4.dylib' (no such file)
In addition: Warning message:
package ‘rjags’ was built under R version 4.3.3 
Execution halted
ERROR: lazy loading failed for package ‘bsam’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/bsam/old/bsam.Rcheck/bsam’


```
# cgmanalysis

<details>

* Version: 2.7.7
* GitHub: NA
* Source code: https://github.com/cran/cgmanalysis
* Date/Publication: 2023-10-20 21:20:02 UTC
* Number of recursive dependencies: 52

Run `revdepcheck::revdep_details(, "cgmanalysis")` for more info

</details>

## Error before installation

### Devel

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/cgmanalysis/new/cgmanalysis.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘cgmanalysis/DESCRIPTION’ ... OK
...
* checking for code/documentation mismatches ... OK
* checking Rd \usage sections ... OK
* checking Rd contents ... OK
* checking for unstated dependencies in examples ... OK
* checking examples ... OK
* DONE

Status: OK







```
### CRAN

```






```
# cleanTS

<details>

* Version: 0.1.2
* GitHub: https://github.com/Mayur1009/cleanTS
* Source code: https://github.com/cran/cleanTS
* Date/Publication: 2023-07-06 07:33:10 UTC
* Number of recursive dependencies: 159

Run `revdepcheck::revdep_details(, "cleanTS")` for more info

</details>

## Error before installation

### Devel

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/cleanTS/new/cleanTS.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘cleanTS/DESCRIPTION’ ... OK
...
* checking examples ... OK
* checking for unstated dependencies in ‘tests’ ... OK
* checking tests ...
  Running ‘spelling.R’
 OK
* DONE

Status: OK







```
### CRAN

```






```
# CLVTools

<details>

* Version: 0.11.2
* GitHub: https://github.com/bachmannpatrick/CLVTools
* Source code: https://github.com/cran/CLVTools
* Date/Publication: 2024-12-02 22:40:02 UTC
* Number of recursive dependencies: 86

Run `revdepcheck::revdep_details(, "CLVTools")` for more info

</details>

## In both

*   checking whether package ‘CLVTools’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/CLVTools/new/CLVTools.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘CLVTools’ ...
** package ‘CLVTools’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using SDK: ‘MacOSX12.3.sdk’
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG `/Library/Frameworks/R.framework/Resources/bin/Rscript -e "RcppGSL:::CFlags()"` -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/CLVTools/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/CLVTools/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/CLVTools/RcppGSL/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/CLVTools/testthat/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
Warning message:
No 'gsl-config' config script found, limiting extensibility. 
In file included from RcppExports.cpp:5:
In file included from /Users/vitalie/dev/lubridate/revdep/library.noindex/CLVTools/RcppGSL/include/RcppGSL.h:25:
/Users/vitalie/dev/lubridate/revdep/library.noindex/CLVTools/RcppGSL/include/RcppGSLForward.h:25:10: fatal error: 'gsl/gsl_vector.h' file not found
#include <gsl/gsl_vector.h> 
         ^~~~~~~~~~~~~~~~~~
1 error generated.
make: *** [RcppExports.o] Error 1
ERROR: compilation failed for package ‘CLVTools’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/CLVTools/new/CLVTools.Rcheck/CLVTools’


```
### CRAN

```
* installing *source* package ‘CLVTools’ ...
** package ‘CLVTools’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using SDK: ‘MacOSX12.3.sdk’
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG `/Library/Frameworks/R.framework/Resources/bin/Rscript -e "RcppGSL:::CFlags()"` -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/CLVTools/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/CLVTools/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/CLVTools/RcppGSL/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/CLVTools/testthat/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
Warning message:
No 'gsl-config' config script found, limiting extensibility. 
In file included from RcppExports.cpp:5:
In file included from /Users/vitalie/dev/lubridate/revdep/library.noindex/CLVTools/RcppGSL/include/RcppGSL.h:25:
/Users/vitalie/dev/lubridate/revdep/library.noindex/CLVTools/RcppGSL/include/RcppGSLForward.h:25:10: fatal error: 'gsl/gsl_vector.h' file not found
#include <gsl/gsl_vector.h> 
         ^~~~~~~~~~~~~~~~~~
1 error generated.
make: *** [RcppExports.o] Error 1
ERROR: compilation failed for package ‘CLVTools’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/CLVTools/old/CLVTools.Rcheck/CLVTools’


```
# completejourney

<details>

* Version: 
* GitHub: https://github.com/tidyverse/lubridate
* Source code: NA
* Number of recursive dependencies: 0

</details>

## Error before installation

### Devel

```






```
### CRAN

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/completejourney/old/completejourney.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘completejourney/DESCRIPTION’ ... OK
...
* checking package vignettes in ‘inst/doc’ ... OK
* checking running R code from vignettes ...
  ‘completejourney.Rmd’ using ‘UTF-8’... OK
 OK
* checking re-building of vignette outputs ... SKIPPED
* DONE

Status: OK







```
# crawl

<details>

* Version: 2.3.0
* GitHub: NA
* Source code: https://github.com/cran/crawl
* Date/Publication: 2022-10-09 20:30:02 UTC
* Number of recursive dependencies: 36

Run `revdepcheck::revdep_details(, "crawl")` for more info

</details>

## In both

*   checking whether package ‘crawl’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/crawl/new/crawl.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘crawl’ ...
** package ‘crawl’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using C++ compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using SDK: ‘MacOSX12.3.sdk’
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/crawl/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/crawl/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c CTCRWN2LL.cpp -o CTCRWN2LL.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/crawl/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/crawl/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c CTCRWN2LL_DRIFT.cpp -o CTCRWN2LL_DRIFT.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/crawl/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/crawl/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c CTCRWPREDICT.cpp -o CTCRWPREDICT.o
...
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/crawl/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/crawl/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c SMM_MATS.cpp -o SMM_MATS.o
clang -arch arm64 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/crawl/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/crawl/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c init.c -o init.o
clang++ -arch arm64 -std=gnu++17 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/opt/R/arm64/lib -o crawl.so CTCRWN2LL.o CTCRWN2LL_DRIFT.o CTCRWPREDICT.o CTCRWPREDICT_DRIFT.o CTCRWSAMPLE.o CTCRWSAMPLE_DRIFT.o RcppExports.o SMM_MATS.o init.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0 -L/opt/gfortran/lib -lgfortran -lemutls_w -lquadmath -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0'
ld: warning: directory not found for option '-L/opt/gfortran/lib'
ld: library not found for -lgfortran
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [crawl.so] Error 1
ERROR: compilation failed for package ‘crawl’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/crawl/new/crawl.Rcheck/crawl’


```
### CRAN

```
* installing *source* package ‘crawl’ ...
** package ‘crawl’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using C++ compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using SDK: ‘MacOSX12.3.sdk’
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/crawl/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/crawl/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c CTCRWN2LL.cpp -o CTCRWN2LL.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/crawl/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/crawl/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c CTCRWN2LL_DRIFT.cpp -o CTCRWN2LL_DRIFT.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/crawl/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/crawl/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c CTCRWPREDICT.cpp -o CTCRWPREDICT.o
...
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/crawl/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/crawl/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c SMM_MATS.cpp -o SMM_MATS.o
clang -arch arm64 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/crawl/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/crawl/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c init.c -o init.o
clang++ -arch arm64 -std=gnu++17 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/opt/R/arm64/lib -o crawl.so CTCRWN2LL.o CTCRWN2LL_DRIFT.o CTCRWPREDICT.o CTCRWPREDICT_DRIFT.o CTCRWSAMPLE.o CTCRWSAMPLE_DRIFT.o RcppExports.o SMM_MATS.o init.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0 -L/opt/gfortran/lib -lgfortran -lemutls_w -lquadmath -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0'
ld: warning: directory not found for option '-L/opt/gfortran/lib'
ld: library not found for -lgfortran
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [crawl.so] Error 1
ERROR: compilation failed for package ‘crawl’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/crawl/old/crawl.Rcheck/crawl’


```
# cricketdata

<details>

* Version: 
* GitHub: https://github.com/tidyverse/lubridate
* Source code: NA
* Number of recursive dependencies: 0

</details>

## Error before installation

### Devel

```






```
### CRAN

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/cricketdata/old/cricketdata.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘cricketdata/DESCRIPTION’ ... OK
...

* checking re-building of vignette outputs ... SKIPPED
* DONE

Status: 1 ERROR, 1 NOTE
See
  ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/cricketdata/old/cricketdata.Rcheck/00check.log’
for details.







```
# CSTools

<details>

* Version: 5.2.0
* GitHub: NA
* Source code: https://github.com/cran/CSTools
* Date/Publication: 2024-01-25 16:40:02 UTC
* Number of recursive dependencies: 114

Run `revdepcheck::revdep_details(, "CSTools")` for more info

</details>

## In both

*   checking whether package ‘CSTools’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/CSTools/new/CSTools.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘CSTools’ ...
** package ‘CSTools’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
sh: /opt/gfortran/bin/gfortran: No such file or directory
using SDK: ‘MacOSX12.3.sdk’
/opt/gfortran/bin/gfortran -arch arm64  -fPIC  -Wall -g -O2  -c  mod_csts.f90 -o mod_csts.o
make: /opt/gfortran/bin/gfortran: No such file or directory
make: *** [mod_csts.o] Error 1
ERROR: compilation failed for package ‘CSTools’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/CSTools/new/CSTools.Rcheck/CSTools’


```
### CRAN

```
* installing *source* package ‘CSTools’ ...
** package ‘CSTools’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
sh: /opt/gfortran/bin/gfortran: No such file or directory
using SDK: ‘MacOSX12.3.sdk’
/opt/gfortran/bin/gfortran -arch arm64  -fPIC  -Wall -g -O2  -c  mod_csts.f90 -o mod_csts.o
make: /opt/gfortran/bin/gfortran: No such file or directory
make: *** [mod_csts.o] Error 1
ERROR: compilation failed for package ‘CSTools’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/CSTools/old/CSTools.Rcheck/CSTools’


```
# ctrdata

<details>

* Version: 1.19.5
* GitHub: https://github.com/rfhb/ctrdata
* Source code: https://github.com/cran/ctrdata
* Date/Publication: 2024-11-10 17:10:09 UTC
* Number of recursive dependencies: 126

Run `revdepcheck::revdep_details(, "ctrdata")` for more info

</details>

## Error before installation

### Devel

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/ctrdata/new/ctrdata.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘ctrdata/DESCRIPTION’ ... OK
...
  ‘ctrdata_install.pdf.asis’ using ‘UTF-8’... OK
  ‘ctrdata_retrieve.pdf.asis’ using ‘UTF-8’... OK
  ‘ctrdata_summarise.pdf.asis’ using ‘UTF-8’... OK
 NONE
* checking re-building of vignette outputs ... SKIPPED
* DONE

Status: OK







```
### CRAN

```






```
# diversitree

<details>

* Version: 0.10-1
* GitHub: NA
* Source code: https://github.com/cran/diversitree
* Date/Publication: 2024-10-02 07:10:01 UTC
* Number of recursive dependencies: 45

Run `revdepcheck::revdep_details(, "diversitree")` for more info

</details>

## In both

*   checking whether package ‘diversitree’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/diversitree/new/diversitree.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘diversitree’ ...
** package ‘diversitree’ successfully unpacked and MD5 sums checked
** using staged installation
checking for gcc... clang -arch arm64
checking whether the C compiler works... no
configure: error: in `/Users/vitalie/dev/lubridate/revdep/checks.noindex/diversitree/new/diversitree.Rcheck/00_pkg_src/diversitree':
configure: error: C compiler cannot create executables
See `config.log' for more details
ERROR: configuration failed for package ‘diversitree’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/diversitree/new/diversitree.Rcheck/diversitree’


```
### CRAN

```
* installing *source* package ‘diversitree’ ...
** package ‘diversitree’ successfully unpacked and MD5 sums checked
** using staged installation
checking for gcc... clang -arch arm64
checking whether the C compiler works... no
configure: error: in `/Users/vitalie/dev/lubridate/revdep/checks.noindex/diversitree/old/diversitree.Rcheck/00_pkg_src/diversitree':
configure: error: C compiler cannot create executables
See `config.log' for more details
ERROR: configuration failed for package ‘diversitree’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/diversitree/old/diversitree.Rcheck/diversitree’


```
# doublIn

<details>

* Version: 0.2.0
* GitHub: NA
* Source code: https://github.com/cran/doublIn
* Date/Publication: 2024-06-19 12:40:07 UTC
* Number of recursive dependencies: 161

Run `revdepcheck::revdep_details(, "doublIn")` for more info

</details>

## Error before installation

### Devel

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/doublIn/new/doublIn.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘doublIn/DESCRIPTION’ ... OK
...
Installation failed.
See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/doublIn/new/doublIn.Rcheck/00install.out’ for details.
* DONE

Status: 1 ERROR
See
  ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/doublIn/new/doublIn.Rcheck/00check.log’
for details.







```
### CRAN

```






```
# duckplyr

<details>

* Version: 0.4.1
* GitHub: https://github.com/duckdblabs/duckplyr
* Source code: https://github.com/cran/duckplyr
* Date/Publication: 2024-07-12 10:50:02 UTC
* Number of recursive dependencies: 94

Run `revdepcheck::revdep_details(, "duckplyr")` for more info

</details>

## Error before installation

### Devel

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/duckplyr/new/duckplyr.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘duckplyr/DESCRIPTION’ ... OK
...
 OK
* DONE

Status: 1 NOTE
See
  ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/duckplyr/new/duckplyr.Rcheck/00check.log’
for details.








```
### CRAN

```






```
# EBASE

<details>

* Version: 1.1.0
* GitHub: https://github.com/fawda123/EBASE
* Source code: https://github.com/cran/EBASE
* Date/Publication: 2024-09-25 17:30:02 UTC
* Number of recursive dependencies: 92

Run `revdepcheck::revdep_details(, "EBASE")` for more info

</details>

## In both

*   checking whether package ‘EBASE’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/EBASE/new/EBASE.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘EBASE’ ...
** package ‘EBASE’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
Error: .onLoad failed in loadNamespace() for 'rjags', details:
  call: dyn.load(file, DLLpath = DLLpath, ...)
  error: unable to load shared object '/Users/vitalie/dev/lubridate/revdep/library.noindex/EBASE/rjags/libs/rjags.so':
  dlopen(/Users/vitalie/dev/lubridate/revdep/library.noindex/EBASE/rjags/libs/rjags.so, 0x000A): Library not loaded: /usr/local/lib/libjags.4.dylib
  Referenced from: <72E8DB98-CB80-3F9D-8F16-765FE7AB59EF> /Users/vitalie/dev/lubridate/revdep/library.noindex/EBASE/rjags/libs/rjags.so
  Reason: tried: '/usr/local/lib/libjags.4.dylib' (no such file), '/System/Volumes/Preboot/Cryptexes/OS/usr/local/lib/libjags.4.dylib' (no such file), '/usr/local/lib/libjags.4.dylib' (no such file), '/Library/Frameworks/R.framework/Resources/lib/libjags.4.dylib' (no such file), '/Library/Java/JavaVirtualMachines/jdk-11.0.18+10/Contents/Home/lib/server/libjags.4.dylib' (no such file)
Execution halted
ERROR: lazy loading failed for package ‘EBASE’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/EBASE/new/EBASE.Rcheck/EBASE’


```
### CRAN

```
* installing *source* package ‘EBASE’ ...
** package ‘EBASE’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
Error: .onLoad failed in loadNamespace() for 'rjags', details:
  call: dyn.load(file, DLLpath = DLLpath, ...)
  error: unable to load shared object '/Users/vitalie/dev/lubridate/revdep/library.noindex/EBASE/rjags/libs/rjags.so':
  dlopen(/Users/vitalie/dev/lubridate/revdep/library.noindex/EBASE/rjags/libs/rjags.so, 0x000A): Library not loaded: /usr/local/lib/libjags.4.dylib
  Referenced from: <72E8DB98-CB80-3F9D-8F16-765FE7AB59EF> /Users/vitalie/dev/lubridate/revdep/library.noindex/EBASE/rjags/libs/rjags.so
  Reason: tried: '/usr/local/lib/libjags.4.dylib' (no such file), '/System/Volumes/Preboot/Cryptexes/OS/usr/local/lib/libjags.4.dylib' (no such file), '/usr/local/lib/libjags.4.dylib' (no such file), '/Library/Frameworks/R.framework/Resources/lib/libjags.4.dylib' (no such file), '/Library/Java/JavaVirtualMachines/jdk-11.0.18+10/Contents/Home/lib/server/libjags.4.dylib' (no such file)
Execution halted
ERROR: lazy loading failed for package ‘EBASE’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/EBASE/old/EBASE.Rcheck/EBASE’


```
# eurostat

<details>

* Version: 4.0.0
* GitHub: https://github.com/rOpenGov/eurostat
* Source code: https://github.com/cran/eurostat
* Date/Publication: 2023-12-19 20:30:02 UTC
* Number of recursive dependencies: 104

Run `revdepcheck::revdep_details(, "eurostat")` for more info

</details>

## Error before installation

### Devel

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/eurostat/new/eurostat.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘eurostat/DESCRIPTION’ ... OK
...
* checking re-building of vignette outputs ... SKIPPED
* DONE

Status: 1 NOTE
See
  ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/eurostat/new/eurostat.Rcheck/00check.log’
for details.








```
### CRAN

```






```
# exuber

<details>

* Version: 1.0.2
* GitHub: https://github.com/kvasilopoulos/exuber
* Source code: https://github.com/cran/exuber
* Date/Publication: 2023-03-22 23:10:02 UTC
* Number of recursive dependencies: 100

Run `revdepcheck::revdep_details(, "exuber")` for more info

</details>

## In both

*   checking whether package ‘exuber’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/exuber/new/exuber.Rcheck/00install.out’ for details.
    ```

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘exuberdata’
    ```

## Installation

### Devel

```
* installing *source* package ‘exuber’ ...
** package ‘exuber’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using C++17
using SDK: ‘MacOSX12.3.sdk’
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/exuber/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/exuber/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/exuber/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/exuber/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c rls_gsadf.cpp -o rls_gsadf.o
clang++ -arch arm64 -std=gnu++17 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/opt/R/arm64/lib -o exuber.so RcppExports.o rls_gsadf.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0 -L/opt/gfortran/lib -lgfortran -lemutls_w -lquadmath -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0'
ld: warning: directory not found for option '-L/opt/gfortran/lib'
ld: library not found for -lgfortran
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [exuber.so] Error 1
ERROR: compilation failed for package ‘exuber’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/exuber/new/exuber.Rcheck/exuber’


```
### CRAN

```
* installing *source* package ‘exuber’ ...
** package ‘exuber’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using C++17
using SDK: ‘MacOSX12.3.sdk’
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/exuber/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/exuber/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/exuber/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/exuber/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c rls_gsadf.cpp -o rls_gsadf.o
clang++ -arch arm64 -std=gnu++17 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/opt/R/arm64/lib -o exuber.so RcppExports.o rls_gsadf.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0 -L/opt/gfortran/lib -lgfortran -lemutls_w -lquadmath -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0'
ld: warning: directory not found for option '-L/opt/gfortran/lib'
ld: library not found for -lgfortran
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [exuber.so] Error 1
ERROR: compilation failed for package ‘exuber’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/exuber/old/exuber.Rcheck/exuber’


```
# fable.ata

<details>

* Version: 0.0.6
* GitHub: https://github.com/alsabtay/fable.ata
* Source code: https://github.com/cran/fable.ata
* Date/Publication: 2023-06-19 19:00:02 UTC
* Number of recursive dependencies: 85

Run `revdepcheck::revdep_details(, "fable.ata")` for more info

</details>

## In both

*   checking whether package ‘fable.ata’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/fable.ata/new/fable.ata.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘fable.ata’ ...
** package ‘fable.ata’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** byte-compile and prepare package for lazy loading
Error: package or namespace load failed for ‘ATAforecasting’ in loadNamespace(j <- i[[1L]], c(lib.loc, .libPaths()), versionCheck = vI[[j]]):
 namespace ‘Matrix’ 1.5-4.1 is already loaded, but >= 1.6.0 is required
In addition: Warning message:
package ‘fabletools’ was built under R version 4.3.3 
Execution halted
ERROR: lazy loading failed for package ‘fable.ata’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/fable.ata/new/fable.ata.Rcheck/fable.ata’


```
### CRAN

```
* installing *source* package ‘fable.ata’ ...
** package ‘fable.ata’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** byte-compile and prepare package for lazy loading
Error: package or namespace load failed for ‘ATAforecasting’ in loadNamespace(j <- i[[1L]], c(lib.loc, .libPaths()), versionCheck = vI[[j]]):
 namespace ‘Matrix’ 1.5-4.1 is already loaded, but >= 1.6.0 is required
In addition: Warning message:
package ‘fabletools’ was built under R version 4.3.3 
Execution halted
ERROR: lazy loading failed for package ‘fable.ata’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/fable.ata/old/fable.ata.Rcheck/fable.ata’


```
# farr

<details>

* Version: 
* GitHub: https://github.com/tidyverse/lubridate
* Source code: NA
* Number of recursive dependencies: 0

</details>

## Error before installation

### Devel

```






```
### CRAN

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/farr/old/farr.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘farr/DESCRIPTION’ ... OK
...
 OK
* DONE

Status: 1 NOTE
See
  ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/farr/old/farr.Rcheck/00check.log’
for details.








```
# fastcpd

<details>

* Version: 0.14.6
* GitHub: https://github.com/doccstat/fastcpd
* Source code: https://github.com/cran/fastcpd
* Date/Publication: 2024-11-05 09:00:02 UTC
* Number of recursive dependencies: 110

Run `revdepcheck::revdep_details(, "fastcpd")` for more info

</details>

## In both

*   checking whether package ‘fastcpd’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/fastcpd/new/fastcpd.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘fastcpd’ ...
** package ‘fastcpd’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using SDK: ‘MacOSX12.3.sdk’
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/progress/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/RcppClock/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/testthat/include' -I/opt/R/arm64/include    -I../inst/include/ -fPIC  -falign-functions=64 -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/progress/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/RcppClock/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/testthat/include' -I/opt/R/arm64/include    -I../inst/include/ -fPIC  -falign-functions=64 -Wall -g -O2  -c fastcpd_class.cc -o fastcpd_class.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/progress/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/RcppClock/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/testthat/include' -I/opt/R/arm64/include    -I../inst/include/ -fPIC  -falign-functions=64 -Wall -g -O2  -c fastcpd_class_nll.cc -o fastcpd_class_nll.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/progress/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/RcppClock/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/testthat/include' -I/opt/R/arm64/include    -I../inst/include/ -fPIC  -falign-functions=64 -Wall -g -O2  -c fastcpd_impl.cc -o fastcpd_impl.o
...
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/progress/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/RcppClock/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/testthat/include' -I/opt/R/arm64/include    -I../inst/include/ -fPIC  -falign-functions=64 -Wall -g -O2  -c test-fastcpd.cc -o test-fastcpd.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/progress/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/RcppClock/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/testthat/include' -I/opt/R/arm64/include    -I../inst/include/ -fPIC  -falign-functions=64 -Wall -g -O2  -c test-runner.cc -o test-runner.o
clang++ -arch arm64 -std=gnu++17 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/opt/R/arm64/lib -o fastcpd.so RcppExports.o fastcpd_class.o fastcpd_class_nll.o fastcpd_impl.o fastcpd_test.o test-fastcpd.o test-runner.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0 -L/opt/gfortran/lib -lgfortran -lemutls_w -lquadmath -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0'
ld: warning: directory not found for option '-L/opt/gfortran/lib'
ld: library not found for -lgfortran
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [fastcpd.so] Error 1
ERROR: compilation failed for package ‘fastcpd’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/fastcpd/new/fastcpd.Rcheck/fastcpd’


```
### CRAN

```
* installing *source* package ‘fastcpd’ ...
** package ‘fastcpd’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using SDK: ‘MacOSX12.3.sdk’
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/progress/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/RcppClock/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/testthat/include' -I/opt/R/arm64/include    -I../inst/include/ -fPIC  -falign-functions=64 -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/progress/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/RcppClock/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/testthat/include' -I/opt/R/arm64/include    -I../inst/include/ -fPIC  -falign-functions=64 -Wall -g -O2  -c fastcpd_class.cc -o fastcpd_class.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/progress/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/RcppClock/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/testthat/include' -I/opt/R/arm64/include    -I../inst/include/ -fPIC  -falign-functions=64 -Wall -g -O2  -c fastcpd_class_nll.cc -o fastcpd_class_nll.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/progress/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/RcppClock/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/testthat/include' -I/opt/R/arm64/include    -I../inst/include/ -fPIC  -falign-functions=64 -Wall -g -O2  -c fastcpd_impl.cc -o fastcpd_impl.o
...
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/progress/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/RcppClock/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/testthat/include' -I/opt/R/arm64/include    -I../inst/include/ -fPIC  -falign-functions=64 -Wall -g -O2  -c test-fastcpd.cc -o test-fastcpd.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/progress/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/RcppClock/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/fastcpd/testthat/include' -I/opt/R/arm64/include    -I../inst/include/ -fPIC  -falign-functions=64 -Wall -g -O2  -c test-runner.cc -o test-runner.o
clang++ -arch arm64 -std=gnu++17 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/opt/R/arm64/lib -o fastcpd.so RcppExports.o fastcpd_class.o fastcpd_class_nll.o fastcpd_impl.o fastcpd_test.o test-fastcpd.o test-runner.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0 -L/opt/gfortran/lib -lgfortran -lemutls_w -lquadmath -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0'
ld: warning: directory not found for option '-L/opt/gfortran/lib'
ld: library not found for -lgfortran
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [fastcpd.so] Error 1
ERROR: compilation failed for package ‘fastcpd’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/fastcpd/old/fastcpd.Rcheck/fastcpd’


```
# fixtuRes

<details>

* Version: 
* GitHub: https://github.com/tidyverse/lubridate
* Source code: NA
* Number of recursive dependencies: 0

</details>

## Error before installation

### Devel

```






```
### CRAN

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/fixtuRes/old/fixtuRes.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘fixtuRes/DESCRIPTION’ ... OK
...
* checking package vignettes in ‘inst/doc’ ... OK
* checking running R code from vignettes ...
  ‘configuration.Rmd’ using ‘UTF-8’... OK
 NONE
* checking re-building of vignette outputs ... SKIPPED
* DONE

Status: OK







```
# fmpcloudr

<details>

* Version: 
* GitHub: https://github.com/tidyverse/lubridate
* Source code: NA
* Number of recursive dependencies: 0

</details>

## Error before installation

### Devel

```






```
### CRAN

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/fmpcloudr/old/fmpcloudr.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘fmpcloudr/DESCRIPTION’ ... OK
...
 OK
* DONE

Status: 1 NOTE
See
  ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/fmpcloudr/old/fmpcloudr.Rcheck/00check.log’
for details.








```
# garma

<details>

* Version: 0.9.23
* GitHub: https://github.com/rlph50/garma
* Source code: https://github.com/cran/garma
* Date/Publication: 2024-09-13 03:40:02 UTC
* Number of recursive dependencies: 91

Run `revdepcheck::revdep_details(, "garma")` for more info

</details>

## Error before installation

### Devel

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/garma/new/garma.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘garma/DESCRIPTION’ ... OK
...
* checking re-building of vignette outputs ... SKIPPED
* DONE

Status: 1 WARNING
See
  ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/garma/new/garma.Rcheck/00check.log’
for details.








```
### CRAN

```






```
# gdalcubes

<details>

* Version: 0.7.0
* GitHub: https://github.com/appelmar/gdalcubes
* Source code: https://github.com/cran/gdalcubes
* Date/Publication: 2024-03-07 00:00:02 UTC
* Number of recursive dependencies: 50

Run `revdepcheck::revdep_details(, "gdalcubes")` for more info

</details>

## In both

*   checking whether package ‘gdalcubes’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/gdalcubes/new/gdalcubes.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘gdalcubes’ ...
** package ‘gdalcubes’ successfully unpacked and MD5 sums checked
** using staged installation
configure: CC: clang -arch arm64
configure: CXX: clang++ -arch arm64 -std=gnu++11
checking for gdal-config... no
no
configure: error: gdal-config not found or not executable.
ERROR: configuration failed for package ‘gdalcubes’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/gdalcubes/new/gdalcubes.Rcheck/gdalcubes’


```
### CRAN

```
* installing *source* package ‘gdalcubes’ ...
** package ‘gdalcubes’ successfully unpacked and MD5 sums checked
** using staged installation
configure: CC: clang -arch arm64
configure: CXX: clang++ -arch arm64 -std=gnu++11
checking for gdal-config... no
no
configure: error: gdal-config not found or not executable.
ERROR: configuration failed for package ‘gdalcubes’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/gdalcubes/old/gdalcubes.Rcheck/gdalcubes’


```
# ggpp

<details>

* Version: 
* GitHub: https://github.com/tidyverse/lubridate
* Source code: NA
* Number of recursive dependencies: 0

</details>

## Error before installation

### Devel

```






```
### CRAN

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/ggpp/old/ggpp.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘ggpp/DESCRIPTION’ ... OK
...
* checking running R code from vignettes ...
  ‘grammar-extensions.Rmd’ using ‘UTF-8’... OK
  ‘nudge-examples.Rmd’ using ‘UTF-8’... OK
 OK
* checking re-building of vignette outputs ... SKIPPED
* DONE

Status: OK







```
# gk

<details>

* Version: 0.6.0
* GitHub: https://github.com/dennisprangle/gk
* Source code: https://github.com/cran/gk
* Date/Publication: 2023-08-10 15:40:15 UTC
* Number of recursive dependencies: 109

Run `revdepcheck::revdep_details(, "gk")` for more info

</details>

## Error before installation

### Devel

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/gk/new/gk.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘gk/DESCRIPTION’ ... OK
...
* checking examples ... OK
* checking for unstated dependencies in ‘tests’ ... OK
* checking tests ...
  Running ‘testthat.R’
 OK
* DONE

Status: OK







```
### CRAN

```






```
# heatwaveR

<details>

* Version: 0.4.6
* GitHub: https://github.com/robwschlegel/heatwaveR
* Source code: https://github.com/cran/heatwaveR
* Date/Publication: 2021-10-27 14:50:02 UTC
* Number of recursive dependencies: 133

Run `revdepcheck::revdep_details(, "heatwaveR")` for more info

</details>

## In both

*   checking whether package ‘heatwaveR’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/heatwaveR/new/heatwaveR.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘heatwaveR’ ...
** package ‘heatwaveR’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using C++11
using SDK: ‘MacOSX12.3.sdk’
clang++ -arch arm64 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/heatwaveR/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/heatwaveR/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++ -arch arm64 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/heatwaveR/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/heatwaveR/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c clim_calc.cpp -o clim_calc.o
clang++ -arch arm64 -std=gnu++11 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/opt/R/arm64/lib -o heatwaveR.so RcppExports.o clim_calc.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0 -L/opt/gfortran/lib -lgfortran -lemutls_w -lquadmath -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0'
ld: warning: directory not found for option '-L/opt/gfortran/lib'
ld: library not found for -lgfortran
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [heatwaveR.so] Error 1
ERROR: compilation failed for package ‘heatwaveR’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/heatwaveR/new/heatwaveR.Rcheck/heatwaveR’


```
### CRAN

```
* installing *source* package ‘heatwaveR’ ...
** package ‘heatwaveR’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using C++11
using SDK: ‘MacOSX12.3.sdk’
clang++ -arch arm64 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/heatwaveR/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/heatwaveR/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++ -arch arm64 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/heatwaveR/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/heatwaveR/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c clim_calc.cpp -o clim_calc.o
clang++ -arch arm64 -std=gnu++11 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/opt/R/arm64/lib -o heatwaveR.so RcppExports.o clim_calc.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0 -L/opt/gfortran/lib -lgfortran -lemutls_w -lquadmath -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0'
ld: warning: directory not found for option '-L/opt/gfortran/lib'
ld: library not found for -lgfortran
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [heatwaveR.so] Error 1
ERROR: compilation failed for package ‘heatwaveR’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/heatwaveR/old/heatwaveR.Rcheck/heatwaveR’


```
# highcharter

<details>

* Version: 0.9.4
* GitHub: https://github.com/jbkunst/highcharter
* Source code: https://github.com/cran/highcharter
* Date/Publication: 2022-01-03 16:40:05 UTC
* Number of recursive dependencies: 149

Run `revdepcheck::revdep_details(, "highcharter")` for more info

</details>

## Error before installation

### Devel

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/highcharter/new/highcharter.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘highcharter/DESCRIPTION’ ... OK
...
* checking examples ... OK
* DONE

Status: 1 NOTE
See
  ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/highcharter/new/highcharter.Rcheck/00check.log’
for details.








```
### CRAN

```






```
# HMDHFDplus

<details>

* Version: 
* GitHub: https://github.com/tidyverse/lubridate
* Source code: NA
* Number of recursive dependencies: 0

</details>

## Error before installation

### Devel

```






```
### CRAN

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/HMDHFDplus/old/HMDHFDplus.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘HMDHFDplus/DESCRIPTION’ ... OK
...
* checking for code/documentation mismatches ... OK
* checking Rd \usage sections ... OK
* checking Rd contents ... OK
* checking for unstated dependencies in examples ... OK
* checking examples ... OK
* DONE

Status: OK







```
# hystReet

<details>

* Version: 0.0.3
* GitHub: https://github.com/JohannesFriedrich/hystReet
* Source code: https://github.com/cran/hystReet
* Date/Publication: 2022-11-27 13:00:02 UTC
* Number of recursive dependencies: 60

Run `revdepcheck::revdep_details(, "hystReet")` for more info

</details>

## Error before installation

### Devel

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/hystReet/new/hystReet.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘hystReet/DESCRIPTION’ ... OK
...

* checking re-building of vignette outputs ... SKIPPED
* DONE

Status: 1 ERROR, 1 WARNING, 1 NOTE
See
  ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/hystReet/new/hystReet.Rcheck/00check.log’
for details.







```
### CRAN

```






```
# iClick

<details>

* Version: 1.5
* GitHub: NA
* Source code: https://github.com/cran/iClick
* Date/Publication: 2018-11-22 12:00:18 UTC
* Number of recursive dependencies: 160

Run `revdepcheck::revdep_details(, "iClick")` for more info

</details>

## In both

*   checking whether package ‘iClick’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/iClick/new/iClick.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘iClick’ ...
** package ‘iClick’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** data
*** moving datasets to lazyload DB
** byte-compile and prepare package for lazy loading
tcltk DLL is linked to '/opt/X11/lib/libX11.6.dylib'
Error: package or namespace load failed for ‘tcltk’:
 .onLoad failed in loadNamespace() for 'tcltk', details:
  call: fun(libname, pkgname)
  error: X11 library is missing: install XQuartz from www.xquartz.org
In addition: Warning message:
package ‘rugarch’ was built under R version 4.3.3 
Execution halted
ERROR: lazy loading failed for package ‘iClick’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/iClick/new/iClick.Rcheck/iClick’


```
### CRAN

```
* installing *source* package ‘iClick’ ...
** package ‘iClick’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** data
*** moving datasets to lazyload DB
** byte-compile and prepare package for lazy loading
tcltk DLL is linked to '/opt/X11/lib/libX11.6.dylib'
Error: package or namespace load failed for ‘tcltk’:
 .onLoad failed in loadNamespace() for 'tcltk', details:
  call: fun(libname, pkgname)
  error: X11 library is missing: install XQuartz from www.xquartz.org
In addition: Warning message:
package ‘rugarch’ was built under R version 4.3.3 
Execution halted
ERROR: lazy loading failed for package ‘iClick’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/iClick/old/iClick.Rcheck/iClick’


```
# ie2misc

<details>

* Version: 0.9.1
* GitHub: NA
* Source code: https://github.com/cran/ie2misc
* Date/Publication: 2023-09-20 07:20:02 UTC
* Number of recursive dependencies: 49

Run `revdepcheck::revdep_details(, "ie2misc")` for more info

</details>

## In both

*   checking whether package ‘ie2misc’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/ie2misc/new/ie2misc.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘ie2misc’ ...
** package ‘ie2misc’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** inst
** byte-compile and prepare package for lazy loading
tcltk DLL is linked to '/opt/X11/lib/libX11.6.dylib'
Error: .onLoad failed in loadNamespace() for 'tcltk', details:
  call: fun(libname, pkgname)
  error: X11 library is missing: install XQuartz from www.xquartz.org
Execution halted
ERROR: lazy loading failed for package ‘ie2misc’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/ie2misc/new/ie2misc.Rcheck/ie2misc’


```
### CRAN

```
* installing *source* package ‘ie2misc’ ...
** package ‘ie2misc’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** inst
** byte-compile and prepare package for lazy loading
tcltk DLL is linked to '/opt/X11/lib/libX11.6.dylib'
Error: .onLoad failed in loadNamespace() for 'tcltk', details:
  call: fun(libname, pkgname)
  error: X11 library is missing: install XQuartz from www.xquartz.org
Execution halted
ERROR: lazy loading failed for package ‘ie2misc’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/ie2misc/old/ie2misc.Rcheck/ie2misc’


```
# ie2miscdata

<details>

* Version: 
* GitHub: https://github.com/tidyverse/lubridate
* Source code: NA
* Number of recursive dependencies: 0

</details>

## Error before installation

### Devel

```






```
### CRAN

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/ie2miscdata/old/ie2miscdata.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘ie2miscdata/DESCRIPTION’ ... OK
...
* checking re-building of vignette outputs ... SKIPPED
* DONE

Status: 1 NOTE
See
  ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/ie2miscdata/old/ie2miscdata.Rcheck/00check.log’
for details.








```
# insee

<details>

* Version: 1.1.7
* GitHub: https://github.com/pyr-opendatafr/R-Insee-Data
* Source code: https://github.com/cran/insee
* Date/Publication: 2024-08-26 07:30:01 UTC
* Number of recursive dependencies: 88

Run `revdepcheck::revdep_details(, "insee")` for more info

</details>

## Error before installation

### Devel

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/insee/new/insee.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘insee/DESCRIPTION’ ... OK
...
  ‘v5_pop-vignettes.Rmd’ using ‘UTF-8’... OK
  ‘v6_pop_map-vignettes.Rmd’ using ‘UTF-8’... OK
  ‘v7_death_birth-vignettes.Rmd’ using ‘UTF-8’... OK
 OK
* checking re-building of vignette outputs ... SKIPPED
* DONE

Status: OK







```
### CRAN

```






```
# iNZightPlots

<details>

* Version: 2.15.3
* GitHub: https://github.com/iNZightVIT/iNZightPlots
* Source code: https://github.com/cran/iNZightPlots
* Date/Publication: 2023-10-14 05:00:02 UTC
* Number of recursive dependencies: 161

Run `revdepcheck::revdep_details(, "iNZightPlots")` for more info

</details>

## In both

*   checking whether package ‘iNZightPlots’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/iNZightPlots/new/iNZightPlots.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘iNZightPlots’ ...
** package ‘iNZightPlots’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** inst
** byte-compile and prepare package for lazy loading
Error in loadNamespace(j <- i[[1L]], c(lib.loc, .libPaths()), versionCheck = vI[[j]]) : 
  namespace ‘Matrix’ 1.5-4.1 is already loaded, but >= 1.6.0 is required
Calls: <Anonymous> ... namespaceImportFrom -> asNamespace -> loadNamespace
Execution halted
ERROR: lazy loading failed for package ‘iNZightPlots’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/iNZightPlots/new/iNZightPlots.Rcheck/iNZightPlots’


```
### CRAN

```
* installing *source* package ‘iNZightPlots’ ...
** package ‘iNZightPlots’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** inst
** byte-compile and prepare package for lazy loading
Error in loadNamespace(j <- i[[1L]], c(lib.loc, .libPaths()), versionCheck = vI[[j]]) : 
  namespace ‘Matrix’ 1.5-4.1 is already loaded, but >= 1.6.0 is required
Calls: <Anonymous> ... namespaceImportFrom -> asNamespace -> loadNamespace
Execution halted
ERROR: lazy loading failed for package ‘iNZightPlots’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/iNZightPlots/old/iNZightPlots.Rcheck/iNZightPlots’


```
# linelistBayes

<details>

* Version: 1.0
* GitHub: NA
* Source code: https://github.com/cran/linelistBayes
* Date/Publication: 2024-05-03 13:00:10 UTC
* Number of recursive dependencies: 57

Run `revdepcheck::revdep_details(, "linelistBayes")` for more info

</details>

## In both

*   checking whether package ‘linelistBayes’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/linelistBayes/new/linelistBayes.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘linelistBayes’ ...
** package ‘linelistBayes’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using SDK: ‘MacOSX12.3.sdk’
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/linelistBayes/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/linelistBayes/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/linelistBayes/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/linelistBayes/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c backnow_cm.cpp -o backnow_cm.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/linelistBayes/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/linelistBayes/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c dnb.cpp -o dnb.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/linelistBayes/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/linelistBayes/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c dummy.cpp -o dummy.o
...
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/linelistBayes/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/linelistBayes/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c prop.cpp -o prop.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/linelistBayes/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/linelistBayes/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c rnb.cpp -o rnb.o
clang++ -arch arm64 -std=gnu++17 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/opt/R/arm64/lib -o linelistBayes.so RcppExports.o backnow_cm.o dnb.o dummy.o findmiss.o get_mu_vec.o getr.o lambda.o loglikNB.o pnb.o prop.o rnb.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0 -L/opt/gfortran/lib -lgfortran -lemutls_w -lquadmath -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0'
ld: warning: directory not found for option '-L/opt/gfortran/lib'
ld: library not found for -lgfortran
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [linelistBayes.so] Error 1
ERROR: compilation failed for package ‘linelistBayes’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/linelistBayes/new/linelistBayes.Rcheck/linelistBayes’


```
### CRAN

```
* installing *source* package ‘linelistBayes’ ...
** package ‘linelistBayes’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using SDK: ‘MacOSX12.3.sdk’
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/linelistBayes/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/linelistBayes/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/linelistBayes/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/linelistBayes/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c backnow_cm.cpp -o backnow_cm.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/linelistBayes/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/linelistBayes/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c dnb.cpp -o dnb.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/linelistBayes/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/linelistBayes/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c dummy.cpp -o dummy.o
...
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/linelistBayes/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/linelistBayes/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c prop.cpp -o prop.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/linelistBayes/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/linelistBayes/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c rnb.cpp -o rnb.o
clang++ -arch arm64 -std=gnu++17 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/opt/R/arm64/lib -o linelistBayes.so RcppExports.o backnow_cm.o dnb.o dummy.o findmiss.o get_mu_vec.o getr.o lambda.o loglikNB.o pnb.o prop.o rnb.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0 -L/opt/gfortran/lib -lgfortran -lemutls_w -lquadmath -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0'
ld: warning: directory not found for option '-L/opt/gfortran/lib'
ld: library not found for -lgfortran
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [linelistBayes.so] Error 1
ERROR: compilation failed for package ‘linelistBayes’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/linelistBayes/old/linelistBayes.Rcheck/linelistBayes’


```
# MazamaCoreUtils

<details>

* Version: 
* GitHub: https://github.com/tidyverse/lubridate
* Source code: NA
* Number of recursive dependencies: 0

</details>

## Error before installation

### Devel

```






```
### CRAN

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/MazamaCoreUtils/old/MazamaCoreUtils.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘MazamaCoreUtils/DESCRIPTION’ ... OK
...
  ‘date-parsing.Rmd’ using ‘UTF-8’... OK
  ‘error-handling.Rmd’ using ‘UTF-8’... OK
  ‘logging.Rmd’ using ‘UTF-8’... OK
 OK
* checking re-building of vignette outputs ... SKIPPED
* DONE

Status: OK







```
# midasml

<details>

* Version: 0.1.10
* GitHub: https://github.com/jstriaukas/midasml
* Source code: https://github.com/cran/midasml
* Date/Publication: 2022-04-29 07:00:02 UTC
* Number of recursive dependencies: 15

Run `revdepcheck::revdep_details(, "midasml")` for more info

</details>

## In both

*   checking whether package ‘midasml’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/midasml/new/midasml.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘midasml’ ...
** package ‘midasml’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
sh: /opt/gfortran/bin/gfortran: No such file or directory
using SDK: ‘MacOSX12.3.sdk’
/opt/gfortran/bin/gfortran -arch arm64  -fPIC  -Wall -g -O2  -c  auxiliary.f90 -o auxiliary.o
make: /opt/gfortran/bin/gfortran: No such file or directory
make: *** [auxiliary.o] Error 1
ERROR: compilation failed for package ‘midasml’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/midasml/new/midasml.Rcheck/midasml’


```
### CRAN

```
* installing *source* package ‘midasml’ ...
** package ‘midasml’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
sh: /opt/gfortran/bin/gfortran: No such file or directory
using SDK: ‘MacOSX12.3.sdk’
/opt/gfortran/bin/gfortran -arch arm64  -fPIC  -Wall -g -O2  -c  auxiliary.f90 -o auxiliary.o
make: /opt/gfortran/bin/gfortran: No such file or directory
make: *** [auxiliary.o] Error 1
ERROR: compilation failed for package ‘midasml’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/midasml/old/midasml.Rcheck/midasml’


```
# midasr

<details>

* Version: 0.8
* GitHub: https://github.com/mpiktas/midasr
* Source code: https://github.com/cran/midasr
* Date/Publication: 2021-02-23 09:40:05 UTC
* Number of recursive dependencies: 80

Run `revdepcheck::revdep_details(, "midasr")` for more info

</details>

## In both

*   checking whether package ‘midasr’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/midasr/new/midasr.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘midasr’ ...
** package ‘midasr’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** data
** demo
** inst
** byte-compile and prepare package for lazy loading
Error: package or namespace load failed for ‘quantreg’ in loadNamespace(j <- i[[1L]], c(lib.loc, .libPaths()), versionCheck = vI[[j]]):
 namespace ‘Matrix’ 1.5-4.1 is already loaded, but >= 1.6.0 is required
In addition: Warning messages:
1: package ‘sandwich’ was built under R version 4.3.3 
2: package ‘quantreg’ was built under R version 4.3.3 
3: package ‘SparseM’ was built under R version 4.3.3 
Execution halted
ERROR: lazy loading failed for package ‘midasr’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/midasr/new/midasr.Rcheck/midasr’


```
### CRAN

```
* installing *source* package ‘midasr’ ...
** package ‘midasr’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** data
** demo
** inst
** byte-compile and prepare package for lazy loading
Error: package or namespace load failed for ‘quantreg’ in loadNamespace(j <- i[[1L]], c(lib.loc, .libPaths()), versionCheck = vI[[j]]):
 namespace ‘Matrix’ 1.5-4.1 is already loaded, but >= 1.6.0 is required
In addition: Warning messages:
1: package ‘sandwich’ was built under R version 4.3.3 
2: package ‘quantreg’ was built under R version 4.3.3 
3: package ‘SparseM’ was built under R version 4.3.3 
Execution halted
ERROR: lazy loading failed for package ‘midasr’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/midasr/old/midasr.Rcheck/midasr’


```
# MixviR

<details>

* Version: 3.5.0
* GitHub: https://github.com/mikesovic/MixviR
* Source code: https://github.com/cran/MixviR
* Date/Publication: 2022-10-22 22:17:49 UTC
* Number of recursive dependencies: 105

Run `revdepcheck::revdep_details(, "MixviR")` for more info

</details>

## Error before installation

### Devel

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/MixviR/new/MixviR.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘MixviR/DESCRIPTION’ ... OK
...
* checking package vignettes in ‘inst/doc’ ... OK
* checking running R code from vignettes ...
  ‘vignette.Rmd’ using ‘UTF-8’... OK
 OK
* checking re-building of vignette outputs ... SKIPPED
* DONE

Status: OK







```
### CRAN

```






```
# momentuHMM

<details>

* Version: 1.5.5
* GitHub: https://github.com/bmcclintock/momentuHMM
* Source code: https://github.com/cran/momentuHMM
* Date/Publication: 2022-10-18 20:52:35 UTC
* Number of recursive dependencies: 149

Run `revdepcheck::revdep_details(, "momentuHMM")` for more info

</details>

## In both

*   checking whether package ‘momentuHMM’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/momentuHMM/new/momentuHMM.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘momentuHMM’ ...
** package ‘momentuHMM’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using C++ compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using SDK: ‘MacOSX12.3.sdk’
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/momentuHMM/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/momentuHMM/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/momentuHMM/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/momentuHMM/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c XBloop.cpp -o XBloop.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/momentuHMM/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/momentuHMM/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c getDM.cpp -o getDM.o
...
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/momentuHMM/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/momentuHMM/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c nLogLike.cpp -o nLogLike.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/momentuHMM/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/momentuHMM/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c trMatrix.cpp -o trMatrix.o
clang++ -arch arm64 -std=gnu++17 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/opt/R/arm64/lib -o momentuHMM.so RcppExports.o XBloop.o getDM.o momentuHMM_init.o nLogLike.o trMatrix.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0 -L/opt/gfortran/lib -lgfortran -lemutls_w -lquadmath -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0'
ld: warning: directory not found for option '-L/opt/gfortran/lib'
ld: library not found for -lgfortran
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [momentuHMM.so] Error 1
ERROR: compilation failed for package ‘momentuHMM’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/momentuHMM/new/momentuHMM.Rcheck/momentuHMM’


```
### CRAN

```
* installing *source* package ‘momentuHMM’ ...
** package ‘momentuHMM’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using C++ compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using SDK: ‘MacOSX12.3.sdk’
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/momentuHMM/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/momentuHMM/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/momentuHMM/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/momentuHMM/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c XBloop.cpp -o XBloop.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/momentuHMM/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/momentuHMM/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c getDM.cpp -o getDM.o
...
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/momentuHMM/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/momentuHMM/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c nLogLike.cpp -o nLogLike.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/momentuHMM/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/momentuHMM/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c trMatrix.cpp -o trMatrix.o
clang++ -arch arm64 -std=gnu++17 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/opt/R/arm64/lib -o momentuHMM.so RcppExports.o XBloop.o getDM.o momentuHMM_init.o nLogLike.o trMatrix.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0 -L/opt/gfortran/lib -lgfortran -lemutls_w -lquadmath -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0'
ld: warning: directory not found for option '-L/opt/gfortran/lib'
ld: library not found for -lgfortran
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [momentuHMM.so] Error 1
ERROR: compilation failed for package ‘momentuHMM’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/momentuHMM/old/momentuHMM.Rcheck/momentuHMM’


```
# moodleR

<details>

* Version: 
* GitHub: https://github.com/tidyverse/lubridate
* Source code: NA
* Number of recursive dependencies: 0

</details>

## Error before installation

### Devel

```






```
### CRAN

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/moodleR/old/moodleR.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘moodleR/DESCRIPTION’ ... OK
...
* checking package vignettes in ‘inst/doc’ ... OK
* checking running R code from vignettes ...
  ‘setup.Rmd’ using ‘UTF-8’... OK
 OK
* checking re-building of vignette outputs ... SKIPPED
* DONE

Status: OK







```
# mvgam

<details>

* Version: 1.1.3
* GitHub: https://github.com/nicholasjclark/mvgam
* Source code: https://github.com/cran/mvgam
* Date/Publication: 2024-09-04 03:40:02 UTC
* Number of recursive dependencies: 147

Run `revdepcheck::revdep_details(, "mvgam")` for more info

</details>

## In both

*   R CMD check timed out
    

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘cmdstanr’
    
    Packages which this enhances but not available for checking:
      'gratia', 'tidyr'
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  5.0Mb
      sub-directories of 1Mb or more:
        doc   2.0Mb
        R     1.9Mb
    ```

*   checking Rd cross-references ... NOTE
    ```
    Packages unavailable to check Rd xrefs: ‘cmdstanr’, ‘patchwork’
    ```

# oce

<details>

* Version: 1.8-3
* GitHub: https://github.com/dankelley/oce
* Source code: https://github.com/cran/oce
* Date/Publication: 2024-08-17 10:20:04 UTC
* Number of recursive dependencies: 108

Run `revdepcheck::revdep_details(, "oce")` for more info

</details>

## In both

*   checking whether package ‘oce’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/oce/new/oce.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘oce’ ...
** package ‘oce’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
sh: /opt/gfortran/bin/gfortran: No such file or directory
using C++ compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using SDK: ‘MacOSX12.3.sdk’
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DSTRICT_R_HEADERS -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/oce/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DSTRICT_R_HEADERS -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/oce/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c ad2cp_ahrs.cpp -o ad2cp_ahrs.o
...
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DSTRICT_R_HEADERS -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/oce/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c fillgap2d.cpp -o fillgap2d.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DSTRICT_R_HEADERS -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/oce/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c gappy_index.cpp -o gappy_index.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DSTRICT_R_HEADERS -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/oce/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c geod.cpp -o geod.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DSTRICT_R_HEADERS -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/oce/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c get_bit.cpp -o get_bit.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DSTRICT_R_HEADERS -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/oce/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c gradient.cpp -o gradient.o
/opt/gfortran/bin/gfortran -arch arm64  -fPIC  -Wall -g -O2  -c igrf12.f -o igrf12.o
make: /opt/gfortran/bin/gfortran: No such file or directory
make: *** [igrf12.o] Error 1
ERROR: compilation failed for package ‘oce’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/oce/new/oce.Rcheck/oce’


```
### CRAN

```
* installing *source* package ‘oce’ ...
** package ‘oce’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
sh: /opt/gfortran/bin/gfortran: No such file or directory
using C++ compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using SDK: ‘MacOSX12.3.sdk’
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DSTRICT_R_HEADERS -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/oce/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DSTRICT_R_HEADERS -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/oce/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c ad2cp_ahrs.cpp -o ad2cp_ahrs.o
...
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DSTRICT_R_HEADERS -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/oce/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c fillgap2d.cpp -o fillgap2d.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DSTRICT_R_HEADERS -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/oce/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c gappy_index.cpp -o gappy_index.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DSTRICT_R_HEADERS -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/oce/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c geod.cpp -o geod.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DSTRICT_R_HEADERS -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/oce/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c get_bit.cpp -o get_bit.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -DSTRICT_R_HEADERS -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/oce/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c gradient.cpp -o gradient.o
/opt/gfortran/bin/gfortran -arch arm64  -fPIC  -Wall -g -O2  -c igrf12.f -o igrf12.o
make: /opt/gfortran/bin/gfortran: No such file or directory
make: *** [igrf12.o] Error 1
ERROR: compilation failed for package ‘oce’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/oce/old/oce.Rcheck/oce’


```
# openair

<details>

* Version: 2.18-2
* GitHub: https://github.com/davidcarslaw/openair
* Source code: https://github.com/cran/openair
* Date/Publication: 2024-03-11 16:30:02 UTC
* Number of recursive dependencies: 66

Run `revdepcheck::revdep_details(, "openair")` for more info

</details>

## In both

*   checking whether package ‘openair’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/openair/new/openair.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘openair’ ...
** package ‘openair’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using C++ compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using SDK: ‘MacOSX12.3.sdk’
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/openair/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c cluster.cpp -o cluster.o
clang -arch arm64 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/openair/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c init.c -o init.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/openair/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c rolling.cpp -o rolling.o
clang++ -arch arm64 -std=gnu++17 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/opt/R/arm64/lib -o openair.so cluster.o init.o rolling.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0 -L/opt/gfortran/lib -lgfortran -lemutls_w -lquadmath -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0'
ld: warning: directory not found for option '-L/opt/gfortran/lib'
ld: library not found for -lgfortran
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [openair.so] Error 1
ERROR: compilation failed for package ‘openair’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/openair/new/openair.Rcheck/openair’


```
### CRAN

```
* installing *source* package ‘openair’ ...
** package ‘openair’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using C++ compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using SDK: ‘MacOSX12.3.sdk’
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/openair/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c cluster.cpp -o cluster.o
clang -arch arm64 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/openair/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c init.c -o init.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/openair/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c rolling.cpp -o rolling.o
clang++ -arch arm64 -std=gnu++17 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/opt/R/arm64/lib -o openair.so cluster.o init.o rolling.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0 -L/opt/gfortran/lib -lgfortran -lemutls_w -lquadmath -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0'
ld: warning: directory not found for option '-L/opt/gfortran/lib'
ld: library not found for -lgfortran
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [openair.so] Error 1
ERROR: compilation failed for package ‘openair’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/openair/old/openair.Rcheck/openair’


```
# PAMmisc

<details>

* Version: 1.12.1
* GitHub: NA
* Source code: https://github.com/cran/PAMmisc
* Date/Publication: 2024-06-10 21:20:01 UTC
* Number of recursive dependencies: 88

Run `revdepcheck::revdep_details(, "PAMmisc")` for more info

</details>

## In both

*   checking whether package ‘PAMmisc’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/PAMmisc/new/PAMmisc.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘PAMmisc’ ...
** package ‘PAMmisc’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
tcltk DLL is linked to '/opt/X11/lib/libX11.6.dylib'
Error: .onLoad failed in loadNamespace() for 'tcltk', details:
  call: fun(libname, pkgname)
  error: X11 library is missing: install XQuartz from www.xquartz.org
Execution halted
ERROR: lazy loading failed for package ‘PAMmisc’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/PAMmisc/new/PAMmisc.Rcheck/PAMmisc’


```
### CRAN

```
* installing *source* package ‘PAMmisc’ ...
** package ‘PAMmisc’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
tcltk DLL is linked to '/opt/X11/lib/libX11.6.dylib'
Error: .onLoad failed in loadNamespace() for 'tcltk', details:
  call: fun(libname, pkgname)
  error: X11 library is missing: install XQuartz from www.xquartz.org
Execution halted
ERROR: lazy loading failed for package ‘PAMmisc’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/PAMmisc/old/PAMmisc.Rcheck/PAMmisc’


```
# PAMpal

<details>

* Version: 1.2.1
* GitHub: NA
* Source code: https://github.com/cran/PAMpal
* Date/Publication: 2024-07-11 22:50:02 UTC
* Number of recursive dependencies: 117

Run `revdepcheck::revdep_details(, "PAMpal")` for more info

</details>

## In both

*   checking whether package ‘PAMpal’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/PAMpal/new/PAMpal.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘PAMpal’ ...
** package ‘PAMpal’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
tcltk DLL is linked to '/opt/X11/lib/libX11.6.dylib'
Error: .onLoad failed in loadNamespace() for 'tcltk', details:
  call: fun(libname, pkgname)
  error: X11 library is missing: install XQuartz from www.xquartz.org
Execution halted
ERROR: lazy loading failed for package ‘PAMpal’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/PAMpal/new/PAMpal.Rcheck/PAMpal’


```
### CRAN

```
* installing *source* package ‘PAMpal’ ...
** package ‘PAMpal’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
tcltk DLL is linked to '/opt/X11/lib/libX11.6.dylib'
Error: .onLoad failed in loadNamespace() for 'tcltk', details:
  call: fun(libname, pkgname)
  error: X11 library is missing: install XQuartz from www.xquartz.org
Execution halted
ERROR: lazy loading failed for package ‘PAMpal’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/PAMpal/old/PAMpal.Rcheck/PAMpal’


```
# PAMscapes

<details>

* Version: 0.7.0
* GitHub: NA
* Source code: https://github.com/cran/PAMscapes
* Date/Publication: 2024-09-22 17:20:02 UTC
* Number of recursive dependencies: 115

Run `revdepcheck::revdep_details(, "PAMscapes")` for more info

</details>

## In both

*   checking whether package ‘PAMscapes’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/PAMscapes/new/PAMscapes.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘PAMscapes’ ...
** package ‘PAMscapes’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** inst
** byte-compile and prepare package for lazy loading
tcltk DLL is linked to '/opt/X11/lib/libX11.6.dylib'
Error: .onLoad failed in loadNamespace() for 'tcltk', details:
  call: fun(libname, pkgname)
  error: X11 library is missing: install XQuartz from www.xquartz.org
Execution halted
ERROR: lazy loading failed for package ‘PAMscapes’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/PAMscapes/new/PAMscapes.Rcheck/PAMscapes’


```
### CRAN

```
* installing *source* package ‘PAMscapes’ ...
** package ‘PAMscapes’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** inst
** byte-compile and prepare package for lazy loading
tcltk DLL is linked to '/opt/X11/lib/libX11.6.dylib'
Error: .onLoad failed in loadNamespace() for 'tcltk', details:
  call: fun(libname, pkgname)
  error: X11 library is missing: install XQuartz from www.xquartz.org
Execution halted
ERROR: lazy loading failed for package ‘PAMscapes’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/PAMscapes/old/PAMscapes.Rcheck/PAMscapes’


```
# phenofit

<details>

* Version: 0.3.9
* GitHub: https://github.com/eco-hydro/phenofit
* Source code: https://github.com/cran/phenofit
* Date/Publication: 2024-01-23 06:50:02 UTC
* Number of recursive dependencies: 82

Run `revdepcheck::revdep_details(, "phenofit")` for more info

</details>

## In both

*   checking whether package ‘phenofit’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/phenofit/new/phenofit.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘phenofit’ ...
** package ‘phenofit’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using C++ compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using SDK: ‘MacOSX12.3.sdk’
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/phenofit/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/phenofit/RcppArmadillo/include' -I/opt/R/arm64/include     -fPIC  -falign-functions=64 -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/phenofit/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/phenofit/RcppArmadillo/include' -I/opt/R/arm64/include     -fPIC  -falign-functions=64 -Wall -g -O2  -c doubleLogistics.cpp -o doubleLogistics.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/phenofit/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/phenofit/RcppArmadillo/include' -I/opt/R/arm64/include     -fPIC  -falign-functions=64 -Wall -g -O2  -c f_goal.cpp -o f_goal.o
...
clang -arch arm64 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/phenofit/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/phenofit/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c smooth_whit.c -o smooth_whit.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/phenofit/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/phenofit/RcppArmadillo/include' -I/opt/R/arm64/include     -fPIC  -falign-functions=64 -Wall -g -O2  -c wTSM.cpp -o wTSM.o
clang++ -arch arm64 -std=gnu++17 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/opt/R/arm64/lib -o phenofit.so RcppExports.o doubleLogistics.o f_goal.o register_routines.o season_filter.o smooth_wSG.o smooth_whit.o wTSM.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0 -L/opt/gfortran/lib -lgfortran -lemutls_w -lquadmath -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0'
ld: warning: directory not found for option '-L/opt/gfortran/lib'
ld: library not found for -lgfortran
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [phenofit.so] Error 1
ERROR: compilation failed for package ‘phenofit’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/phenofit/new/phenofit.Rcheck/phenofit’


```
### CRAN

```
* installing *source* package ‘phenofit’ ...
** package ‘phenofit’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using C++ compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using SDK: ‘MacOSX12.3.sdk’
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/phenofit/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/phenofit/RcppArmadillo/include' -I/opt/R/arm64/include     -fPIC  -falign-functions=64 -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/phenofit/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/phenofit/RcppArmadillo/include' -I/opt/R/arm64/include     -fPIC  -falign-functions=64 -Wall -g -O2  -c doubleLogistics.cpp -o doubleLogistics.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/phenofit/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/phenofit/RcppArmadillo/include' -I/opt/R/arm64/include     -fPIC  -falign-functions=64 -Wall -g -O2  -c f_goal.cpp -o f_goal.o
...
clang -arch arm64 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/phenofit/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/phenofit/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c smooth_whit.c -o smooth_whit.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/phenofit/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/phenofit/RcppArmadillo/include' -I/opt/R/arm64/include     -fPIC  -falign-functions=64 -Wall -g -O2  -c wTSM.cpp -o wTSM.o
clang++ -arch arm64 -std=gnu++17 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/opt/R/arm64/lib -o phenofit.so RcppExports.o doubleLogistics.o f_goal.o register_routines.o season_filter.o smooth_wSG.o smooth_whit.o wTSM.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0 -L/opt/gfortran/lib -lgfortran -lemutls_w -lquadmath -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0'
ld: warning: directory not found for option '-L/opt/gfortran/lib'
ld: library not found for -lgfortran
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [phenofit.so] Error 1
ERROR: compilation failed for package ‘phenofit’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/phenofit/old/phenofit.Rcheck/phenofit’


```
# popstudy

<details>

* Version: 1.0.1
* GitHub: NA
* Source code: https://github.com/cran/popstudy
* Date/Publication: 2023-10-17 23:50:02 UTC
* Number of recursive dependencies: 241

Run `revdepcheck::revdep_details(, "popstudy")` for more info

</details>

## In both

*   checking whether package ‘popstudy’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/popstudy/new/popstudy.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘popstudy’ ...
** package ‘popstudy’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
Error in loadNamespace(j <- i[[1L]], c(lib.loc, .libPaths()), versionCheck = vI[[j]]) : 
  namespace ‘Matrix’ 1.5-4.1 is already loaded, but >= 1.6.0 is required
Calls: <Anonymous> ... namespaceImportFrom -> asNamespace -> loadNamespace
Execution halted
ERROR: lazy loading failed for package ‘popstudy’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/popstudy/new/popstudy.Rcheck/popstudy’


```
### CRAN

```
* installing *source* package ‘popstudy’ ...
** package ‘popstudy’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
Error in loadNamespace(j <- i[[1L]], c(lib.loc, .libPaths()), versionCheck = vI[[j]]) : 
  namespace ‘Matrix’ 1.5-4.1 is already loaded, but >= 1.6.0 is required
Calls: <Anonymous> ... namespaceImportFrom -> asNamespace -> loadNamespace
Execution halted
ERROR: lazy loading failed for package ‘popstudy’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/popstudy/old/popstudy.Rcheck/popstudy’


```
# portalr

<details>

* Version: 
* GitHub: https://github.com/tidyverse/lubridate
* Source code: NA
* Number of recursive dependencies: 0

</details>

## Error before installation

### Devel

```






```
### CRAN

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/portalr/old/portalr.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘portalr/DESCRIPTION’ ... OK
...
* checking running R code from vignettes ...
  ‘portal_researcher_examples.Rmd’ using ‘UTF-8’... OK
  ‘rodent-abundance-demo.Rmd’ using ‘UTF-8’... OK
 OK
* checking re-building of vignette outputs ... SKIPPED
* DONE

Status: OK







```
# puls

<details>

* Version: 
* GitHub: https://github.com/tidyverse/lubridate
* Source code: NA
* Number of recursive dependencies: 0

</details>

## Error before installation

### Devel

```






```
### CRAN

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/puls/old/puls.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘puls/DESCRIPTION’ ... OK
...
* checking package vignettes in ‘inst/doc’ ... OK
* checking running R code from vignettes ...
  ‘puls.Rmd’ using ‘UTF-8’... OK
 OK
* checking re-building of vignette outputs ... SKIPPED
* DONE

Status: OK







```
# rcontroll

<details>

* Version: 
* GitHub: https://github.com/tidyverse/lubridate
* Source code: NA
* Number of recursive dependencies: 0

</details>

## Error before installation

### Devel

```






```
### CRAN

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/rcontroll/old/rcontroll.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘rcontroll/DESCRIPTION’ ... OK
...
Installation failed.
See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/rcontroll/old/rcontroll.Rcheck/00install.out’ for details.
* DONE

Status: 1 ERROR
See
  ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/rcontroll/old/rcontroll.Rcheck/00check.log’
for details.







```
# robservable

<details>

* Version: 0.2.2
* GitHub: https://github.com/juba/robservable
* Source code: https://github.com/cran/robservable
* Date/Publication: 2022-06-28 14:50:02 UTC
* Number of recursive dependencies: 57

Run `revdepcheck::revdep_details(, "robservable")` for more info

</details>

## Error before installation

### Devel

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/robservable/new/robservable.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘robservable/DESCRIPTION’ ... OK
...
* checking re-building of vignette outputs ... SKIPPED
* DONE

Status: 1 NOTE
See
  ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/robservable/new/robservable.Rcheck/00check.log’
for details.








```
### CRAN

```






```
# rtrend

<details>

* Version: 0.1.5
* GitHub: https://github.com/rpkgs/rtrend
* Source code: https://github.com/cran/rtrend
* Date/Publication: 2024-01-11 03:30:02 UTC
* Number of recursive dependencies: 60

Run `revdepcheck::revdep_details(, "rtrend")` for more info

</details>

## In both

*   checking whether package ‘rtrend’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/rtrend/new/rtrend.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘rtrend’ ...
** package ‘rtrend’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using SDK: ‘MacOSX12.3.sdk’
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/rtrend/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/rtrend/RcppArmadillo/include' -I/opt/R/arm64/include     -fPIC  -falign-functions=64 -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/rtrend/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/rtrend/RcppArmadillo/include' -I/opt/R/arm64/include     -fPIC  -falign-functions=64 -Wall -g -O2  -c mktrend.cpp -o mktrend.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/rtrend/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/rtrend/RcppArmadillo/include' -I/opt/R/arm64/include     -fPIC  -falign-functions=64 -Wall -g -O2  -c movmean.cpp -o movmean.o
clang++ -arch arm64 -std=gnu++17 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/opt/R/arm64/lib -o rtrend.so RcppExports.o mktrend.o movmean.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0 -L/opt/gfortran/lib -lgfortran -lemutls_w -lquadmath -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0'
ld: warning: directory not found for option '-L/opt/gfortran/lib'
ld: library not found for -lgfortran
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [rtrend.so] Error 1
ERROR: compilation failed for package ‘rtrend’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/rtrend/new/rtrend.Rcheck/rtrend’


```
### CRAN

```
* installing *source* package ‘rtrend’ ...
** package ‘rtrend’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using SDK: ‘MacOSX12.3.sdk’
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/rtrend/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/rtrend/RcppArmadillo/include' -I/opt/R/arm64/include     -fPIC  -falign-functions=64 -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/rtrend/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/rtrend/RcppArmadillo/include' -I/opt/R/arm64/include     -fPIC  -falign-functions=64 -Wall -g -O2  -c mktrend.cpp -o mktrend.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/rtrend/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/rtrend/RcppArmadillo/include' -I/opt/R/arm64/include     -fPIC  -falign-functions=64 -Wall -g -O2  -c movmean.cpp -o movmean.o
clang++ -arch arm64 -std=gnu++17 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/opt/R/arm64/lib -o rtrend.so RcppExports.o mktrend.o movmean.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0 -L/opt/gfortran/lib -lgfortran -lemutls_w -lquadmath -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0'
ld: warning: directory not found for option '-L/opt/gfortran/lib'
ld: library not found for -lgfortran
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [rtrend.so] Error 1
ERROR: compilation failed for package ‘rtrend’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/rtrend/old/rtrend.Rcheck/rtrend’


```
# RtsEva

<details>

* Version: 
* GitHub: https://github.com/tidyverse/lubridate
* Source code: NA
* Number of recursive dependencies: 0

</details>

## Error before installation

### Devel

```






```
### CRAN

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/RtsEva/old/RtsEva.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘RtsEva/DESCRIPTION’ ... OK
...
* checking package vignettes in ‘inst/doc’ ... OK
* checking running R code from vignettes ...
  ‘general-demo.Rmd’ using ‘UTF-8’... OK
 OK
* checking re-building of vignette outputs ... SKIPPED
* DONE

Status: OK







```
# simET

<details>

* Version: 
* GitHub: https://github.com/tidyverse/lubridate
* Source code: NA
* Number of recursive dependencies: 0

</details>

## Error before installation

### Devel

```






```
### CRAN

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/simET/old/simET.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘simET/DESCRIPTION’ ... OK
...
* checking contents of ‘data’ directory ... OK
* checking data for non-ASCII characters ... OK
* checking LazyData ... OK
* checking data for ASCII and uncompressed saves ... OK
* checking examples ... OK
* DONE

Status: OK







```
# sits

<details>

* Version: 1.5.1
* GitHub: https://github.com/e-sensing/sits
* Source code: https://github.com/cran/sits
* Date/Publication: 2024-08-19 21:50:01 UTC
* Number of recursive dependencies: 225

Run `revdepcheck::revdep_details(, "sits")` for more info

</details>

## In both

*   checking whether package ‘sits’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/sits/new/sits.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘sits’ ...
** package ‘sits’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using SDK: ‘MacOSX12.3.sdk’
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/sits/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/sits/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/sits/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/sits/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c combine_data.cpp -o combine_data.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/sits/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/sits/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c detect_change_distances.cpp -o detect_change_distances.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/sits/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/sits/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c dtw.cpp -o dtw.o
...
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/sits/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/sits/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c softmax.cpp -o softmax.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/sits/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/sits/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c uncertainty.cpp -o uncertainty.o
clang++ -arch arm64 -std=gnu++17 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/opt/R/arm64/lib -o sits.so RcppExports.o combine_data.o detect_change_distances.o dtw.o kernel.o kohonen_distances.o kohonen_som.o label_class.o linear_interp.o nnls_solver.o normalize_data.o normalize_data_0.o reduce_fns.o sampling_window.o smooth.o smooth_bayes.o smooth_sgp.o smooth_whit.o softmax.o uncertainty.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0 -L/opt/gfortran/lib -lgfortran -lemutls_w -lquadmath -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0'
ld: warning: directory not found for option '-L/opt/gfortran/lib'
ld: library not found for -lgfortran
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [sits.so] Error 1
ERROR: compilation failed for package ‘sits’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/sits/new/sits.Rcheck/sits’


```
### CRAN

```
* installing *source* package ‘sits’ ...
** package ‘sits’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using SDK: ‘MacOSX12.3.sdk’
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/sits/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/sits/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/sits/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/sits/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c combine_data.cpp -o combine_data.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/sits/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/sits/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c detect_change_distances.cpp -o detect_change_distances.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/sits/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/sits/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c dtw.cpp -o dtw.o
...
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/sits/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/sits/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c softmax.cpp -o softmax.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/sits/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/sits/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c uncertainty.cpp -o uncertainty.o
clang++ -arch arm64 -std=gnu++17 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/opt/R/arm64/lib -o sits.so RcppExports.o combine_data.o detect_change_distances.o dtw.o kernel.o kohonen_distances.o kohonen_som.o label_class.o linear_interp.o nnls_solver.o normalize_data.o normalize_data_0.o reduce_fns.o sampling_window.o smooth.o smooth_bayes.o smooth_sgp.o smooth_whit.o softmax.o uncertainty.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0 -L/opt/gfortran/lib -lgfortran -lemutls_w -lquadmath -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0'
ld: warning: directory not found for option '-L/opt/gfortran/lib'
ld: library not found for -lgfortran
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [sits.so] Error 1
ERROR: compilation failed for package ‘sits’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/sits/old/sits.Rcheck/sits’


```
# SPARSEMODr

<details>

* Version: 1.2.0
* GitHub: https://github.com/NAU-CCL/SPARSEMODr
* Source code: https://github.com/cran/SPARSEMODr
* Date/Publication: 2022-07-19 20:50:02 UTC
* Number of recursive dependencies: 126

Run `revdepcheck::revdep_details(, "SPARSEMODr")` for more info

</details>

## In both

*   checking whether package ‘SPARSEMODr’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/SPARSEMODr/new/SPARSEMODr.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘SPARSEMODr’ ...
** package ‘SPARSEMODr’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using SDK: ‘MacOSX12.3.sdk’
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/SPARSEMODr/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c Nrutil.cpp -o Nrutil.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/SPARSEMODr/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/SPARSEMODr/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c covid19_model.cpp -o covid19_model.o
covid19_model.cpp:8:10: fatal error: 'gsl/gsl_rng.h' file not found
#include <gsl/gsl_rng.h>
         ^~~~~~~~~~~~~~~
1 error generated.
make: *** [covid19_model.o] Error 1
ERROR: compilation failed for package ‘SPARSEMODr’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/SPARSEMODr/new/SPARSEMODr.Rcheck/SPARSEMODr’


```
### CRAN

```
* installing *source* package ‘SPARSEMODr’ ...
** package ‘SPARSEMODr’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using SDK: ‘MacOSX12.3.sdk’
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/SPARSEMODr/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c Nrutil.cpp -o Nrutil.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/SPARSEMODr/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/SPARSEMODr/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c covid19_model.cpp -o covid19_model.o
covid19_model.cpp:8:10: fatal error: 'gsl/gsl_rng.h' file not found
#include <gsl/gsl_rng.h>
         ^~~~~~~~~~~~~~~
1 error generated.
make: *** [covid19_model.o] Error 1
ERROR: compilation failed for package ‘SPARSEMODr’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/SPARSEMODr/old/SPARSEMODr.Rcheck/SPARSEMODr’


```
# stppSim

<details>

* Version: 1.3.4
* GitHub: https://github.com/Manalytics/stppSim
* Source code: https://github.com/cran/stppSim
* Date/Publication: 2024-07-24 13:30:02 UTC
* Number of recursive dependencies: 131

Run `revdepcheck::revdep_details(, "stppSim")` for more info

</details>

## In both

*   checking whether package ‘stppSim’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/stppSim/new/stppSim.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘stppSim’ ...
** package ‘stppSim’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
tcltk DLL is linked to '/opt/X11/lib/libX11.6.dylib'
Error: .onLoad failed in loadNamespace() for 'tcltk', details:
  call: fun(libname, pkgname)
  error: X11 library is missing: install XQuartz from www.xquartz.org
Execution halted
ERROR: lazy loading failed for package ‘stppSim’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/stppSim/new/stppSim.Rcheck/stppSim’


```
### CRAN

```
* installing *source* package ‘stppSim’ ...
** package ‘stppSim’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
tcltk DLL is linked to '/opt/X11/lib/libX11.6.dylib'
Error: .onLoad failed in loadNamespace() for 'tcltk', details:
  call: fun(libname, pkgname)
  error: X11 library is missing: install XQuartz from www.xquartz.org
Execution halted
ERROR: lazy loading failed for package ‘stppSim’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/stppSim/old/stppSim.Rcheck/stppSim’


```
# summarytools

<details>

* Version: 1.0.1
* GitHub: https://github.com/dcomtois/summarytools
* Source code: https://github.com/cran/summarytools
* Date/Publication: 2022-05-20 07:30:05 UTC
* Number of recursive dependencies: 74

Run `revdepcheck::revdep_details(, "summarytools")` for more info

</details>

## In both

*   checking whether package ‘summarytools’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/summarytools/new/summarytools.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘summarytools’ ...
** package ‘summarytools’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
tcltk DLL is linked to '/opt/X11/lib/libX11.6.dylib'
Error: .onLoad failed in loadNamespace() for 'tcltk', details:
  call: fun(libname, pkgname)
  error: X11 library is missing: install XQuartz from www.xquartz.org
Execution halted
ERROR: lazy loading failed for package ‘summarytools’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/summarytools/new/summarytools.Rcheck/summarytools’


```
### CRAN

```
* installing *source* package ‘summarytools’ ...
** package ‘summarytools’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
tcltk DLL is linked to '/opt/X11/lib/libX11.6.dylib'
Error: .onLoad failed in loadNamespace() for 'tcltk', details:
  call: fun(libname, pkgname)
  error: X11 library is missing: install XQuartz from www.xquartz.org
Execution halted
ERROR: lazy loading failed for package ‘summarytools’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/summarytools/old/summarytools.Rcheck/summarytools’


```
# suncalc

<details>

* Version: 0.5.1
* GitHub: https://github.com/datastorm-open/suncalc
* Source code: https://github.com/cran/suncalc
* Date/Publication: 2022-09-29 16:20:14 UTC
* Number of recursive dependencies: 6

Run `revdepcheck::revdep_details(, "suncalc")` for more info

</details>

## Error before installation

### Devel

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/suncalc/new/suncalc.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘suncalc/DESCRIPTION’ ... OK
...
* checking for code/documentation mismatches ... OK
* checking Rd \usage sections ... OK
* checking Rd contents ... OK
* checking for unstated dependencies in examples ... OK
* checking examples ... OK
* DONE

Status: OK







```
### CRAN

```






```
# topdowntimeratio

<details>

* Version: 0.1.0
* GitHub: NA
* Source code: https://github.com/cran/topdowntimeratio
* Date/Publication: 2022-09-22 08:50:02 UTC
* Number of recursive dependencies: 39

Run `revdepcheck::revdep_details(, "topdowntimeratio")` for more info

</details>

## Error before installation

### Devel

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/topdowntimeratio/new/topdowntimeratio.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘topdowntimeratio/DESCRIPTION’ ... OK
...
* checking for unstated dependencies in ‘tests’ ... OK
* checking tests ...
  Running ‘spelling.R’
  Running ‘testthat.R’
 OK
* DONE

Status: OK







```
### CRAN

```






```
# tsmarch

<details>

* Version: 1.0.0
* GitHub: https://github.com/tsmodels/tsmarch
* Source code: https://github.com/cran/tsmarch
* Date/Publication: 2024-11-18 13:30:02 UTC
* Number of recursive dependencies: 149

Run `revdepcheck::revdep_details(, "tsmarch")` for more info

</details>

## In both

*   checking whether package ‘tsmarch’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/tsmarch/new/tsmarch.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘tsmarch’ ...
** package ‘tsmarch’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using SDK: ‘MacOSX12.3.sdk’
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I../inst/include -DARMA_64BIT_WORD=1 -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppParallel/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppBessel/include' -I/opt/R/arm64/include   -DARMA_NO_DEBUG -DARMA_USE_BLAS -DARMA_DONT_USE_OPENMP -DARMA_USE_TBB_ALLOC -DARMA_WARN_LEVEL=1 -I../inst/include -fPIC  -falign-functions=64 -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I../inst/include -DARMA_64BIT_WORD=1 -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppParallel/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppBessel/include' -I/opt/R/arm64/include   -DARMA_NO_DEBUG -DARMA_USE_BLAS -DARMA_DONT_USE_OPENMP -DARMA_USE_TBB_ALLOC -DARMA_WARN_LEVEL=1 -I../inst/include -fPIC  -falign-functions=64 -Wall -g -O2  -c copula.cpp -o copula.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I../inst/include -DARMA_64BIT_WORD=1 -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppParallel/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppBessel/include' -I/opt/R/arm64/include   -DARMA_NO_DEBUG -DARMA_USE_BLAS -DARMA_DONT_USE_OPENMP -DARMA_USE_TBB_ALLOC -DARMA_WARN_LEVEL=1 -I../inst/include -fPIC  -falign-functions=64 -Wall -g -O2  -c corfun.cpp -o corfun.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I../inst/include -DARMA_64BIT_WORD=1 -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppParallel/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppBessel/include' -I/opt/R/arm64/include   -DARMA_NO_DEBUG -DARMA_USE_BLAS -DARMA_DONT_USE_OPENMP -DARMA_USE_TBB_ALLOC -DARMA_WARN_LEVEL=1 -I../inst/include -fPIC  -falign-functions=64 -Wall -g -O2  -c dcc.cpp -o dcc.o
...
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I../inst/include -DARMA_64BIT_WORD=1 -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppParallel/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppBessel/include' -I/opt/R/arm64/include   -DARMA_NO_DEBUG -DARMA_USE_BLAS -DARMA_DONT_USE_OPENMP -DARMA_USE_TBB_ALLOC -DARMA_WARN_LEVEL=1 -I../inst/include -fPIC  -falign-functions=64 -Wall -g -O2  -c nig.cpp -o nig.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I../inst/include -DARMA_64BIT_WORD=1 -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppParallel/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppBessel/include' -I/opt/R/arm64/include   -DARMA_NO_DEBUG -DARMA_USE_BLAS -DARMA_DONT_USE_OPENMP -DARMA_USE_TBB_ALLOC -DARMA_WARN_LEVEL=1 -I../inst/include -fPIC  -falign-functions=64 -Wall -g -O2  -c radical.cpp -o radical.o
clang++ -arch arm64 -std=gnu++17 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/opt/R/arm64/lib -o tsmarch.so RcppExports.o copula.o corfun.o dcc.o distributions.o gogarch.o helpers.o nig.o radical.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0 -L/opt/gfortran/lib -lgfortran -lemutls_w -lquadmath -L/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppParallel/lib -ltbb -ltbbmalloc -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0'
ld: warning: directory not found for option '-L/opt/gfortran/lib'
ld: library not found for -lgfortran
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [tsmarch.so] Error 1
ERROR: compilation failed for package ‘tsmarch’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/tsmarch/new/tsmarch.Rcheck/tsmarch’


```
### CRAN

```
* installing *source* package ‘tsmarch’ ...
** package ‘tsmarch’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using SDK: ‘MacOSX12.3.sdk’
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I../inst/include -DARMA_64BIT_WORD=1 -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppParallel/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppBessel/include' -I/opt/R/arm64/include   -DARMA_NO_DEBUG -DARMA_USE_BLAS -DARMA_DONT_USE_OPENMP -DARMA_USE_TBB_ALLOC -DARMA_WARN_LEVEL=1 -I../inst/include -fPIC  -falign-functions=64 -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I../inst/include -DARMA_64BIT_WORD=1 -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppParallel/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppBessel/include' -I/opt/R/arm64/include   -DARMA_NO_DEBUG -DARMA_USE_BLAS -DARMA_DONT_USE_OPENMP -DARMA_USE_TBB_ALLOC -DARMA_WARN_LEVEL=1 -I../inst/include -fPIC  -falign-functions=64 -Wall -g -O2  -c copula.cpp -o copula.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I../inst/include -DARMA_64BIT_WORD=1 -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppParallel/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppBessel/include' -I/opt/R/arm64/include   -DARMA_NO_DEBUG -DARMA_USE_BLAS -DARMA_DONT_USE_OPENMP -DARMA_USE_TBB_ALLOC -DARMA_WARN_LEVEL=1 -I../inst/include -fPIC  -falign-functions=64 -Wall -g -O2  -c corfun.cpp -o corfun.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I../inst/include -DARMA_64BIT_WORD=1 -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppParallel/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppBessel/include' -I/opt/R/arm64/include   -DARMA_NO_DEBUG -DARMA_USE_BLAS -DARMA_DONT_USE_OPENMP -DARMA_USE_TBB_ALLOC -DARMA_WARN_LEVEL=1 -I../inst/include -fPIC  -falign-functions=64 -Wall -g -O2  -c dcc.cpp -o dcc.o
...
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I../inst/include -DARMA_64BIT_WORD=1 -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppParallel/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppBessel/include' -I/opt/R/arm64/include   -DARMA_NO_DEBUG -DARMA_USE_BLAS -DARMA_DONT_USE_OPENMP -DARMA_USE_TBB_ALLOC -DARMA_WARN_LEVEL=1 -I../inst/include -fPIC  -falign-functions=64 -Wall -g -O2  -c nig.cpp -o nig.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I../inst/include -DARMA_64BIT_WORD=1 -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppParallel/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppBessel/include' -I/opt/R/arm64/include   -DARMA_NO_DEBUG -DARMA_USE_BLAS -DARMA_DONT_USE_OPENMP -DARMA_USE_TBB_ALLOC -DARMA_WARN_LEVEL=1 -I../inst/include -fPIC  -falign-functions=64 -Wall -g -O2  -c radical.cpp -o radical.o
clang++ -arch arm64 -std=gnu++17 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/opt/R/arm64/lib -o tsmarch.so RcppExports.o copula.o corfun.o dcc.o distributions.o gogarch.o helpers.o nig.o radical.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0 -L/opt/gfortran/lib -lgfortran -lemutls_w -lquadmath -L/Users/vitalie/dev/lubridate/revdep/library.noindex/tsmarch/RcppParallel/lib -ltbb -ltbbmalloc -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0'
ld: warning: directory not found for option '-L/opt/gfortran/lib'
ld: library not found for -lgfortran
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [tsmarch.so] Error 1
ERROR: compilation failed for package ‘tsmarch’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/tsmarch/old/tsmarch.Rcheck/tsmarch’


```
# VIC5

<details>

* Version: 0.2.6
* GitHub: https://github.com/rpkgs/VIC5
* Source code: https://github.com/cran/VIC5
* Date/Publication: 2023-02-17 08:40:02 UTC
* Number of recursive dependencies: 34

Run `revdepcheck::revdep_details(, "VIC5")` for more info

</details>

## In both

*   checking whether package ‘VIC5’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/VIC5/new/VIC5.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘VIC5’ ...
** package ‘VIC5’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using SDK: ‘MacOSX12.3.sdk’
clang -arch arm64 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I "./vic/vic_run/include" -I "./vic/drivers/shared_all/include" -I "." -DLOG_LVL=25 -D_DEFAULT_SOURCE -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/VIC5/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/VIC5/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c vic/vic_run/src/advected_sensible_heat.c -o vic/vic_run/src/advected_sensible_heat.o
clang -arch arm64 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I "./vic/vic_run/include" -I "./vic/drivers/shared_all/include" -I "." -DLOG_LVL=25 -D_DEFAULT_SOURCE -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/VIC5/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/VIC5/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c vic/vic_run/src/alloc_and_free.c -o vic/vic_run/src/alloc_and_free.o
clang -arch arm64 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I "./vic/vic_run/include" -I "./vic/drivers/shared_all/include" -I "." -DLOG_LVL=25 -D_DEFAULT_SOURCE -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/VIC5/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/VIC5/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c vic/vic_run/src/arno_evap.c -o vic/vic_run/src/arno_evap.o
clang -arch arm64 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I "./vic/vic_run/include" -I "./vic/drivers/shared_all/include" -I "." -DLOG_LVL=25 -D_DEFAULT_SOURCE -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/VIC5/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/VIC5/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c vic/vic_run/src/calc_atmos_energy_bal.c -o vic/vic_run/src/calc_atmos_energy_bal.o
...
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I "./vic/vic_run/include" -I "./vic/drivers/shared_all/include" -I "." -DLOG_LVL=25 -D_DEFAULT_SOURCE -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/VIC5/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/VIC5/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c vic_run_cells_all.cpp -o vic_run_cells_all.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I "./vic/vic_run/include" -I "./vic/drivers/shared_all/include" -I "." -DLOG_LVL=25 -D_DEFAULT_SOURCE -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/VIC5/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/VIC5/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c XAJ.cpp -o XAJ.o
clang++ -arch arm64 -std=gnu++17 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/opt/R/arm64/lib -o VIC5.so vic/vic_run/src/advected_sensible_heat.o vic/vic_run/src/alloc_and_free.o vic/vic_run/src/arno_evap.o vic/vic_run/src/calc_atmos_energy_bal.o vic/vic_run/src/calc_gridcell_avg_albedo.o vic/vic_run/src/calc_Nscale_factors.o vic/vic_run/src/calc_rainonly.o vic/vic_run/src/calc_snow_coverage.o vic/vic_run/src/calc_surf_energy_bal.o vic/vic_run/src/calc_veg_params.o vic/vic_run/src/CalcAerodynamic.o vic/vic_run/src/CalcBlowingSnow.o vic/vic_run/src/canopy_assimilation.o vic/vic_run/src/canopy_evap.o vic/vic_run/src/comparisons.o vic/vic_run/src/compute_coszen.o vic/vic_run/src/compute_derived_lake_dimensions.o vic/vic_run/src/compute_pot_evap.o vic/vic_run/src/compute_soil_resp.o vic/vic_run/src/compute_zwt.o vic/vic_run/src/correct_precip.o vic/vic_run/src/estimate_T1.o vic/vic_run/src/faparl.o vic/vic_run/src/frozen_soil.o vic/vic_run/src/func_atmos_energy_bal.o vic/vic_run/src/func_atmos_moist_bal.o vic/vic_run/src/func_canopy_energy_bal.o vic/vic_run/src/func_surf_energy_bal.o vic/vic_run/src/ice_melt.o vic/vic_run/src/IceEnergyBalance.o vic/vic_run/src/initialize_lake.o vic/vic_run/src/interpoloation.o vic/vic_run/src/lake_utils.o vic/vic_run/src/lakes.eb.o vic/vic_run/src/latent_heat_from_snow.o vic/vic_run/src/massrelease.o vic/vic_run/src/newt_raph_func_fast.o vic/vic_run/src/penman.o vic/vic_run/src/photosynth.o vic/vic_run/src/physics.o vic/vic_run/src/prepare_full_energy.o vic/vic_run/src/root_brent.o vic/vic_run/src/runoff.o vic/vic_run/src/snow_intercept.o vic/vic_run/src/snow_melt.o vic/vic_run/src/snow_utility.o vic/vic_run/src/SnowPackEnergyBalance.o vic/vic_run/src/soil_carbon_balance.o vic/vic_run/src/soil_conduction.o vic/vic_run/src/soil_thermal_eqn.o vic/vic_run/src/solve_snow.o vic/vic_run/src/StabilityCorrection.o vic/vic_run/src/surface_fluxes.o vic/vic_run/src/svp.o vic/vic_run/src/vic_run.o vic/vic_run/src/water_energy_balance.o vic/vic_run/src/water_under_ice.o vic/vic_run/src/write_layer.o vic/vic_run/src/write_vegvar.o vic/drivers/shared_all/src/agg_data.o vic/drivers/shared_all/src/alarms.o vic/drivers/shared_all/src/calc_root_fraction.o vic/drivers/shared_all/src/cmd_proc.o vic/drivers/shared_all/src/compress_files.o vic/drivers/shared_all/src/compute_derived_state_vars.o vic/drivers/shared_all/src/compute_lake_params.o vic/drivers/shared_all/src/compute_treeline.o vic/drivers/shared_all/src/forcing_utils.o vic/drivers/shared_all/src/free_all_vars.o vic/drivers/shared_all/src/free_vegcon.o vic/drivers/shared_all/src/generate_default_lake_state.o vic/drivers/shared_all/src/generate_default_state.o vic/drivers/shared_all/src/get_parameters.o vic/drivers/shared_all/src/history_metadata.o vic/drivers/shared_all/src/initialize_energy.o vic/drivers/shared_all/src/initialize_global.o vic/drivers/shared_all/src/initialize_options.o vic/drivers/shared_all/src/initialize_parameters.o vic/drivers/shared_all/src/initialize_snow.o vic/drivers/shared_all/src/initialize_soil.o vic/drivers/shared_all/src/initialize_veg.o vic/drivers/shared_all/src/input_tools.o vic/drivers/shared_all/src/make_all_vars.o vic/drivers/shared_all/src/make_cell_data.o vic/drivers/shared_all/src/make_dmy.o vic/drivers/shared_all/src/make_energy_bal.o vic/drivers/shared_all/src/make_snow_data.o vic/drivers/shared_all/src/make_veg_var.o vic/drivers/shared_all/src/open_file.o vic/drivers/shared_all/src/print_library_shared.o vic/drivers/shared_all/src/put_data.o vic/drivers/shared_all/src/set_output_defaults.o vic/drivers/shared_all/src/soil_moisture_from_water_table.o vic/drivers/shared_all/src/timing.o vic/drivers/shared_all/src/update_step_vars.o vic/drivers/shared_all/src/vic_history.o vic/drivers/shared_all/src/vic_log.o vic/drivers/shared_all/src/vic_time.o vic/drivers/shared_all/src/zero_output_list.o ./conv.o ./display_current_settings.o ./force.o ./get_options.o ./globals.o ./initiate.o ./make_output_info.o ./make_params.o ./RcppExports.o ./vic_run_cell.o ./vic_version.o vic_run_cells_all.o XAJ.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0 -L/opt/gfortran/lib -lgfortran -lemutls_w -lquadmath -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0'
ld: warning: directory not found for option '-L/opt/gfortran/lib'
ld: library not found for -lgfortran
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [VIC5.so] Error 1
ERROR: compilation failed for package ‘VIC5’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/VIC5/new/VIC5.Rcheck/VIC5’


```
### CRAN

```
* installing *source* package ‘VIC5’ ...
** package ‘VIC5’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using SDK: ‘MacOSX12.3.sdk’
clang -arch arm64 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I "./vic/vic_run/include" -I "./vic/drivers/shared_all/include" -I "." -DLOG_LVL=25 -D_DEFAULT_SOURCE -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/VIC5/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/VIC5/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c vic/vic_run/src/advected_sensible_heat.c -o vic/vic_run/src/advected_sensible_heat.o
clang -arch arm64 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I "./vic/vic_run/include" -I "./vic/drivers/shared_all/include" -I "." -DLOG_LVL=25 -D_DEFAULT_SOURCE -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/VIC5/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/VIC5/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c vic/vic_run/src/alloc_and_free.c -o vic/vic_run/src/alloc_and_free.o
clang -arch arm64 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I "./vic/vic_run/include" -I "./vic/drivers/shared_all/include" -I "." -DLOG_LVL=25 -D_DEFAULT_SOURCE -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/VIC5/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/VIC5/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c vic/vic_run/src/arno_evap.c -o vic/vic_run/src/arno_evap.o
clang -arch arm64 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I "./vic/vic_run/include" -I "./vic/drivers/shared_all/include" -I "." -DLOG_LVL=25 -D_DEFAULT_SOURCE -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/VIC5/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/VIC5/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c vic/vic_run/src/calc_atmos_energy_bal.c -o vic/vic_run/src/calc_atmos_energy_bal.o
...
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I "./vic/vic_run/include" -I "./vic/drivers/shared_all/include" -I "." -DLOG_LVL=25 -D_DEFAULT_SOURCE -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/VIC5/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/VIC5/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c vic_run_cells_all.cpp -o vic_run_cells_all.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I "./vic/vic_run/include" -I "./vic/drivers/shared_all/include" -I "." -DLOG_LVL=25 -D_DEFAULT_SOURCE -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/VIC5/RcppArmadillo/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/VIC5/Rcpp/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c XAJ.cpp -o XAJ.o
clang++ -arch arm64 -std=gnu++17 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/opt/R/arm64/lib -o VIC5.so vic/vic_run/src/advected_sensible_heat.o vic/vic_run/src/alloc_and_free.o vic/vic_run/src/arno_evap.o vic/vic_run/src/calc_atmos_energy_bal.o vic/vic_run/src/calc_gridcell_avg_albedo.o vic/vic_run/src/calc_Nscale_factors.o vic/vic_run/src/calc_rainonly.o vic/vic_run/src/calc_snow_coverage.o vic/vic_run/src/calc_surf_energy_bal.o vic/vic_run/src/calc_veg_params.o vic/vic_run/src/CalcAerodynamic.o vic/vic_run/src/CalcBlowingSnow.o vic/vic_run/src/canopy_assimilation.o vic/vic_run/src/canopy_evap.o vic/vic_run/src/comparisons.o vic/vic_run/src/compute_coszen.o vic/vic_run/src/compute_derived_lake_dimensions.o vic/vic_run/src/compute_pot_evap.o vic/vic_run/src/compute_soil_resp.o vic/vic_run/src/compute_zwt.o vic/vic_run/src/correct_precip.o vic/vic_run/src/estimate_T1.o vic/vic_run/src/faparl.o vic/vic_run/src/frozen_soil.o vic/vic_run/src/func_atmos_energy_bal.o vic/vic_run/src/func_atmos_moist_bal.o vic/vic_run/src/func_canopy_energy_bal.o vic/vic_run/src/func_surf_energy_bal.o vic/vic_run/src/ice_melt.o vic/vic_run/src/IceEnergyBalance.o vic/vic_run/src/initialize_lake.o vic/vic_run/src/interpoloation.o vic/vic_run/src/lake_utils.o vic/vic_run/src/lakes.eb.o vic/vic_run/src/latent_heat_from_snow.o vic/vic_run/src/massrelease.o vic/vic_run/src/newt_raph_func_fast.o vic/vic_run/src/penman.o vic/vic_run/src/photosynth.o vic/vic_run/src/physics.o vic/vic_run/src/prepare_full_energy.o vic/vic_run/src/root_brent.o vic/vic_run/src/runoff.o vic/vic_run/src/snow_intercept.o vic/vic_run/src/snow_melt.o vic/vic_run/src/snow_utility.o vic/vic_run/src/SnowPackEnergyBalance.o vic/vic_run/src/soil_carbon_balance.o vic/vic_run/src/soil_conduction.o vic/vic_run/src/soil_thermal_eqn.o vic/vic_run/src/solve_snow.o vic/vic_run/src/StabilityCorrection.o vic/vic_run/src/surface_fluxes.o vic/vic_run/src/svp.o vic/vic_run/src/vic_run.o vic/vic_run/src/water_energy_balance.o vic/vic_run/src/water_under_ice.o vic/vic_run/src/write_layer.o vic/vic_run/src/write_vegvar.o vic/drivers/shared_all/src/agg_data.o vic/drivers/shared_all/src/alarms.o vic/drivers/shared_all/src/calc_root_fraction.o vic/drivers/shared_all/src/cmd_proc.o vic/drivers/shared_all/src/compress_files.o vic/drivers/shared_all/src/compute_derived_state_vars.o vic/drivers/shared_all/src/compute_lake_params.o vic/drivers/shared_all/src/compute_treeline.o vic/drivers/shared_all/src/forcing_utils.o vic/drivers/shared_all/src/free_all_vars.o vic/drivers/shared_all/src/free_vegcon.o vic/drivers/shared_all/src/generate_default_lake_state.o vic/drivers/shared_all/src/generate_default_state.o vic/drivers/shared_all/src/get_parameters.o vic/drivers/shared_all/src/history_metadata.o vic/drivers/shared_all/src/initialize_energy.o vic/drivers/shared_all/src/initialize_global.o vic/drivers/shared_all/src/initialize_options.o vic/drivers/shared_all/src/initialize_parameters.o vic/drivers/shared_all/src/initialize_snow.o vic/drivers/shared_all/src/initialize_soil.o vic/drivers/shared_all/src/initialize_veg.o vic/drivers/shared_all/src/input_tools.o vic/drivers/shared_all/src/make_all_vars.o vic/drivers/shared_all/src/make_cell_data.o vic/drivers/shared_all/src/make_dmy.o vic/drivers/shared_all/src/make_energy_bal.o vic/drivers/shared_all/src/make_snow_data.o vic/drivers/shared_all/src/make_veg_var.o vic/drivers/shared_all/src/open_file.o vic/drivers/shared_all/src/print_library_shared.o vic/drivers/shared_all/src/put_data.o vic/drivers/shared_all/src/set_output_defaults.o vic/drivers/shared_all/src/soil_moisture_from_water_table.o vic/drivers/shared_all/src/timing.o vic/drivers/shared_all/src/update_step_vars.o vic/drivers/shared_all/src/vic_history.o vic/drivers/shared_all/src/vic_log.o vic/drivers/shared_all/src/vic_time.o vic/drivers/shared_all/src/zero_output_list.o ./conv.o ./display_current_settings.o ./force.o ./get_options.o ./globals.o ./initiate.o ./make_output_info.o ./make_params.o ./RcppExports.o ./vic_run_cell.o ./vic_version.o vic_run_cells_all.o XAJ.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0 -L/opt/gfortran/lib -lgfortran -lemutls_w -lquadmath -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0'
ld: warning: directory not found for option '-L/opt/gfortran/lib'
ld: library not found for -lgfortran
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [VIC5.so] Error 1
ERROR: compilation failed for package ‘VIC5’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/VIC5/old/VIC5.Rcheck/VIC5’


```
# whomds

<details>

* Version: 1.1.1
* GitHub: https://github.com/lindsayevanslee/whomds
* Source code: https://github.com/cran/whomds
* Date/Publication: 2023-09-08 04:30:02 UTC
* Number of recursive dependencies: 122

Run `revdepcheck::revdep_details(, "whomds")` for more info

</details>

## Error before installation

### Devel

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/whomds/new/whomds.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘whomds/DESCRIPTION’ ... OK
...
* checking re-building of vignette outputs ... SKIPPED
* DONE

Status: 2 WARNINGs
See
  ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/whomds/new/whomds.Rcheck/00check.log’
for details.








```
### CRAN

```






```
# wqtrends

<details>

* Version: 1.5.0
* GitHub: https://github.com/tbep-tech/wqtrends
* Source code: https://github.com/cran/wqtrends
* Date/Publication: 2024-09-04 12:50:02 UTC
* Number of recursive dependencies: 89

Run `revdepcheck::revdep_details(, "wqtrends")` for more info

</details>

## Error before installation

### Devel

```
* using log directory ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/wqtrends/new/wqtrends.Rcheck’
* using R version 4.3.1 (2023-06-16)
* using platform: aarch64-apple-darwin20 (64-bit)
* R was compiled by
    Apple clang version 14.0.0 (clang-1400.0.29.202)
    GNU Fortran (GCC) 12.2.0
* running under: macOS 15.1
* using session charset: UTF-8
* using options ‘--no-manual --no-build-vignettes’
* checking for file ‘wqtrends/DESCRIPTION’ ... OK
...
* checking package vignettes in ‘inst/doc’ ... OK
* checking running R code from vignettes ...
  ‘wqtrends.Rmd’ using ‘UTF-8’... OK
 OK
* checking re-building of vignette outputs ... SKIPPED
* DONE

Status: OK







```
### CRAN

```






```
# WRTDStidal

<details>

* Version: 1.1.4
* GitHub: https://github.com/fawda123/WRTDStidal
* Source code: https://github.com/cran/WRTDStidal
* Date/Publication: 2023-10-20 09:00:11 UTC
* Number of recursive dependencies: 139

Run `revdepcheck::revdep_details(, "WRTDStidal")` for more info

</details>

## In both

*   checking whether package ‘WRTDStidal’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/WRTDStidal/new/WRTDStidal.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘WRTDStidal’ ...
** package ‘WRTDStidal’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
Error in loadNamespace(j <- i[[1L]], c(lib.loc, .libPaths()), versionCheck = vI[[j]]) : 
  namespace ‘Matrix’ 1.5-4.1 is already loaded, but >= 1.6.0 is required
Calls: <Anonymous> ... namespaceImportFrom -> asNamespace -> loadNamespace
Execution halted
ERROR: lazy loading failed for package ‘WRTDStidal’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/WRTDStidal/new/WRTDStidal.Rcheck/WRTDStidal’


```
### CRAN

```
* installing *source* package ‘WRTDStidal’ ...
** package ‘WRTDStidal’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
Error in loadNamespace(j <- i[[1L]], c(lib.loc, .libPaths()), versionCheck = vI[[j]]) : 
  namespace ‘Matrix’ 1.5-4.1 is already loaded, but >= 1.6.0 is required
Calls: <Anonymous> ... namespaceImportFrom -> asNamespace -> loadNamespace
Execution halted
ERROR: lazy loading failed for package ‘WRTDStidal’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/WRTDStidal/old/WRTDStidal.Rcheck/WRTDStidal’


```
# ycevo

<details>

* Version: 0.2.1
* GitHub: https://github.com/bonsook/ycevo
* Source code: https://github.com/cran/ycevo
* Date/Publication: 2024-06-05 16:20:02 UTC
* Number of recursive dependencies: 93

Run `revdepcheck::revdep_details(, "ycevo")` for more info

</details>

## In both

*   checking whether package ‘ycevo’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/ycevo/new/ycevo.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘ycevo’ ...
** package ‘ycevo’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using SDK: ‘MacOSX12.3.sdk’
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/ycevo/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/ycevo/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/ycevo/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/ycevo/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c dbar_cpp.cpp -o dbar_cpp.o
clang++ -arch arm64 -std=gnu++17 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/opt/R/arm64/lib -o ycevo.so RcppExports.o dbar_cpp.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0 -L/opt/gfortran/lib -lgfortran -lemutls_w -lquadmath -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0'
ld: warning: directory not found for option '-L/opt/gfortran/lib'
ld: library not found for -lgfortran
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [ycevo.so] Error 1
ERROR: compilation failed for package ‘ycevo’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/ycevo/new/ycevo.Rcheck/ycevo’


```
### CRAN

```
* installing *source* package ‘ycevo’ ...
** package ‘ycevo’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘Apple clang version 13.1.6 (clang-1316.0.21.2)’
using SDK: ‘MacOSX12.3.sdk’
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/ycevo/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/ycevo/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++ -arch arm64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/ycevo/Rcpp/include' -I'/Users/vitalie/dev/lubridate/revdep/library.noindex/ycevo/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c dbar_cpp.cpp -o dbar_cpp.o
clang++ -arch arm64 -std=gnu++17 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/opt/R/arm64/lib -o ycevo.so RcppExports.o dbar_cpp.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0 -L/opt/gfortran/lib -lgfortran -lemutls_w -lquadmath -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/12.2.0'
ld: warning: directory not found for option '-L/opt/gfortran/lib'
ld: library not found for -lgfortran
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [ycevo.so] Error 1
ERROR: compilation failed for package ‘ycevo’
* removing ‘/Users/vitalie/dev/lubridate/revdep/checks.noindex/ycevo/old/ycevo.Rcheck/ycevo’


```
