##' Deprecated function in \code{lubridate} package
##' @param ... arguments to be passed to the functions
##'     (obscured to enforce the usage of new functions)
##' @rdname Deprecated
##' @name Deprecated-lubridate
NULL

## modified ggplot2:::gg_dep
.deprecated <- function(replacement, version) {

  name <- as.character(sys.call(-1)[[1]])
  
  v <- as.package_version(version)
  cv <- packageVersion("lubridate")

  ## If current major number is greater than last-good major number, or if
  ##  current minor number is more than 1 greater than last-good minor number,
  ##  give error.
  if (cv[[1,1]] > v[[1,1]]  ||  cv[[1,2]] > v[[1,2]] + 1) {
    stop(sprintf("'%s' is defunct; use '%s' instead. Last used in version '%s'.",
                 name, replacement, version),
         call. = FALSE)
  } else if (cv[[1,2]] > v[[1,2]]) {
    ## If minor number differs by one, give warning
    warning(sprintf("'%s' is deprecated; use '%s' instead. Last used in version '%s'.",
                    name, replacement, version),
            call. = FALSE)
  } else if (cv[[1,3]] > v[[1,3]]) {
    ## If only subminor number is greater, give message
    message(sprintf("'%s' is deprecated use '%s' instead. Last used in version '%s'.",
                    name, replacement, version),
            call. = FALSE)
  }
  invisible()
}

##' @rdname Deprecated
##' @export
new_period <- function(...) {
  .deprecated("period", "1.4.0")
  period(...)
}

##' @rdname Deprecated
##' @export
new_interval <- function(...) {
  .deprecated("interval", "1.4.0")
  interval(...)
}

##' @rdname Deprecated
##' @export
new_duration <- function(...) {
  .deprecated("duration", "1.4.0")
  duration(...)
}

##' @rdname Deprecated
##' @export
new_difftime <- function(...) {
  .deprecated("make_difftime", "1.4.0")
  make_difftime(...)
}


