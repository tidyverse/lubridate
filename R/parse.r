#' Parse dates according to the order that year, month, and day elements appear
#'
#' Transforms dates stored in character and numeric vectors to POSIXct objects. 
#' These functions automatically recognize the following separators: "-", "/", 
#' ".", and "" (i.e., no separators). 
#'
#' Users should choose the function that models the order in which year(y), 
#' month(m), and date(d) appear in the dates. All inputed dates are considered 
#' to have the same order and the same separators.
#'
#' ymd() type functions automatically assign the Universal Coordinated Time Zone 
#' (UTC) to the parsed dates. This time zone can be changed with
#' \code{\link{force_tz}}.
#'
#' @export ymd myd dym ydm mdy dmy
#' @aliases yearmonthdate ymd myd dym ydm mdy dmy
#' @param ... a character or numeric vector of suspected dates 
#' @param quiet logical. When TRUE function evalueates without displaying customary messages.
#' @param tz a character string that specifies which time zone to parse the date with. The string must be a time zone that is recognized by the user's OS.
#' @return a vector of POSIXct date-time objects
#' @seealso \code{\link{parse_date}}
#' @keywords chron 
#' @examples
#' x <- c("09-01-01", "09-01-02", "09-01-03")
#' ymd(x)
#' # "2009-01-01 UTC" "2009-01-02 UTC" "2009-01-03 UTC"
#' z <- c("2009-01-01", "2009-01-02", "2009-01-03")
#' ymd(z)
#' # "2009-01-01 UTC" "2009-01-02 UTC" "2009-01-03 UTC"
#' ymd(090101)
#' # "2009-01-01 UTC"
#' ymd(90101)
#' # "2009-01-01 UTC"
#' now() > ymd(20090101) 
#' # TRUE
#' dmy(010210)
#' mdy(010210)
ymd <- function(..., quiet = FALSE, tz = "UTC") {
  dates <- unlist(list(...))
  parse_date(num_to_date(dates), make_format("ymd"), quiet = quiet, tz = tz)
}
ydm <- function(..., quiet = FALSE, tz = "UTC") {
  dates <- unlist(list(...))
  parse_date(num_to_date(dates), make_format("ydm"), quiet = quiet, tz = tz)
}
mdy <- function(..., quiet = FALSE, tz = "UTC") {
  dates <- unlist(list(...))
  parse_date(num_to_date(dates), make_format("mdy"), quiet = quiet, tz = tz)
}
myd <- function(..., quiet = FALSE, tz = "UTC") {
  dates <- unlist(list(...))
  parse_date(num_to_date(dates), make_format("myd"), quiet = quiet, tz = tz)
}
dmy <- function(..., quiet = FALSE, tz = "UTC") {
  dates <- unlist(list(...))
  parse_date(num_to_date(dates), make_format("dmy"), quiet = quiet, tz = tz)
}
dym <- function(..., quiet = FALSE, tz = "UTC") {
  dates <- unlist(list(...))
  parse_date(num_to_date(dates), make_format("dym"), quiet = quiet, tz = tz)
}


make_format <- function(order) {
  order <- strsplit(order, "")[[1]]
  
  formats <- list(
    d = "%d",
    m = c("%m", "%b"),
    y = c("%y", "%Y")
  )[order]
  
  grid <- expand.grid(formats, 
    KEEP.OUT.ATTRS = FALSE, stringsAsFactors = FALSE)
  lapply(1:nrow(grid), function(i) unname(unlist(grid[i, ])))
}


