add_duration_to_date <- function(dur, date) {
  if(is.Date(date)){
    date <- as.POSIXct(date)
    ans <- with_tz(date + dur@.Data, "UTC")
    if (hour(ans) == 0 && minute(ans) == 0 && second(ans) == 0)
      return(as.Date(ans))
    return(ans)
  }
  new <- date + dur@.Data
  attr(new, "tzone") <- tz(date)
  reclass_date(new, date)
}

add_duration_to_duration <- function(dur2, dur1)
	new("Duration", dur1@.Data + dur2@.Data)

add_duration_to_interval <- function(dur, int)
	new("Interval", int@.Data + dur@.Data, start = int@start)

add_duration_to_period <- function(dur, per){
	message("duration converted to seconds")
	per + seconds(dur@.Data)
}




add_interval_to_date <- function(int, date){
	message("coercing interval to duration")
	dur <- new("Duration", int@.Data)
	add_duration_to_date(dur, date)
}

add_interval_to_interval <- function(int2, int1){
	union(int2, int1)
}



add_number_to_duration <- function(num, dur){
  	new("Duration", dur@.data + num)
}

add_number_to_interval <-function(num, int){
  message("numeric coerced to duration in seconds")
  new("Interval", int@.Data + num, start = int@start)
}

add_number_to_period <- function(num, per){
  message("numeric coerced to seconds")
  slot(per, ".Data") <- per@.Data + num
  per
}


add_period_to_date <- function(per, date){
	new <- update(as.POSIXlt(date), 
			years = year(date) + per@year,
			months = month(date) + per@month,
			days = mday(date) + per@day,
			hours = hour(date) + per@hour,
			minutes = minute(date) + per@minute,
			seconds = second(date) + per@.Data
			)
	if (is.Date(date) && sum(new@.Data, new@minute, new@hour, na.rm = TRUE) != 0)
		return(new)	
	
	reclass_date(new, date)
}

add_period_to_interval <- function(per, int){
  end <- int@start + int@.Data
  end2 <- end + per
  new_interval(end2, int@start)
}

add_period_to_period <- function(per2, per1){
  new("Period", per1@.Data + per2@.Data,
  	year = per1@year + per2@year,
  	month = per1@month + per2@month,
  	day = per1@day + per2@day,
  	hour = per1@hour + per2@hour,
  	minute = per1@minute + per2@minute)
}


#' RE-DOCUMENT!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#' Adding date-time objects
#'
#' add_dates adds two objects, both of which can be date-time 
#' objects. Lubridate is built so that you don't need to use 
#' add_dates but can use regular math expressions instead.
#' @param e1 a numeric or date-time object
#' @param e2 a numeric or date-time object
#' @export add_dates


setMethod("+", signature(e1 = "Interval", e2 = "Interval"),
	add_interval_to_interval(e2, e1))
	
setMethod("+", signature(e1 = "Interval", e2 = "Period"),
	add_period_to_interval(e2, e1)

setMethod("+", signature(e1 = "Interval", e2 = "Duration"),
	add_duration_to_interval(e2, e1)) 

setMethod("+", signature(e1 = "Interval", e2 = "POSIXt"),
	add_interval_to_date(e1, e2))
	
setMethod("+", signature(e1 = "Interval", e2 = "difftime"),
	add_duration_to_interval(as.duration(e2), e1))
 
setMethod("+", signature(e1 = "Interval", e2 = "numeric"), 
	add_number_to_interval(e2, e1))




setMethod("+", signature(e1 = "Period", e2 = "Interval"),
	add_period_to_interval(e1, e2))

setMethod("+", signature(e1 = "Period", e2 = "Period"), 
	add_period_to_period(e2, e1))

setMethod("+", signature(e1 = "Period", e2 = "Duration"),		
	add_duration_to_period(e2, e1))

setMethod("+", signature(e1 = "Period", e2 = "POSIXt"), 
	add_period_to_date(e1, e2))
		
setMethod("+", signature(e1 = "Period", e2 = "difftime"),	
	add_duration_to_period(as.duration(e2), e1))
	
setMethod("+", signature(e1 = "Period", e2 = "numeric"),		
	add_number_to_period(e2, e1))

	
	


setMethod("+", signature(e1 = "Duration", e2 = "Interval"),
	add_duration_to_interval(e1, e2))
	
setMethod("+", signature(e1 = "Duration", e2 = "Period"),
	add_duration_to_period(e1, e2))
	
setMethod("+", signature(e1 = "Duration", e2 = "Duration"),
	add_duration_to_duration(e2, e1))
  
setMethod("+", signature(e1 = "Duration", e2 = "POSIXt"), 
	add_duration_to_date(e1, e2)) 
	
setMethod("+", signature(e1 = "Duration", e2 = "difftime"),
	add_duration_to_duration(as.duration(e2), e1))
	
setMethod("+", signature(e1 = "Duration", e2 = "numeric"),
	add_number_to_duration(e2, e1))




setMethod("+", signature(e1 = "POSIXt", e2 = "Interval"),
	add_interval_to_date(e2, e1))
	
setMethod("+", signature(e1 = "POSIXt", e2 = "Period"), 
	add_period_to_date(e2, e1))
      
setMethod("+", signature(e1 = "POSIXt", e2 = "Duration"), 
	add_duration_to_date(e2, e1)) 


	

setMethod("+", signature(e1 = "difftime", e2 = "Interval"),
	add_duration_to_interval(e1, e2))

setMethod("+", signature(e1 = "difftime", e2 = "Period"), 
	add_duration_to_period(e1, e2))

setMethod("+", signature(e1 = "difftime", e2 = "Duration"), 
	add_difftime_to_difftime(as.difftime(e2, units = "secs"), e1))
	

  
	
setMethod("+", signature(e1 = "numeric", e2 = "Interval"),
	add_number_to_interval(e1, e2)) 

setMethod("+", signature(e1 = "numeric", e2 = "Period"),
	add_number_to_period(e1, e2))

setMethod("+", signature(e1 = "numeric", e2 = "Duration"),
	add_number_to_duration(e1, e2)) 