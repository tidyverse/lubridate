setOldClass("Date")

#' Is x a Date object?
#'
#' @export is.Date
#' @param x an R object
#' @return TRUE if x is a Date object, FALSE otherwise.
#' @seealso \code{\link{is.instant}}, \code{\link{is.timespan}}, \code{\link{is.POSIXt}}
#' @keywords logic chron
#' @examples
#' is.Date(as.Date("2009-08-03")) # TRUE
#' is.Date(difftime(now() + 5, now())) # FALSE
is.Date <- function(x) is(x, "Date")
