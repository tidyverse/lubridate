#' @include timespans.r
NULL


check_interval <- function(object){
	errors <- character()
	if (!is.numeric(object@.Data)) {
		msg <- "Span length must be numeric."
		errors <- c(errors, msg)
	}
	if (!is(object@start, "POSIXct")) {
		msg <- "Start date must be in POSIXct format."
		errors <- c(errors, msg)
	}
	if (length(object@.Data) != length(object@start)) {
		msg <- paste("Inconsistent lengths: spans = ", length(object@.Data),
			", start dates = ", length(object@start), sep = "")
		errors <- c(errors, msg)
	}
	if (length(errors) == 0)
		TRUE
	else
		errors
}

.units_within_seconds <- function(secs, unit = "second"){
  ## return a list suitable to pass to new("Period", ...)
  switch(unit,
         second = list(secs),
         minute = list(secs %% 60, minute = secs %/% 60),
         hour =
           c(.units_within_seconds(secs %% 3600, "minute"),
             list(hour = secs %/% 3600)),
         day =
           c(.units_within_seconds(secs %% 86400, "hour"),
             list(day = secs %/% 86400)),
         stop("Unsuported unit ", unit))
}


#' Interval class
#'
#' Interval is an S4 class that extends the \code{\link{Timespan-class}} class. An
#' Interval object records one or more spans of time. Intervals record these
#' timespans as a sequence of seconds that begin at a specified date. Since
#' intervals are anchored to a precise moment of time, they can accurately be
#' converted to \code{\link{Period-class}} or \code{\link{Duration-class}} class objects. This
#' is because we can observe the length in seconds of each period that begins on a
#' specific date. Contrast this to a generalized period, which may not have a
#' consistent length in seconds (e.g. the number of seconds in a year will change
#' if it is a leap year).
#'
#' Intervals can be both negative and positive. Negative intervals progress
#' backwards from the start date; positive intervals progress forwards.
#'
#' Interval class objects have two slots: .Data, a numeric object equal to the number
#' of seconds in the interval; and start, a POSIXct object that specifies the time
#' when the interval starts.
#'
#'
#' @name Interval-class
#' @rdname Interval-class
#' @exportClass Interval
#' @aliases intersect,Interval,Interval-method union,Interval,Interval-method
#' setdiff,Interval,Interval-method as.numeric,Interval-method
#' show,Interval-method c,Interval-method rep,Interval-method [,Interval-method
#' [<-,Interval,ANY,ANY,ANY-method [[,Interval-method
#' [[<-,Interval,ANY,ANY,ANY-method $,Interval-method $<-,Interval-method
#' as.difftime,Interval-method as.character,Interval-method
#' +,Interval,Duration-method +,Interval,Interval-method
#' +,Interval,Period-method +,Interval,Date-method +,Date,Interval-method
#' +,Interval,difftime-method +,difftime,Interval-method
#' +,Interval,numeric-method +,numeric,Interval-method +,Interval,POSIXct-method
#' +,POSIXct,Interval-method +,Interval,POSIXlt-method +,POSIXlt,Interval-method
#' /,Interval,Duration-method /,Interval,Interval-method
#' /,Interval,Period-method /,Interval,difftime-method
#' /,difftime,Interval-method /,Interval,numeric-method
#' /,numeric,Interval-method *,Interval,ANY-method *,ANY,Interval-method
#' -,Interval,missing-method -,Interval,Interval-method -,Date,Interval-method
#' -,POSIXct,Interval-method -,POSIXlt,Interval-method -,numeric,Interval-method
#' -,Interval,Date-method -,Interval,POSIXct-method -,Interval,POSIXlt-method
#' -,Interval,numeric-method -,Duration,Interval-method -,Period,Interval-method
#' %%,Interval,Duration-method %%,Interval,Interval-method
#' %%,Interval,Period-method %%,Interval,Duration %%,Interval,Interval
#' %%,Interval,Period -,Date,Interval -,Duration,Interval -,Interval,Date
#' -,Interval,Interval -,Interval,POSIXct -,Interval,POSIXlt -,Interval,numeric
#' -,POSIXct,Interval -,POSIXlt,Interval -,numeric,Interval
setClass("Interval", contains = c("Timespan", "numeric"),
  slots = c(start = "POSIXct", 	tzone = "character"), validity = check_interval)

