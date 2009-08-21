
#' Internal function. Formats duration objects.
#'
#' keywords internal print chron
format.duration <- function(dur, ...){
  format_unit <- function(x, xsign, singular = NULL) {
      if (is.null(singular)) singular <- deparse(substitute(x))
      x <- x * sign(xsign)
      plural <- paste(singular, "s", sep = "")
      ifelse(x == 0, "", 
          paste(x, ifelse(!is.na(x) & x == 1, singular, plural)))
    }
  
  
  dur <- as.numeric(dur)
  month_num <- dur %/% (10^11)
  months <- abs(month_num)
  sec_num <- dur - month_num * 10^11 - 5 * 10^10
  seconds <- abs(sec_num)
  
  year <- months %/% 12
  month <- months %% 12
  
  week <- (seconds %/% 604800)
  day <- (seconds - week * 604800) %/% 86400
  hour <- (seconds - week * 604800 - day * 86400) %/% 3600
  minute <- (seconds - week * 604800 - day * 86400 - hour * 3600) %/% 60
  second <- seconds - week * 604800 - day * 86400 - hour * 3600 - minute * 60
  
  duration <- cbind(
      format_unit(year, dur), 
      format_unit(month, dur), 
      format_unit(week, sec_num),
      format_unit(day, sec_num),
      format_unit(hour, sec_num), 
      format_unit(minute, sec_num), 
      format_unit(second, sec_num)
    )
  
  collapse <- function(x) {
      all <- x[x != ""]
      if (length(all) == 0) return("0 seconds")
      if (length(all) == 1) return(all)
      paste(
        paste(all[1:length(all) - 1], collapse = ", "),
        all[length(all)], sep = " and ")
    }

  aaply(duration, 1, collapse)
} 

#' Internal function for printing duration objects.
#'
#' keywords internal print chron
print.duration <- function(x, ...) {
  print(format(x), ..., quote = FALSE)
}
