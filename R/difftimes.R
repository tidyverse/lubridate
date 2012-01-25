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
  seconds <- abs(x)
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