#' @export
setMethod("show", signature(object = "Interval"), function(object){
	print(format.Interval(object), quote = F)
})

#' @export
format.Interval <- function(x,...){
  if (length(x@.Data) == 0) return("Interval(0)")
	paste(format(x@start, tz = x@tzone, usetz = TRUE), "--",
		format(x@start + x@.Data, tz = x@tzone, usetz = TRUE), sep = "")
}

#' @export
setMethod("c", signature(x = "Interval"), function(x, ...){
  elements <- lapply(list(...), as.interval)
	spans <- c(x@.Data, unlist(elements@.Data))
	starts <- c(x@start, lapply(elements, int_start))
	new("Interval", spans, start = starts, tzone = x@tzone)
})

#' @export
setMethod("rep", signature(x = "Interval"), function(x, ...){
	new("Interval", rep(x@.Data, ...), start = rep(x@start,...), tzone = x@tzone)
})

#' @export
setMethod("[", signature(x = "Interval"),
	function(x, i, j, ..., drop = TRUE) {
    	new("Interval", x@.Data[i], start = x@start[i], tzone = x@tzone)
	}
)

#' @export
setMethod("[[", signature(x = "Interval"),
  function(x, i, j, ..., exact = TRUE) {
    new("Interval", x@.Data[i], start = x@start[i], tzone = x@tzone)
  }
)

#' @export
setMethod("[<-", signature(x = "Interval"), function(x, i, j, ..., value) {
  	if (is.interval(value)){
  		x@.Data[i] <- value@.Data
  		x@start[i] <- value@start
  		new("Interval", x@.Data, start = x@start, tzone = x@tzone)
  	}
  	else {
  		x@.Data[i] <- value
		new("Interval", x@.Data, start = x@start, tzone = x@tzone)
	}
})

#' @export
setMethod("[[<-", signature(x = "Interval"), function(x, i, j, ..., value) {
  if (is.interval(value)){
    x@.Data[i] <- value@.Data
    x@start[i] <- value@start
    new("Interval", x@.Data, start = x@start, tzone = x@tzone)
  }
  else {
    x@.Data[i] <- value
    new("Interval", x@.Data, start = x@start, tzone = x@tzone)
  }
})


#' @export
setMethod("$", signature(x = "Interval"), function(x, name) {
	if(name == "span") name <- ".Data"
	slot(x, name)
})

#' @export
setMethod("$<-", signature(x = "Interval"), function(x, name, value) {
	if(name == "span") name <- ".Data"
	slot(x, name) <- value
	x
})

#' @export
unique.Interval <- function(x, ...){
  df <- unique.data.frame(data.frame(data = x@.Data, start = x@start), ...)
  new("Interval", df$data, start = df$start, tzone = x@tzone)
}

