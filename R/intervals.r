new_interval <- function(date1, date2){
	compatible <- recognize(c(date1, date2))
	if(!compatible)
		stop("unrecognized date format")
		
	start <- min(date1, date2)
	end <- max(date1, date2)
	interval <- data.frame(start = start, end = end)
	structure(interval, class = c("interval", "data.frame"))
}

