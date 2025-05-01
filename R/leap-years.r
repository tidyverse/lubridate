#' Is a year a leap year?
#'
#' If x is a recognized date-time object, leap_year will return whether x
#' occurs during a leap year. If x is a number, leap_year returns whether it
#' would be a leap year under the Gregorian calendar.
#'
#' @export leap_year
#' @param date a date-time object or a year
#' @return TRUE if x is a leap year, FALSE otherwise
#' @keywords logic chron
#' @examples
#' x <- as.Date("2009-08-02")
#' leap_year(x) # FALSE
#' leap_year(2009) # FALSE
#' leap_year(2008) # TRUE
#' leap_year(1900) # FALSE
#' leap_year(2000) # TRUE
leap_year <- function(date) {
  if (is.numeric(date)) {
    year <- date
  } else {
    year <- year(date)
  }
  .Call(C_is_leap_year, as.integer(year))
}
