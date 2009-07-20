new_duration <- function(secs = 0, mins = 0, hours = 0, days = 0, weeks = 0, months = 0, years = 0){
	
	if( months - trunc(months) != 0 || years - trunc(years) != 0)
		stop("months and years must be in integer values", call. = F)
	
	dur <- secs + mins * 60 + hours * 3600 + days * 86400 + weeks * 604800 
	
	years <- years + 4 * (dur %/% 126230400)
	dur <- dur - 126230400 * (dur %/% 126230400)
	dur <- dur + 10 ^ 10 * months + 12* 10 ^ 10 * years
	structure(dur, class = "duration")
}

as.duration <- function (x, ...) UseMethod("as.duration")

as.duration.difftime <- function(x, ...){
  new_duration(secs = as.numeric(x, units = "secs"))
}

as.duration.default <- function(x, ...){
  message("Numeric coerced to seconds")
  new_duration(secs = x)
}

as.duration.duration <- function(x, ...) {
  x
}

seconds <- function(x = 1) new_duration(x)
minutes <- function(x = 1) new_duration(mins = x)
hours <-   function(x = 1) new_duration(hours = x)
days <-    function(x = 1) new_duration(days = x)  
weeks <-   function(x = 1) new_duration(weeks = x)
months <-  function(x = 1) new_duration(months = x)
years <-   function(x = 1) new_duration(years = x)

y <- years(1)
m <- months(1)
w <- weeks(1)
d <- days(1)

is.duration <- function(x) inherits(x, "duration")
is.POSIXt <- function(x) inherits(x, c("POSIXt", "POSIXct", "POSIXlt"))
is.difftime <- function(x) inherits(x, "difftime")



	
