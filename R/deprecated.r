##' Deprecated functions in the lubridate package
##' @param x numeric value to be converted into duration
##' @param ... arguments to be passed to the functions
##'     (obscured to enforce the usage of new functions)
##' @rdname Deprecated
##' @keywords internal
##' @name Deprecated-lubridate
NULL

## modified ggplot2:::gg_dep
.deprecated_fun <- function(replacement, version, n_call = 1) {
  name <- as.character(sys.call(-(n_call))[[1]])
  name <- sprintf("'%s'", name[[length(name)]])
  replacement <- sprintf("; use '%s' instead", replacement)
  .deprecated(name, replacement, version)
}

.deprecated_arg <- function(arg, version, n_call = 1) {
  name <- as.character(sys.call(-n_call)[[1]])
  mes <- sprintf("Argument '%s' of '%s'", arg, name)
  .deprecated(mes, "", version)
}

.deprecated <- function(name, replacement = NULL, version) {

  v <- as.package_version(version)
  cv <- packageVersion("lubridate")

  replacement <- if (is.null(replacement)) "" else replacement

  ## If current major number is greater than last-good major number, or if
  ## current minor number is more than 2 greater than last-good minor number,
  ## give error.
  if (cv[[1, 1]] > v[[1, 1]]  ||  cv[[1, 2]] > v[[1, 2]] + 2) {
    stop(sprintf("%s is defunct%s. Deprecated in version '%s'.",
                 name, replacement, version),
         call. = FALSE)
  } else if (cv[[1, 2]] > v[[1, 2]]) {
    ## If minor number differs by one, give warning
    warning(sprintf("%s is deprecated%s. Deprecated in version '%s'.",
                    name, replacement, version),
            call. = FALSE)
  } else if (cv[[1, 3]] >=  v[[1, 3]]) {
    ## If only subminor number is greater, give message
    message(sprintf("%s is deprecated%s. Deprecated in version '%s'.",
                    name, replacement, version))
  }
  invisible()

}
