
# Convenience functions for parsing dates
# ---------------------------------------------------------------------------

# Should really only need md and dm 
# Need to generate some sample data

# Note: It seems like there must be a way to code this so that ymd() could parse 
#   all dates that use %y %m %d, no matter which order the %y %m and %d's appear 
#   in (instead of also needing mdy(), dmy(), etc.). The guess_format() function 
#   identifies the correct order by going with the one that yields the most non-
#   NA matches.

ymd <- function(...) {
	
  # Note: Why do we list then unlist?
  # Creates an atomic vector of dates
  dates <- unlist(list(...))
  
  # parses the dates 
  # Note: this "format" of formats does not work with the code in guess_format() 
  #   below.
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

# Changes dates to POSIXct format
# A list of possible format inputs can be found at ?strptime
parse_date <- function(x, formats, seps = c("-", "/", ".", "")) {

  # Note: Is this necessary? Strptime coerces x to a character string.
  x <- as.character(x)
    
  # Determines what format date is in  
  fmt <- guess_format(x, formats, seps)
  
  # Transforms date from its format to POSIXct form
  parsed <- as.POSIXct(strptime(x, fmt))

  message("Using date format ", fmt, ".")

  # Identifies the number of real dates that failed to parse
  failed <- sum(is.na(parsed)) - sum(is.na(x))
  if (failed > 0) {
  	
  	# "Unrecognized date format?"
    message(failed, " failed to parse.")    
  }
  
  parsed
}


# Identifies the likely separators of a string.
find_separator <- function(x) {
	
  # Creates a vector of each character in x	
  chars <- unlist(strsplit(x, ""))
  
  # Extracts characters that are not letters (upper or lower case) or numbers.
  nonalpha <- setdiff(chars, c(LETTERS, letters, 0:9))
  
  # Returns a data frame of each non-letter/number character and how often it 
  # appears.
  as.data.frame(table(nonalpha))
}



# Converts a number, like 080101 to a string that can be parsed into a date
num_to_date <- function(x) {
  if (is.numeric(x)) {
    x <- as.character(x)
    
    # Add a 0 before x if it is an odd number of characters (i.e. 1 character).
    x <- paste(ifelse(nchar(x) %% 2 == 1, "0", ""), x, sep = "")
  }
  x
}


# Determines the format used by a list of dates
guess_format <- function(x, formats, seps = c("-", "/", "")) {

  # Create a data frame of all unique combinations of format and seps.
  # First we make a grid of integer combinations.
  combs <- expand.grid(format = seq_along(formats), sep = seq_along(seps))
  
  # Then we substitute the values of formats and seps that correspond to each 
  #   integer.
  comb_strings <- cbind(formats[combs$format], sep = seps[combs$sep])
  
  # Create a character vector of the row values pasted together
  # Note: This does not work on my computer. It returns a character vector that 
  #  is identical to the first column of comb_strings.
  # Note: This problem is remedied if we remove "sep =" from comb_strings <- 
  #   cbind(....
  # Note: Using splat() with mlply() may be redundant. Removing splat() gives 
  #   the same results. 
  # Note: ymd (and the other functions) make format a list of length 1 with 
  #   three characters. For example, 
  #   > formats
  #   [[1]]
  #   [1] "%d" "%m" "%y"
  #   In this case, splat(paste) puts the separator between each entry in the 
  #     list (i.e. at the end of the first entry), but not between each 
  #     character (since they're all in the same entry.) We get "%d %m %y /".
  fmts <- unlist(mlply(comb_strings, splat(paste)))
  
  # For each of the formats, convert x to a POSIXlt date with the given format. 
  # If a given format doesn't match x, strptime will return NA.
  # Return a list of the POSIXlt objects and NAs.  
  trials <- llply(fmts, function(fmt) strptime(x, fmt))
  
  # Sum the number of matches (non-NA responses) for each format
  successes <- unlist(llply(trials, function(x) sum(!is.na(x))))
  
  # Note the highest number of matches
  bestn <- max(successes)
  
  # Select the format(s) that resulted in highest number of matches greater than 
  # zero.
  best <- fmts[successes > 0 & successes == bestn]
  
  # If no formats matched
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