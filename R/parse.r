
lubridate_formats <- local({
    comb <- c( "ymd", "ydm", "mdy", "myd", "dmy", "dym")
    out <- lapply(comb, function(order) {
        formats <- list(
                     d = "%d",
                     m = c("%m", "%b"),
                     y = c("%y", "%Y"))[ unlist(strsplit(order, ""))]
        grid <- expand.grid(formats, 
                            KEEP.OUT.ATTRS = FALSE, stringsAsFactors = FALSE)
        apply(grid, 1, function(row) paste(row, collapse = ""))
    })
    names(out) <- comb

    ## hms <- c("%H%M%S", "%H%M%OS", "%k%M%S")
    hms.f <- "%H%M%OS"
    hms <- c("%H%M%S", "%I%M%S%p")
    hm <- "%H%M"
    h <- c("%H")
    ms.f <- "%M%OS"
    ms <- "%M%S"

    for(D in comb){
        out[[paste(D, "_hms.f", sep = "")]] <-
            paste(out[[D]], rep(hms.f, each = length(out[comb])), sep = "")
    }

    for(D in comb){
        out[[paste(D, "_hms", sep = "")]] <-
            paste(out[[D]], rep(hms, each = length(out[comb])), sep = "")
    }

    
    for(D in comb){
        out[[paste(D, "_hm", sep = "")]] <-
            paste(out[[D]], rep(hm, each = length(out[comb])), sep = "")
    }

    for(D in comb){
        out[[paste(D, "_h", sep = "")]] <-
            paste(out[[D]], rep(h, each = length(out[comb])), sep = "")
    }

    for( i in seq_along(out))
        out[[i]] <- unique(out[[i]])

    out[["hms.f"]] <- hms.f
    out[["hms"]] <- hms
    out[["hm"]] <- hm
    out[["ms.f"]] <- ms.f
    out[["ms"]] <- ms
    out
})

##' Parse dates according to the order that year, month, and day elements appear
##' in the input vector.
##'
##' Transforms dates stored in character and numeric vectors to POSIXct
##' objects. These functions automatically recognize all non-alphanumeric
##' separators as well as no separator. As long as the order of formats is
##' correct, these functions will parse dates correctly even when dates have
##' different formats or use different separators. For even more flexibility in
##' treatment of heterogeneous formats see low level parser
##' \code{\link{parseDateTime}.
##'
##' \code{ymd} family of functions automatically assign the Universal
##' Coordinated Time Zone (UTC) to the parsed dates. This time zone can be
##' changed with \code{\link{force_tz}}.
##'
##' If \doce{missing} parameter is non-zero \code{ymd} functions also check for
##' truncated formats. For example \code{ymd} with \code{missing = 2} will also
##' parse incomplete dates like \code{2012-06} and \code{2012}. NOTE: \code{ymd}
##' family of functions are based on \code{strptime} which currently fails to
##' parse \code{%y-%m} formats.
##'
##' @export ymd myd dym ydm mdy dmy
##' @aliases yearmonthdate ymd myd dym ydm mdy dmy
##' @param ... a character or numeric vector of suspected dates 
##' @param quiet logical. When TRUE function evalueates without displaying
##' customary messages.
##' @param tz a character string that specifies which time zone to parse the
##' date with. The string must be a time zone that is recognized by the user's
##' OS.
##' @param missing integer. Number of formats that can be missing. 
##' @return a vector of class POSIXct 
##' @seealso \code{\link{parseDateTime}} for underlying mechanism.
##' @keywords chron 
##' @examples
##' x <- c("09-01-01", "09-01-02", "09-01-03")
##' ymd(x)
##' # "2009-01-01 UTC" "2009-01-02 UTC" "2009-01-03 UTC"
##' z <- c("2009-01-01", "2009-01-02", "2009-01-03")
##' ymd(z)
##' # "2009-01-01 UTC" "2009-01-02 UTC" "2009-01-03 UTC"
##' ymd(090101)
##' # "2009-01-01 UTC"
##' ymd(90101)
##' # "2009-01-01 UTC"
##' now() > ymd(20090101) 
##' # TRUE
##' dmy(010210)
##' mdy(010210)
ymd <- function(..., quiet = FALSE, tz = "UTC", missing = 0)
    .parse_xxx(..., type = "ymd", quiet = quiet, tz = tz, missing = missing)

