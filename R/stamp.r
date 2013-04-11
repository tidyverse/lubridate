##' Format dates and times based on human-friendly templates.
##'
##' Stamps are just like \code{\link{format}}, but based on human-frendly
##' templates like "Recorded at 10 am, September 2002" or "Meeting, Sunday May
##' 1, 2000, at 10:20 pm".
##'
##' \code{stamp} is a stamping function date-time templates mainly, though it
##' correctly handles all date and time formats as long as they are
##' unambiguous. \code{stamp_date}, and \code{stamp_time} are the specialized
##' stamps for dates and times (MHS). These function might be useful when the
##' input template is unambiguous and matches both a time and a date format.
##'
##' Lubridate tries it's best to figure our the formats, but often a given
##' format can be interpreted in several ways. One way to deal with the
##' situation is to provide unambiguous formats like 22/05/81 instead of
##' 10/05/81 if you want d/m/y format. Another option is to use a more
##' specialized stamp_date and stamp_time. The core function \code{stamp} give
##' priority to longer date-time formats.
##'
##' Another option is to proved a vector of several values as \code{x}
##' parameter. Then lubridate will choose the format which fits \code{x} the
##' best. Note that longer formats are preferred. If you have "22:23:00 PM" then
##' "HMSp" format will be given priority to shorter "HMS" order which also fits
##' the supplied string.
##'
##' Finally, you can give desired format order directly as \code{orders}
##' argument.
##'
##' @param x a character vector of templates.
##' @param orders orders are sequences of formatting characters which might be
##' used for disambiguation. For example "ymd hms", "aym" etc. See
##' \code{\link{guess_formats}} for a list of available formats.
##' @param locale locale in which \code{x} is encoded. On linux like systems use
##' \code{locale -a} in terminal to list available locales.
##' @param quiet whether to output informative messages.
##' @return a function to be applied on a vector of dates
##' @seealso \link{guess_formats}, \link{parse_date_time}, \link{strptime}
##' @export
##' @examples
##' D <- ymd("2010-04-05") - days(1:5)
##' stamp("March 1, 1999")(D)
##' sf <- stamp("Created on Sunday, Jan 1, 1999 3:34 pm")
##' sf(D)
##' stamp("Jan 01")(D)
##' stamp("Sunday, May 1, 2000")(D)
##' stamp("Sun Aug 5")(D) #=> "Sun Aug 04" "Sat Aug 04" "Fri Aug 04" "Thu Aug 04" "Wed Aug 03"
##' stamp("12/31/99")(D)              #=> "06/09/11"
##' stamp("Sunday, May 1, 2000 22:10")(D)
stamp <- function(x, orders = lubridate_formats,
                  locale = Sys.getlocale("LC_TIME"), quiet = FALSE){
  ## if( is.null(orders) )
  ##   orders <- 
  
  fmts <- unique(guess_formats(x, orders, locale))
  if( is.null(fmts) ) stop( "Couldn't quess formats of: ", x)
  if( length(fmts) == 1L ){
    FMT <- fmts[[1]]
  }else{
    trained <- .train_formats(x, fmts)
    formats <- .select_formats(trained)
    FMT <- formats[[1]]
    if( !quiet && length(trained) > 1 )
      message("Multiple formats matched: ", paste("\"", names(trained),"\"(", trained, ")", sep = "", collapse= ", "))
  }
  
  if( !quiet )
    message("Using: \"", FMT, "\"")
  
  f <- 
    eval(
      substitute(
        function(x){ 
          
          # regular expression to detect ISO-8601 format, 
          #   ends with "%Ou", "%Oo", "%Oz", "%OO"
          regexp_8601 <- "%O\\w$"
          
          # do we have an ISO-8601 format?
          ifelse(
            str_detect(FMT, regexp_8601), 
{ # yes - find out which one and use its function
  sub_fmt <- str_extract(FMT, regexp_8601)
  switch(
    sub_fmt,
    "%Ou" = { # ex: "2013-04-16T04:59:59Z"
      FMT_new <- str_replace(FMT, regexp_8601, "Z")
      x <- with_tz(x, tzone="UTC")
      format(x, format = FMT_new)
    },
{ # All others:
  # %Oo: "2013-04-16T04:59:59+01"
  # %Oz: "2013-04-16T04:59:59+0100"
  # %OO: "2013-04-16T04:59:59+01:00"
  FMT_new <- str_replace(FMT, regexp_8601, "")
  str_join(format(x, format = FMT_new),
           format_offset(x, fmt=sub_fmt))
}
  )
},
            # no - use default function
            format(x, format = FMT)
          )                    
          
        }, 
        list(FMT = FMT)
      ), 
      envir = topenv()
    )
  
  
  
  
  
  
  attr(f, "srcref") <- NULL
  f
}

