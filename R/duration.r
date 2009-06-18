new_duration <- function (months, seconds){
	structure(data.frame(months, seconds), class = c("duration", "data.frame"))
}

seconds <- function(x = 1) new_duration(0, x)
minutes <- function(x = 1) seconds(x * 60)
hours <-   function(x = 1) minutes(x * 60)
days <-    function(x = 1) hours(x * 24)	
weeks <-   function(x = 1) days(x * 7)
months <-  function(x = 1) new_duration(x, 0)
years <-   function(x = 1) months(x * 12)

is.duration <- function(x) inherits(x, "duration")

# adding 
"+.duration" <- "+.POSIXt" <- function(e1, e2){
  if (is.duration(e1) && is.duration(e2)) {
    add_duration_to_duration(e1, e2)
  } else if (is.duration(e1)){
		add_duration_to_date(e2, e1)
	} else if (is.duration(e2)) {
		add_duration_to_date(e1, e2)
	} else {
		base::'+.POSIXt'(e1, e2)
	}
}	

add_duration_to_date <- function(date, dur) {
	second(date) <- second(date) + dur$seconds
	month(date) <- month(date) + dur$months
	date
}

add_duration_to_duration <- function(dur1, dur2) {
  dur1$seconds <- dur1$seconds + dur2$seconds
  dur1$months <- dur1$months + dur2$months
  dur1
}

# TODO: Need multiplication methods for duration that preserve class.

# subtracting 
"-.duration" <- "-.POSIXt" <- function(e1, e2){
  # Deal with unary minus, e.g. -hours(1)
  if (missing(e2) && is.duration(e1)) {
    e1$seconds <- -e1$seconds
    e1$months <-  -e1$months
    return(e1)
  }
  
	e1 + -e2
}

# TODO: This function should convert months into years if > 12, and 
# similarly should convert seconds into weeks, days, hours and minutes.
print.duration <- function(x, ...) {
  cat("Duration: ", x$months, " months and ", x$seconds, " seconds\n", sep ="")
}
