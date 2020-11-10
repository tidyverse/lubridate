# nocov start

.onLoad <- function(libname, pkgname) {
  ## CCTZ needs zoneinfo. On windows we set it to R's own zoneinfo. On unix like
  ## it's in "/usr/share/zoneinfo" where CCTZ looks by default. On some systems
  ## (solaris, osx) it might be in a different location. So, help ourselves by
  ## setting the TZDIR env var, but only if it's not already set.

  ## adapted from Syz.timezone and OlsonNames function
  .find_tzdir <- function() {
    ## Initialize Sys.timezone() cache to avoid resetting TZDIR at a later stage.
    ## As of R4.0.3 Sys.timezone() intrusively sets TZDIR to non path values.
    Sys.timezone()
    if (.Platform$OS.type == "windows")
      return(file.path(R.home("share"), "zoneinfo"))
    tzdirs <- c("/usr/share/zoneinfo",
                "/usr/share/lib/zoneinfo",
                "/usr/lib/zoneinfo",
                "/usr/local/etc/zoneinfo",
                "/etc/zoneinfo",
                "/usr/etc/zoneinfo",
                "/usr/share/zoneinfo.default",
                "/var/db/timezone/zoneinfo",
                file.path(R.home("share"), "zoneinfo"))
    tzdirs <- tzdirs[file.exists(tzdirs)]
    if (length(tzdirs)) tzdirs[[1]]
    else NULL
  }

  tzdir <- Sys.getenv("TZDIR")
  if (tzdir == "internal") {
    Sys.setenv(TZDIR = file.path(R.home("share"), "zoneinfo"))
  } else if (tzdir == "macOS") {
    if (!is.null(dir <- .find_tzdir()))
      Sys.setenv(TZDIR = dir)
  } else if (tzdir == "") {
    # not checking for /usr/share/zoneinfo which is the default in CCTZ
    if (!file.exists("/usr/share/zoneinfo")) {
      if (!is.null(dir <- .find_tzdir()))
        Sys.setenv(TZDIR = dir)
    }
  }

  on_package_load("vctrs", {
    register_s3_method("vctrs", "vec_proxy", "Period")
    register_s3_method("vctrs", "vec_proxy_compare", "Period")
    register_s3_method("vctrs", "vec_proxy_equal", "Period")
    register_s3_method("vctrs", "vec_restore", "Period")
    register_s3_method("vctrs", "vec_ptype2", "Period.Period")
    register_s3_method("vctrs", "vec_cast", "Period.Period")

    register_s3_method("vctrs", "vec_proxy", "Duration")
    register_s3_method("vctrs", "vec_proxy_compare", "Duration")
    register_s3_method("vctrs", "vec_proxy_equal", "Duration")
    register_s3_method("vctrs", "vec_restore", "Duration")
    register_s3_method("vctrs", "vec_ptype2", "Duration.Duration")
    register_s3_method("vctrs", "vec_ptype2", "Duration.difftime")
    register_s3_method("vctrs", "vec_ptype2", "difftime.Duration")
    register_s3_method("vctrs", "vec_cast", "Duration.Duration")
    register_s3_method("vctrs", "vec_cast", "Duration.difftime")
    register_s3_method("vctrs", "vec_cast", "difftime.Duration")

    register_s3_method("vctrs", "vec_proxy", "Interval")
    register_s3_method("vctrs", "vec_proxy_compare", "Interval")
    register_s3_method("vctrs", "vec_proxy_equal", "Interval")
    register_s3_method("vctrs", "vec_restore", "Interval")
    register_s3_method("vctrs", "vec_ptype2", "Interval.Interval")
    register_s3_method("vctrs", "vec_cast", "Interval.Interval")
  })
}

register_s3_method <- function(pkg, generic, class, fun = NULL) {
  stopifnot(is.character(pkg), length(pkg) == 1)
  stopifnot(is.character(generic), length(generic) == 1)
  stopifnot(is.character(class), length(class) == 1)

  if (is.null(fun)) {
    fun <- get(paste0(generic, ".", class), envir = parent.frame())
  } else {
    stopifnot(is.function(fun))
  }

  if (pkg %in% loadedNamespaces()) {
    registerS3method(generic, class, fun, envir = asNamespace(pkg))
  }

  # Always register hook in case package is later unloaded & reloaded
  setHook(
    packageEvent(pkg, "onLoad"),
    function(...) {
      registerS3method(generic, class, fun, envir = asNamespace(pkg))
    }
  )
}

on_package_load <- function(pkg, expr) {
  if (isNamespaceLoaded(pkg)) {
    expr
  } else {
    thunk <- function(...) expr
    setHook(packageEvent(pkg, "onLoad"), thunk)
  }
}

#nocov end