#' Parse dates that have hours, minutes, or seconds elements 
#'
#' Transforms dates stored as character vectors in year, month, day, hour, minute, 
#' second format to POSIXct objects. ymd_hms() type functions recognize all non-alphanumeric 
#' separators of length 1 with the exception of ".". ymd_hms() functions automatically
#' assigns the Universal Coordinated Time Zone (UTC) to the parsed date. This time 
#' zone can be changed with \code{\link{force_tz}}. ymdThms() specifically handles combined dates and times written in the ISO 8601 format.
#'
#' @export ymd_hms ymd_hm ymd_h dmy_hms dmy_hm dmy_h mdy_hms mdy_hm mdy_h ydm_hms ydm_hm ydm_h ymdThms
#' @aliases ymd_hms ymd_hm ymd_h dmy_hms dmy_hm dmy_h mdy_hms mdy_hm mdy_h ydm_hms ydm_hm ydm_h ymdThms
#' @param ... a character vector of dates in year, month, day, hour, minute, 
#'   second format 
#' @param quiet logical. When TRUE function evalueates without displaying customary messages.
#' @param tz a character string that specifies which time zone to parse the date with. The string must be a time zone that is recognized by the user's OS.
#' @return a vector of POSIXct date-time objects
#' @seealso \code{\link{ymd}}, \code{\link{hms}}
#' @keywords POSIXt parse 
#' @examples
#' x <- c("2010-04-14-04-35-59", "2010-04-01-12-00-00")
#' ymd_hms(x)
#' # [1] "2010-04-14 04:35:59 UTC" "2010-04-01 12:00:00 UTC"
#' y <- c("2011-12-31 12:59:59", "2010-01-01 12:00:00")
#' ymd_hms(y)
#' # [1] "2011-12-31 12:59:59 UTC" "2010-01-01 12:00:00 UTC"
ymd_hms <- function(..., quiet = FALSE, tz = "UTC"){
  dates <- unlist(list(...))
  seps <- find_separator(dates)
  
  if(length(seps) >= 2){
    parts <- as.data.frame(str_split(dates, seps[2]),
      stringsAsFactors = FALSE)
    date <- ymd(parts[1,], quiet = quiet, tz = tz)
    time <- hms(parts[2,])
  }
  
  else{
    breaks <- as.data.frame(gregexpr(seps, dates))
    breaks <- as.numeric(breaks[3,])
    date <- ymd(substr(dates, 1, breaks-1), quiet = quiet, tz = tz)
    time <- hms(substr(dates, breaks + 1, nchar(dates)))
  }
  date + time
}

ymdThms <- function(..., quiet = FALSE, tz = "UTC"){
  dates <- unlist(list(...))
  seps <- find_separator_T(dates)
  
  if(length(seps) >= 2){
    parts <- as.data.frame(str_split(dates, "T"),
      stringsAsFactors = FALSE)
    date <- ymd(parts[1,], quiet = quiet, tz = tz)
    time <- hms(parts[2,])
  }
  
  else{
    breaks <- as.data.frame(gregexpr(seps, dates))
    breaks <- as.numeric(breaks[3,])
    date <- ymd(substr(dates, 1, breaks-1), quiet = quiet, tz = tz)
    time <- hms(substr(dates, breaks + 1, nchar(dates)))
  }
  date + time
}

ymd_hm <- function(..., quiet = FALSE, tz = "UTC"){
  dates <- unlist(list(...))
  seps <- find_separator(dates)
  
  if(length(seps) >= 2){
    parts <- as.data.frame(str_split(dates, seps[2]),
      stringsAsFactors = FALSE)
    date <- ymd(parts[1,], quiet = quiet, tz = tz)
    time <- hm(parts[2,])
  }
  
  else{
    breaks <- as.data.frame(gregexpr(seps, dates))
    breaks <- as.numeric(breaks[3,])
    date <- ymd(substr(dates, 1, breaks-1), quiet = quiet, tz = tz)
    time <- hm(substr(dates, breaks + 1, nchar(dates)))
  }
  date + time
}

ymd_h <- function(..., quiet = FALSE, tz = "UTC"){
  dates <- unlist(list(...))
  seps <- find_separator(dates)
  
  if(length(seps) >= 2){
    parts <- as.data.frame(str_split(dates, seps[2]),
      stringsAsFactors = FALSE)
    date <- ymd(parts[1,], quiet = quiet, tz = tz)
    time <- hours(parts[2,])
  }
  
  else{
    breaks <- as.data.frame(gregexpr(seps, dates))
    breaks <- as.numeric(breaks[3,])
    date <- ymd(substr(dates, 1, breaks-1), quiet = quiet, tz = tz)
    time <- hours(substr(dates, breaks + 1, nchar(dates)))
  }
  date + time
}


dmy_hms <- function(..., quiet = FALSE, tz = "UTC"){
  dates <- unlist(list(...))
  seps <- find_separator(dates)
  
  if(length(seps) >= 2){
    parts <- as.data.frame(str_split(dates, seps[2]),
      stringsAsFactors = FALSE)
    date <- dmy(parts[1,], quiet = quiet, tz = tz)
    time <- hms(parts[2,])
  }
  
  else{
    breaks <- as.data.frame(gregexpr(seps, dates))
    breaks <- as.numeric(breaks[3,])
    date <- dmy(substr(dates, 1, breaks-1), quiet = quiet, tz = tz)
    time <- hms(substr(dates, breaks + 1, nchar(dates)))
  }
  date + time
}

