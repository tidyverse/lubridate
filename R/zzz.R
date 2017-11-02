
.onLoad <- function(libname, pkgname) {
  ## CCTZ needs zoneinfo. On windows we set it to R's own zoneinfo. On unix like
  ## it's in "/usr/share/zoneinfo" where CCTZ looks by default. On some systems
  ## (solaris, osx) it might be in a different location. So, help ourselves by
  ## setting the TZDIR env var, but only if it's not already set.
  if (Sys.getenv("TZDIR") == "") {
    ## adapted from OlsonNames function
    tzdir <-
      if (.Platform$OS.type == "windows") {
        file.path(R.home("share"), "zoneinfo")
      } else if (!file.exists("/usr/share/zoneinfo")) {
        tzdirs <- c(file.path(R.home("share"), "zoneinfo"),
                    "/usr/share/lib/zoneinfo", "/usr/lib/zoneinfo",
                    "/usr/local/etc/zoneinfo", "/etc/zoneinfo",
                    "/usr/etc/zoneinfo")
        tzdirs <- tzdirs[file.exists(tzdirs)]
        if (length(tzdirs)) tzdirs[[1]]
        else NULL
      }
    if (!is.null(tzdir)) {
      Sys.setenv(TZDIR = tzdir)
    }
  }
}
