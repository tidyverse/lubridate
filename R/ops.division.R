divide_difftime_by_duration <- function(dif, dur)
	as.numeric(dif, units = "secs") / as.numeric(dur)

divide_difftime_by_interval <- function(dif, int)
	as.numeric(dif, units = "secs") / as.numeric(int)

divide_difftime_by_period <- function(dif, per)
	as.numeric(dif, units = "secs") / as.numeric(as.duration(per))
	
divide_difftime_by_number <- function(e1, e2)
    .difftime(unclass(e1)/e2, attr(e1, "units"))



divide_duration_by_difftime <- function(dur, diff)
	as.numeric(dur) / as.numeric(diff, units = "secs")

divide_duration_by_duration <- function(dur1, dur2)
	as.numeric(dur1) / as.numeric(dur2)
	
divide_duration_by_interval <- function(dur, int)
	as.numeric(dur) / as.numeric(int)

divide_duration_by_number <- function(dur, num)
	new_duration(as.numeric(dur) / num)

divide_duration_by_period <- function(dur, per)
	as.numeric(dur) / as.numeric(as.duration(per))


divide_interval_by_difftime <- function(int, diff){
	as.numeric(unclass(int) / as.double(diff, units = "secs"))
}

divide_interval_by_duration <- function(int, dur){
	as.numeric(unclass(int) / unclass(dur))
}

divide_interval_by_interval <- function(int, int2){
	message("interval denominator coerced to duration")
	as.numeric(unclass(int) / unclass(int2))
}

divide_interval_by_number <- function(int, num){
	start <- attr(int, "start")
	span <- as.duration(int) / num
	
	new_interval(start + span, start)
}

equalize_length <- function(x, y){
	n.x <- length(x)
	n.y <- nrow(y) 
	n.max <- max(n.x, n.y)
	n.min <- min(n.x, n.y)
	if (n.max %% n.min != 0L){
		stop("longer object length is not a multiple of shorter object length")
	} else {
		if (n.x < n.y) {
			x <- rep(x, length.out = n.y)
		} else {
			y <- rep(y, length.out = n.x)
		}	
	}
	list(x, y)
}

divide_interval_by_period <- function(int, per){
	
	message("estimate only: convert periods to intervals for accuracy")
	equals <- equalize_length(int, per)
	int <- equals[[1]]
	per <- equals[[2]]
	
	paired.up <- data.frame(interval = int, per, row = seq_along(int))

	
	division_engine <- function(df){
		int <- df$int
		per <- structure(df[,2:7], class = c("period", "data.frame"))
	
		start <- attr(int, "start")
		end <- start + unclass(int)
	
		# sign of period shouldn't affect answer
		per <- abs(per)
	
		# duration division should give good approximation
		dur <- suppressMessages(as.duration(per))
		estimate <- trunc(as.numeric(int) / as.numeric(dur))
	
		# did we overshoot or undershoot?
		try1 <- start + per * estimate
		miss <- as.numeric(end) - as.numeric(try1)
	
		# adjust estimate until satisfactory
		n <- 0
		if (miss == 0) {
			return(estimate)
		} else if (miss > 0) {
			while (try1 + n * per <= end)
				n <- n + 1
			# because the last one went too far	
			return(estimate + (n - 1)) 
		} else {
			while (try1 - n * per >= end)
				n <- n + 1
			# because the last one went too far	
			return(estimate - (n - 1))
		}
	}
	
	unlist(ddply(paired.up, "row", division_engine)[,2])	
}


divide_period_by_difftime <- function(per, diff){
	as.numeric(as.duration(per)) / as.numeric(diff, units = "secs")
}


divide_period_by_duration <- function(per, dur){
	as.numeric(as.duration(per)) / as.numeric(dur)
}

divide_period_by_interval <- function(per, int){
	as.numeric(as.duration(per)) / as.numeric(int)
}

divide_period_by_number <- function(per, num){
  new_period(
    year = per$year / num,
    month = per$month / num,
    day = per$day / num,
    hour = per$hour / num,
    minute = per$minute / num,
    second = per$second / num
  )
}

divide_period_by_period <- function(per1, per2){
	suppressMessages(as.duration(per1)) / as.duration(per2)
}

remainder_period_into_interval <- function(per, int){
	integ <- int / per
	int2 <- new_interval(int_start(int) + integ * per, int_end(int))
	as.period(int2)
}





setMethod("/", signature(e1 = "Interval", e2 = "Interval"), function {
	message("interval denominator coerced to duration")
	e2 <- as.duration(e2)
	divide_interval_by_duration(e1, e2)
})
	
setMethod("/", signature(e1 = "Interval", e2 = "Duration"), 
	divide_interval_by_duration(e1, e2))	
	
setMethod("/", signature(e1 = "Interval", e2 = "Period"), 
	divide_interval_by_period(e1, e2))
		
setMethod("/", signature(e1 = "Interval", e2 = "difftime"), 
	divide_interval_by_difftime(e1, e2))
	
setMethod("/", signature(e1 = "Interval", e2 = "numeric"), 
	divide_interval_by_number(e1, e2))


setMethod("/", signature(e1 = "Duration", e2 = "Interval"), function {
	message("interval denominator coerced to duration")
	e2 <- as.duration(e2)
	divide_duration_by_duration(e1, e2)
})

setMethod("/", signature(e1 = "Duration", e2 = "Duration"),
	divide_duration_by_duration(e1, e2))

setMethod("/", signature(e1 = "Duration", e2 = "Period"),
	divide_duration_by_period(e1, e2))
		
setMethod("/", signature(e1 = "Duration", e2 = "difftime"),
	divide_duration_by_difftime(e1, e2))

setMethod("/", signature(e1 = "Duration", e2 = "numeric"),	
	divide_duration_by_number(e1, e2))
	



setMethod("/", signature(e1 = "Period", e2 = "Interval"), function {
	message("interval denominator coerced to duration")
	e2 <- as.duration(e2)
	divide_period_by_duration(e1, e2)
})	

setMethod("/", signature(e1 = "Period", e2 = "Duration"),
	divide_period_by_duration(e1, e2))

setMethod("/", signature(e1 = "Period", e2 = "Period"),
	divide_period_by_period(e1, e2))
		
setMethod("/", signature(e1 = "Period", e2 = "difftime"),
	divide_period_by_difftime(e1, e2))
	
setMethod("/", signature(e1 = "Period", e2 = "numeric"),
	divide_period_by_number(e1, e2))



setMethod("/", signature(e1 = "difftime", e2 = "Interval"), function {
	message("interval denominator coerced to duration")
	e2 <- as.duration(e2)
	divide_difftime_by_duration(e1, e2)
})		

setMethod("/", signature(e1 = "difftime", e2 = "Duration"),
	divide_difftime_by_duration(e1, e2))

setMethod("/", signature(e1 = "difftime", e2 = "Period"),
	divide_difftime_by_period(e1, e2))
