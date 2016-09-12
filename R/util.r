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
  dates <- c("second", "minute", "hour", "day", "week", "month", "year",
             ## these ones are used for rounding only
             "bimonth", "quarter", "halfyear")
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

## return list(n=nr_untis,  unti="unit_name")
parse_period_unit <- function(unit) {

  if (length(unit) > 1) {
    warning("Unit argument longer than 1. Taking first element.")
    unit <- unit[[1]]
  }

  p <- .Call("c_parse_period", as.character(unit))

  if (!is.na(p[[1]])) {

    period_units <- c("second", "minute", "hour", "day", "week", "month", "year")

    wp <- which(p > 0)
    if(length(wp) > 1){
      stop("Multi unit periods are not yet supported")
    }

    list(n = p[wp], unit = period_units[wp])

  } else {

    ## this is for backward compatibility and allows for bimonth, halfyear and quarter
    m <- regexpr(" *(?<n>[0-9.,]+)? *(?<unit>[^ \t\n]+)", unit[[1]], perl = T)
    if(m > 0){
      ## should always match
      nms <- attr(m, "capture.names")
      nms <- nms[nzchar(nms)]
      start <- attr(m, "capture.start")
      end <- start + attr(m, "capture.length") - 1L
      n <- if(end[[1]] >= start[[1]]){
             as.integer(str_sub(unit, start[[1]], end[[1]]))
           } else {
             1
           }
      unit <- str_sub(unit, start[[2]], end[[2]])
      list(n = n, unit = unit)
    } else {
      stop(sprintf("Invalid unit specification '%s'", unit))
    }

  }
}

undefined_arithmetic <- function(e1, e2){
  msg <- sprintf("Arithmetic operators undefined for '%s' and '%s' classes:
  convert one to numeric or a matching time-span class.", class(e1), class(e2))
  stop(msg)
}
