new_interval <- function(date1, date2){
	compatible <- recognize(c(date1, date2))
	if(!compatible)
		stop("unrecognized date format")
		
	interval <- data.frame(start = date1, end = date2)
	structure(interval, class = c("interval", "data.frame"))
}

format.interval <- function(int,...){
	x <- difftime(int$end, int$start)
	paste(format(unclass(x),...), units(x), "beginning at", int$start)
}


print.interval <- function(x, ...) {
  print(format(x), ..., quote = FALSE)
}

as.period <- function(x, periods)
	UseMethod("as.period")
	
as.period.default <- function(x, periods){
	x <- as.numeric(x)
	unit <- standardise_date_names(periods[1])
	f <- match.fun(paste(unit, "s", sep = ""))
	f(x)
}

as.period.interval <- function(x, periods){
	periods <- standardise_date_names(periods)
	newper <- new_period(second = 0)
	
	for(i in 1:length(periods)){
		start <- x$start + newper
		name <- match(periods[i], names(newper))
		f <- match.fun(periods[i])
		newper[1,name] <- f(x$end) - f(start)
	}

	remainder <- as.double(difftime(x$end, x$start + newper), "secs")
	newper$second <- newper$second + remainder
newper
}

as.period.difftime <- function(x, periods)
	stop("no unique mapping exists between durations (difftimes) and periods", call. = F)
	
as.interval <- function(x, origin){
	origin <- as.POSIXct(origin)
	new_interval(origin, origin + x)
}

as.duration <- function(x)
	UseMethod(as.duration)
	
as.duration.period <- function(x)
	stop("no unique mapping exists between durations and periods.", call. = F)
	
as.duration.interval <- function(x)
	difftime(x$end, x$start)

as.duration.default <- function(x)
	make_difftime(x)
	