dmy_hm <- function(..., quiet = FALSE, tz = "UTC"){
  dates <- unlist(list(...))
  seps <- find_separator(dates)
  
  if(length(seps) >= 2){
    parts <- as.data.frame(str_split(dates, seps[2]),
      stringsAsFactors = FALSE)
    date <- dmy(parts[1,], quiet = quiet, tz = tz)
    time <- hm(parts[2,])
  }
  
  else{
    breaks <- as.data.frame(gregexpr(seps, dates))
    breaks <- as.numeric(breaks[3,])
    date <- dmy(substr(dates, 1, breaks-1), quiet = quiet, tz = tz)
    time <- hm(substr(dates, breaks + 1, nchar(dates)))
  }
  date + time
}

dmy_h <- function(..., quiet = FALSE, tz = "UTC"){
  dates <- unlist(list(...))
  seps <- find_separator(dates)
  
  if(length(seps) >= 2){
    parts <- as.data.frame(str_split(dates, seps[2]),
      stringsAsFactors = FALSE)
    date <- dmy(parts[1,], quiet = quiet, tz = tz)
    time <- hours(parts[2,])
  }
  
  else{
    breaks <- as.data.frame(gregexpr(seps, dates))
    breaks <- as.numeric(breaks[3,])
    date <- dmy(substr(dates, 1, breaks-1), quiet = quiet, tz = tz)
    time <- hours(substr(dates, breaks + 1, nchar(dates)))
  }
  date + time
}


mdy_hms <- function(..., quiet = FALSE, tz = "UTC"){
  dates <- unlist(list(...))
  seps <- find_separator(dates)
  
  if(length(seps) >= 2){
    parts <- as.data.frame(str_split(dates, seps[2]),
      stringsAsFactors = FALSE)
    date <- mdy(parts[1,], quiet = quiet, tz = tz)
    time <- hms(parts[2,])
  }
  
  else{
    breaks <- as.data.frame(gregexpr(seps, dates))
    breaks <- as.numeric(breaks[3,])
    date <- mdy(substr(dates, 1, breaks-1), quiet = quiet, tz = tz)
    time <- hms(substr(dates, breaks + 1, nchar(dates)))
  }
  date + time
}

mdy_hm <- function(..., quiet = FALSE, tz = "UTC"){
  dates <- unlist(list(...))
  seps <- find_separator(dates)
  
  if(length(seps) >= 2){
    parts <- as.data.frame(str_split(dates, seps[2]),
      stringsAsFactors = FALSE)
    date <- mdy(parts[1,], quiet = quiet, tz = tz)
    time <- hm(parts[2,])
  }
  
  else{
    breaks <- as.data.frame(gregexpr(seps, dates))
    breaks <- as.numeric(breaks[3,])
    date <- mdy(substr(dates, 1, breaks-1), quiet = quiet, tz = tz)
    time <- hm(substr(dates, breaks + 1, nchar(dates)))
  }
  date + time
}

mdy_h <- function(..., quiet = FALSE, tz = "UTC"){
  dates <- unlist(list(...))
  seps <- find_separator(dates)
  
  if(length(seps) >= 2){
    parts <- as.data.frame(str_split(dates, seps[2]),
      stringsAsFactors = FALSE)
    date <- mdy(parts[1,], quiet = quiet, tz = tz)
    time <- hours(parts[2,])
  }
  
  else{
    breaks <- as.data.frame(gregexpr(seps, dates))
    breaks <- as.numeric(breaks[3,])
    date <- mdy(substr(dates, 1, breaks-1), quiet = quiet, tz = tz)
    time <- hours(substr(dates, breaks + 1, nchar(dates)))
  }
  date + time
}

ydm_hms <- function(..., quiet = FALSE, tz = "UTC"){
  dates <- unlist(list(...))
  seps <- find_separator(dates)
  
  if(length(seps) >= 2){
    parts <- as.data.frame(str_split(dates, seps[2]),
      stringsAsFactors = FALSE)
    date <- ydm(parts[1,], quiet = quiet, tz = tz)
    time <- hms(parts[2,])
  }
  
  else{
    breaks <- as.data.frame(gregexpr(seps, dates))
    breaks <- as.numeric(breaks[3,])
    date <- ydm(substr(dates, 1, breaks-1), quiet = quiet, tz = tz)
    time <- hms(substr(dates, breaks + 1, nchar(dates)))
  }
  date + time
}

