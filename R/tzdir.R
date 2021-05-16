## CCTZ needs zoneinfo. On windows we set it to R's own zoneinfo. On unix like
## it's in "/usr/share/zoneinfo" where CCTZ looks by default. On some systems
## (solaris, osx) it might be in a different location. So, help ourselves by
## setting the TZDIR env var, but only if it's not already set.
##
## As of R4.0.3 Sys.timezone() intrusively sets TZDIR to non path values.
## https://github.com/wch/r-source/commit/92712b530e5f0f3c19b1e83ed86554bbfb6d9095#diff-883a8df98e17cbfd43513e7378ae4899bf504d8dbd8e47d021d8493602ab4b8fR52-R66
tzdir_set <- function() {
  # On MacOS, this chooses between system and built-in zoneinfo based on
  # which is newer
  Sys.timezone()

  tzdir <- tzdir_get()
  if (tzdir == "internal") {
    Sys.setenv(TZDIR = tzdir_internal())
  } else if (tzdir %in% c("macOS", "")) {
    dir <- tzdir_find()
    if (is.null(dir)) {
      warning("Failed to locate timezone database", call. = FALSE)
    } else {
      Sys.setenv(TZDIR = dir)
    }
  }
}

tzdir_get <- function() {
  Sys.getenv("TZDIR")
}

## adapted from Syz.timezone and OlsonNames function
tzdir_find <- function() {
  if (.Platform$OS.type == "windows") {
    return(tzdir_internal())
  }

  tzdirs <- c(
    "/usr/share/zoneinfo",
    "/usr/share/lib/zoneinfo",
    "/usr/lib/zoneinfo",
    "/usr/local/etc/zoneinfo",
    "/etc/zoneinfo",
    "/usr/etc/zoneinfo",
    "/usr/share/zoneinfo.default",
    "/var/db/timezone/zoneinfo",
    tzdir_internal()
  )
  tzdirs <- tzdirs[file.exists(tzdirs)]
  if (length(tzdirs)) {
    tzdirs[[1]]
  } else {
    NULL
  }
}

tzdir_internal <- function() {
  file.path(R.home("share"), "zoneinfo")
}
