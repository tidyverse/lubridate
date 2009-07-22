new_duration <- function(secs = 0, mins = 0, hours = 0, days = 0, weeks = 0, months = 0, years = 0){
	
	if( any(months - trunc(months) != 0))
		stop(paste("durations do not support partial months. Rewrite element(s)", paste(which(months - trunc(months) != 0), collapse = ", "), "in seconds. See 'duration' documentation.", sep = " "))
	if(any(years/12 - trunc(years/12) != 0))
		stop(paste("durations do not support partial months. Rewrite element(s)", paste(which(years/12 - trunc(years/12) != 0), collapse = ", "), "in seconds. See 'duration' documentation.", sep = " "))
	
	dur <- 500000000 + secs + mins * 60 + hours * 3600 + days * 86400 + weeks * 604800 
	
	if (dur >= 10^9 || dur < 0)
		stop("seconds overflow: see 'duration' documentation")
	
	dur <- dur + 10 ^ 9 * months + 12* 10 ^ 9 * years
	structure(dur, class = "duration")
}

as.duration <- function (x, ...) UseMethod("as.duration")

as.duration.difftime <- function(x, ...){
  new_duration(secs = as.numeric(x, units = "secs"))
}

as.duration.default <- function(x, ...){
  message("Numeric coerced to seconds")
  new_duration(secs = x)
}

as.duration.duration <- function(x, ...) {
  x
}

c.duration <- function(...) {
  structure(do.call(rbind, list(...)), class = "duration")
}

seconds <- function(x = 1) new_duration(x)
minutes <- function(x = 1) new_duration(mins = x)
hours <-   function(x = 1) new_duration(hours = x)
days <-    function(x = 1) new_duration(days = x)  
weeks <-   function(x = 1) new_duration(weeks = x)
months <-  function(x = 1) new_duration(months = x)
years <-   function(x = 1) new_duration(years = x)

y <- years(1)
m <- months(1)
w <- weeks(1)
d <- days(1)

is.duration <- function(x) inherits(x, "duration")
is.POSIXt <- function(x) inherits(x, c("POSIXt", "POSIXct", "POSIXlt"))
is.difftime <- function(x) inherits(x, "difftime")

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

	
