
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

standardise_difftime_names <- function(x) {
  dates <- c("secs", "mins", "hours", "days", "weeks")
  y <- gsub("(.)s$", "\\1", x)
  y <- substr(y, 1, 3)
  res <- dates[pmatch(y, dates)]
  if (any(is.na(res))) {
    stop("Invalid difftime name: ", paste(x[is.na(res)], collapse = ", "), 
      call. = FALSE)
  }
  res
}

standardise_period_names <- function(x) {
  dates <- c("second", "minute", "hour", "day", "week", "month", "year")
  y <- gsub("(.)s$", "\\1", x)
  y <- substr(y, 1, 3)
  res <- dates[pmatch(y, dates)]
  if (any(is.na(res))) {
    stop("Invalid difftime name: ", paste(x[is.na(res)], collapse = ", "), 
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