#' Create an \code{interval} object.
#'
#' interval creates an \code{\link{Interval-class}} object with the specified start and end
#' dates. If the start date occurs before the end date, the interval will be positive.
#' Otherwise, it will be negative.
#'
#' Intervals are time spans bound by two real date-times.  Intervals can be
#' accurately converted to either period or duration objects using
#' \code{\link{as.period}}, \code{\link{as.duration}}. Since an interval is
#' anchored to a fixed history of time, both the exact number of seconds that passed
#' and the number of variable length time units that occurred during the interval can be
#' calculated.
#'
#' \code{\%--\%} Creates an interval that covers the range spanned
#' by two dates. It replaces the
#' original behavior of lubridate, which created an interval by default whenever
#' two date-times were subtracted.
#'
#' @export
#' @aliases interval is.interval %--%
#' @param start a POSIXt or Date date-time object
#' @param end a POSIXt or Date date-time object
#' @param tzone a recognized timezone to display the interval in
#' @param x an R object
#' @return an Interval object
#' @seealso \code{\link{Interval-class}}, \code{\link{as.interval}}
#' @examples
#' interval(ymd(20090201), ymd(20090101))
#' # 2009-02-01 UTC--2009-01-01 UTC
#'
#' date1 <- as.POSIXct("2009-03-08 01:59:59")
#' date2 <- as.POSIXct("2000-02-29 12:00:00")
#' interval(date2, date1)
#' # 2000-02-29 12:00:00 CST--2009-03-08 01:59:59 CST
#' interval(date1, date2)
#' # 2009-03-08 01:59:59 CST--2000-02-29 12:00:00 CST
#' span <- interval(ymd(20090101), ymd(20090201))
#' # 2009-01-01 UTC--2009-02-01 UTC
#'
#' is.interval(period(months= 1, days = 15)) # FALSE
#' is.interval(interval(ymd(20090801), ymd(20090809))) # TRUE
interval <- function(start, end, tzone = attr(start, "tzone")){
  if (is.null(tzone)) {
		tzone <-
      if (is.null(attr(end, "tzone"))) "UTC"
      else attr(end, "tzone")
	}

	if (is.Date(start)) start <- with_tz(as.POSIXct(start), "UTC")
	if (is.Date(end)) end <- with_tz(as.POSIXct(end), "UTC")

  if (!is.POSIXct(start)) start <- as.POSIXct(start, tz = tzone)
	if (!is.POSIXct(end)) end <- as.POSIXct(end, tz = tzone)

	span <- as.numeric(end) - as.numeric(start)
	starts <- start + rep(0, length(span))
	if (tzone != tz(starts)) starts <- with_tz(starts, tzone)

	new("Interval", span, start = starts, tzone = tzone)
}

#' @export
"%--%" <- function(start, end) interval(start, end)

#' @rdname interval
#' @export
is.interval <- function(x) is(x, c("Interval"))


#' Access and change the start date of an interval
#'
#' Note that changing the start date of an interval will change the length of
#' the interval, since the end date will remain the same.
#'
#' @aliases int_start int_start<-
#' @export int_start "int_start<-"
#' @param int An interval object
#' @return A POSIXct date object when used as an accessor. Nothing when used as a settor
#' @seealso \code{\link{int_end}}, \code{\link{int_shift}}, \code{\link{int_flip}},
#' \code{\link{int_length}}
#' @examples
#' int <- interval(ymd("2001-01-01"), ymd("2002-01-01"))
#' # 2001-01-01 UTC--2002-01-01 UTC
#' int_start(int)
#' # "2001-01-01 UTC"
#' int_start(int) <- ymd("2001-06-01")
#' int
#' # 2001-06-01 UTC--2002-01-01 UTC
int_start <- function(int) int@start

"int_start<-" <- function(int, value){
	value <- as.POSIXct(value)
	span <- as.numeric(int@start + int@.Data - value, "secs")
	equal.lengths <- data.frame(span, value)
	int <- new("Interval", span, start = equal.lengths$value,
		tzone = int@tzone)

}

#' Access and change the end date of an interval
#'
#' Note that changing the end date of an interval will change the length of
#' the interval, since the start date will remain the same.
#'
#' @aliases int_end int_end<-
#' @export int_end "int_end<-"
#' @param int An interval object
#' @return A POSIXct date object when used as an accessor. Nothing when used as a settor
#' @seealso \code{\link{int_start}}, \code{\link{int_shift}}, \code{\link{int_flip}},
#' \code{\link{int_length}}
#' @examples
#' int <- interval(ymd("2001-01-01"), ymd("2002-01-01"))
#' # 2001-01-01 UTC--2002-01-01 UTC
#' int_end(int)
#' # "2002-01-01 UTC"
#' int_end(int) <- ymd("2002-06-01")
#' int
#' # 2001-01-01 UTC--2002-06-01 UTC
int_end <- function(int) int@start + int@.Data

"int_end<-" <- function(int, value){
	value <- as.POSIXct(value)
	span <- as.numeric(value - int@start, "secs")
	int <- new("Interval", span, start = int@start,
		tzone = int@tzone)
}

