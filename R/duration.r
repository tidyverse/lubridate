# Is this necessary for S3 objects?
# setClass("duration",
#	representation(seconds = "numeric", months = "numeric"),
#	)
	
seconds <- function(x = 1) {
	dur <- c(seconds = x * 1, months = 0)
	class(dur) <- "duration"
	dur
	}
	
minutes <- function(x = 1) {
	dur <- c(seconds = x * 60, months = 0)
	class(dur) <- "duration"
	dur
	}
	
hours <- function(x = 1) {
	dur <- c(seconds = x * 3600, months = 0)
	class(dur) <- "duration"
	dur
	}
		
days <- function(x = 1) {
	dur <- c(seconds = x * 86400, months = 0)
	class(dur) <- "duration"
	dur
	}
	
weeks <- function(x = 1) {
	dur <- c(seconds = x * 604800, months = 0)
	class(dur) <- "duration"
	dur
	}
	
months <- function(x = 1) {
	dur <- c(seconds = 0, months = x * 1)
	class(dur) <- "duration"
	dur
	}
	
years <- function(x = 1) {
	dur <- c(seconds = 0, months = x * 12)
	class(dur) <- "duration"
	dur
	}
	
d <- days(1)
w <- weeks(1)
m <- months(1)
y <- years(1)


# handling months (for within 'x.POSIXt')
# note to self: length.out rounds up, [] rounds down
month_add <- function (a1, a2){
	if (a2 == 0){
		return(a1)
		}
	else if (a2 > 0){
			month_seq <- seq(a1, by = "month", length.out = a2 + 1)
		} else { # adding negative months (subtracting)
			a2 <- abs(a2)
			month_seq <- seq(a1, by = "-1 month", length.out = a2 + 1)
			}
			
			
	if (a2 %% trunc(a2) == 0){ #whole months
		month_seq[a2 + 1]
			
		} else { #partial months
			secs <- as.double(difftime(month_seq[a2 + 2], month_seq[a2 + 1], 
				units = "secs"))
			part <- a2 %% trunc(a2) * secs
			month_seq[a2 + 1] + part
			}
	}


# adding 
"+.POSIXt" <- function(e1, e2){
	if (inherits(e2, "duration")){
		
		# adding seconds
		withsec <- e1 + e2[1]
		
		#adding months
		unname(month_add(withsec, e2[2]))
		
		} else {
			base::'+.POSIXt'(e1, e2)
			}
	}		
		
# subtracting 
"-.POSIXt" <- function(e1, e2){
	'+.POSIXt'(e1, -1 * e2)
	}
			
		


