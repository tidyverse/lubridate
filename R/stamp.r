##' Format dates and times based on human-friendly templates
##'
##' Stamps are just like [format()], but based on human-friendly
##' templates like "Recorded at 10 am, September 2002" or "Meeting, Sunday May
##' 1, 2000, at 10:20 pm".
##'
##' `stamp()` is a stamping function date-time templates mainly, though it
##' correctly handles all date and time formats as long as they are
##' unambiguous. `stamp_date()`, and `stamp_time()` are the specialized
##' stamps for dates and times (MHS). These function might be useful when the
##' input template is unambiguous and matches both a time and a date format.
##'
##' Lubridate tries hard to guess the formats, but often a given format can be
##' interpreted in multiple ways. One way to deal with such cases is to provide
##' unambiguous formats like 22/05/81 instead of 10/05/81 for d/m/y
##' format. Another way is to use a more specialized [`stamp_date`] and
##' [`stamp_time`]. The core function `stamp()` prioritizes longer date-time
##' formats.
##'
##' If `x` is a vector of values \pkg{lubridate} will choose the format which
##' "fits" `x` the best. Note that longer formats are preferred. If you have
##' "22:23:00 PM" then "HMSp" format will be given priority to shorter "HMS"
##' order which also fits the supplied string.
##'
##' Finally, you can give desired format order directly as `orders`
##' argument.
##'
##' @param x a character vector of templates.
##' @param orders orders are sequences of formatting characters which might be
##' used for disambiguation. For example "ymd hms", "aym" etc. See
##' [guess_formats()] for a list of available formats.
##' @param locale locale in which `x` is encoded. On Linux-like systems use
##' `locale -a` in the terminal to list available locales.
##' @param quiet whether to output informative messages.
##' @param exact logical. If `TRUE`, the `orders` parameter is interpreted as an
##'   exact [base::strptime()] format and no format guessing is performed.
##' @return a function to be applied on a vector of dates
##' @seealso [guess_formats()], [parse_date_time()], [strptime()]
##' @export
##' @examples
##' D <- ymd("2010-04-05") - days(1:5)
##' stamp("March 1, 1999")(D)
##' sf <- stamp("Created on Sunday, Jan 1, 1999 3:34 pm")
##' sf(D)
##' stamp("Jan 01")(D)
##' stamp("Sunday, May 1, 2000", locale = "C")(D)
##' stamp("Sun Aug 5")(D) #=> "Sun Aug 04" "Sat Aug 04" "Fri Aug 04" "Thu Aug 04" "Wed Aug 03"
##' stamp("12/31/99")(D)              #=> "06/09/11"
##' stamp("Sunday, May 1, 2000 22:10", locale = "C")(D)
##' stamp("2013-01-01T06:00:00Z")(D)
##' stamp("2013-01-01T00:00:00-06")(D)
##' stamp("2013-01-01T00:00:00-08:00")(force_tz(D, "America/Chicago"))
stamp <- function(x, orders = lubridate_formats,
                  locale = Sys.getlocale("LC_TIME"),
                  quiet = FALSE, exact = FALSE) {
  if (exact) {
    stopifnot(length(orders) > 0)
    fmts <- orders
  } else {
    fmts <- unique(guess_formats(x, orders, locale))
    ## remove internal lubridate formats except of the ISO8601 time zone formats
    fmts <- grep("%O[^oOzudHImMUVwWy]", fmts, value = TRUE, invert = TRUE)
    if (is.null(fmts)) stop("Couldn't guess formats of: ", x)
  }
  if (length(fmts) == 1L) {
    FMT <- fmts[[1]]
  } else {
    trained <- .train_formats(x, fmts, locale = locale)
    formats <- .select_formats(trained)
    FMT <- formats[[1]]
    if (!quiet && length(trained) > 1) {
      message(
        "Multiple formats matched: ",
        paste("\"", names(trained), "\"(", trained, ")",
          sep = "",
          collapse = ", "
        )
      )
    }
  }

  if (!quiet) {
    message("Using: \"", FMT, "\"")
  }


  ## format doesn't accept 'locale' argument; need a hard reset
  reset_local_expr <-
    quote({
      old_lc_time <- Sys.getlocale("LC_TIME")
      if (old_lc_time != locale) {
        on.exit(Sys.setlocale("LC_TIME", old_lc_time))
        Sys.setlocale("LC_TIME", locale)
      }
    })

  ## ISO8601
  ## %Ou: "2013-04-16T04:59:59Z"
  ## %Oo: "2013-04-16T04:59:59+01"
  ## %Oz: "2013-04-16T04:59:59+0100"
  ## %OO: "2013-04-16T04:59:59+01:00"

  ## Is a timezone format?
  if (grepl("%O[oOzu]|%z", FMT)) {
    ## We need to post-process x in the case of %Oo, %OO and %Oz formats
    ## because standard %z output format ignores timezone.

    ## Post-process only when at the end of the string, otherwise don't bother
    ## and just output with %z format after a conversion to UTC.

    # replicate str_extract(FMT, "%O[oOz]$") without stringr dependence.
    # must return NA if no match.
    oOz_end <- ifelse(grepl("%O[oOz]$", FMT), gsub("^.*(%O[oOz]$)", "\\1", FMT), rep(NA, length(FMT)))

    if (is.na(oOz_end)) {
      FMT <- sub(
        "%O[oOz]", "%z",
        sub("%Ou", "Z", FMT, fixed = TRUE)
      )

      out <- eval(bquote(
        function(x, locale = .(locale)) {
          ## %z ignores timezone
          if (!is_utc(tz(x[[1L]]))) {
            x <- with_tz(x, tzone = "UTC")
          }
          .(reset_local_expr)
          format(x, format = .(FMT))
        }
      ))
    } else {
      FMT <- sub("%O[oOz]$", "", FMT)

      out <- eval(bquote(
        function(x, locale = .(locale)) {
          .(reset_local_expr)
          paste0(
            format(x, format = .(FMT)),
            .format_offset(x, fmt = .(oOz_end))
          )
        }
      ))
    }
  } else {
    ## most common case
    out <- eval(bquote(function(x, locale = .(locale)) {
      .(reset_local_expr)
      format(x, format = .(FMT))
    }))
  }

  attr(out, "srcref") <- NULL
  out
}


