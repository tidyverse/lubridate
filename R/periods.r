new_period <- function(...) {
  pieces <- data.frame(...)
  if(any(trunc(pieces) - pieces != 0))
  	stop("periods must have integer values", call. = F)
  	
  names(pieces) <- standardise_date_names(names(pieces))
  defaults <- data.frame(
    second = 0, minute = 0, hour = 0, day = 0, week = 0, 
    month = 0, year = 0
  )
  
  pieces <- cbind(pieces, defaults[setdiff(names(defaults), names(pieces))])
  pieces <- pieces[c("year", "month", "week", "day", "hour", "minute", "second")] 
  
  pieces$day <- pieces$day + pieces$week * 7
  pieces <- pieces[,-3]
  
  structure(pieces, class = c("period", "data.frame"))
}

seconds <- function(x = 1) new_period(second = x)
minutes <- function(x = 1) new_period(minute = x)
hours <-   function(x = 1) new_period(hour = x)
days <-    function(x = 1) new_period(day = x)  
weeks <-   function(x = 1) new_period(week = x)
months <-  function(x = 1) new_period(month = x)
years <-   function(x = 1) new_period(year = x)

format.period <- function(per, ...){
	per <- per[which(per != 0)]
	if (length(per) == 0) return("0 seconds")
	singular <- names(per)
    plural <- paste(singular, "s", sep = "")
    
    IDs <-paste(per, ifelse(!is.na(per) & per == 1, singular, plural))
    if(length(IDs) == 1) return(IDs)
    paste(paste(IDs[-length(IDs)], collapse = ", "), IDs[length(IDs)],sep = " and ")
}

print.period <- function(x, ...) {
  print(format(x), ..., quote = FALSE)
}

is.period <- function(x) inherits(x,"period")
is.timespan <- function(x) inherits(x,c("period", "difftime", "interval"))
is.instant <- function(x) inherits(x, c("POSIXt", "POSIXct", "POSIXlt", "Date"))
is.interval <- function(x) inherits(x, c("interval"))

new_duration <- function(...){
	pieces <- list(...)
	names(pieces) <- standardise_difftime_names(names(pieces))
	dur <- structure(as.numeric(pieces[1]), class = "difftime", units = names(pieces)[1])
	
	for( i in 2:length(pieces))
		dur <- dur + structure(as.numeric(pieces[i]), class = "difftime", units = names(pieces)[i])
	
	make_difftime(as.double(dur, "secs"))
}

standardise_difftime_names <- function(x) {
  dates <- c("secs", "mins", "hours", "days", "weeks")
  y <- gsub("(.)s$", "\\1", x)
  y <- substr(y, 1, 3)
  res <- dates[pmatch(y, dates)]
  if (any(is.na(res))) {
    stop("Invalid difftime name: ", paste(x[is.na(res)], collapse = ", "), 
      call. = FALSE)
  }
  res
}


add_period_to_date <- function(date, period){
	sums <- data.frame(
		year = year(date) + period$year,
		month = month(date) + period$month,
		mday = mday(date) + period$day,
		hour = hour(date) + period$hour,
		minute = minute(date) + period$minute,
		second = second(date) + period$second
	)
		
	sums <- cbind(date, sums)
	names(sums)[1] <- ""
	
	newdate <- mlply(sums, update)
	attributes(newdate) <- NULL
	structure(unlist(newdate), class = class(newdate[[1]]))
}

add_duration_to_date <- function(date, duration) {
	if(is.Date(date))
		stop("duration does not support date class")
		#return(date + as.double(duration, "days"))
	base::'+.POSIXt'(date, duration)
}

add_number_to_duration <- function(dur, num)
	make_difftime(num + as.double(dur, "secs"))

add_number_to_period <- function(per, num){
	message("numeric coerced to seconds")
	per$second <- per$second + num
	per
}
	
add_period_to_period <- function(per1, per2)
	per1 + per2
	
add_duration_to_period <- function(dur, per){
	stop("incompatible time spans. See 'interval' documentation.")
	# per + seconds(as.double(dur, "secs"))
}
	
add_duration_to_duration <- function(dur1, dur2)
	make_difftime(as.double(dur1, "secs") + as.double(dur2, "secs"))

add_duration_to_interval <- function(int, dur){
	int$end <- int$end + dur
	int
}
	
add_period_to_interval <- function(int, per){
	int$end <- int$end + per
	int
}

