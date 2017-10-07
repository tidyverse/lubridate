##' @include util.r
NULL

## #' @export
## setMethod("<", signature(e1 = "POSIXct", e2 = "Date"),
##           function(e1, e2) {
##             cat("here")
##             callNextMethod(e1, .POSIXct(e2, tz = attr(e1, "tzone")))
##           })

## #' @export
## setMethod("<", signature(e1 = "Date", e2 = "POSIXct"),
##           function(e1, e2) {
##             cat("here")
##            callNextMethod(.POSIXct(e1, tz = attr(e2, "tzone")), e2)
##           })

comp_posix_date <- function(e1, e2) {
  if (nargs() == 1)
    stop(gettextf("unary '%s' not defined for \"%s\" objects",  .Generic, class(e1)), domain = NA)

  if (inherits(e1, "POSIXlt"))
    e1 <- as.POSIXct(e1)
  if (inherits(e2, "POSIXlt"))
    e2 <- as.POSIXct(e2)

  if (is.character(e1)) {
    e1 <-
      if (is.Date(e2)) as.Date(e1)
      else as.POSIXct(e1)
  }

  if (is.character(e2)) {
    e2 <-
      if (is.Date(e1)) as.Date(e2)
      else as.POSIXct(e2)
  }

  if (is.POSIXct(e1) && is.Date(e2)) {
    e2 <- date_to_posix(e2, tz(e1))
    base::check_tzones(e1, e2)
  } else if (is.Date(e1) && is.POSIXct(e2)) {
    e1 <- date_to_posix(e1, tz = tz(e2))
    base::check_tzones(e1, e2)
  }
  NextMethod(.Generic)
}

## Nothing else seems to work, only this sneaky trick.
evalqOnLoad({

  for (op in c("<", ">", "==", ">=", "<=", "!=")) {
    registerS3method(op, "Date", comp_posix_date)
    registerS3method(op, "POSIXt", comp_posix_date)
  }

})
