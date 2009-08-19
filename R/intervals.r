new_interval <- function(date1, date2){
	date1 <- as.POSIXct(date1)
	date2 <- as.POSIXct(date2)
		
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

	
