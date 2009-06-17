# Is this necessary for S3 objects?
#setClass("duration",
#	representation(months = "numeric", seconds = "numeric"),
#)

new_duration <- function (months, seconds){
	structure(data.frame(months, seconds), class = c("duration", "data.frame"))
}

seconds <- function(x = 1) new_duration(0, x)
minutes <- function(x = 1) seconds(x * 60)
hours <- function(x = 1) minutes(x * 60)
days <- function(x = 1) hours(x * 24)	
weeks <- function(x = 1) days(x * 7)
	
months <- function(x = 1) new_duration(x, 0)
years <- function(x = 1) months(x * 12)
	
d <- days(1)
w <- weeks(1)
m <- months(1)
y <- years(1)


# handling months (for within 'x.POSIXt')
# note to self: length.out rounds up, [] rounds down


# adding 
"+.POSIXt" <- function(e1, e2){
	if (inherits(e2, "duration")){
		
		second(e1) <- second(e1) + e2$seconds
		month(e1) <- month(e1) + e2$months
		e1
		
	} else {
		base::'+.POSIXt'(e1, e2)
	}
}	

		
# subtracting 
"-.POSIXt" <- function(e1, e2){
	'+.POSIXt'(e1, -1 * e2)
}
			
		