add_number_to_interval <-function(int, num){
	message("numeric coerced to duration in seconds")
	int$end <- int$end + as.duration(num)
	int
}

"+.period" <- "+.POSIXt" <- "+.difftime" <- "+.interval" <- "+.Date" <- function(e1, e2){
	
	if (is.instant(e1)) {
		if (is.instant(e2))
			stop("binary '+' not defined for adding dates together")
		if (is.interval(e2))
			stop("binary '+' not defined for adding dates together")
		if (is.period(e2))
			add_period_to_date(e1, e2)
		else 
			add_duration_to_date(e1, e2)
	}

	else if (is.period(e1)) {
		if (is.instant(e2))
			add_period_to_date(e2, e1)
		else if (is.period(e2))
			add_period_to_period(e1, e2)
		else if (is.difftime(e2))
			add_duration_to_period(e1, e2)
		else if (is.interval(e2))
			add_period_to_interval(e2, e1)
		else
			add_number_to_period(e1, e2)
	}

	else if (is.difftime(e1)) {
		if (is.instant(e2))
			add_duration_to_date(e2, e1)
		else if (is.period(e2))
			add_duration_to_period(e2, e1)
		else if (is.difftime(e2))
			add_duration_to_duration(e1, e2)
		else if (is.interval(e2))
			add_duration_to_interval(e2, e1)
		else
			add_number_to_duration(e1, e2)
	}
	
	else if (is.interval(e1)){
		if (is.instant(e2))
			stop("binary '+' not defined for adding dates together")
		if (is.interval(e2))
			stop("binary '+' not defined for adding dates together")
		else if (is.period(e2))
			add_period_to_interval(e1, e2)
		else if (is.duration(e2))
			add_duration_to_interval(e1, e2)	
		else
			add_number_to_interval(e1, e2)
	}
	else if (is.numeric(e1)) {
		if (is.instant(e2))
			add_duration_to_date(e2, new_duration(secs = e1))
		else if (is.period(e2))
			add_number_to_period(e2, e1)
		else if (is.duration(e2))
			add_number_to_duration(e2, e1)
		else if (is.interval(e2))
			add_number_to_interval(e2, e1)	
		else stop("Unknown object class")
	}
	else stop("Unknown object class")
}

"*.period" <- "*.interval" <- function(e1, e2){
    if (is.timespan(e1) && is.timespan(e2)) 
    	stop("cannot multiply time span by time span")
    else if (is.period(e1))
    	multiply_period_by_number(e1, e2)
    else if (is.period(e2))
    	multiply_period_by_number(e2, e1)
    else if (is.interval(e1))
    	multiply_interval_by_number(e1, e2)
    else if (is.interval(e2))
    	multiply_interval_by_number(e2, e1)
    else base::'*'(e1, e2)
}  

multiply_period_by_number <- function(per, num){
	new_period(
		year = per$year * num,
		month = per$month * num,
		day = per$day * num,
		hour = per$hour * num,
		minute = per$minute * num,
		second = per$second * num
	)
}

multiply_interval_by_number <- function(int, num){
	diff <- difftime(int$end, int$start) * diff
    new_interval(int$start, int$start + diff)
}

"/.period" <- "/.interval" <- function(e1, e2){
 	if (is.timespan(e2)) 
  		stop( "second argument of / cannot be a timespan")
  	else if (is.period(e1)){
    	divide_period_by_number(e1, e2)
    else if (is.interval(e1)){
    	divide_interval_by_number(e1, e2)
    else base::'/'(e1, e2)
}  

divide_period_by_number <- function(per, num){
	new_period(
		year = per$year / num,
		month = per$month / num,
		day = per$day / num,
		hour = per$hour / num,
		minute = per$minute / num,
		second = per$second / num
	)
}

divide_interval_by_number <- function(int, num){
	diff <- difftime(int$end, int$start) / num
    new_interval(int$start, int$start + diff)
}


"-.period" <- "-.POSIXt" <- "-.difftime" <- "-.interval" <- "-.Date" <- function(e1, e2){
	if (missing(e2))
		-1 * e1
	else if(is.instant(e1) && is.instant(e2))
		new_interval(e1, e2)
	else if (is.POSIXt(e1) && !is.timespan(e2))
		structure(unclass(as.POSIXct(e1)) - e2, class = c("POSIXt", "POSIXct"))
	else		
		e1  + (-1 * e2)
}