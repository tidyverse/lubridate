#' Extract time of day in the current time zone
#'
#' @export
#' @param x a date-time object
#' @return an object of class [Interval-class]
#' @examples
#' time_of_day(Sys.time())
time_of_day <- function(x) {
  interval(floor_date(x, "days"), x)
}
