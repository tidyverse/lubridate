# adding 
"+.duration" <- "+.POSIXt" <- "+.difftime" <- function(e1, e2){
 
  if(!is.POSIXt(e1) && is.duration(e2)) e1 <- as.duration(e1)
  if(!is.POSIXt(e2) && is.duration(e1)) e2 <- as.duration(e2)
  if (is.duration(e1) && is.duration(e2)) 
    add_duration_to_duration(e1, e2)
  else if (is.duration(e1) && is.POSIXt(e2))
    add_duration_to_date(e2, e1)
  else if (is.duration(e2) && is.POSIXt(e1)) 
    add_duration_to_date(e1, e2)
  else if (is.POSIXt(e1) && is.POSIXt(e2))
    stop("binary '+' is not defined for \"POSIXt\" objects")
  else if (is.POSIXt(e1) || is.POSIXt(e2))
    base::'+.POSIXt'(e1,e2)
  else if (is.difftime(e1) && is.difftime(e2))
    make_difftime( as.numeric(e1, units = "secs") +  as.numeric(e2, units = "secs"))
  else if (is.difftime(e1)){
    e2 <- structure(e2, units = units(e1), class = "difftime")
    make_difftime( as.numeric(e1, units = "secs") +  as.numeric(e2, units = "secs"))
  }
  else if (is.difftime(e2)){
    e1 <- structure(e1, units = units(e2), class = "difftime")
     make_difftime( as.numeric(e1, units = "secs") +  as.numeric(e2, units = "secs"))
  }
  else 
    base::'+'(e1, e2)
  
}  

add_duration_to_date <- function(date, dur) {
  second(date) <- second(date) + just_seconds(dur)
  month(date) <- month(date) + just_months(dur)
  date
}

add_duration_to_duration <- function(dur1, dur2) {
	seconds <- just_seconds(dur1) + just_seconds(dur2)
	months <- just_months(dur1) + just_months(dur2)
	new_duration(secs = seconds, months = months)
}
  

make_difftime <- function (diff) {  
	seconds <- abs(diff)
    if (seconds < 60) 
        units <- "secs"
    else if (seconds < 3600)
        units <- "mins"
    else if (seconds < 86400)
        units <- "hours"
    else if (seconds < 604800)
    	units <- "days"
    else units <- "weeks"
    
    switch(units, secs = structure(diff, units = "secs", class = "difftime"), 
    mins = structure(diff/60, units = "mins", class = "difftime"), 
    hours = structure(diff/3600, units = "hours", class = "difftime"), 
    days = structure(diff/86400, units = "days", class = "difftime"), 
    weeks = structure(diff/(604800), units = "weeks", class = "difftime"))
}


"*.duration" <- function(e1, e2){
    if (is.duration(e1) && is.duration(e2)) {
    NA
  } else if (is.duration(e1)){
    multiply_duration_by_numeric(e2, e1)
  } else if (is.duration(e2)) {
    multiply_duration_by_numeric(e1, e2)
  } else {
    base::'*'(e1, e2)
  }
}  


multiply_duration_by_numeric <- function(num, dur){
	seconds <- just_seconds(dur)
	months <- just_months(dur)
	new_duration(months = num * months, secs = num * seconds)
}

"/.duration" <- function(e1, e2){
    if (is.duration(e1) && is.duration(e2)) {
    NA
  } else if (is.duration(e1)){
    divide_duration_by_numeric(e2, e1)
  } else if (is.duration(e2)) {
    divide_duration_by_numeric(e1, e2)
  } else {
    base::'*'(e1, e2)
  }
}  


divide_duration_by_numeric <- function(num, dur){
	seconds <- just_seconds(dur)
	months <- just_months(dur)
	new_duration(months = months / num, secs = seconds / num)
}


# subtracting 
"-.duration" <- "-.POSIXt" <- "-.difftime" <- function(e1, e2){
  # Deal with unary minus, e.g. -hours(1)
  if (missing(e2) && is.duration(e1)) {
    seconds <- just_seconds(e1)
    months <- just_months(e1)
    return (new_duration(secs = -seconds, months =  -months))
  }
  if (missing(e2) && is.POSIXt(e1))
    stop("unary '-' is not defined for \"POSIXt\" objects")
  if (missing(e2) && is.difftime(e1))
    return(make_difftime(-as.numeric(e1, units = "secs")))
  if (missing(e2)) 
  	return(base::'-'(e1))
  

  # subtraction
  if (!is.POSIXt(e1) && is.duration(e2)) e1 <- as.duration(e1)
  if (!is.POSIXt(e2) && is.duration(e1)) e2 <- as.duration(e2)
    if (is.duration(e1) && is.duration(e2))
      e1 + -e2
    else if (is.POSIXt(e1) && is.duration(e2))
      e1 + -e2
    else if (is.POSIXt(e1) && is.POSIXt(e2))
      as.duration(difftime(e1, e2))    
    else if (is.POSIXt(e2)) 
      stop("Can only subtract from POSIXt objects")
    else if (is.POSIXt(e1) && is.difftime(e2))
      e1 + -as.numeric(e2, units = "secs")
    else if (is.POSIXt(e1))
      structure(unclass(as.POSIXct(e1)) - e2, class = c("POSIXt", "POSIXct"))
    else if (is.difftime(e1) || is.difftime(e2))
      e1 + -e2
    else
      base::'-'(e1, e2)
}
