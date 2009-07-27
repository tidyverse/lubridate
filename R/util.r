# A year is a leap year if it is evenly divisible by 400 or evenly 
# divisible by 4 but not 100.

leap.year <- function(date) {
		year <- year(date)
  (year %% 4 == 0) & ((year %% 100 != 0) | (year %% 400 == 0))
}


now <- function() Sys.time()
today <- Sys.Date()

pretty.dates <- function(dates, n){
	Sys.setenv(TZ = tz(dates[1]))
	rng <- range(dates)
	diff <- rng[2] - rng[1]
	diff <- just_seconds(diff)
	
	binunits <- pretty.unit(diff/n)
	
	f <- match.fun(paste("pretty", binunits, sep = "."))
	binlength <- f(diff, n)
	
	browser()
	
	start <- pretty.point(min(rng), binunits, binlength)
	end <- pretty.point(max(rng), binunits, binlength)
	
	breaks <- seq.POSIXt(start, end, paste(binlength, binunits)) 
	Sys.unsetenv("TZ")
	breaks
}
	
	

pretty.unit <- function(interval){
	
	if (interval > 3600*24*365)
		return("year")
	if (interval > 3600*24*30)
		return("month")
	if (interval > 3600*24)
		return("day")
	if (interval > 3600)
		return("hour")
	if (interval > 60)
		return("min")
	else
		return("sec")
}

pretty.sec <- function(span, n){
	lengths <- c(1,2,5,10,15,30,60)
	fit <- abs(span - lengths*n)
	lengths[which.min(fit)]
}

pretty.min <- function(span, n){
	span <- span/60
	lengths <- c(1,2,5,10,15,30,60)
	fit <- abs(span - lengths*n)
	lengths[which.min(fit)]
}

pretty.hour <- function(span, n){
	span <- span / 3600
	lengths <- c(1,2,3,4,6,8,12,24)
	fit <- abs(span - lengths*n)
	lengths[which.min(fit)]
}

pretty.day <- function(span, n){
	span <- span / (3600 * 24)
	pretty(1:span, n = n)[2]
}

pretty.month <- function(span, n){
	span <- span / (3600 * 24 * 30)
	lengths <- c(1,2,3,4,6,12)
	fit <- abs(span - lengths*n)
	lengths[which.min(fit)]
}
	
pretty.year <- function(span, n){
	span <- span / (3600 * 24 * 365)
	pretty(1:span, n = n)[2]
}

pretty.point <- function(x, units, length, start = TRUE){
	x <- as.POSIXct(x)
	
	floors <- c("sec", "min", "hour", "day", "d", "month", "year")
	floorto <- floors[which(floors == units) + 1]
	lower <- floor_date(x, floorto)
	upper <- ceiling_date(x, floorto)
	
	points <- seq.POSIXt(lower, upper, paste(length, units))
	
	fit <- just_seconds(x - points)
	
	if (start){
		fit <- fit[fit >= 0]
		return(points[which.min(fit)])
	}
	
	if (!start){
		fit <- fit[fit <=0]
		return(points[which.max(fit)])
	}
}
