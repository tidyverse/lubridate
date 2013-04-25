#' @include timespans.r
#' @include durations.r
#' @include intervals.r
#' @include periods.r


setOldClass("difftime")


#' Makes a difftime object from a given number of seconds 
#'
#' @export make_difftime
#' @param x number value of seconds to be transformed into a difftime object
#' @return a difftime object corresponding to x seconds
#' @keywords chron
#' @examples
#' make_difftime(1)
#' make_difftime(60)
#' make_difftime(3600)
make_difftime <- function (x) {  
  seconds <- abs(na.omit(x))
    if (any(seconds < 60)) 
        units <- "secs"
    else if (any(seconds < 3600))
        units <- "mins"
    else if (any(seconds < 86400))
        units <- "hours"
    else
        units <- "days"

    
    switch(units, secs = structure(x, units = "secs", class = "difftime"), 
      mins = structure(x/60, units = "mins", class = "difftime"), 
      hours = structure(x/3600, units = "hours", class = "difftime"), 
      days = structure(x/86400, units = "days", class = "difftime"))
}


#' Create a difftime object.
#'
#' new_difftime creates a difftime object with the specified number of units. Entries for 
#' different units are cumulative. difftime displays durations in various units, 
#' but these units are estimates given for convenience. The underlying object is 
#' always recorded as a fixed number of seconds. For display and creation 
#' purposes, units are converted to seconds using their most common lengths in 
#' seconds. Minutes = 60 seconds, hours = 3600 seconds, days = 86400 seconds, 
#' weeks = 604800. Units larger than weeks are not used due to their 
#' variability.
#'
#' Conceptually, difftime objects are a type of duration. They measure the 
#' exact passage of time but do not always align with measurements 
#' made in larger units of time such as hours, months and years. 
#' This is because the length of larger time units can be affected 
#' by conventions such as leap years 
#' and Daylight Savings Time. lubridate provides a second class for measuring durations, the Duration class.
#'
#' @param ... a list of time units to be included in the difftime and their amounts. Seconds, 
#'   minutes, hours, days, and weeks are supported. 
#' @return a difftime object
#' @export new_difftime
#' @seealso \code{\link{duration}}, \code{\link{as.duration}}
#' @keywords chron classes
#' @examples
#' new_difftime(second = 90)
#' # Time difference of 1.5 mins
#' new_difftime(minute = 1.5)
#' # Time difference of 1.5 mins
#' new_difftime(second = 3, minute = 1.5, hour = 2, day = 6, week = 1)
#' # Time difference of 13.08441 days
#' new_difftime(hour = 1, minute = -60)
#' # Time difference of 0 secs
#' new_difftime(day = -1)
#' # Time difference of -1 days
new_difftime <- function(...){
  pieces <- list(...)
  names(pieces) <- standardise_difftime_names(names(pieces))
  
  defaults <- list(secs = 0, mins = 0, hours = 0, days = 0, weeks = 0)
  pieces <- c(pieces, defaults[setdiff(names(defaults), names(pieces))])
  
  x <- pieces$secs +
    pieces$mins * 60 +
    pieces$hours * 3600 +
    pieces$days * 86400 +
    pieces$weeks * 604800
  
  make_difftime(x)
}


#' Is x a difftime object?
#'
#' @export is.difftime
#' @param x an R object   
#' @return TRUE if x is a difftime object, FALSE otherwise.
#' @seealso \code{\link{is.instant}}, \code{\link{is.timespan}}, \code{\link{is.interval}}, 
#'   \code{\link{is.period}}.
#' @keywords logic chron
#' @examples
#' is.difftime(as.Date("2009-08-03")) # FALSE
#' is.difftime(new_difftime(days = 12.4)) # TRUE
is.difftime <- function(x) is(x, "difftime")
