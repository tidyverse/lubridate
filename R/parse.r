#' Parse dates according to the order year, month, and day appears
#'
#' Transforms dates stored in character and numeric vectors to POSIXct objects. These functions automatically recognize the following separators: "-", "/", ".", and "" (i.e., no separators). Users should choose the function that models the order in which year(y), month(m), and date(d) appear in the dates. All inputed dates are considered to have the same order and the same separators.
#'
#' @param ... a character or numeric vector of suspected dates 
#' @seealso \code{link{parse_date}, link{guess_format}}
#' @examples
#' x <- c("09-01-01", "09-01-02", "09-01-03")
#' ymd(x)
#' # "2009-01-01 GMT" "2009-01-02 GMT" "2009-01-03 GMT"
#' z <- c("2009-01-01", "2009-01-02", "2009-01-03")
#' ymd(z)
#' # "2009-01-01 GMT" "2009-01-02 GMT" "2009-01-03 GMT"
#' ymd(090101)
#' # "2009-01-01 GMT"
#' ymd(90101)
#' # "2009-01-01 GMT"
#' myd(090101)
#' # "2001-09-01 GMT"
#' dym(090101)
#' # "2001-01-09 GMT"
#' Sys.time() > ymd(20090101) 
#' # TRUE
ymd <- function(...) {
  dates <- unlist(list(...))
  parse_date(num_to_date(dates), formats = list(c("%y", "%m", "%d"), c("%Y", "%m", "%d")))
}
myd <- function(...) {
  dates <- unlist(list(...))
  parse_date(num_to_date(dates), formats = list(c("%m", "%y","%d"), c("%m", "%Y", "%d")))
}
dym <- function(...) {
  dates <- unlist(list(...))
  parse_date(num_to_date(dates), formats = list(c("%d", "%y", "%m"), c("%d", "%Y", "%m")))
}
ydm <- function(...) {
  dates <- unlist(list(...))
  parse_date(num_to_date(dates), formats = list(c("%y", "%d", "%m"), c("%Y", "%d", "%m")))
}
mdy <- function(...) {
  dates <- unlist(list(...))
  parse_date(num_to_date(dates), formats = list(c("%m", "%d", "%y"), c("%m", "%d", "%Y")))
}


#' Create a date-time with the specified hours and minutes
#'
#' Transforms a numeric or character string into a POSIXct object with the current date and the specified number of hours and minutes. hm recognizes ":" and "" (i.e., no separator) as separators. Hours should be written as a two digit integer (00-23). Minutes should be written as a two digit integer (00-59).
#'
#' @param ... a numeric or character string 
#' @seealso \code{link{hms}}
#' @examples
#' x <- c("09:01", "09:02", "09:03")
#' hm(x)
#' # "2009-08-04 09:01:00 GMT" "2009-08-04 09:02:00 GMT" "2009-08-04 09:03:00 GMT"
#' hm(0802)
#' # "2009-08-04 08:02:00 GMT"
hm <- function(...) {
  dates <- unlist(list(...))
  formats <- list(c("%H", "%M"))
  parse_date(num_to_date(dates), formats = formats, seps = c("", ":"))  
}

#' Create a date-time with the specified hours, minutes, and seconds
#'
#' Transforms a numeric or character string into a POSIXct object with the current date and the specified number of hours, minutes, and seconds. hms recognizes ":" and "" (i.e., no separator) as separators. Hours, minutes, and seconds should be written as a two digit integers (00-23)(00-59)(00-59).
#'
#' @param ... a numeric or character string 
#' @seealso \code{link{hm}}
#' @examples
#' x <- c("09:10:01", "09:10:02", "09:10:03")
#' hms(x)
#' # "2009-08-04 09:10:01 GMT" "2009-08-04 09:10:02 GMT" "2009-08-04 09:10:03 GMT"
#' hms("070605")
#' # "2009-08-04 07:06:05 GMT"
#' hms(070605)
#' # "2009-08-04 07:06:05 GMT"
hms <- function(...) {
  dates <- unlist(list(...))
  formats <- list(c("%H", "%M", "%S"))
  parse_date(num_to_date(dates), formats = formats, seps = c("", ":"))  
}


