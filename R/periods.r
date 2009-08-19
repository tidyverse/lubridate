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

y <- years(1)
m <- months(1)
w <- weeks(1)
d <- days(1)


format.period <- function(period, ...){
	show <- vector(mode = "character")
	for (i in 1:nrow(period)){
		per <- period[i,]
	
		per <- per[which(per != 0)]
		if (length(per) == 0) show[i] <- "0 seconds"
		
		else{
			singular <- names(per)
	   		plural <- paste(singular, "s", sep = "")
    
	    	IDs <-paste(per, ifelse(!is.na(per) & per == 1, singular, plural))
 		   	if(length(IDs) == 1) show[i] <- IDs
    		else
    			show[i] <- paste(paste(IDs[-length(IDs)], collapse = ", "), IDs[length(IDs)],sep = " and ")
    	}
    }
    paste(show, collapse = "   ")
}

print.period <- function(x, ...) {
  print(format(x), ..., quote = FALSE)
}



as.period <- function(x, periods, ...)
	UseMethod("as.period")
	
as.period.default <- function(x, periods, ...){
	x <- as.numeric(x)
	unit <- standardise_date_names(periods[1])
	f <- match.fun(paste(unit, "s", sep = ""))
	f(x)
}

as.period.interval <- function(x, periods = c("year", "month", "day", "hour", "minute", "seconds"), ...){
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

as.period.difftime <- function(x, periods){
	periods <- standardise_date_names(periods)
	span <- as.double(x, "secs")
	remainder <- abs(span)
	newper <- new_period(second = 0)
	denominator <- c(second = 1, minute = 60, hour = 3600, day = (3600 * 24), year =  (3600 * 24 * 7 * 365))
	
	for (i in 1:length(periods)){
		bite <- switch(periods[i], 
			"second" = span, 
			"minute" = span %/% 60 * 60, 
			"hour" = span %/% 3600 * 3600, 
			"day" = span %/% (3600 * 24) * (3600 * 24), 
			"month" = stop("month length cannot be estimated from durtions", call. = F),
			"year" = span %/% (3600 * 24 * 7 * 365) * (3600 * 24 * 7 * 365))
		remainder <- remainder - bite
		newper[periods[i]] <- bite / denominator[[periods[i]]]
	}
	
	newper$second <- newper$second + remainder
	newper * sign(span)
}