#' Get the length of an interval in seconds
#'
#' @export int_length
#' @param int An interval object
#' @return numeric The length of the interval in seconds. A negative number connotes
#' a negative interval
#' @seealso \code{\link{int_start}}, \code{\link{int_shift}}, \code{\link{int_flip}}
#' @examples
#' int <- interval(ymd("2001-01-01"), ymd("2002-01-01"))
#' # 2001-01-01 UTC--2002-01-01 UTC
#' int_length(int)
#' # 31536000
int_length <- function(int) int@.Data

#' Flip the direction of an interval
#'
#' Reverses the order of the start date and end date in an interval. The
#' new interval takes place during the same timespan as the original interval,
#' but has the opposite direction.
#'
#' @export int_flip
#' @param int An interval object
#' @return An interval object
#' @seealso \code{\link{int_shift}},  \code{\link{int_start}}, \code{\link{int_end}},
#' \code{\link{int_length}}
#' @examples
#' int <- interval(ymd("2001-01-01"), ymd("2002-01-01"))
#' # 2001-01-01 UTC--2002-01-01 UTC
#' int_flip(int)
#' # 2002-01-01 UTC--2001-01-01 UTC
int_flip <- function(int){
	new("Interval", -int@.Data, start = int@start + int@.Data, tzone = int@tzone)
}

