difftime <- function(time1, time2){
	as.duration(base::difftime(time1, time2))
}

# failed attempt ot prevent z - a from returning a difftime object
# Ops.difftime.POSIXt <- function(time1, time2){
#	as.duration(base::Ops.difftime.POSIXt(time1, time2))
#}

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
	base::'-.POSIXt'(e1,e2)
  }

}


print.duration <- function(x, ...) {
	years <- x$months %/% 12
	months <- x$months %% 12
	weeks <- x$seconds %/% 604800
	days <- (x$seconds - weeks * 604800) %/% 86400
	hours <- (x$seconds - weeks * 604800 - days * 86400) %/% 3600
	minutes <- (x$seconds - weeks * 604800 - days * 86400 - hours * 3600) %/% 60
	seconds <- x$seconds - weeks * 604800 - days * 86400 - hours * 3600 - minutes * 60
  cat("Duration: ", 
  		years, " years, " ,
  		months, " months, ", 
  		weeks, " weeks, " , 
  		days, " days, " ,
  		hours, " hours, " ,
  		minutes, " minutes and ",
  		seconds, " seconds\n", sep ="")
}
