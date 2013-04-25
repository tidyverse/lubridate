setOldClass("POSIXt")
setOldClass("POSIXct")
setOldClass("POSIXlt")

#' Is x a POSIXct or POSIXlt object?
#'
#' @export is.POSIXt is.POSIXlt is.POSIXct
#' @aliases is.POSIXt is.POSIXlt is.POSIXct
#' @param x an R object   
#' @return TRUE if x is a POSIXct or POSIXlt object, FALSE otherwise.
#' @seealso \code{\link{is.instant}}, \code{\link{is.timespan}}, \code{\link{is.Date}}
#' @keywords logic chron
#' @examples
#' is.POSIXt(as.Date("2009-08-03")) # FALSE
#' is.POSIXt(as.POSIXct("2009-08-03")) # TRUE
is.POSIXt <- function(x) is(x, "POSIXt")
is.POSIXlt <- function(x) is(x, "POSIXlt")
is.POSIXct <- function(x) is(x, "POSIXct")

#' @S3method c POSIXct
c.POSIXct <- function (..., recursive = FALSE) {
	.POSIXct(c(unlist(lapply(list(...), unclass))), tz = tz(list(...)[[1]]))
}

#' @S3method c POSIXlt
c.POSIXlt <- function (..., recursive = FALSE) {
  as.POSIXlt(do.call("c.POSIXct", lapply(list(...), as.POSIXct)))
}
