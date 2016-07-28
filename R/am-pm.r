#' Does date time occur in the am or pm?
#'
#' @export
#' @param x a date-time object
#' @return TRUE or FALSE depending on whether x occurs in the am or pm
#' @keywords chron
#' @examples
#' x <- ymd("2012-03-26")
#' am(x)
#' pm(x)
am <- function(x) hour(x) < 12

#' @export
#' @rdname am
pm <- function(x) !am(x)
