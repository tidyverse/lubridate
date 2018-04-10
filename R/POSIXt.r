setOldClass("POSIXt")
setOldClass("POSIXct")
setOldClass("POSIXlt")

#' Is x a POSIXct or POSIXlt object?
#'
#' @export
#' @param x an R object
#' @return TRUE if x is a POSIXct or POSIXlt object, FALSE otherwise.
#' @seealso [is.instant()], [is.timespan()], [is.Date()]
#' @keywords logic chron
#' @examples
#' is.POSIXt(as.Date("2009-08-03")) # FALSE
#' is.POSIXt(as.POSIXct("2009-08-03")) # TRUE
is.POSIXt <- function(x) inherits(x, "POSIXt")

#' @rdname is.POSIXt
#' @export
is.POSIXlt <- function(x) inherits(x, "POSIXlt")

#' @rdname is.POSIXt
#' @export
is.POSIXct <- function(x) inherits(x, "POSIXct")

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
