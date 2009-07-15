new_duration <- function (months, seconds){
  structure(data.frame(months, seconds), class = c("duration", "data.frame"))
}

as.duration <- function (x, ...) UseMethod("as.duration")

as.duration.data.frame <- function(x, ...) {
  stopifnot(identical(sort(colnames(x)), c("months", "seconds")))
  x <- structure(x, class = c("duration", "data.frame"))
  x
}

as.duration.difftime <- function(x, ...){
  new_duration(0, as.numeric(x, units = "secs"))
}

as.duration.default <- function(x, ...){
  message("Numeric coerced to seconds")
  new_duration(0,x)
}
as.duration.duration <- function(x, ...) {
  x
}

as.data.frame.duration <- function(x, optional = TRUE, ...) {
  stop("Currently, durations can not be stored in a data frame", 
    call. = FALSE)
}


c.duration <- function(...) {
  structure(do.call(rbind, list(...)), class = c("duration", "data.frame"))
}


seconds <- function(x = 1) new_duration(0, x)
minutes <- function(x = 1) seconds(x * 60)
hours <-   function(x = 1) minutes(x * 60)
days <-    function(x = 1) hours(x * 24)  
weeks <-   function(x = 1) days(x * 7)
months <-  function(x = 1) new_duration(x, 0)
years <-   function(x = 1) months(x * 12)

y <- years(1)
m <- months(1)
w <- weeks(7)
d <- days(1)


is.duration <- function(x) inherits(x, "duration")
is.POSIXt <- function(x) inherits(x, c("POSIXt", "POSIXct", "POSIXlt"))
is.difftime <- function(x) inherits(x, "difftime")

# for expanding arguments within operations

get_length <- function(x) {
  if(is.data.frame(x)) {
    nrow(x)
  } else {
    length(x)
  }
}
  
expand <- function(obj, sml, big){
  if (big %% sml != 0) 
    stop("longer object length is not a multiple of shorter object length", call. = F)
  seq <- rep(seq_len(sml), length = big)
    
  if (length(dim(obj)) == 2) {
    obj[seq, , drop = FALSE]
  } else {
    obj[seq]
  }
    
}