ydm <- function(..., quiet = FALSE, tz = "UTC", missing = 0) 
    .parse_xxx(..., type = "ydm", quiet = quiet, tz = tz, missing = missing)

mdy <- function(..., quiet = FALSE, tz = "UTC", missing = 0) 
    .parse_xxx(..., type = "mdy", quiet = quiet, tz = tz, missing = missing)

 
myd <- function(..., quiet = FALSE, tz = "UTC", missing = 0) 
    .parse_xxx(..., type = "myd", quiet = quiet, tz = tz, missing = missing)

dmy <- function(..., quiet = FALSE, tz = "UTC", missing = 0) 
    .parse_xxx(..., type = "dmy", quiet = quiet, tz = tz, missing = missing)

dym <- function(..., quiet = FALSE, tz = "UTC", missing = 0) 
    .parse_xxx(..., type = "dym", quiet = quiet, tz = tz, missing = missing)



##' Parse dates that have hours, minutes, or seconds elements.
##'
##' Transform dates stored as character or numeric vectors to POSIXct
##' objects. ymd_hms family of functions recognize all non-alphanumeric
##' separators (with the exception of "." if \code{frac = TRUE}) and correctly
##' handle heterogeneous date-time representations. For more flexibility in
##' treatment of heterogeneous formats, see low level parser
##' \code{\link{parseDateTime}.
##'
##' ymd_hms() functions automatically assigns the Universal Coordinated Time
##' Zone (UTC) to the parsed date. This time zone can be changed with
##' \code{\link{force_tz}}.
##'
##' The most common type of irregularity in date-time data is the truncation
##' due to rounding or unavailability of the time stamp. If \doce{missing}
##' parameter is non-zero \code{ymd_hms} functions also check for truncated
##' formats. For example \code{ymd_hms} with \code{missing = 3} will also parse
##' incomplete dates like \code{2012-06-01 12:23}, \code{2012-06-01 12} and
##' \code{2012-06-01}. NOTE: \code{ymd} family of functions are based on
##' \code{strptime} which currently fails to parse \code{%y-%m} formats.
##'
##' ymdThms() specifically handles combined dates and times written in the ISO
##' 8601 format.
##'
##' @export ymd_hms ymd_hm ymd_h dmy_hms dmy_hm dmy_h mdy_hms mdy_hm mdy_h ydm_hms ydm_hm ydm_h ymdThms
##' @aliases ymd_hms ymd_hm ymd_h dmy_hms dmy_hm dmy_h mdy_hms mdy_hm mdy_h ydm_hms ydm_hm ydm_h ymdThms
##' @param ... a character vector of dates in year, month, day, hour, minute, 
##'   second format 
##' @param quiet logical. When TRUE function evalueates without displaying customary messages.
##' @param tz a character string that specifies which time zone to parse the date with. The string must be a time zone that is recognized by the user's OS.
##' @param missing integer, indicating how many formats can be missing. See details.
##' @param frac If \code{TRUE}, fractional seconds are allowed. It is assumed
##' that fractional seconds are separated by ".". In this case "." cannot be
##' used as a separator between other fields.
##' @return a vector of POSIXct date-time objects
##' @seealso \code{\link{ymd}}, \code{\link{hms}}. \code{\link{parseDateTime}}
##' for underlying mechanism.
##' @keywords POSIXt parse 
##' @examples
##' x <- c("2010-04-14-04-35-59", "2010-04-01-12-00-00")
##' ymd_hms(x)
##' # [1] "2010-04-14 04:35:59 UTC" "2010-04-01 12:00:00 UTC"
##' y <- c("2011-12-31 12:59:59", "2010-01-01 12:00:00")
##' ymd_hms(y)
##' # [1] "2011-12-31 12:59:59 UTC" "2010-01-01 12:00:00 UTC"
ymd_hms <- function(..., quiet = FALSE, tz = "UTC", missing = 0, frac = FALSE){
    .parse_xxx_hms(..., type = "ymd_hms", quiet = quiet, tz = tz, missing = missing, frac = frac)
}

