# nocov start

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
