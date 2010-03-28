# for case study 2
# Easter depends on full moons, so will do thanksgiving instead
# very hard to do with current version of lubridate, so propose 
#  code below

# To find thanksgiving:
# date <- ymd("2010-01-01")
# date + months(10) + thursdays(4)

# thursdays() is new class: epoch.
# epochs are time points of interest
# we can find the next occurence of the epoch, or 
#  the nth next occurence of the epoch

# could also use to make a businessdays(6) sort of function

# would have to write subtract_epoch_from_date method, and 
#  incorporate both into ops.durations.r


sundays <- function(x = 1) 
	new_epoch(weekday = "sunday", number = x)
mondays <- function(x = 1) 
	new_epoch(weekday = "monday", number = x)
tuesdays <- function(x = 1) 
	new_epoch(weekday = "tuesday", number = x)
wednesdays <- function(x = 1) 
	new_epoch(weekday = "wednesday", number = x)
thursdays <- function(x = 1) 
	new_epoch(weekday = "thursday", number = x)
fridays <- function(x = 1) 
	new_epoch(weekday = "friday", number = x)
saturdays <- function(x = 1) 
	new_epoch(weekday = "saturday", number = x)


new_epoch <- function(weekday, number){
	epoch <- list(weekday = weekday, number = number)
	structure(epoch, class = c("epoch", "list"))
}
	
	
add_epoch_to_date <- function(date, epoch){
	weekday <- switch(epoch$weekday, sunday = 1, monday = 2, 
		tuesday = 3, wednesday = 4, thursday = 5, friday = 6, 
		saturday = 7)
		
	start_day <- wday(date)
	
	if (weekday >= weekday){
		return(date + days(7 + weekday - start_day) + 
			weeks(number - 1))
	}else{
		return(date <- date + days(weekday - start_day) + 
			weeks(number - 1))
	}
}