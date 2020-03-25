match_lengths <- function(x, y) {
  n.x <- length(x)
  n.y <- length(y)
  n.max <- max(n.x, n.y)
  n.min <- min(n.x, n.y)
  if (n.max %% n.min != 0L) {
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

standardise_date_names <- function(x) {
  dates <- c("second", "minute", "hour", "mday", "wday", "yday", "day", "week", "month", "year", "tz")
  y <- gsub("(.)s$", "\\1", x)
  res <- dates[pmatch(y, dates, duplicates.ok = TRUE)]
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
  res <- dates[pmatch(y, dates, duplicates.ok = TRUE)]
  if (any(is.na(res))) {
    stop("Invalid difftime name: ", paste(x[is.na(res)], collapse = ", "),
      call. = FALSE)
  }
  res
}

standardise_period_names <- function(x) {
  dates <- c("second", "minute", "hour", "day", "week", "month", "year",
             ## these ones are used for rounding only
             "bimonth", "quarter", "halfyear", "season")
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
  if (length(x) == 0L)
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

## return list(n=nr_units, unit="unit_name")
parse_period_unit <- function(unit) {

  if (length(unit) > 1) {
    warning("Unit argument longer than 1. Taking first element.")
    unit <- unit[[1]]
  }

  p <- .Call(C_parse_period, as.character(unit))

  if (!is.na(p[[1]])) {

    period_units <- c("second", "minute", "hour", "day", "week", "month", "year")

    wp <- which(p > 0)
    if (length(wp) > 1) {
      ## Fractional units are actually supported but only when it leads to one
      ## final unit.
      stop("Cannot't parse heterogenuous or fractional units larger than one minute.")
    }

    list(n = p[wp], unit = period_units[wp])

  } else {
    ## this part is for backward compatibility and allows for bimonth, halfyear
    ## and quarter

    m <- regexpr(" *(?<n>[0-9.,]+)? *(?<unit>[^ \t\n]+)", unit[[1]], perl = T)
    if (m > 0) {
      ## should always match
      nms <- attr(m, "capture.names")
      nms <- nms[nzchar(nms)]
      start <- attr(m, "capture.start")
      end <- start + attr(m, "capture.length") - 1L
      n <- if (end[[1]] >= start[[1]]) {
             as.integer(substr(unit, start[[1]], end[[1]]))
           } else {
             1
           }
      unit <- substr(unit, start[[2]], end[[2]])
      list(n = n, unit = unit)
    } else {
      stop(sprintf("Invalid unit specification '%s'", unit))
    }

  }
}

date_to_posix <- function(date, tz = "UTC") {
  utc <- .POSIXct(unclass(date) * 86400, tz = "UTC")
  if (is_utc(tz)) utc
  else force_tz(utc, tz)
}

# UTC-equivalent timezones can be treated as UTC;
#   check grep('UTC|GMT', OlsonNames(), value = TRUE)
is_utc = function(tz) {
  utc_tz = c("UTC", "GMT", "Etc/UTC", "Etc/GMT", "GMT-0", "GMT+0", "GMT0")
  if (is.null(tz)) tz = Sys.timezone()
  return(tz %in% utc_tz)
}

# minimal custom str_sub function to replicate stringr::str_sub without the full dependency.
.str_sub <- function(x, start, end, replace_with = "") {

  # get the parts of the string to the left and right of the replacement.
  start.c = substr(x, 1, start - 1)
  end.c = substr(x, end + 1, nchar(x))

  # paste with replacement in the middle.
  x <- paste(start.c, replace_with, end.c, sep = "")

  x
}

is_verbose <- function() {
  isTRUE(getOption("lubridate.verbose"))
}

stop_incompatible_classes <- function(x, y, method) {
  stop(paste0(
    "Incompatible classes: <", is(x)[[1]], "> ", method, " <", is(y)[[1]], ">\n"
  ), call. = FALSE)
}
