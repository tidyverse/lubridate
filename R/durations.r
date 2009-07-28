new_duration <- function(second = 0, minute = 0, hour = 0, day = 0, week = 0, month = 0, year = 0){
		
	dur1 <- 50000000000 + second + minute * 60 + hour * 3600 + day * 86400 + week * 604800 
	
	if (any(dur1 >= 10^11) || any(dur1 < 0))
		stop("seconds overflow: see 'duration' documentation")
	
	dur2 <- 10 ^ 11 * month + 12* 10 ^ 11 * year
	
	if (any(dur2 %% 10^11 != 0))
		stop("durations do not support partial months")
	
	structure(dur1 + dur2, class = "duration")
}

as.duration <- function (x, ...) UseMethod("as.duration")

as.duration.difftime <- function(x, ...){
  new_duration(second = as.numeric(x, units = "secs"))
}

as.duration.default <- function(x, ...){
  message("Numeric coerced to seconds")
  new_duration(second = x)
}

as.duration.duration <- function(x, ...) {
  x
}

as.POSIXt <- function(x) as.POSIXlt(x)

c.duration <- function(...) {
  structure(do.call(rbind, list(...)), class = "duration")
}

seconds <- function(x = 1) new_duration(x)
minutes <- function(x = 1) new_duration(minute = x)
hours <-   function(x = 1) new_duration(hour = x)
days <-    function(x = 1) new_duration(day = x)  
weeks <-   function(x = 1) new_duration(week = x)
months <-  function(x = 1) new_duration(month = x)
years <-   function(x = 1) new_duration(year = x)

y <- years(1)
m <- months(1)
w <- weeks(1)
d <- days(1)

is.timepoint <- function(x) inherits(x, c("POSIXt", "POSIXct", "POSIXlt", "Date"))
is.timeperiod <- function(x) inherits(x, c("duration", "difftime"))
is.duration <- function(x) inherits(x, "duration")
is.POSIXt <- function(x) inherits(x, c("POSIXt", "POSIXct", "POSIXlt"))
is.difftime <- function(x) inherits(x, "difftime")
is.Date <- function(x) inherits(x, "Date")

as.data.frame.duration <- function (x, row.names = NULL, optional = FALSE, ..., nm = paste(deparse(substitute(x), 
    width.cutoff = 500L), collapse = " ")) 
{
    force(nm)
    nrows <- length(x)
    if (is.null(row.names)) {
        if (nrows == 0L) 
            row.names <- character(0L)
        else if (length(row.names <- names(x)) == nrows && !any(duplicated(row.names))) {
        }
        else row.names <- .set_row_names(nrows)
    }
    names(x) <- NULL
    value <- list(x)
    if (!optional) 
        names(value) <- nm
    attr(value, "row.names") <- row.names
    class(value) <- "data.frame"
    value
}

	