ymd_hm <- function(..., quiet = FALSE, tz = "UTC", missing = 0)
    .parse_xxx_hm(..., type =  "ymd_hm", quiet = quiet, tz = tz, missing = missing)

ymd_h <- function(..., quiet = FALSE, tz = "UTC", missing = 0)
    .parse_xxx_hm(..., type = "ymd_h", quiet = quiet, tz = tz, missing = missing)

dmy_hms <- function(..., quiet = FALSE, tz = "UTC", missing = 0, frac = FALSE)
    .parse_xxx_hms(..., type = "dmy_hms", quiet = quiet, tz = tz, missing = missing, frac = frac)

dmy_hm <- function(..., quiet = FALSE, tz = "UTC", missing = 0)
    .parse_xxx_hm(..., type = "dmy_hm", quiet = quiet, tz = tz, missing = missing)

dmy_h <- function(..., quiet = FALSE, tz = "UTC", missing = 0)
    .parse_xxx_hm(..., type = "dmy_hm", quiet = quiet, tz = tz, missing = missing)

mdy_hms <- function(..., quiet = FALSE, tz = "UTC", missing = 0, frac = FALSE)
    .parse_xxx_hms(..., type = "mdy_hms", quiet = quiet, tz = tz, missing = missing, frac = frac)
    
mdy_hm <- function(..., quiet = FALSE, tz = "UTC", missing = 0)
    .parse_xxx_hm(..., type = "mdy_hm", quiet = quiet, tz = tz, missing = missing)

mdy_h <- function(..., quiet = FALSE, tz = "UTC", missing = 0)
    .parse_xxx_hm(..., type = "mdy_h", quiet = quiet, tz = tz, missing = missing)

ydm_hms <- function(..., quiet = FALSE, tz = "UTC", missing = 0, frac = FALSE)
    .parse_xxx_hms(..., type = "ydm_hms", quiet = quiet, tz = tz, missing = missing, frac = frac)

ydm_hm <- function(..., quiet = FALSE, tz = "UTC", missing = 0)
    .parse_xxx_hm(..., type = "ydm_hm", quiet = quiet, tz = tz, missing = missing)

ydm_h <- function(..., quiet = FALSE, tz = "UTC", missing = 0)
    .parse_xxx_hm(..., type = "ydm_hm", quiet = quiet, tz = tz, missing = missing)


ymdThms <- function(..., quiet = FALSE, tz = "UTC", missing = 0, frac = FALSE){
    dates <- unlist(list(...), use.names= FALSE)
    if(frac){
        sep <- "T|[^[:alnum:].]"
        type <- "ymd_hms.f"
    }else{
        sep <- "T|[^[:alnum:]]"
        type <- "ymd_hms"
    }
    as.POSIXct(parseDateTime(dates, lubridate_formats[[type]], tz = tz, 
                          sep_regexp= sep, missing = missing, quiet = quiet))
}



##' Create a period with the specified number of minutes and seconds
##'
##' Transforms character or numeric vectors into a period object with the
##' specified number of minutes and seconds. ms() recognizes all
##' non-alphanumeric separators as well as no separator. 
##'
##' @export ms
##' @param ... character or numeric vectors of minute second pairs
##' @param frac If \code{TRUE}, fractional seconds are allowed. It is assumed
##' that fractional seconds are separated by ".". If \code{TRUE}, "." cannot be
##' used as a separator between minutes and seconds.
##' @return a vector of class \code{Period}
##' @seealso \code{\link{hms}, \link{hm}}
##' @keywords period
##' @examples
##' x <- c("09:10", "09:02", "1:10")
##' ms(x)
##' # [1] 9 minutes and 10 seconds   9 minutes and 2 seconds   1 minute and 10 seconds
##' ms("7 6")
##' # [1] 7 minutes and 6 seconds
##' ms("6,5")
##' # 6 minutes and 5 seconds
ms <- function(..., frac = FALSE) {
    hms <- .parse_hms(..., type = "ms", frac = frac)
    new_period(minute = hms$min, second = hms$sec)
}


