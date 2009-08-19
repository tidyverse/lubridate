new_interval <- function(date1, date2){
	compatible <- recognize(c(date1, date2))
	if(!compatible)
		stop("unrecognized date format")
		
	interval <- data.frame(start = pmin(date1, date2), end = pmax(date1, date2))
	structure(interval, class = c("interval", "data.frame"))
}

format.interval <- function(int,...){
	x <- difftime(int$end, int$start)
	paste(format(unclass(x),...), units(x), "beginning at", int$start)
}


print.interval <- function(x, ...) {
  print(format(x), ..., quote = FALSE)
}


	
as.interval <- function(x, origin){
	origin <- as.POSIXct(origin)
	new_interval(origin, origin + x)
}

	
