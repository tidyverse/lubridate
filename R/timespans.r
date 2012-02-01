setClass("Timespan")

#' Is x a length of time?
#'
#' @export is.timespan 
#' @aliases is.timespan
#' @param x an R object   
#' @return TRUE if x is a period, interval, duration, or difftime object, FALSE otherwise.
#' @seealso \code{\link{is.instant}}, \code{\link{is.duration}}, \code{\link{is.difftime}}, \code{\link{is.period}}, \code{\link{is.interval}}
#' @keywords logic chron
#' @examples
#' is.timespan(as.Date("2009-08-03")) # FALSE
#' is.timespan(new_duration(second = 1)) # TRUE
is.timespan <- function(x) is(x, "Timespan")