##' Create a period with the specified number of hours and minutes
##'
##' Transforms a character or numeric vectors into a period object with the
##' specified number of hours and minutes. hm() recognizes all non-alphanumeric
##' separators, and no separator.
##'
##' @export hm
##' @param ... character or numeric vectors of hour minute pairs
##' @return a vector of class \code{Period}
##' @seealso \code{\link{hms}, \link{ms}}
##' @keywords period
##' @examples
##' x <- c("09:10", "09:02", "1:10")
##' hm(x)
##' # [1] 9 hours and 10 minutes   9 hours and 2 minutes   1 hour and 10 minutes
##' hm("7 6")
##' # [1] 7 hours and 6 minutes
##' hm("6,5")
##' # [1] 6 hours and 5 minutes
hm <- function(...) {
    time <- .parse_hms(..., type = "hm")
    new_period(hour = time$hour, minute = time$min)
}

##' Create a period with the specified hours, minutes, and seconds
##'
##' Transforms a character or numeric vector into a period object with the
##' specified number of hours, minutes, and seconds. hms() recognizes all
##' non-alphanumeric separators, as well as no separator.
##'
##' @export hms
##' @param ... a character vector of hour minute second triples
##' @param missing integer, number of formats that can be missing. See
##' \code{\link{parseDateTime}}.
##' @param frac If \code{TRUE}, fractional seconds are allowed. It is assumed
##' that fractional seconds are separated by ".". If \code{TRUE}, "." cannot be
##' used as a separator between minutes and seconds.
##' @return a vector of period objects
##' @seealso \code{\link{hm}, \link{ms}}
##' @keywords period
##' @examples
##' x <- c("09:10:01", "09:10:02", "09:10:03")
##' hms(x)
##' # [1] 9 hours, 10 minutes and 1 second   9 hours, 10 minutes and 2 seconds   9 hours, 10 minutes and 3 seconds
##' hms("7 6 5")
##' # [1] 7 hours, 6 minutes and 5 seconds
hms <- function(..., missing = 0, frac = FALSE) {
    time <- .parse_hms(..., type = "hms", missing = missing, frac = frac)
    new_period(hour = time$hour, minute = time$min, second = time$sec)
}