ydm_hm <- function(..., quiet = FALSE, tz = "UTC"){
  dates <- unlist(list(...))
  seps <- find_separator(dates)
  
  if(length(seps) >= 2){
    parts <- as.data.frame(str_split(dates, seps[2]),
      stringsAsFactors = FALSE)
    date <- ydm(parts[1,], quiet = quiet, tz = tz)
    time <- hm(parts[2,])
  }
  
  else{
    breaks <- as.data.frame(gregexpr(seps, dates))
    breaks <- as.numeric(breaks[3,])
    date <- ydm(substr(dates, 1, breaks-1), quiet = quiet, tz = tz)
    time <- hm(substr(dates, breaks + 1, nchar(dates)))
  }
  date + time
}

ydm_h <- function(..., quiet = FALSE, tz = "UTC"){
  dates <- unlist(list(...))
  seps <- find_separator(dates)
  
  if(length(seps) >= 2){
    parts <- as.data.frame(str_split(dates, seps[2]),
      stringsAsFactors = FALSE)
    date <- ydm(parts[1,], quiet = quiet, tz = tz)
    time <- hours(parts[2,])
  }
  
  else{
    breaks <- as.data.frame(gregexpr(seps, dates))
    breaks <- as.numeric(breaks[3,])
    date <- ydm(substr(dates, 1, breaks-1), quiet = quiet, tz = tz)
    time <- hours(substr(dates, breaks + 1, nchar(dates)))
  }
  date + time
}



#' Create a period with the specified number of minutes and seconds
#'
#' Transforms a character string into a period object with the 
#' specified number of minutes and seconds. ms() 
#' recognizes all non-alphanumeric separators of length 1 with the exception of ".".
#'
#' @export ms
#' @param ... a character vector of minute second pairs
#' @return a vector of period objects
#' @seealso \code{\link{hms}, \link{hm}}
#' @keywords period
#' @examples
#' x <- c("09:10", "09:02", "1:10")
#' ms(x)
#' # [1] 9 minutes and 10 seconds   9 minutes and 2 seconds   1 minute and 10 seconds
#' ms("7 6")
#' # [1] 7 minutes and 6 seconds
#' ms("6,5")
#' # 6 minutes and 5 seconds
ms <- function(...) {
  dates <- unlist(list(...))
  sep <- find_separator(dates)
  
  parts <- as.data.frame(str_split(dates, fixed(sep[1])), 
    stringsAsFactors = FALSE)
  
  if(nrow(parts) != 2) stop("incorrect number of elements")
  
  new_period(minute = as.numeric(parts[1,]), 
    second = as.numeric(parts[2,]))
}


#' Create a period with the specified number of hours and minutes
#'
#' Transforms a character string into a period object with the 
#' specified number of hours and minutes. hm() 
#' recognizes all non-alphanumeric separators of length 1 with the exception of ".".
#'
#' @export hm
#' @param ... a character vector of hour minute pairs
#' @return a vector of period objects
#' @seealso \code{\link{hms}, \link{ms}}
#' @keywords period
#' @examples
#' x <- c("09:10", "09:02", "1:10")
#' hm(x)
#' # [1] 9 hours and 10 minutes   9 hours and 2 minutes   1 hour and 10 minutes
#' hm("7 6")
#' # [1] 7 hours and 6 minutes
#' hm("6,5")
#' # [1] 6 hours and 5 minutes
hm <- function(...) {
  dates <- unlist(list(...))
  sep <- find_separator(dates)
  
  parts <- as.data.frame(str_split(dates, fixed(sep)), 
    stringsAsFactors = FALSE)
  
  if(nrow(parts) != 2) stop("incorrect number of elements")
  
  new_period(hour = as.numeric(parts[1,]), 
    minute = as.numeric(parts[2,]))
}

#' Create a period with the specified hours, minutes, and seconds
#'
#' Transforms a character string into a period object with the 
#' specified number of hours, minutes, and seconds. hms() 
#' recognizes all non-alphanumeric separators of length 1 with the exception of ".".
#'
#' @export hms
#' @param ... a character vector of hour minute second triples
#' @return a vector of period objects
#' @seealso \code{\link{hm}, \link{ms}}
#' @keywords period
#' @examples
#' x <- c("09:10:01", "09:10:02", "09:10:03")
#' hms(x)
#' # [1] 9 hours, 10 minutes and 1 second   9 hours, 10 minutes and 2 seconds   9 hours, 10 minutes and 3 seconds
#' hms("7 6 5")
#' # [1] 7 hours, 6 minutes and 5 seconds
hms <- function(...) {
  dates <- unlist(list(...))
  sep <- find_separator(dates)
  
  parts <- as.data.frame(str_split(dates, fixed(sep[1])), 
    stringsAsFactors = FALSE)
  
  if(nrow(parts) != 3) stop("incorrect number of elements")
  
  new_period(hour = as.numeric(parts[1,]), 
    minute = as.numeric(parts[2,]), 
    second = as.numeric(parts[3,]))
}


