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
##' stamp("Sunday, May 1, 2000", locale = "en_US")(D)
##' stamp("Sun Aug 5")(D) #=> "Sun Aug 04" "Sat Aug 04" "Fri Aug 04" "Thu Aug 04" "Wed Aug 03"
##' stamp("12/31/99")(D)              #=> "06/09/11"
##' stamp("Sunday, May 1, 2000 22:10", locale = "en_US")(D)
##' stamp("2013-01-01T06:00:00Z")(D)
##' stamp("2013-01-01T00:00:00-06")(D)
##' stamp("2013-01-01T00:00:00-08:00")(force_tz(D, "America/Chicago"))
stamp <- function(x, orders = lubridate_formats,
                  locale = Sys.getlocale("LC_TIME"), quiet = FALSE){

  fmts <- unique(guess_formats(x, orders, locale))
  if( is.null(fmts) ) stop( "Couldn't guess formats of: ", x)
  if( length(fmts) == 1L ){
    FMT <- fmts[[1]]
  }else{
    trained <- .train_formats(x, fmts)
    formats <- .select_formats(trained)
    FMT <- formats[[1]]
    if( !quiet && length(trained) > 1 ) {
      message("Multiple formats matched: ",
              paste("\"", names(trained),"\"(", trained, ")", sep = "",
                    collapse= ", "))
    }
  }

  if( !quiet )
      message("Using: \"", FMT, "\"")

  ## ISO8601
  ## %Ou: "2013-04-16T04:59:59Z"
  ## %Oo: "2013-04-16T04:59:59+01"
  ## %Oz: "2013-04-16T04:59:59+0100"
  ## %OO: "2013-04-16T04:59:59+01:00"

  ## Is a timezone format?
  if( grepl("%O[oOzu]|%z", FMT) ){
    ## We need to post-process x in the case of %Oo, %OO and %Oz formats
    ## because standard %z output format ignores timezone.

    ## Post-process only when at the end of the string, otherwise don't bother
    ## and just output with %z format after a conversion to UTC.

    oOz_end <- str_extract(FMT, "%O[oOz]$")

    if(is.na(oOz_end)){
      FMT <- sub("%O[oOz]", "%z",
                 sub("%Ou", "Z", FMT, fixed = TRUE))

      eval(bquote(
        function(x){
          ## %z ignores timezone
          if(tz(x[[1]]) != "UTC")
            x <- with_tz(x, tzone = "UTC")
          format(x, format = .(FMT))
        }))

    } else {
      FMT <- sub("%O[oOz]$", "", FMT)

      eval(bquote(
        function(x) paste0(format(x, format = .(FMT)),
                           .format_offset(x, fmt = .(oOz_end)))))
    }

  } else {
    ## most common case
    eval(bquote(function(x) format(x, format = .(FMT))))
  }
}

.format_offset <- function(x, fmt="%Oz"){
  ## .format_offset
  ##
  ## function to format the offset of a time from UTC
  ##
  ## This is an internal function, used in conjunction with \code{\link{stamp}}.
  ## There are three available formats:
  ##
  ## \itemize{
  ##   \item \code{\%Oo} +01
  ##   \item \code{\%Oz} +0100
  ##   \item \code{\%OO} +01:00
  ## }
  ##
  ## If the \code{\%Oo} format is used for a half-hour timezone, a warning
  ## is issued, and the format is changed to \code{\%Oz}
  ##
  ## @param x      POSIXct for which offset-string is sought
  ## @param fmt    string describing format of offset, default: \code{\%Oz}
  ##
  ## @return string
  ##

  ## "%Oo"  +01
  ## "%Oz"  +0100
  ## "%OO"  +01:00

  ## calulate offset by forcing this time as utc
  dtm_utc <- force_tz(x, tzone = "UTC")

  ## the offset is the duration represented by the difference in time
  offset_duration = as.duration(dtm_utc - x)

  ## determine sign
  .sgn <- ifelse(offset_duration >= as.duration(0), "+", "-")

  ## remove sign
  offset_duration <- abs(offset_duration)

  ## determine hour
  .hr <- floor(offset_duration/dhours(1))

  ## determine minutes
  .min <- floor((offset_duration-dhours(.hr))/dminutes(1))

  ## warning if we need minutes, but are using format without minutes
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

##' @rdname stamp
##' @export
stamp_date <- function(x, locale = Sys.getlocale("LC_TIME"))
  stamp(x, orders = c("ymd", "dmy", "mdy", "ydm", "dym", "myd", "my", "ym", "md", "dm", "m", "d", "y"),
        locale = locale)

##' @rdname stamp
##' @export
stamp_time <- function(x, locale = Sys.getlocale("LC_TIME"))
  stamp(x, orders = c("hms", "hm", "ms", "h", "m", "s"), locale = locale)


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

  ## adding ISO8601
  out <- c(ymd_hmsz="ymdTz", out)

  out
})
