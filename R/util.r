match_lengths <- function(x, y) {
  n.x <- length(x)
  n.y <- length(y)
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
    stop("Invalid period name: ", paste(x[is.na(res)], collapse = ", "),
      call. = FALSE)
  }
  res
}

standardise_lt_names <- function(x) {
  if(length(x) == 0L)
    stop("No unit names supplied.")
  dates <- c("sec", "min", "hour", "day", "mday", "wday", "yday", "mon", "year", "tz")
  y <- gsub("(.)s$", "\\1", x)
  y <- substr(y, 1, 3)
  res <- dates[pmatch(y, dates)]
  if (any(is.na(res))) {
    stop("Invalid unit name: ", paste(x[is.na(res)], collapse = ", "),
         call. = FALSE)
  }
  res
}
