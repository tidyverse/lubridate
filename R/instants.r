#' Is x a date-time object?
#'
#' An instant is a specific moment in time. Most common date-time
#' objects (e.g, POSIXct, POSIXlt, and Date objects) are instants.
#'
#' @aliases instant instants
#' @export
#' @param x an R object
#' @return TRUE if x is a POSIXct, POSIXlt, or Date object, FALSE otherwise.
#' @seealso [is.timespan()], [is.POSIXt()], [is.Date()]
#' @keywords logic chron
#' @examples
#' is.instant(as.Date("2009-08-03")) # TRUE
#' is.timepoint(5) # FALSE
is.instant <- function(x) inherits(x, c("POSIXt", "POSIXct", "POSIXlt", "Date"))

#' @export
#' @rdname is.instant
is.timepoint <- is.instant

#' The current day and time
#'
#' @param tzone a character vector specifying which time zone you would like the
#'   current time in. tzone defaults to your computer's system timezone. You can
#'   retrieve the current time in the Universal Coordinated Time (UTC) with
#'   now("UTC").
#' @return `now` - the current datetime as a `POSIXct` object
#'
#' @keywords chron utilities
#' @examples
#' now()
#' now("GMT")
#' now("")
#' now() == now() # would be TRUE if computer processed both at the same instant
#' now() < now() # TRUE
#' now() > now() # FALSE
#' @export
now <- function(tzone = "") {
  with_tz(Sys.time(), tzone)
}


#' @rdname now
#' @examples
#' today()
#' today("GMT")
#' today() == today("GMT") # not always true
#' today() < as.Date("2999-01-01") # TRUE  (so far)
#' @export
today <- function(tzone = "") {
  force_tz(as_date(now()),tzone)
}

#' 1970-01-01 UTC
#'
#' Origin is the date-time for 1970-01-01 UTC in POSIXct format. This date-time
#' is the origin for the numbering system used by POSIXct, POSIXlt, chron, and
#' Date classes.
#'
#' @keywords data chron
#' @examples
#' origin
#' @export origin
origin <- structure(0, class = c("POSIXct", "POSIXt"), tzone = "UTC")

.rep_maybe <- function(x, N) {
  if (N > 1 && length(x) > 1 && length(x) != N) {
    out <- rep_len(x, N)
    ## repl_len doesn't preserve attributes
    if (is.POSIXct(x)) {
      attributes(out) <- attributes(x)
    }
    out
  } else {
    x
  }
}

##' Efficient creation of date-times from numeric representations
##'
##' `make_datetime()` is a very fast drop-in replacement for
##' [base::ISOdate()] and [base::ISOdatetime()]. `make_date()` produces
##' objects of class `Date`.
##'
##' Input vectors are silently recycled. All inputs except `sec` are
##' silently converted to integer vectors; `sec` can be either integer or
##' double.
##'
##' @param year numeric year
##' @param month numeric month
##' @param day numeric day
##' @param hour numeric hour
##' @param min numeric minute
##' @param sec numeric second
##' @param tz time zone. Defaults to UTC.
##' @export
##' @examples
##' make_datetime(year = 1999, month = 12, day = 22, sec = 10)
##' make_datetime(year = 1999, month = 12, day = 22, sec = c(10, 11))
make_datetime <- function(year = 1970L, month = 1L, day = 1L, hour = 0L, min = 0L, sec = 0, tz = "UTC") {
  lengths <- vapply(list(year, month, day, hour, min, sec), length, 1, USE.NAMES = FALSE)
  if (min(lengths) == 0L) {
    .POSIXct(numeric(), tz = tz)
  } else {
    N <- max(lengths)
    timechange::time_update(
      time = .rep_maybe(origin, N),
      year = .rep_maybe(year, N),
      month = .rep_maybe(month, N),
      mday = .rep_maybe(day, N),
      hour = .rep_maybe(hour, N),
      minute = .rep_maybe(min, N),
      second = .rep_maybe(sec, N),
      tz = tz,
      roll_month = "full"
    )
  }
}

##' @rdname make_datetime
##' @export
make_date <- function(year = 1970L, month = 1L, day = 1L) {
  lengths <- vapply(list(year, month, day), length, 1, USE.NAMES = FALSE)
  if (min(lengths) == 0L) {
    as.Date(integer(), origin = origin)
  } else {
    N <- max(lengths)
    secs <- .Call(
      C_make_d,
      rep_len(as.integer(year), N),
      rep_len(as.integer(month), N),
      rep_len(as.integer(day), N)
    )
    structure(secs / 86400L, class = "Date")
  }
}
