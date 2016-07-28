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
#' @export
#' @examples
#' x <- seq.Date(as.Date("2009-08-02"), by = "year", length.out = 2)
#' # "2009-08-02" "2010-08-02"
#' pretty_dates(x, 12)
#' ## [1] "2009-08-01 GMT" "2009-09-01 GMT" "2009-10-01 GMT" "2009-11-01 GMT"
#' ## [5] "2009-12-01 GMT" "2010-01-01 GMT" "2010-02-01 GMT" "2010-03-01 GMT"
#' ## [9] "2010-04-01 GMT" "2010-05-01 GMT" "2010-06-01 GMT" "2010-07-01 GMT"
#' ## [13] "2010-08-01 GMT" "2010-09-01 GMT"
pretty_dates <- function(x, n, ...){
  otz <- Sys.getenv("TZ")
  if (Sys.getenv("TZ") == "") otz <- "unset"
  Sys.setenv(TZ = tz(x[1]))
  on.exit(if (otz == "unset") Sys.unsetenv("TZ")
          else  Sys.setenv(TZ = otz))

  rng <- range(x)
  diff <- difftime(rng[2], rng[1], units = "secs")

  binunits <- pretty.unit(diff/n)

  f <- match.fun(paste("pretty", binunits, sep = "."))
  binlength <- f(diff, n)

  start <- pretty.point(min(rng), binunits, binlength)
  end <- pretty.point(max(rng), binunits, binlength, start = FALSE)


  breaks <- seq.POSIXt(start, end, paste(binlength, binunits))
  breaks
}

#' @export
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

#' @export
pretty.sec <- function(x, n, ...){
  lengths <- c(1,2,5,10,15,30,60)
  fit <- abs(x - lengths*n)
  lengths[which.min(fit)]
}

#' @export
pretty.min <- function(x, n, ...){
  span <- x/60
  lengths <- c(1,2,5,10,15,30,60)
  fit <- abs(span - lengths*n)
  lengths[which.min(fit)]
}

#' @export
pretty.hour <- function(x, n, ...){
  span <- x / 3600
  lengths <- c(1,2,3,4,6,8,12,24)
  fit <- abs(span - lengths*n)
  lengths[which.min(fit)]
}

#' @export
pretty.day <- function(x, n, ...){
  span <- x / (3600 * 24)
  pretty(1:span, n = n)[2]
}

#' @export
pretty.month <- function(x, n, ...){
  span <- x / (3600 * 24 * 30)
  lengths <- c(1,2,3,4,6,12)
  fit <- abs(span - lengths*n)
  lengths[which.min(fit)]
}

#' @export
pretty.year <- function(x, n, ...){
  span <- x / (3600 * 24 * 365)
  pretty(1:span, n = n)[2]
}

#' @export
pretty.point <- function(x, units, length, start = TRUE, ...){
  x <- as.POSIXct(x)

  if(units %in% c("day", "year")){

    if(start) return(floor_date(x, units))
    else return(ceiling_date(x, units))

  } else {

    floors <- c("sec", "min", "hour", "day", "month", "year")
    floorto <- floors[match(units, floors) + 1L]
    lower <- floor_date(x, floorto)
    upper <- ceiling_date(x, floorto)

    points <- seq.POSIXt(lower, upper, paste(length, units))

    if (start)
      points <- points[points <= x]
    else
      points <- points[points >= x]

    fit <- as.duration(x - points)
    fit <- abs(as.double(fit, "secs"))
    points[which.min(fit)]
  }
}