#' Change dates into a POSIXct format
#'
#' parse_date is an internal function for the \code{\link{ymd}} family of 
#' functions. Its recommended to use these functions instead. It transforms 
#' dates stored in character and numeric vectors to POSIXct objects. All 
#' inputed dates are considered to have the same order and to use the same 
#' separator. 
#'
#' @export parse_date
#' @param x a character or numeric vector of suspected dates 
#' @param formats a vector of date-time format elements in the order they occur within the dates. 
#'   See \code{\link[base]{strptime}} for format elements.
#' @param quiet logical. When TRUE function evalueates without displaying customary messages.
#' @param seps a vector of possible characters used to separate elements within the dates.
#' @param tz a character string that specifies the time zone with which to parse the dates
#' @return a vector of POSIXct date-time objects
#' @seealso \code{\link{ymd}}
#' @keywords chron
#' @examples
#' x <- c("09-01-01", "09-01-02", "09-01-03")
#' parse_date(x, c("%y", "%m", "%d"), seps = "-")
#' #  "2009-01-01 UTC" "2009-01-02 UTC" "2009-01-03 UTC"
#' ymd(x)
#' #  "2009-01-01 UTC" "2009-01-02 UTC" "2009-01-03 UTC"
parse_date <- function(x, formats, quiet = FALSE, seps = find_separator(x), tz = "UTC") {
  fmt <- guess_format(head(x, 100), formats, seps, quiet)
  parsed <- as.POSIXct(strptime(x, fmt, tz = tz))

  if (length(x) > 2 & !quiet) message("Using date format ", fmt, ".")

  failed <- sum(is.na(parsed)) - sum(is.na(x))
  if (failed > 0) {
    message(failed, " failed to parse.")    
  }
  
  parsed
}


find_separator <- function(x) {
  x <- as.character(na.omit(x))
  chars <- unlist(strsplit(x, ""))
  
  alpha <- c(LETTERS, letters, 0:9)
  nonalpha <- setdiff(chars, alpha)
  if (length(nonalpha) == 0) nonalpha <- ""
  nonalpha
}

find_separator_T <- function(x) {
  x <- as.character(x)
  chars <- unlist(strsplit(x, ""))
  
  alpha <- c(LETTERS, letters, 0:9)
  nonalpha <- setdiff(chars, alpha)
  nonalpha <- c(nonalpha, "T")
  if (length(nonalpha) == 1) nonalpha <- ""
  nonalpha
}

num_to_date <- function(x) {
  if (is.numeric(x)) {
    x <- as.character(x)
    x <- paste(ifelse(nchar(x) %% 2 == 1, "0", ""), x, sep = "")
  }
  x
}


guess_format <- function(x, formats, seps = c("-", "/", ""), quiet = FALSE) {
  
  if (is.list(formats))
    formats <- do.call(rbind, formats)
  else formats <- as.matrix(t(formats))
    
  with_seps <- combine(formats, seps)

  fmts <- unlist(mlply(with_seps, paste))
  
  x <- paste("@", x, "@", sep = "")
  fmts2 <- paste("@", fmts, "@", sep = "")
  
  trials <- llply(fmts2, function(fmt) strptime(x, fmt))

  successes <- unlist(llply(trials, function(x) sum(!is.na(x))))
  
  bestn <- max(successes)
  best <- fmts[successes > 0 & successes == bestn]
  
  if (length(best) == 0) {
    stop("Date did not match any of the guessed formats: ", 
      paste(fmts, collapse = ", "), ". ",
      "Check for incorrect or missing elements.", call. = FALSE)
  } 
  else if (length(best) > 1 & !quiet) {
    message("Multiple format matches with ", bestn, " successes: ", paste(best, collapse =", "), ".")
    best <- best[1]
  }

  best
}

combine <- function(mat, vec){
  
  combined <- mat[rep(1:nrow(mat), each = length(vec)),]
  if (nrow(mat) == 1)
    combined <- cbind(t(unname(combined)), sep = rep(vec, nrow(mat)))
  else
    combined <- cbind(unname(combined), sep = rep(vec, nrow(mat)))
  combined
}