#' Shift an interval along the timeline
#'
#' Shifts the start and end dates of an interval up or down the timeline
#' by a specified amount. Note that this may change the exact length of the
#' interval if the interval is shifted by a Period object. Intervals shifted by a
#' Duration or difftime object will retain their exact length in seconds.
#'
#' @export int_shift
#' @param int An interval object
#' @param by A period or duration object
#' @return An interval object
#' @seealso \code{\link{int_flip}},  \code{\link{int_start}}, \code{\link{int_end}},
#' \code{\link{int_length}}
#' @examples
#' int <- interval(ymd("2001-01-01"), ymd("2002-01-01"))
#' # 2001-01-01 UTC--2002-01-01 UTC
#' int_shift(int, duration(days = 11))
#' # 2001-01-12 UTC--2002-01-12 UTC
#' int_shift(int, duration(hours = -1))
#' # 2000-12-31 23:00:00 UTC--2001-12-31 23:00:00 UTC
int_shift <- function(int, by){
	if(!is.timespan(by)) stop("by is not a recognized timespan object")
	if(is.interval(by)) stop("an interval cannot be shifted by another interval.
		Convert second interval to a period or duration.")
	interval(int@start + by, int_end(int) + by)
}


#' Test if two intervals overlap
#'
#' @export "int_overlaps"
#' @param int1 an Interval object
#' @param int2 an Interval object
#' @return Logical. TRUE if int1 and int2 overlap by at least one second. FALSE otherwise.
#' @examples
#' int1 <- interval(ymd("2001-01-01"), ymd("2002-01-01"))
#' # 2001-01-01 UTC--2002-01-01 UTC
#' int2 <- interval(ymd("2001-06-01"), ymd("2002-06-01"))
#' # 2001-06-01 UTC--2002-06-01 UTC
#' int3 <- interval(ymd("2003-01-01"), ymd("2004-01-01"))
#' # 2003-01-01 UTC--2004-01-01 UTC
#'
#' int_overlaps(int1, int2) # TRUE
#' int_overlaps(int1, int3) # FALSE
int_overlaps <- function(int1, int2){
	stopifnot(c(is.interval(int1), is.interval(int2)))
  int1 <- int_standardize(int1)
  int2 <- int_standardize(int2)
	int1@start <= int2@start + int2@.Data & int2@start <= int1@start + int1@.Data
}

#' Ensures all intervals in an interval object are positive
#'
#' If an interval is not positive, int_standardize flips it so that it
#' retains its endpoints but becomes positive.
#'
#' @export "int_standardize"
#' @param int an Interval object
#' @examples
#' int <- interval(ymd("2002-01-01"), ymd("2001-01-01"))
#' # 2002-01-01 UTC--2001-01-01 UTC
#' int_standardize(int)
#' # 2001-01-01 UTC--2002-01-01 UTC
int_standardize <- function(int){
  negs <- !is.na(int@.Data) & int@.Data < 0
  int[negs] <- int_flip(int[negs])
	int
}


#' Test if two intervals share an endpoint
#'
#' int_aligns tests for the case where two intervals begin or end at the same
#' moment when arranged chronologically. The direction of each interval is ignored.
#' int_align tests whether the earliest or latest moments of each interval occur at
#' the same time.
#'
#' @export "int_aligns"
#' @param int1 an Interval object
#' @param int2 an Interval object
#' @return Logical. TRUE if int1 and int2 begin or end on the same moment. FALSE otherwise.
#' @examples
#' int1 <- interval(ymd("2001-01-01"), ymd("2002-01-01"))
#' # 2001-01-01 UTC--2002-01-01 UTC
#' int2 <- interval(ymd("2001-06-01"), ymd("2002-01-01"))
#' # 2001-06-01 UTC--2002-01-01 UTC
#' int3 <- interval(ymd("2003-01-01"), ymd("2004-01-01"))
#' # 2003-01-01 UTC--2004-01-01 UTC
#'
#' int_aligns(int1, int2) # TRUE
#' int_aligns(int1, int3) # FALSE
int_aligns <- function(int1, int2){
	int1 <- int_standardize(int1)
	int2 <- int_standardize(int2)

	int1@start == int2@start | (int1@start + int1@.Data) == (int2@start + int2@.Data)
}

#' Extract the intervals within a vector of date-times
#'
#' int_diff returns the intervals that occur between the elements of a vector of
#'date-times. int_diff is similar to the POSIXt and Date methods of
#' \code{\link{diff}}, but returns an interval object instead of a difftime object.
#'
#' @export "int_diff"
#' @param times A vector of POSIXct, POSIXlt or Date class date-times
#' @return An interval object that contains the n-1 intervals between the n date-time in times
#' @examples
#' dates <- now() + days(1:10)
#' int_diff(dates)
int_diff <- function(times){
  interval(times[-length(times)], times[-1])
}

#' @export
setGeneric("intersect")

#' @export
setMethod("intersect", signature(x = "Interval", y = "Interval"), function(x,y){
	int1 <- int_standardize(x)
	int2 <- int_standardize(y)

  starts <- pmax(int1@start, int2@start)
	ends <- pmin(int1@start + int1@.Data, int2@start + int2@.Data)
	spans <- as.numeric(ends) - as.numeric(starts)

	no.int <- ends < starts
	spans[no.int] <- NA
	starts[no.int] <- NA

	new.int <- new("Interval", spans, start = starts, tzone = x@tzone)
  new.int[sign(x@.Data) == -1] <- int_flip(new.int[sign(x@.Data) == -1])
  new.int
})

#' @export
setGeneric("union")

#' @export
setMethod("union", signature(x = "Interval", y = "Interval"), function(x,y){
	int1 <- int_standardize(x)
	int2 <- int_standardize(y)

	starts <- pmin(int1@start, int2@start)
	ends <- pmax(int1@start + int1@.Data, int2@start + int2@.Data)

	spans <- as.numeric(ends) - as.numeric(starts)

	if(any(!int_overlaps(int1, int2)))
		message("Union includes intervening time between intervals.")

	tz(starts) <- x@tzone
	new.int <- new("Interval", spans, start = starts, tzone = x@tzone)
	new.int[sign(x@.Data) == -1] <- int_flip(new.int[sign(x@.Data) == -1])
	new.int
})

#' @export
setGeneric("setdiff")

# returns the part of x that is not in y
#' @export
setMethod("setdiff", signature(x = "Interval", y = "Interval"), function(x,y){

  if (length(x) != length(y)) {
    xy <- match_lengths(x, y)
    x <- xy[[1]]
    y <- xy[[2]]
  }

  aligned <- int_aligns(x,y)
  inside <- y %within% x
  makes2 <- !aligned & inside

  if(sum(makes2)) {
		stop(paste("Cases", which(makes2),
			"result in discontinuous intervals."))
	}

	int1 <- int_standardize(x)
	int2 <- int_standardize(y)

	first.y <- int_start(int2)
	last.y <- int_end(int2)

	starts <- int_start(int1)

	starts[(last.y + 1) %within% int1] <- last.y[(last.y + 1) %within% int1]

	ends <- int_end(int1)
	ends[(first.y - 1) %within% int1] <- first.y[(first.y - 1) %within% int1]

	spans <- as.numeric(ends) - as.numeric(starts)

	new.int <- new("Interval", spans, start = starts, tzone = x@tzone)
	new.int[sign(x@.Data) == -1] <- int_flip(new.int[sign(x@.Data) == -1])
	new.int
})


#' Tests whether a date or interval falls within an interval
#'
#' %within% returns TRUE if a falls within interval b, FALSE otherwise.
#' If a is an interval, both its start and end dates must fall within b
#' to return TRUE.
#'
#' @export
#' @rdname within-interval
#' @usage a \%within\% b
#' @aliases %within%,Interval,Interval-method %within%,ANY,Interval-method
#' @param a An interval or date-time object
#' @param b An interval
#' @return A logical
#' @examples
#' int <- interval(ymd("2001-01-01"), ymd("2002-01-01"))
#' # 2001-01-01 UTC--2002-01-01 UTC
#' int2 <- interval(ymd("2001-06-01"), ymd("2002-01-01"))
#' # 2001-06-01 UTC--2002-01-01 UTC
#'
#' ymd("2001-05-03") %within% int # TRUE
#' int2 %within% int # TRUE
#' ymd("1999-01-01") %within% int # FALSE
"%within%" <- function(a,b) standardGeneric("%within%")

#' @export
setGeneric("%within%")

setMethod("%within%", signature(b = "Interval"), function(a,b){
	if(!is.instant(a)) stop("Argument 1 is not a recognized date-time")
	a <- as.POSIXct(a)
	as.numeric(a) - as.numeric(b@start) <= b@.Data & as.numeric(a) - as.numeric(b@start) >= 0
})

setMethod("%within%", signature(a = "Interval", b = "Interval"), function(a,b){
  a <- int_standardize(a)
  b <- int_standardize(b)
  start.in <- as.numeric(a@start) >= as.numeric(b@start)
	end.in <- (as.numeric(a@start) + a@.Data) <= (as.numeric(b@start) + b@.Data)
  start.in & end.in
})

#' @export
as.list.Interval <- function(x, ...){
  lapply(seq_along(x), function(i) x[[i]])
}

#' @export
summary.Interval <- function(object, ...) {
  nas <-is.na(object)
  object <- object[!nas]
  n <- length(object)
  dates <- c(int_start(object), int_end(object))
  earliest <- as.character(min(dates))
  latest <- as.character(max(dates))
  zone <- tz(dates)

  qq <- c(n, earliest, latest, zone)
  names(qq) <- c("Intervals", "Earliest endpoint", "Latest endpoint", "Time zone")
  if (any(nas))
    c(qq, `NA's` = sum(nas))
  else qq
}

#' @rdname time_length
setMethod("time_length", signature("Interval"), function(x, unit = "second") {
  unit <- standardise_period_names(unit)
  if (unit %in% c("year", "month")) {

    periods <- as.period(x, unit = unit)
    int_part <- slot(periods, unit)

    prev_aniv <- add_with_rollback(
      int_start(x), (int_part * period(1, units = unit)),
      roll_to_first = TRUE, preserve_hms = FALSE)
    next_aniv <- add_with_rollback(
      int_start(x), ((int_part + ifelse(x@.Data < 0, -1, 1)) * period(1, units = unit)),
      roll_to_first = TRUE, preserve_hms = FALSE)

    sofar <- as.duration(int_end(x) - prev_aniv)
    total <- as.duration(next_aniv - prev_aniv)
    int_part + sign(x@.Data) * sofar / total

  } else {
    as.duration(x) / duration(num = 1, units = unit)
  }
})
