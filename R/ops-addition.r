#' @include timespans.r
#' @include durations.r
#' @include intervals.r
#' @include periods.r
#' @include Dates.r
#' @include difftimes.r
#' @include numeric.r
#' @include POSIXt.r
NULL


add_duration_to_duration <- function(dur2, dur1)
	new("Duration", dur1@.Data + dur2@.Data)

add_duration_to_interval <- function(dur, int)
	new("Interval", int@.Data + dur@.Data, start = int@start, tzone = int@tzone)

add_duration_to_period <- function(dur, per){
	message("duration converted to seconds")
	per + seconds(dur@.Data)
}

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




add_interval_to_date <- function(int, date){
	message("coercing interval to duration")
	dur <- new("Duration", int@.Data)
	add_duration_to_date(dur, date)
}

add_interval_to_interval <- function(int2, int1){
	union(int2, int1)
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

add_period_to_date <- function(per, date){
	new <- update(as.POSIXlt(date), 
			years = year(date) + per@year,
			months = month(date) + per@month,
			days = mday(date) + per@day,
			hours = hour(date) + per@hour,
			minutes = minute(date) + per@minute,
			seconds = second(date) + per@.Data
			)
	if (is.Date(date) && sum(new$sec, new$min, new$hour, na.rm = TRUE) != 0)
		return(new)	
	
	reclass_date(new, date)
}




add_number_to_duration <- function(num, dur){
  	new("Duration", dur@.data + num)
}

add_number_to_interval <-function(num, int){
  message("numeric coerced to duration in seconds")
  new("Interval", int@.Data + num, start = int@start, tzone = int@tzone)
}

add_number_to_period <- function(num, per){
  message("numeric coerced to seconds")
  slot(per, ".Data") <- per@.Data + num
  per
}




#' @export
setMethod("+", signature(e1 = "Duration", e2 = "Duration"),
	function(e1, e2) add_duration_to_duration(e2, e1))

#' @export
setMethod("+", signature(e1 = "Duration", e2 = "Interval"),
	function(e1, e2) add_duration_to_interval(e1, e2))

#' @export	
setMethod("+", signature(e1 = "Duration", e2 = "Period"),
	function(e1, e2) add_duration_to_period(e1, e2))

#' @export	
setMethod("+", signature(e1 = "Duration", e2 = "Date"), 
	function(e1, e2) add_duration_to_date(e1, e2)) 
	
#' @export	
setMethod("+", signature(e1 = "Duration", e2 = "difftime"),
	function(e1, e2) add_duration_to_duration(as.duration(e2), e1))
	
#' @export	
setMethod("+", signature(e1 = "Duration", e2 = "numeric"),
	function(e1, e2) add_number_to_duration(e2, e1))

#' @export  
setMethod("+", signature(e1 = "Duration", e2 = "POSIXct"), 
	function(e1, e2) add_duration_to_date(e1, e2)) 

#' @export	
setMethod("+", signature(e1 = "Duration", e2 = "POSIXlt"), 
	function(e1, e2) add_duration_to_date(e1, e2)) 
	

#' @export
setMethod("+", signature(e1 = "Interval", e2 = "Duration"),
	function(e1, e2) add_duration_to_interval(e2, e1)) 

#' @export	
setMethod("+", signature(e1 = "Interval", e2 = "Interval"),
	function(e1, e2) add_interval_to_interval(e2, e1))

#' @export	
setMethod("+", signature(e1 = "Interval", e2 = "Period"),
	function(e1, e2) add_period_to_interval(e2, e1))

#' @export	
setMethod("+", signature(e1 = "Interval", e2 = "Date"),
	function(e1, e2) add_interval_to_date(e1, e2))

#' @export	
setMethod("+", signature(e1 = "Interval", e2 = "difftime"),
	function(e1, e2) add_duration_to_interval(as.duration(e2), e1))

#' @export 
setMethod("+", signature(e1 = "Interval", e2 = "numeric"), 
	function(e1, e2) add_number_to_interval(e2, e1))

#' @export 
setMethod("+", signature(e1 = "Interval", e2 = "POSIXct"),
	function(e1, e2) add_interval_to_date(e1, e2))

#' @export 	
setMethod("+", signature(e1 = "Interval", e2 = "POSIXlt"),
	function(e1, e2) add_interval_to_date(e1, e2))



#' @export 
setMethod("+", signature(e1 = "Period", e2 = "Duration"),
	function(e1, e2) add_duration_to_period(e2, e1))

#' @export 	
setMethod("+", signature(e1 = "Period", e2 = "Interval"),
	function(e1, e2) add_period_to_interval(e1, e2))

#' @export 
setMethod("+", signature(e1 = "Period", e2 = "Period"), 
	function(e1, e2) add_period_to_period(e2, e1))

#' @export 
setMethod("+", signature(e1 = "Period", e2 = "Date"), 
	function(e1, e2) add_period_to_date(e1, e2))

#' @export 		
setMethod("+", signature(e1 = "Period", e2 = "difftime"),	
	function(e1, e2) add_duration_to_period(as.duration(e2), e1))

#' @export 	
setMethod("+", signature(e1 = "Period", e2 = "numeric"),
	function(e1, e2) add_number_to_period(e2, e1))

#' @export 
setMethod("+", signature(e1 = "Period", e2 = "POSIXct"), 
	function(e1, e2) add_period_to_date(e1, e2))

#' @export 	
setMethod("+", signature(e1 = "Period", e2 = "POSIXlt"), 
	function(e1, e2) add_period_to_date(e1, e2))
	


#' @export 
setMethod("+", signature(e1 = "Date", e2 = "Duration"), 
	function(e1, e2) add_duration_to_date(e2, e1)) 

#' @export 	
setMethod("+", signature(e1 = "Date", e2 = "Interval"),
	function(e1, e2) add_interval_to_date(e2, e1))

#' @export 	
setMethod("+", signature(e1 = "Date", e2 = "Period"), 
	function(e1, e2) add_period_to_date(e2, e1))


	

#' @export 
setMethod("+", signature(e1 = "difftime", e2 = "Duration"), 
	function(e1, e2) add_difftime_to_difftime(as.difftime(e2, units = "secs"), e1))

#' @export 	
setMethod("+", signature(e1 = "difftime", e2 = "Interval"),
	function(e1, e2) add_duration_to_interval(e1, e2))

#' @export 
setMethod("+", signature(e1 = "difftime", e2 = "Period"), 
	function(e1, e2) add_duration_to_period(e1, e2))

	



#' @export 
setMethod("+", signature(e1 = "numeric", e2 = "Duration"),
	function(e1, e2) add_number_to_duration(e1, e2)) 

#' @export 	
setMethod("+", signature(e1 = "numeric", e2 = "Interval"),
	function(e1, e2) add_number_to_interval(e1, e2)) 

#' @export 
setMethod("+", signature(e1 = "numeric", e2 = "Period"),
	function(e1, e2) add_number_to_period(e1, e2))

	
	

#' @export 
setMethod("+", signature(e1 = "POSIXct", e2 = "Duration"), 
	function(e1, e2) add_duration_to_date(e2, e1)) 

#' @export 	
setMethod("+", signature(e1 = "POSIXct", e2 = "Interval"),
	function(e1, e2) add_interval_to_date(e2, e1))

#' @export 	
setMethod("+", signature(e1 = "POSIXct", e2 = "Period"), 
	function(e1, e2) add_period_to_date(e2, e1))
      
      

#' @export       
setMethod("+", signature(e1 = "POSIXlt", e2 = "Duration"), 
	function(e1, e2) add_duration_to_date(e2, e1)) 

#' @export 
setMethod("+", signature(e1 = "POSIXlt", e2 = "Interval"),
	function(e1, e2) add_interval_to_date(e2, e1))

#' @export 	
setMethod("+", signature(e1 = "POSIXlt", e2 = "Period"), 
	function(e1, e2) add_period_to_date(e2, e1))