.format_offset <- function(x, fmt = "%Oz") {
  ## .format_offset
  ##
  ## function to format the offset of a time from UTC
  ##
  ## This is an internal function, used in conjunction with [stamp()].
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

  ## calculate offset by forcing this time as utc
  dtm_utc <- force_tz(x, tzone = "UTC")

  ## the offset is the duration represented by the difference in time
  offset_duration <- difftime(dtm_utc, x, units = "secs")

  ## determine sign
  .sgn <- ifelse(offset_duration >= as.duration(0), "+", "-")

  ## remove sign
  offset_duration <- abs(offset_duration)

  ## determine hour
  .hr <- floor(offset_duration / dhours(1))

  ## determine minutes
  .min <- floor((offset_duration - dhours(.hr)) / dminutes(1))

  ## warning if we need minutes, but are using format without minutes
  if (any(.min > 0) & fmt == "%Oo") {
    warning("timezone offset-minutes are non-zero - changing format to %Oz")
    fmt <- "%Oz"
  }

  result <- switch(fmt,
    "%Oo" = sprintf("%s%02d", .sgn, .hr),
    "%Oz" = sprintf("%s%02d%02d", .sgn, .hr, .min),
    "%OO" = sprintf("%s%02d:%02d", .sgn, .hr, .min)
  )

  return(result)
}

##' @rdname stamp
##' @export
stamp_date <- function(x, locale = Sys.getlocale("LC_TIME"), quiet = FALSE) {
  stamp(x,
    orders = c("ymd", "dmy", "mdy", "ydm", "dym", "myd", "my", "ym", "md", "dm", "m", "d", "y"),
    locale = locale, quiet = quiet
  )
}

##' @rdname stamp
##' @export
stamp_time <- function(x, locale = Sys.getlocale("LC_TIME"), quiet = FALSE) {
  stamp(x,
    orders = c("hms", "hm", "ms", "h", "m", "s"),
    locale = locale, quiet = quiet
  )
}


lubridate_formats <- local({
  xxx <- c("ymd", "ydm", "mdy", "myd", "dmy", "dym")
  names(xxx) <- xxx
  out <- character()
  for (D in xxx) {
    out[[paste(D, "_hms", sep = "")]] <- paste(xxx[[D]], "T", sep = "")
    out[[paste(D, "_hm", sep = "")]] <- paste(xxx[[D]], "R", sep = "")
    out[[paste(D, "_h", sep = "")]] <- paste(xxx[[D]], "r", sep = "")
  }

  out <- c(out, xxx,
    my = "my", ym = "ym", md = "md", dm = "dm",
    hms = "T", hm = "R", ms = "MS", h = "r", m = "m", y = "y"
  )

  ## adding ISO8601
  out <- c(ymd_hmsz = "ymdTz", out)

  out
})
