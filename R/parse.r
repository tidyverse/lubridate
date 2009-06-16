# Convenience functions for parsing dates
# Note: fails if input is already in POSIX format
# ---------------------------------------------------------------------------

# New guess_format() tests all permutations of the format entries
# Removed redundant convenience functions
# Need to generate some sample data


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



# formats now a character vector (previously a list)
guess_format <- function(x, formats, seps = c("-", "/", "")) {
	
  # Creates grid of all permutations of the format entries.
  # Note: Is there an R function for this?
  perm_strings <- permute(formats)
  

  # Combines each permutation with each value of seps
  with_seps <- combine(perm_strings, seps)

  # Creates vector of possible format strings
  fmts <- unlist(mlply(with_seps, paste))
  
  # Returns a list of the POSIXlt objects and NAs. 
  trials <- llply(fmts, function(fmt) strptime(x, fmt))
  # Sums the number of successes (non-NA ouputs) for each format
  successes <- unlist(llply(trials, function(x) sum(!is.na(x))))
  
  # Selects the format that resulted in the highest number of successes
  bestn <- max(successes)
  best <- fmts[successes > 0 & successes == bestn]
  
  # If no formats succeeded
  if (length(best) == 0) {
    stop(paste(fmts, collapse = ", "), " all failed to parse dates", 
      .call = FALSE)
      
  # If multiple formats performed equally well    
  } else if (length(best) > 1) {
    message("Multiple format matches with ", bestn, " successes: ", 
      paste(best, collapse =", "), ".")
    best <- best[1]
  }
  
  best
}


# Returns all permutations of elements in a vector. I wrote this to use above.
permute <- function(...){
	data <- unlist(list(...))

	# Creates grid of all unique combinations of data elements with 
	# length = length(data). 	
	perms <- splat(expand.grid)(rep(list(seq_along(data)), length(data)))
	
	# Retains only combinations that use each element once
	# (These are the permutations)
	perms <- perms[apply(perms, 1, function(x) nlevels(as.factor(x))) == length(data), ]
	
	# Replaces each element with its value from data
	perm_strings <- sapply(perms, function(x) data[x])
	perm_strings
}



# Quickly adds separator values to rows of strings, 
# which can then be used in mlply(x, paste). 
combine <- function(mat, vec){
	
	# Splits each row in a matrix into n rows and adds to each a deifferent element from a 
	# vector of length n
	combined <- mat[rep(1:nrow(mat), each = length(vec)),]
	combined <- cbind(unname(combined), sep = rep(vec, nrow(mat)))
	combined
}