##' Low level function to parse character and numeric vectors into POSIXct
##' object, specifically designed to handle heterogeneous date-time formats at
##' once. It first sorts the supplied formats based on a training set and then
##' applies them recursively for parsing of the input vector.
##'
##'
##' If \code{sep_regexp} is non-NULL, it should be a regular expression to match
##' separators between numeric elements in \code{x}. In this case \code{formats}
##' should not contain separators (like in "%y%m%d"). See
##' \code{lubridate_formats} for formats used in \code{ymd} and \code{ymd_hms}
##' families of functions.
##'
##' There are two strategies that can be applied for the training and
##' parsing. First strategy (when \code{try_separated = TRUE}) is to replace the
##' separators with "-" and then parse with \code{strptime}. Second strategy
##' (requested with \code{try_collapsed = TRUE}), it to completely remove
##' separators and then parse with \code{strptime}.
##' 
##' \bold{Parsing steps:}
##'
##' \enumerate{
##' 
##'   \item For each requested strategy, sort the available formats according to
##' their performance on the training set in \code{train}.
##' 
##'   \item If both \code{try_separated} and \code{try_collapsed} are TRUE. Take
##' the best strategy and store the alternative strategy for the potential latter
##' use. 
##' 
##'   \item Parse \code{x} with first \code{nr_best} formats recursively with
##' the best strategy. That is, parse \code{x} with the best format, then parse
##' with the second best format all the unparsed in the previous stage
##' elements. Continue until all elements in \code{x} are parsed or all formats
##' are exhausted.
##'
##'   \item If there are still unparsed elements in \code{x}, try to parse them
##' with the alternative strategy, if any, using the same formats.
##'
##' }
##'
##' \bold{Speed considerations:}
##'
##' In most of the cases \code{parseDateTime} is very fast (as fast as
##' \code{as.POSIXct}) on vectors longer than 10000 elements. (todo: check this
##' number)
##'
##' For short vectors it might not be very efficient because of the training of
##' formats involved. It's never a problem in interactive use but could have a
##' sizable effect if you run \code{for} or \code{lapply} loops on big data and
##' small blocks. You can deactivate training by setting \code{train} to
##' \code{NULL}. In this case it is a good idea to order the \code{formats} in
##' decreasing order of how often they occur in \code{x}.
##'
##' For efficiency reasons, in \code{ymd} and \code{ymd_hms} family of functions,
##' training is always skipped when length of \code{x} is less than 300.
##'
##' For long input vector \code{x}, If you know all the available formats in
##' \code{x}, it might be a good idea to set \code{sep_regexp} to NULL and
##' supply all the formats explicitly (i.e. including separators). This will
##' save up to 20-30% in speed as it avoids \code{gsub}-ing of \code{x}. This
##' way, you will achieve the efficiency of the bare call to \code{strptime}.
##' 
##' @export parseDateTime
##' @param x a character or numeric vector of suspected dates 
##' @param formats a vector of date-time formats. It should be a character
##' vector of formats. Each format is series of formatting elements as listed
##' \code{\link[base]{strptime}}. Formats should not include separators unless
##' \code{sep_regexp} is NULL. See examples.
##' @param tz a character string that specifies the time zone with which to
##' parse the dates
##' @param sep_regexp a character.  A regular expression matching separators
##' (defaults to all non-alphanumeric characters). Can also be NULL.  In this
##' case, \code{formats} are taken literally and \code{x} is parsed as is. That
##' is,  try_collapsed and try_separated are ignored and no substitution of
##' \code{x} is maid strategies. 
##' @param nr_best number of "best" formats to try. Defaults to \code{Inf}, that
##' is all formats are tried recursively and training is only used to order
##' formats according to how well they have performed on the training set.
##' @param try_collapsed logical. TRUE if collapsed (no separator) formats
##' should be tried.
##' @param try_separated logical. TRUE if separated formats should be tried.
##' @param missing integer, number of formats that can be missing. The most
##' common type of irregularity in date-time data is the truncation due to
##' rounding or unavailability of the time stamp. If \doce{missing} parameter is
##' non-zero \code{parseDateTime} also checks for truncated formats. For example
##' if the format is "%y%m%d%h%m%s" and \code{missing = 3}, \code{parseDateTime}
##' will correctly parse incomplete dates like \code{2012-06-01 12:23},
##' \code{2012-06-01 12} and \code{2012-06-01}. NOTE: \code{ymd} family of
##' functions are based on \code{strptime} which currently fails to parse
##' \code{%y-%m} formats.
##' @param quiet logical. When TRUE function evalueates without displaying
##' customary messages.
##' @param train a vector to use for format training. Defaults to the head of
##' \code{x}. If NULL, no training is performed.
##' @param seps a vector of possible characters used to separate elements within the dates.
##' @return a vector of POSIXct date-time objects
##' @seealso \code{\link{ymd}}
##' @keywords chron
##' @examples
##' x <- c("09-01-01", "09-01-02", "09-01-03")
##' parseDateTime(x, c("%y", "%m", "%d"), seps = "-")
##' #  "2009-01-01 UTC" "2009-01-02 UTC" "2009-01-03 UTC"
##' ymd(x)
##' #  "2009-01-01 UTC" "2009-01-02 UTC" "2009-01-03 UTC"
parseDateTime <- function(x, formats, tz = "UTC", sep_regexp = "[^[:alnum:]]+",
                       nr_best = Inf, try_collapsed = TRUE, try_separated = TRUE,
                       missing = 0L, quiet = FALSE,
                       train = head(x, max(10, min(100, length(x) %/% 3)))){
    if( is.numeric(x) ){
        ## collapsed only
        sep_regexp <- NULL
        x <- .num_to_date(x)
    }

    if( is.null(sep_regexp) )
        try_collapsed <- try_separated <- FALSE

    altern_fmt <- NULL
    if( is.null(train) ){
        ## defaults to collapsed unless specified otherwise
        if( try_collapsed && try_separated){
            try_separated <- FALSE
            altern_fmt <- structure(formats, sep = "-")
        }
    }else{
        if( try_separated ){
            train_s <- gsub(sep_regexp, "-", train)
            fmt <- .train_formats(train_s, gsub("^-", "", gsub("%", "-%", formats)), quiet)
            
            if( try_collapsed ){
                train_c <- gsub(sep_regexp, "", train)
                fmt_c <- .train_formats(train_c, formats, quiet)
                
                if(max(fmt) < max(fmt_c)){
                    altern_fmt <- structure(fmt, sep = "-")
                    fmt <- fmt_c
                    try_separated <- FALSE
                }else{
                    altern_fmt <- structure(fmt_c, sep = "")
                    try_collapsed <- FALSE
                }
            }
            
        }else if( try_collapsed ){
            train_c <- gsub(sep_regexp, "", train)
            fmt <- .train_formats(train_c, formats, quiet)
            
        }else{
            ## not gsub here, as no sep substitution required
            fmt <- .train_formats(train, formats, quiet)
        }

        if( all(fmt == 0L ) )
            stop("Training set didn't match any of the format orders: ", paste(formats, collapse= ", "), call.= FALSE)


        formats <- .select_formats(fmt, nr_best)
    }
    
    if( missing != 0 )
        formats <- .add_missing(formats, missing)

    if( try_collapsed ) # try_separated == FALSE
        x <- gsub(sep_regexp, "", x)    
    else if( try_separated )
        x <- gsub(sep_regexp, "-", x)

    sum_na <- sum(is.na(x))
    ## cat("Trying:"); print(formats)
    out <- .parseDateTime(x, formats, quiet, tz)
    
    parsed_na <- is.na(out$year)
    failed <- sum(parsed_na) - sum_na

    ## alternative treatment for the unparsed times
    if (!is.null(altern_fmt) && failed > 0){
        sep <- attr(altern_fmt, "sep")
        ## cat("Trying alternative:"); print(formats)
        fmt <- .select_formats(altern_fmt, nr_best)
        out[parsed_na] <- .parseDateTime(gsub(sep_regexp, sep, x[parsed_na]), fmt, quiet, tz)
        failed <- sum(is.na(out$year)) - sum_na
    }

    if( length(x) == sum_na + failed )
        stop("x didn't match any of the format orders: ", paste(formats, collapse= ", "), call. = FALSE)

    if( failed > 0 )
        message(failed, " failed to parse.")
    
    out
}


