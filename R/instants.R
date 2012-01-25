#' Is x a date-time object?
#'
#' An instant is a specific moment in time. Most common date-time 
#' objects (e.g, POSIXct, POSIXlt, and Date objects) are instants.
#'
#' @export is.instant is.timepoint
#' @aliases instant instants is.instant timepoint is.timepoint
#' @param x an R object   
#' @return TRUE if x is a POSIXct, POSIXlt, or Date object, FALSE otherwise.
#' @seealso \code{\link{is.timespan}}, \code{\link{is.POSIXt}}, \code{\link{is.Date}}
#' @keywords logic chron
#' @examples
#' is.instant(as.Date("2009-08-03")) # TRUE
#' is.timepoint(5) # FALSE
is.instant <- is.timepoint <- function(x) is(x, c("POSIXt", "POSIXct", "POSIXlt", "Date"))