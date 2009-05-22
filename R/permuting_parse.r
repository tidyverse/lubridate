# Convenience functions for parsing dates
# Note: fails if input is already in POSIX format
# ---------------------------------------------------------------------------

# New guess_format() tests all permutations of the format entries
# Removed redundant convenience functions
# Need to generate some sample data


if (attr(x))


ymd <- function(...) {
  dates <- unlist(list(...))
  parse_date(num_to_date(dates), formats = c("%y", "%m", "%d"))
}
Ymd <- function(...) {
  dates <- unlist(list(...))
  parse_date(num_to_date(dates), formats = c("%Y", "%m", "%d"))
}

hm <- function(...) {
  dates <- unlist(list(...))
  formats <- list(c("%H", "%M"))
  parse_date(dates, formats = formats, seps = c("", ":"))  
}


# Changes dates to POSIXct format
parse_date <- function(x, formats, seps = c("-", "/", ".", "")) {
  fmt <- guess_format(x, formats, seps)
  parsed <- as.POSIXct(strptime(x, fmt))

  message("Using date format ", fmt, ".")

  failed <- sum(is.na(parsed)) - sum(is.na(x))
  if (failed > 0) {
    message(failed, " failed to parse.")    
  }
  
  parsed
}

# Identifies the likely separators of a string.
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



# formats <- c("%Y", "%m", "%d"))
guess_format <- function(x, formats, seps = c("-", "/", "")) {
	
  # Creates grid of all permutations of the format entries.
  # Note: Is there an R function for this?
  perms <- splat(expand.grid)(rep(list(seq_along(formats)), length(formats)))
  perms <- perms[apply(perms, 1, function(x) nlevels(as.factor(x))) == length(formats), ]
  perm_strings <- sapply(perms, function(x) formats[x])

  # Combines each permutation with each value of seps
  with_seps <- perm_strings[rep(1:nrow(perm_strings), each = length(seps)),]
  with_seps <- cbind(with_seps, sep = rep(seps, nrow(perm_strings)))

  fmts <- unlist(mlply(with_seps, paste))
  
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