### INTERNAL
.enclose <- function(fmts)
    paste("@", fmts, "@", sep = "")
    
.select_formats <- function(fmt, nr_best){
    
    fmt <- fmt[order(fmt, decreasing = TRUE)]
    fmt <-
        if( nr_best  < 1 ) fmt[fmt > 0]
        else fmt[1:min(length(fmt), nr_best)]

    ## if( length(fmt) > 1 ) ## longer formats and "%y" format have priority
    ##     fmt <- fmt[order(nzchar(names(fmt)), !grepl("%Y|%OS", names(fmt)), decreasing = TRUE)]

    names(fmt)
}

.parseDateTime <- function(x, formats, quiet, tz){
    out <- strptime(.enclose(x), .enclose(formats[[1]]), tz = tz)
    na <- is.na(out$year)
    newx <- x[na]
    
    if(!quiet &  sum(!na) > 0)
        message(sum(!na), " parsed in ", formats[[1]], " order")
    

    if(length(formats) > 1 &  length(newx) > 0)
        out[na] <- .parseDateTime(newx, formats[-1], quiet, tz)

    ## return POSIXlt
    out
}


.add_missing <- function(formats, missing){    
    stopifnot(is.character(formats))

    out <- strsplit(formats, "%")
    for (fmt in out){
        lenout <- length(out)
        if(nchar(fmt[1]) == 0L) fmt <- fmt[-1]
        if(missing > 0){
            lenfmt <- length(fmt)
            mis <- min(missing, lenfmt-1)
            for (i in 1:mis)
                out[[lenout + i]] <- c("", fmt[1:(lenfmt - i)])
        }else{
            lenfmt <- length(fmt)
            mis <- min(-missing, lenfmt - 1)
            for (i in 1:mis){
                out[[lenout + i]] <- c("", fmt[(i + 1):lenfmt])
            }
        }
    }

    out <- unlist(lapply(out, paste, collapse = "%"), use.names = FALSE)
    ## replace  garbage at the end of string
    out <- gsub("[^[:alnum:]]+$", "", out)
    out
}


