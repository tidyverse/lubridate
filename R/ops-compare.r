
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

comp_posix_date <- function(e1, e2){
  if (nargs() == 1)
    stop(gettextf("unary '%s' not defined for \"%s\" objects",  .Generic, class(e1)), domain = NA)
  if(is.POSIXt(e1) || is.character(e1)){
    if (inherits(e1, "POSIXlt") || is.character(e1))
      e1 <- as.POSIXct(e1)
    if (inherits(e2, "POSIXlt") || is.character(e2))
      e2 <- as.POSIXct(e2)
    if (is.Date(e2))
      e2 <- .POSIXct(unclass(e2) * 86400, tz = attr(e1, "tzone"))
    check_tzones(e1, e2)
  } else if (is.Date(e1) || is.character(e1)) {
    if (is.character(e2))
      e2 <- as.Date(e2)
    if (is.POSIXt(e2)){
      e1 <- .POSIXct(unclass(e1) * 86400, tz = attr(e2, "tzone"))
    }
  }
  NextMethod(.Generic)
}

## Nothing else seem to work, only this sneaky method.
evalqOnLoad({
  for(op in c("<", ">", "==", ">=", "<=", "!=")){
    registerS3method(op, "Date", comp_posix_date)
    registerS3method(op, "POSIXct", comp_posix_date)
  }
})
