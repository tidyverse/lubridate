
# Convenience functions for parsing dates
# ---------------------------------------------------------------------------

# Should really only need md and dm 
# Need to generate some sample data


ymd <- function(...) {
  dates <- unlist(list(...))
  parse_date(num_to_date(dates), formats = list(c("%y", "%m", "%d")))
}
Ymd <- function(...) {
  dates <- unlist(list(...))
  parse_date(num_to_date(dates), formats = list(c("%Y", "%m", "%d")))
}
mdy <- function(...) {
  dates <- unlist(list(...))
  parse_date(num_to_date(dates), formats = list(c("%m", "%d", "%y")))
}
mdY <- function(...) {
  dates <- unlist(list(...))
  parse_date(num_to_date(dates), formats = list(c("%m", "%d", "%Y")))
}
dmy <- function(...) {
  dates <- unlist(list(...))
  parse_date(num_to_date(dates), formats = list(c("%d", "%m", "%y")))
}
dmY <- function(...) {
  dates <- unlist(list(...))
  parse_date(num_to_date(dates), formats = list(c("%d", "%m", "%Y")))
}
hm <- function(...) {
  dates <- unlist(list(...))
  formats <- list(c("%H", "%M"))
  parse_date(dates, formats = formats, seps = c("", ":"))  
}

parse_date <- function(x, formats, seps = c("-", "/", ".", "")) {
  x <- as.character(x)
    
  fmt <- guess_format(x, formats, seps)
  parsed <- as.POSIXct(strptime(x, fmt))

  message("Using date format ", fmt, ".")

  failed <- sum(is.na(parsed)) - sum(is.na(x))
  if (failed > 0) {
    message(failed, " failed to parse.")    
  }
  
  parsed
}

find_separator <- function(x) {
  chars <- unlist(strsplit(x, ""))
  nonalpha <- setdiff(chars, c(LETTERS, letters, 0:9))
  as.data.frame(table(nonalpha))
}

# Converts a number, like 080101 to a string that can be parsed into a date
num_to_date <- function(x) {
  if (is.numeric(x)) {
    x <- as.character(x)
    x <- paste(ifelse(nchar(x) %% 2 == 1, "0", ""), x, sep = "")
  }
  x
}

guess_format <- function(x, formats, seps = c("-", "/", "")) {
  combs <- expand.grid(format = seq_along(formats), sep = seq_along(seps))
  comb_strings <- cbind(formats[combs$format], sep = seps[combs$sep])
  fmts <- unlist(mlply(comb_strings, splat(paste)))
  
  trials <- llply(fmts, function(fmt) strptime(x, fmt))
  successes <- unlist(llply(trials, function(x) sum(!is.na(x))))
  
  bestn <- max(successes)
  best <- fmts[successes > 0 & successes == bestn]
  
  if (length(best) == 0) {
    stop(paste(fmts, collapse = ", "), " all failed to parse dates", 
      .call = FALSE)
  } else if (length(best) > 1) {
    message("Multiple format matches with ", bestn, " successes: ", 
      paste(best, collapse =", "), ".")
    best <- best[1]
  }
  
  best
}