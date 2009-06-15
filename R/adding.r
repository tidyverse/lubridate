# Add components to a date
# -----------------------------------------------------------
# a duration is a fixed number of seconds
# a period is a recognized unit of time of varying length (i.e. months)


# Dates should first be converted to POSIXct with parse.r
seconds <- function(x = 1) {
	dur <- x * 1
	class(dur) <- "duration"
	dur
	}
	
minutes <- function(x = 1) {
	dur <- x * 60
	class(dur) <- "duration"
	dur
	}
	
hours <- function(x = 1) {
	dur <- x * 3600
	class(dur) <- "duration"
	dur
	}
		
days <- function(x = 1) {
	dur <- x * 86400
	class(dur) <- "duration"
	dur
	}
	
weeks <- function(x = 1) {
	dur <- x * 604800
	class(dur) <- "duration"
	dur
	}
	
months <- function(x = 1) {
	per <- x * 1
	class(per) <- "period"
	per
	}
	
years <- function(x = 1) {
	per <- x * 12
	class(per) <- "period"
	per
	}

d <- days(1)
w <- weeks(1)
m <- months(1)
y <- years(1)
	
# creating new adding function
"+.Date" <- function(e1, e2){
	if inherits(e2, "duration"){
		if (e2 %% floor(e2) == 0){ #whole periods
			seq(e1, by = "month", length.out = e2)[e2]
			} else{ # partial periods
				e1 + floor(e2)) + e2 %% floor(e2) * ((e1 + floor(e2)) - (e1 + ceiling(e2)))
				}
		} else {
			base::'+.Date'(e1, e2)
			}
	}

