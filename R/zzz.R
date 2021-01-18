# nocov start

.onLoad <- function(libname, pkgname) {
  tzdir_set()

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
