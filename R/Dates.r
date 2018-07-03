setOldClass("Date")

#' Various date utilities
#'
#' [Date()] mirrors primitive contructors in base R ([double()], [character()]
#' etc.)
#'
#' @rdname date_utils
#' @param x an R object
#' @param length A non-negative number specifying the desired length. Supplying
#'   an argument of length other than one is an error.
#' @seealso [is.instant()], [is.timespan()], [is.POSIXt()], [POSIXct()]
#' @keywords logic chron
#' @examples
#' is.Date(as.Date("2009-08-03")) # TRUE
#' is.Date(difftime(now() + 5, now())) # FALSE
#' @export
is.Date <- function(x) is(x, "Date")

#' @rdname date_utils
#' @export
Date <- function(length = 0L) {
  structure(rep.int(NA_real_, length), class = "Date")
}

#' @rdname date_utils
#' @export
NA_Date_ <- structure(NA_real_, class = "Date")
