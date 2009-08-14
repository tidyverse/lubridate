new_interval <- function(date1, date2){
	compatible <- recognize(c(date1, date2))
	if(!compatible)
		stop("unrecognized date format")
		
	interval <- data.frame(start = date1, end = date2)
	structure(interval, class = c("interval", "data.frame"))
}

