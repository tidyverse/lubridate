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
##' @seealso \link{guess_formats}, \link{parseDateTime}, \link{strptime}
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
stamp <- function(x, orders = unlist(lubridate_formats),
                  locale = Sys.getlocale("LC_TIME"), quiet = FALSE){
  ## if( is.null(orders) )
  ##   orders <- 

  fmts <- guess_formats(x, orders, locale)
  if( is.null(fmts) ) stop( "Couldn't quess formats of: ", x)
  if( length(fmts) == 1L ){
    FMT <- fmts[[1]]
  }else{
    trained <- .train_formats(x, unique(fmts))
    formats <- .select_formats(trained)
    FMT <- formats[[1]]
    if( !quiet && length(trained) > 1 )
      message("Multiple formats matched: ", paste("\"", names(trained),"\"(", trained, ")", sep = "", collapse= ", "))
  }

  if( !quiet )
    message("Using: \"", FMT, "\"")

  f <- eval(substitute(function(x){ format(x, format = FMT)}, list(FMT = FMT)), envir = topenv())
  attr(f, "srcref") <- NULL
  f
}


##'
##' @rdname stamp
##' @param x 
##' @param locale
##' @export
stamp_date <- function(x, locale = Sys.getlocale("LC_TIME"))
  stamp(x, orders = c("ymd", "dmy", "mdy", "ydm", "dym", "myd", "my", "ym", "md", "dm", "m", "d", "y"),
        locale = locale)



##'
##' @rdname stamp
##' @param x 
##' @param locale
##' @export
stamp_time <- function(x, locale = Sys.getlocale("LC_TIME"))
  stamp(x, orders = c("hms", "hm", "ms", "h", "m", "s"), locale = locale)

