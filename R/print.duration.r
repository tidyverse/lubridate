print.duration <- function(dur){
	format_unit <- function(x, singular = NULL) {
	    if (is.null(singular)) singular <- deparse(substitute(x))
    	plural <- paste(singular, "s", sep = "")
    	ifelse(x == 0, "", 
      	paste(x, ifelse(!is.na(x) & x == 1, singular, plural)))
    }
	
	
	dur <- as.numeric(dur)
	month_num <- dur %/% (10^10)
	seconds <- dur - month_num * 10^10
	
	year <- month_num %/% 12
	month <- month_num %% 12
	
	week <- (seconds %/% 604800)
	day <- (seconds - week * 604800) %/% 86400
	hour <- (seconds - week * 604800 - day * 86400) %/% 3600
	minute <- (seconds - week * 604800 - day * 86400 - hour * 3600) %/% 60
	second <- seconds - week * 604800 - day * 86400 - hour * 3600 - minute * 60
	
	duration <- cbind(
    	format_unit(year), 
    	format_unit(month), 
    	format_unit(week),
    	format_unit(day),
    	format_unit(hour), 
    	format_unit(minute), 
    	format_unit(second)
    )
	
	collapse <- function(x) {
    	all <- x[x != ""]
    	if (length(all) == 0) return("0 seconds")
    	if (length(all) == 1) return(all)
    	paste(
    		paste(all[1:length(all) - 1], collapse = ", "),
    		all[length(all)], sep = " and ")
  	}
	
	print(paste(aaply(duration, 1, collapse)))
	} 