#' Calculate ages
#'
#' This function calculate age at last birthday or exact age.
#' 
#' @export age
#' @param start date of birth or equivalent
#' @param end date for which age should be calculated
#' @param unit a character string that specifies with time units to use
#' @param exact should the computed age be exact?
#' @return a numeric value
#' @details
#' \code{age} computes ages based on a classic demographic approach, i.e. the result is equal to 
#' the exact age at last birthday (i.e. completed years). Age computation is based on calendar time 
#' and is therefore more accurate than the basic approach based on the mean duration time of a year 
#' (see examples). If \code{exact} is true, the fraction of time between last birthday and end date 
#' will be added to the result.
#' @keywords chron math period
#' @examples
#' age(ymd('1900-01-01'), ymd('1999-12-31'))
#' age(ymd('1900-01-01'), ymd('1999-12-31'), unit = "month")
#' 
#' # Exact age
#' age(ymd('1900-01-01'), ymd('1999-12-31'), exact = TRUE)
#' 
#' # Comparison with basic approach based on mean duration of a year
#' # The result is not correct
#' new_interval(ymd('1900-01-01'), ymd('1999-12-31')) / duration(num = 1, units = "year")
#' 
#' # Minutes since 00:00
#' age(today(), now(), unit = "minute")


age <- function(start, end = today(), unit = "year", exact = FALSE) {
  res <- new_interval(start, end)
  res[res < 0] <- NA
  unit <- standardise_period_names(unit)
  res <- as.period(res, unit=unit)
  if(unit == "second") res <- slot(res, ".Data")
  else res <- slot(res, unit)
  if (exact) {
    previous_anniversary <- start %m+% res * period(1, units = unit)
    next_anniversary <- start %m+% (res+1) * period(1, units = unit)
    time_to_now <- as.duration(end - previous_anniversary)
    time_to_next <- as.duration(next_anniversary - previous_anniversary)
    res <- res + time_to_now / time_to_next
  }
  return(res)
}

