
## Set zoneinfo location for CCTZ on windows. Copied from RcppCCTZ package.
.onAttach <- function(libname, pkgname) {
    if (Sys.info()[["sysname"]] == "Windows") {
        ## if (interactive()) packageStartupMessage("RcppCCTZ setting zoneinfo on Windows")
        Sys.setenv("TZDIR"=file.path(R.home(), "share", "zoneinfo"))
    }
}
