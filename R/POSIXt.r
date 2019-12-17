setOldClass("POSIXt")
setOldClass("POSIXct")
setOldClass("POSIXlt")

#' Various POSIX utilities
#'
#' [POSIXct()] mirrors primitive contructors in base R ([double()],
#' [character()] etc.)
#'
#' @rdname posix_utils
#' @param x an R object
#' @param length A non-negative number specifying the desired length. Supplying
#'   an argument of length other than one is an error.
#' @param tz a timezone (defaults to "utc")
#' @return TRUE if x is a POSIXct or POSIXlt object, FALSE otherwise.
#' @seealso [is.instant()], [is.timespan()], [is.Date()]
#' @keywords logic chron
#' @examples
#' is.POSIXt(as.Date("2009-08-03"))
#' is.POSIXt(as.POSIXct("2009-08-03"))
#' @export
is.POSIXt <- function(x) inherits(x, "POSIXt")

#' @rdname posix_utils
#' @export
is.POSIXlt <- function(x) inherits(x, "POSIXlt")

#' @rdname posix_utils
#' @export
is.POSIXct <- function(x) inherits(x, "POSIXct")

#' @rdname posix_utils
#' @export
POSIXct <- function(length = 0L, tz = "UTC") {
  t0 <- if (is_utc(tz)) origin else force_tz(origin, tz)
  .POSIXct(rep.int(t0, length), tz = tz)
}

#' @rdname posix_utils
#' @export
NA_POSIXct_ <- .POSIXct(NA_real_, tz = "UTC")

#' @method c POSIXct
c.POSIXct <- function(..., recursive = FALSE) {
  dots <- list(...)
  .POSIXct(c(unlist(lapply(dots, unclass))), tz = tz(dots[[1]]))
}

#' @method c POSIXlt
c.POSIXlt <- function(..., recursive = FALSE) {
  as.POSIXlt(do.call("c.POSIXct", lapply(list(...), as.POSIXct)))
}

evalqOnLoad({
    registerS3method("c", "POSIXct", c.POSIXct)
    ## registerS3method("c", "POSIXlt", c.POSIXlt)
})