# adding 
"+.duration" <- "+.POSIXt" <- "+.difftime" <- function(e1, e2){
  # accounting for different lengths
  n1 <- get_length(e1)
  n2 <- get_length(e2)

  

  if (n1 < n2)
    e1 <- expand(e1, n1, n2)
  else if (n1 > n2)
    e2 <- expand(e2, n2, n1)
  
  if(!is.POSIXt(e1) && is.duration(e2)) e1 <- as.duration(e1)
  if(!is.POSIXt(e2) && is.duration(e1)) e2 <- as.duration(e2)
  if (is.duration(e1) && is.duration(e2)) 
    add_duration_to_duration(e1, e2)
  else if (is.duration(e1) && is.POSIXt(e2))
    add_duration_to_date(e2, e1)
  else if (is.duration(e2) && is.POSIXt(e1)) 
    add_duration_to_date(e1, e2)
  else if (is.POSIXt(e1) && is.POSIXt(e2))
    stop("binary '+' is not defined for \"POSIXt\" objects")
  else if (is.POSIXt(e1) || is.POSIXt(e2))
    base::'+.POSIXt'(e1,e2)
  else if (is.difftime(e1) && is.difftime(e2))
    make_difftime(as.duration(e1) + as.duration(e2))
  else if (is.difftime(e1)){
    e2 <- structure(e2, units = units(e1), class = "difftime")
    make_difftime(as.duration(e1) + e2)
  }
  else if (is.difftime(e2)){
    e1 <- structure(e1, units = units(e2), class = "difftime")
    make_difftime(as.duration(e2) + e1)
  }
  else 
    base::'+'(e1, e2)
  
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

make_difftime <- function (dur) {
  if (dur$months != 0)
    stop("difftime does not support non-uniform durations (months)")
    
  if (dur$seconds >= 0) seconds <- dur$seconds
  else seconds <- -dur$seconds
  
    if (seconds < 60) 
        units <- "secs"
    else if (seconds < 3600)
        units <- "mins"
    else if (seconds < 86400)
        units <- "hours"
    else units <- "days"
    
    switch(units, secs = structure(dur$seconds, units = "secs", class = "difftime"), 
    mins = structure(dur$seconds/60, units = "mins", class = "difftime"), 
    hours = structure(dur$seconds/3600, units = "hours", class = "difftime"), 
    days = structure(dur$seconds/86400, units = "days", class = "difftime"), 
    weeks = structure(dur$seconds/(7 * 86400), units = "weeks", class = "difftime"))
}


"*.duration" <- function(e1, e2){
    if (is.duration(e1) && is.duration(e2)) {
    NA
  } else if (is.duration(e1)){
    multiply_duration_by_numeric(e2, e1)
  } else if (is.duration(e2)) {
    multiply_duration_by_numeric(e1, e2)
  } else {
    base::'*'(e1, e2)
  }
}  

multiply_duration_by_numeric <- function(num, dur){
  as.duration(num * as.data.frame(dur))
}

"/.duration" <- function(e1, e2){
    if (is.duration(e1) && is.duration(e2)) {
    NA
  } else if (is.duration(e1)){
    divide_duration_by_numeric(e2, e1)
  } else if (is.duration(e2)) {
    divide_duration_by_numeric(e1, e2)
  } else {
    base::'*'(e1, e2)
  }
}  

divide_duration_by_numeric <- function(num, dur){
  as.duration(as.data.frame(dur)/num)
}



# subtracting 
"-.duration" <- "-.POSIXt" <- "-.difftime" <- function(e1, e2){
  # Deal with unary minus, e.g. -hours(1)
  if (missing(e2) && is.duration(e1)) {
    e1$seconds <- -e1$seconds
    e1$months <-  -e1$months
    return (e1)
  }
  if (missing(e2) && is.POSIXt(e1))
    stop("unary '-' is not defined for \"POSIXt\" objects")
  if (missing(e2) && is.difftime(e1))
    return(make_difftime(-as.duration(e1)))
  if (missing(e2)) return(base::'-'(e1))
  
  
  # accounting for different lengths
  n1 <- get_length(e1)
  n2 <- get_length(e2)
  if (n1 < n2)
    e1 <- expand(e1, n1, n2)
  else if (n1 > n2)
    e2 <- expand(e2, n2, n1)
  
  # subtraction
  if (!is.POSIXt(e1) && is.duration(e2)) e1 <- as.duration(e1)
  if (!is.POSIXt(e2) && is.duration(e1)) e2 <- as.duration(e2)
    if (is.duration(e1) && is.duration(e2))
      e1 + -e2
    else if (is.POSIXt(e1) && is.duration(e2))
      e1 + -e2
    else if (is.POSIXt(e1) && is.POSIXt(e2))
      as.duration(difftime(e1, e2))    
    else if (is.POSIXt(e2)) 
      stop("Can only subtract from POSIXt objects")
    else if (is.POSIXt(e1) && is.difftime(e2))
      e1 + -as.numeric(e2, units = "secs")
    else if (is.POSIXt(e1))
      structure(unclass(as.POSIXct(e1)) - e2, class = c("POSIXt", "POSIXct"))
    else if (is.difftime(e1) || is.difftime(e2))
      e1 + -e2
    else
      base::'-'(e1, e2)
}


# printing durations
print.duration <- function(x) {
  format_unit <- function(x, xsign, singular = NULL) {
    if (is.null(singular)) singular <- deparse(substitute(x))
    x <- x * sign(xsign)
    plural <- paste(singular, "s", sep = "")
    ifelse(x == 0, "", 
      paste(x, ifelse(!is.na(x) & x == 1, singular, plural)))
  }

  months <- abs(x$months)
  seconds <- abs(x$seconds)

  year <- months %/% 12
  month <- months %% 12
  
  week <- (seconds %/% 604800)
  day <- (seconds - week * 604800) %/% 86400
  hour <- (seconds - week * 604800 - day * 86400) %/% 3600
  minute <- (seconds - week * 604800 - day * 86400 - hour * 3600) %/% 60
  second <- seconds - week * 604800 - day * 86400 - hour * 3600 - minute * 60
  
  duration <- cbind(
    format_unit(year, x$month), 
    format_unit(month, x$month), 
    format_unit(week, x$seconds),
    format_unit(day, x$seconds),
    format_unit(hour, x$seconds), 
    format_unit(minute, x$seconds), 
    format_unit(second, x$seconds)
  )
  
  collapse <- function(x) {
    all <- x[x != ""]
    if (length(all) == 0) return("0 seconds")
    paste(all, collapse = ", ")
  }
  
  print(paste(aaply(duration, 1, collapse)))
}