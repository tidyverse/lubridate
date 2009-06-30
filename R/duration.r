
new_duration <- function (months, seconds){
	structure(data.frame(months, seconds), class = c("duration", "data.frame"))
}


as.duration <- function (x, ...) UseMethod("as.duration")

as.duration.data.frame <- function(x, ...){
	stopifnot(dim(x) == c(1,2))
	x <- structure(x, class = c("duration", "data.frame"))
	x
}

as.duration.difftime <- function(x, ...){
	new_duration(0, as.numeric(x, units = "secs"))
}

seconds <- function(x = 1) new_duration(0, x)
minutes <- function(x = 1) seconds(x * 60)
hours <-   function(x = 1) minutes(x * 60)
days <-    function(x = 1) hours(x * 24)	
weeks <-   function(x = 1) days(x * 7)
months <-  function(x = 1) new_duration(x, 0)
years <-   function(x = 1) months(x * 12)

y <- years(1)
m <- months(1)
d <- days(1)


is.duration <- function(x) inherits(x, "duration")
is.POSIXt <- function(x) inherits(x, "POSIXt")

# adding 
"+.duration" <- "+.POSIXt" <- function(e1, e2){
  if (is.duration(e1) && is.duration(e2)) {
    add_duration_to_duration(e1, e2)
  } else if (is.duration(e1)){
		add_duration_to_date(e2, e1)
	} else if (is.duration(e2)) {
		add_duration_to_date(e1, e2)
	} else {
		base::'+.POSIXt'(e1, e2)
	}
}	

add_duration_to_date <- function(date, dur) {
	second(date) <- second(date) + dur$seconds
	month(date) <- month(date) + dur$months
	date
}

add_duration_to_duration <- function(dur1, dur2) {
  dur1$seconds <- dur1$seconds + dur2$seconds
  dur1$months <- dur1$months + dur2$months
  dur1
}

"*.duration" <- function(e1, e2){
	  if (is.duration(e1) && is.duration(e2)) {
    NA
  } else if (is.duration(e1)){
		multiply_duration_by_numeric(e2, e1)
	} else if (is.duration(e2)) {
		multiply_duration_by_numeric(e1, e2)
	} else {
		base::'*'(e1, e2)
	}
}	

multiply_duration_by_numeric <- function(num, dur){
	as.duration(num * as.data.frame(dur))
}



# subtracting 
"-.duration" <- "-.POSIXt" <- function(e1, e2){
  # Deal with unary minus, e.g. -hours(1)
  if (missing(e2) && is.duration(e1)) {
    e1$seconds <- -e1$seconds
    e1$months <-  -e1$months
    e1
  } else if (is.POSIXt(e1) && is.duration(e2)){
  	e1 + -e2
  } else {
	    coerceTimeUnit <- function(x) {
        	switch(attr(x, "units"), secs = x, mins = 60 * x, hours = 60 * 
            	60 * x, days = 60 * 60 * 24 * x, weeks = 60 * 60 * 
            	24 * 7 * x)
        }
        if (!inherits(e1, "POSIXt")) 
        	stop("Can only subtract from POSIXt objects")
    	if (nargs() == 1) 
        	stop("unary '-' is not defined for \"POSIXt\" objects")
    	if (inherits(e2, "POSIXt")) 
        	return(as.duration(difftime(e1, e2)))
    	if (inherits(e2, "difftime")) 
        	e2 <- unclass(coerceTimeUnit(e2))
    	if (!is.null(attr(e2, "class"))) 
        	stop("can only subtract numbers from POSIXt objects")
    	structure(unclass(as.POSIXct(e1)) - e2, class = c("POSIXt", "POSIXct"))
  }
}

write_out <- function(e1) {
 	if (e1 == 1) return(paste(e1, as.character(substitute(e1)), sep = " "))
 	if (e1 != 0) return(paste(e1, paste(as.character(substitute(e1)), "s", sep = "")))
 	return(NULL)
}


print.duration <- function(x, ...) {
	duration <- vector(mode = "character")
	
	year <- x$months %/% 12
	month <- x$months %% 12
	week <- x$seconds %/% 604800
	day <- (x$seconds - week * 604800) %/% 86400
	hour <- (x$seconds - week * 604800 - day * 86400) %/% 3600
	minute <- (x$seconds - week * 604800 - day * 86400 - hour * 3600) %/% 60
	second <- x$seconds - week * 604800 - day * 86400 - hour * 3600 - minute * 60
	
	duration <- c(write_out(year), write_out(month), write_out(week), write_out(day), write_out(hour), write_out(minute), write_out(second))
	
	if(length(duration) > 1)
	   cat(cat(duration[1:length(duration) - 1], sep = ", "),"and", duration[length(duration)])
	else
	  cat(duration)
}

