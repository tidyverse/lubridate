#' Computes attractive axis breaks for date-time data
#'
#' pretty.dates indentifies which unit of time the sub-intervals should be 
#' measured in to provide approximately n breaks. It then chooses a "pretty" 
#' length for the sub-intervals and sets start and endpoints that 1) span the 
#' entire range of the data, and 2) allow the breaks to occur on important 
#' date-times (i.e. on the hour, on the first of the month, etc.)
#'
#' @param x a vector of POSIXct, POSIXlt, Date, or chron date-time objects
#' @param n integer value of the desired number of breaks
#' @param ... additional arguments to pass to function
#' @return a vector of date-times that can be used as axis tick marks or bin breaks
#' @keywords dplot utilities chron
#' @export pretty_dates pretty.unit pretty.sec pretty.min pretty.hour pretty.day pretty.month pretty.year pretty.point
#' @aliases pretty.dates pretty.unit pretty.sec pretty.min pretty.hour pretty.day pretty.month pretty.year pretty.point
#' @examples
#' x <- seq.Date(as.Date("2009-08-02"), by = "year", length.out = 2)
#' # "2009-08-02" "2010-08-02"
#' pretty_dates(x, 12)
#' ## [1] "2009-08-01 GMT" "2009-09-01 GMT" "2009-10-01 GMT" "2009-11-01 GMT" 
#' ## [5] "2009-12-01 GMT" "2010-01-01 GMT" "2010-02-01 GMT" "2010-03-01 GMT" 
#' ## [9] "2010-04-01 GMT" "2010-05-01 GMT" "2010-06-01 GMT" "2010-07-01 GMT" 
#' ## [13] "2010-08-01 GMT" "2010-09-01 GMT"
pretty_dates <- function(x, n, ...){
  remember <- Sys.getenv("TZ") 
  if (Sys.getenv("TZ") == "")
    remember <- "unset"
  Sys.setenv(TZ = tz(x[1]))
  rng <- range(x)
  diff <- as.duration(rng[2] - rng[1])
  diff <- as.double(diff, "secs") 
  
  binunits <- pretty.unit(diff/n)
  
  f <- match.fun(paste("pretty", binunits, sep = "."))
  binlength <- f(diff, n)
  
  start <- pretty.point(min(rng), binunits, binlength)
  end <- pretty.point(max(rng), binunits, binlength, start = FALSE)
  
  
  breaks <- seq.POSIXt(start, end, paste(binlength, binunits)) 
  if (remember == "unset")
    Sys.unsetenv("TZ")
  else 
    Sys.setenv(TZ = remember)
  breaks
}
  
  
pretty.unit <- function(x, ...){
  if (x > 3600*24*365)
    return("year")
  if (x > 3600*24*30)
    return("month")
  if (x > 3600*24)
    return("day")
  if (x > 3600)
    return("hour")
  if (x > 60)
    return("min")
  else
    return("sec")
}

pretty.sec <- function(x, n, ...){
  lengths <- c(1,2,5,10,15,30,60)
  fit <- abs(x - lengths*n)
  lengths[which.min(fit)]
}

pretty.min <- function(x, n, ...){
  span <- x/60
  lengths <- c(1,2,5,10,15,30,60)
  fit <- abs(span - lengths*n)
  lengths[which.min(fit)]
}

pretty.hour <- function(x, n, ...){
  span <- x / 3600
  lengths <- c(1,2,3,4,6,8,12,24)
  fit <- abs(span - lengths*n)
  lengths[which.min(fit)]
}

pretty.day <- function(x, n, ...){
  span <- x / (3600 * 24)
  pretty(1:span, n = n)[2]
}

pretty.month <- function(x, n, ...){
  span <- x / (3600 * 24 * 30)
  lengths <- c(1,2,3,4,6,12)
  fit <- abs(span - lengths*n)
  lengths[which.min(fit)]
}
  
pretty.year <- function(x, n, ...){
  span <- x / (3600 * 24 * 365)
  pretty(1:span, n = n)[2]
}

pretty.point <- function(x, units, length, start = TRUE, ...){
  x <- as.POSIXct(x)
  
  floors <- c("sec", "min", "hour", "day", "d", "month", "year", "y")
  floorto <- floors[which(floors == units) + 1]
  lower <- floor_date(x, floorto)
  upper <- ceiling_date(x, floorto)
  
  points <- seq.POSIXt(lower, upper, paste(length, units))
  
  if (start)
    points <- points[points <= x]

  else
    points <- points[points >= x]
    
  fit <- as.duration(x - points)  
  fit <- abs(as.double(fit, "secs"))
  return(points[which.min(fit)])
  
}
