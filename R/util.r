
#' 1970-01-01 GMT
#'
#' Origin is the date-time for 1970-01-01 GMT in POSIXct format. This date-time 
#' is the origin for the numbering system used by POSIXct, POSIXlt, chron, and 
#' Date classes.
#'
#' @export origin
#' @keywords data chron
#' @examples
#' origin
#' # "1970-01-01 GMT"
origin <- with_tz(structure(0, class = c("POSIXt", "POSIXct")), "UTC")



recognize <- function(x){
  recognized <- c("POSIXt", "POSIXlt", "POSIXct", "yearmon", "yearqtr", "Date")
  
  if (all(class(x) %in% recognized))
    return(TRUE)
  return(FALSE)
}


standardise_date_names <- function(x) {
  dates <- c("second", "minute", "hour", "mday", "wday", "yday", "day", "week", "month", "year", "tz")
  y <- gsub("(.)s$", "\\1", x)
  res <- dates[pmatch(y, dates)]
  if (any(is.na(res))) {
    stop("Invalid unit name: ", paste(x[is.na(res)], collapse = ", "), 
      call. = FALSE)
  }
  res
}

#' Lakers 2008-2009 basketball data set
#' 
#' This data set contains play by play statistics of each Los 
#' Angeles Lakers basketball game in the 2008-2009 season. Data 
#' includes the date, opponent, and type of each game (home or 
#' away). Each play is described by the time on the game clock 
#' when the play was made, the period in which the play was 
#' attempted, the type of play, the player and team who made the 
#' play, the result of the play, and the location on the court 
#' where each play was made.
#'  
#' @name lakers
#' @docType data
#' @references \url{http://www.basketballgeek.com/data/}
#' @keywords data
NULL