.train_formats <- function(x, formats, quiet = FALSE) {
    x <- .enclose(x)
    formats2 <- .enclose(formats)
    trials <- lapply(formats2, function(fmt) strptime(x, fmt))
    successes <- unlist(lapply(trials, function(x) sum(!is.na(x))), use.names = FALSE)
    names(successes) <- formats
    successes
}

.train_head <- function(x){
    ## heuristics
    if(length(x)  < 300)
        NULL
    else
        nr <- head(x, min(100, length(x) %/% 6))
}

.parse_hms <- function(..., type, frac = FALSE, missing = 0){
    if(length(hms <- list(...)) > 1) # avoid converting to string in most common case
        hms <- lapply(hms, .num_to_date)
    hms <- unlist(hms, use.names= FALSE)
    if( frac ){
        sep <- "[^[:alnum:].]+"
        type <- paste(type, ".f", sep = "")
    }else{
        sep <- "[^[:alnum:]]+"
    }
    formats <- lubridate_formats[[type]]
    formats <- paste("%Y%m%d", formats, sep = "")
    ## ugly hack, but what can we do :(
    tryCatch(parseDateTime(paste("1970-01-01", hms, sep = " "), formats,
                   sep_regexp = sep, missing =  missing, quiet = TRUE, train = .train_head(hms)),
             error = function(e){
                 e$message <- gsub("%Y%m%d|%Y-%m-%d", "", e$message)
                 stop(e)
             })
}


.parse_xxx_hms <- function(..., type, missing, quiet, tz, frac = FALSE){
    if(length(dates <- list(...)) > 1) # avoid converting to string in most common case
        dates <- lapply(dates, .num_to_date)
    dates <- unlist(dates, use.names= FALSE)
    if( frac ){
        sep <- "[^[:alnum:].]+"
        type <- paste(type, ".f", sep = "")
    }else{
        sep <- "[^[:alnum:]]+"
    }
    as.POSIXct(parseDateTime(dates, lubridate_formats[[type]], tz = tz,  sep_regexp = sep,
                             missing = missing, quiet = quiet, train = .train_head(dates)))
}

.parse_xxx_hm <- function(..., type, missing, quiet, tz){
    if(length(dates <- list(...)) > 1) # avoid converting to string in most common case
        dates <- lapply(dates, .num_to_date)
    dates <- unlist(dates, use.names= FALSE)
    as.POSIXct(parseDateTime(dates, lubridate_formats[[type]], tz = tz, missing = missing,
                             quiet = quiet, train = .train_head(dates)))
}

.parse_xxx <- function(..., type, quiet, tz, missing){
    if(length(dates <- list(...)) > 1) # avoid converting to string in most common case
        dates <- lapply(dates, .num_to_date)
    dates <- unlist(dates, use.names= FALSE)
    as.POSIXct(parseDateTime(.num_to_date(dates), lubridate_formats[[type]], quiet = quiet,
                             tz = tz, missing = missing, train = .train_head(dates)))
}


.num_to_date <- function(x) {
  if (is.numeric(x)) {
    x <- as.character(x)
    x <- paste(ifelse(nchar(x) %% 2 == 1, "0", ""), x, sep = "")
  }
  x
}


##' Deprecated internal function, use \code{\link{parseDateTime}} instead.
##'
##'
##' @export parse_date
##' @param x -
##' @param formats -
##' @param quiet -
##' @param seps -
##' @param tz - 
parse_date <- function(x, formats, quiet = FALSE, seps = find_separator(x), tz = "UTC") {

  stop("Internal function parse_date has been removed from lubridate package. Plese use parseDateTime instead.")
}



## parse.r ends here

