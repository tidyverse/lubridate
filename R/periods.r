new_period <- function(...) {
  pieces <- list(...)
  names(pieces) <- standardise_date_names(names(pieces))
  structure(pieces, class = "period")
}

seconds <- function(x = 1) new_period(second = x)
minutes <- function(x = 1) new_period(minute = x)
hours <-   function(x = 1) new_period(hour = x)
days <-    function(x = 1) new_period(day = x)  
weeks <-   function(x = 1) new_period(week = x)
months <-  function(x = 1) new_period(month = x)
years <-   function(x = 1) new_period(year = x)

format.period <- function(per, ...){
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
is.timespan <- function(x) inherits(x,c("period", "difftime"))
is.instant <- function(x) inherits(x, c("POSIXt", "POSIXct", "POSIXlt", "Date"))

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


add_period_to_date <- function(date, period) {
	for (i in 1:length(period)){
		date <- switch(names(period)[i],
			"second" = update(date, second = second(date) + period$second),
			"minute" = update(date, minute = minute(date) + period$minute),
			"hour" = update(date, hour = hour(date) + period$hour),
			"day" = update(date, day = day(date) + period$day),
			"week" = update(date, week = week(date) + period$week),
			"month" = update(date, month = month(date) + period$month),
			"year" = update(date, year = year(date) + period$year)
		)
	}
	date
}

add_duration_to_date <- function(date, duration) {
	if(is.Date(date))
		stop("duration does not support date class")
		#return(date + as.double(duration, "days"))
	base::'+.POSIXt'(date, duration)
}

add_number_to_duration <- function(dur, num)
	make_difftime(num + as.double(dur, "secs"))

add_number_to_period <- function(per, num)
	stop("R does not currently support this operation")
	
add_period_to_period <- function(per1, per2){
	common <- intersect(names(per1), names(per2))
	per1 <- c(per1, per2[setdiff(names(per2), names(per1))])
	per1[common] <- as.numeric(per1[common]) + as.numeric(per2[common])
	
	class(per1) <- "period"
	per1
}
	
add_duration_to_period <- function(dur, per){
	stop("R does not currently support this operation")
	# per + seconds(as.double(dur, "secs"))
}
	
add_duration_to_duration <- function(dur1, dur2)
	make_difftime(as.double(dur1, "secs") + as.double(dur2, "secs"))
	


"+.period" <- "+.POSIXt" <- "+.difftime" <- "+.Date" <- function(e1, e2){
	
	if (is.instant(e1)) {
		if (is.instant(e2))
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
		else
			add_number_to_duration(e1, e2)
	}
	
	
	else if (is.numeric(e1)) {
		if (is.instant(e2))
			add_duration_to_date(e2, new_duration(secs = e1))
		else if (is.period(e2))
			add_number_to_period(e2, e1)
		else if (is.duration(e2))
			add_number_to_duration(e2, e1)
		else stop("Unknown object class")
	}
	else stop("Unknown object class")
}

"*.period" <- function(e1, e2){
    if (is.period(e1) && is.period(e2)) 
    	NA
    else if (is.period(e1))
    	multiply_period_by_numeric(e2, e1)
  	else if (is.period(e2)) 
    	multiply_period_by_numeric(e1, e2)
  	else 
    	base::'*'(e1, e2)
}  

multiply_period_by_numeric <- function(num, per){
	for(i in 1:length(per))
		per[i] <- num * as.numeric(per[i])
	per
}

"/.period" <- function(e1, e2){
	if (is.period(e1) && is.period(e2))
    	NA
    else if (is.period(e1))
  		divide_period_by_numeric(e2, e1)
  	else if (is.period(e2)) 
  		stop( 'second argument of / cannot be a "period" object')
  	else
    	base::'*'(e1, e2)
}  

divide_period_by_numeric <- function(num, per){
	for(i in 1:length(per))
		per[i] <- as.numeric(per[i]) / num
	if(trunc(as.numeric(per)) - as.numeric(per) != 0)	
		stop("period objects must retain integer values", call. = F)
	per
}

"-.period" <- "-.POSIXt" <- "-.difftime" <- "-.Date" <- function(e1, e2){
	if (missing(e2))
		-1 * e1
	else if(is.instant(e1) && is.instant(e2))
		difftime(e1, e2)
	else if (is.POSIXt(e1) && !is.timespan(e2))
		structure(unclass(as.POSIXct(e1)) - e2, class = c("POSIXt", "POSIXct"))
	else		
		e1  + (-1 * e2)
}