##' format_offset
##' 
##' function to format the offset of a time from UTC
##' 
##' This is an internal function, used in conjunction with \code{\link{stamp}}.
##' There are three available formats:
##' 
##' \itemize{
##'   \item \code{%Oo} +01
##'   \item \code{%Oz} +0100
##'   \item \code{%OO} +01:00
##' }
##' 
##' If the \code{%Oo} format is used for a half-hour timezone, a warning 
##' is issued, and the format is changed to \code{%Oz} 
##' 
##' @param x      POSIXct for which offset-string is sought
##' @param fmt    string describing format of offset, default: \code{%Oz}
##' 
##' @return string
##' 
format_offset <- function(x, fmt="%Oz"){
  
  # "%Oo"  +01
  # "%Oz"  +0100
  # "%OO"  +01:00  
  
  # calulate offset by forcing this time as utc
  dtm_utc <- force_tz(x, tz="UTC")
  
  # the offset is the duration represented by the difference in time
  offset_duration = as.duration(dtm_utc - x)
  
  # determine sign 
  .sgn <- ifelse(offset_duration >= 0, "+", "-")
  
  # remove sign
  offset_duration <- abs(offset_duration)
  
  # determine hour
  .hr <- floor(offset_duration/dhours(1))
  
  # determine minutes
  .min <- floor((offset_duration-dhours(.hr))/dminutes(1))
  
  # warning if we need minutes, but are using format without minutes
  if (any(.min > 0) & fmt=="%Oo"){
    warning("timezone offset-minutes are non-zero - changing format to %Oz")
    fmt <- "%Oz"
  }
  
  result <- switch(
    fmt,
    "%Oo" = sprintf("%s%02d", .sgn, .hr),
    "%Oz" = sprintf("%s%02d%02d", .sgn, .hr, .min),
    "%OO" = sprintf("%s%02d:%02d", .sgn, .hr, .min)
  )  
  
  return(result)
}


##'
##' @rdname stamp
##' @export
stamp_date <- function(x, locale = Sys.getlocale("LC_TIME"))
  stamp(x, orders = c("ymd", "dmy", "mdy", "ydm", "dym", "myd", "my", "ym", "md", "dm", "m", "d", "y"),
        locale = locale)

##'
##' @rdname stamp
##' @export
stamp_time <- function(x, locale = Sys.getlocale("LC_TIME"))
  stamp(x, orders = c("hms", "hm", "ms", "h", "m", "s"), locale = locale)

##' Lubridate format orders used in \code{stamp}
##' 
##' @format  character vector of formats.
##' @docType data
##' @seealso \code{\link{parse_date_time}}, \code{\link{ymd}}, \code{\link{ymd_hms}}
##' @keywords chron
##' @examples
##' str(lubridate_formats)
lubridate_formats <- local({
  xxx <- c( "ymd", "ydm", "mdy", "myd", "dmy", "dym")
  names(xxx) <- xxx    
  out <- character()
  for(D in xxx){
    out[[paste(D, "_hms", sep = "")]] <- paste(xxx[[D]], "T", sep = "")
    out[[paste(D, "_hm", sep = "")]] <- paste(xxx[[D]], "R", sep = "")
    out[[paste(D, "_h", sep = "")]] <- paste(xxx[[D]], "r", sep = "")
  }    
  
  out <- c(out, xxx, my = "my", ym = "ym", md = "md", dm = "dm", 
           hms = "T", hm = "R", ms = "MS", h = "r", m = "m", y = "y")
  
  # adding ISO8601
  out <- c(ymd_hmsz="ymdTz", out)
  
  out
})