#' Change dates into a POSIXct format
#'
#' parse_date is an internal function for the \code{link{ymd}} family of functions. Its recommended to use these functions instead. It transforms dates stored in character and numeric vectors to POSIXct objects. All inputed dates are considered to have the same order and the same separators. 
#'
#' @param x a character or numeric vector of suspected dates 
#' @param formats a vector of date-time format elements in the order they occur within the dates. See \code{link[base]{strptime}} for format elements.
#' @param seps a vector of possible characters used to separate elements within the dates.
#' @seealso \code{link{ymd}, link{guess_format}}
#' @keywords internal
#' @examples
#' x <- c("09-01-01", "09-01-02", "09-01-03")
#' parse_date(x, c("%y", "%m", "%d"), seps = "-")
#' #  "2009-01-01 GMT" "2009-01-02 GMT" "2009-01-03 GMT"
#' ymd(x)
#' #  "2009-01-01 GMT" "2009-01-02 GMT" "2009-01-03 GMT"
parse_date <- function(x, formats, seps = c("-", "/", ".", "")) {
  fmt <- guess_format(x, formats, seps)
  parsed <- as.POSIXct(strptime(x, fmt))

  if (length(x) > 2) message("Using date format ", fmt, ".")

  failed <- sum(is.na(parsed)) - sum(is.na(x))
  if (failed > 0) {
    message(failed, " failed to parse.")    
  }
  
  parsed
}



#' Identifies the likely separators of a string.
#'
#' Letters and numbers are assumed not to be separators
#'
#' @param x a character string 
#' examples
#' find_separator("2009-08-03 09:07:03")
find_separator <- function(x) {
  chars <- unlist(strsplit(x, ""))
  nonalpha <- setdiff(chars, c(LETTERS, letters, 0:9))
  as.data.frame(table(nonalpha))
}

#' Internal function
#'
#' @keywords internal
num_to_date <- function(x) {
  if (is.numeric(x)) {
    x <- as.character(x)
    x <- paste(ifelse(nchar(x) %% 2 == 1, "0", ""), x, sep = "")
  }
  x
}


#' Guess the format of dates in a character or numeric vector
#'
#' Returns the format that successfully parses the most dates within a character or umeric vector to POSIXct objects. If multiple formats are equally successful, guess format will display  the formats in a message and select the first format by default. guess_format assumes that each date only uses one type of separator and that all dates use the same separator.
#'
#' @param x a character or numeric vector of suspected dates 
#' @param formats a list of formats to test. Each format should be a vector of date-time format elements. To test an alternative order of elements, the alternative order should be entered as an additional format. See \code{link[base]{strptime}} for format elements.
#' @param seps a vector of possible characters used to separate elements within the dates. 
#' @seealso \code{link{find_separator}}
#' @examples
#' x <- c("2009/01/01", "2009/01/02", "2009/01/03")
#' guess_format(x, list(c("%y", "%m", "%d"), c("%Y", "%m", "%d")), seps = c("-", "", "/"))
#' # "%Y/%m/%d"
#' x <- c("20090101", "20090102", "20090103")
#' guess_format(x, list(c("%y", "%m", "%d"), c("%Y", "%m", "%d")), seps = c("-", "", "/"))
#' #  "%Y%m%d" 
#' x <- c("09-01-01", "09-01-02", "09-01-03")
#' guess_format(x, list(c("%y", "%m", "%d"), c("%Y", "%m", "%d")), seps = c("-", "", "/"))
#' #  Multiple format matches with 3 successes: %y-%m-%d, %Y-%m-%d.
#' #         1 
#' # "%y-%m-%d"
guess_format <- function(x, formats, seps = c("-", "/", "")) {
  
  if (is.list(formats))
    formats <- do.call(rbind, formats)
  else formats <- as.matrix(t(formats))
    
  # Combines each permutation with each value of seps
  with_seps <- combine(formats, seps)

  # Creates vector of possible format strings
  fmts <- unlist(mlply(with_seps, paste))
  
  # defining last digit of x and fmts with "@" 
  x <- paste(x, "@", sep = "")
  fmts2 <- paste(fmts, "@", sep = "")
  
  # Returns a list of the POSIXlt objects and NAs. 
  trials <- llply(fmts2, function(fmt) strptime(x, fmt))
  # Sums the number of successes (non-NA ouputs) for each format
  successes <- unlist(llply(trials, function(x) sum(!is.na(x))))
  
  # Selects the format that resulted in the highest number of successes
  bestn <- max(successes)
  best <- fmts[successes > 0 & successes == bestn]
  
  # If no formats succeeded
  if (length(best) == 0) {
    stop(paste(fmts, collapse = ", "), " All failed to parse dates. Check for incorrect or missing elements.")
    
  # If multiple formats performed equally well    
  } else if (length(best) > 1) {
    message("Multiple format matches with ", bestn, " successes: ", paste(best, collapse =", "), ".")
    best <- best[1]
  }

  best
}



#' Internal function.
#'
# Quickly adds separator values to rows of strings for \code{link{guess_format}}
#'
#' @keywords internal
combine <- function(mat, vec){
  
  # Splits each row in a matrix into n rows and adds to each a different element from a 
  # vector of length n
  combined <- mat[rep(1:nrow(mat), each = length(vec)),]
  if (nrow(mat) == 1)
  	combined <- cbind(t(unname(combined)), sep = rep(vec, nrow(mat)))
  else
  	combined <- cbind(unname(combined), sep = rep(vec, nrow(mat)))
  combined
}