# A year is a leap year if it is evenly divisible by 400 or evenly 
# divisible by 4 but not 100.

leap.year <- function(date) {
		year <- year(date)
  (year %% 4 == 0) & ((year %% 100 != 0) | (year %% 400 == 0))
}


now <- function() Sys.time()
today <- Sys.Date()

pretty.dates <- function(dates, n, tol  = 10){
	rng <- range(dates)
	diff <- rng[2] - rng[1]
	binunits <- pretty.unit(diff/n, tol)
	
	binlength <- pretty.length(just_seconds(diff), binunits, n)
	
	start <- pretty.point(min(rng), binunits, binlength)
	end <- pretty.point(max(rng), binunits, binlength)
	
	seq.POSIXt(start, end, paste(binlength, binunits)) 
}

	
	
	
pretty.unit <- function(interval, tol){
	interval <- just_seconds(interval)
	interval <- interval + interval * tol/100
	if (interval > 3600*24*365)
		return("year")
	if (interval > 3600*24*30)
		return("month")
	if (interval > 3600*24*7)
		return("week")
	if (interval > 3600*24)
		return("day")
	if (interval > 3600)
		return("hour")
	if (interval > 60)
		return("min")
	else
		return("sec")
}
		
pretty.length <- function(span, units, n){
	switch(units, 
		sec = pretty(1:span, n = n)[2],
		min = pretty(1:(span / 60), n = n)[2],
		hour = pretty(1:(span / 3600), n = n)[2],
		day = pretty(1:(span / (3600 * 24)), n = n)[2],
		week = pretty(1:(span / (3600 * 24 * 7)), n = n)[2],
		month = pretty(1:(span / (3600 * 24 * 30)), n = n)[2],
		year= pretty(1:(span / (3600 * 24 * 365)), n = n)[2])
}

pretty.point <- function(x, units, length){
	floors <- c("sec", "min", "hour", "day", "week", "month", "year")
	floorto <- floors[which(floors == units) + 1]
	below <- floor_date(x, floorto)
	
	names(length) <- units
	above <- below + do.call("new_duration", as.list(length))

	smaller <- difftime(x, below, "secs") < difftime(above, x, "secs")
	
	point <- structure(ifelse(smaller, below, above), class= class(x))
	as.POSIXct(point)
}