#' Is x a date-time object?
#'
#' An instant is a specific moment in time. Most common date-time
#' objects (e.g, POSIXct, POSIXlt, and Date objects) are instants.
#'
#' @export is.instant is.timepoint
#' @aliases instant instants is.instant timepoint is.timepoint
#' @param x an R object
#' @return TRUE if x is a POSIXct, POSIXlt, or Date object, FALSE otherwise.
#' @seealso \code{\link{is.timespan}}, \code{\link{is.POSIXt}}, \code{\link{is.Date}}
#' @keywords logic chron
#' @examples
#' is.instant(as.Date("2009-08-03")) # TRUE
#' is.timepoint(5) # FALSE
is.instant <- is.timepoint <- function(x) inherits(x, c("POSIXt", "POSIXct", "POSIXlt", "Date"))

#' The current time
#'
#' @export now
#' @param tzone a character vector specifying which time zone you would like
#' the current time in. tzone defaults to your computer's system timezone.
#' You can retrieve the current time in the Universal Coordinated Time (UTC)
#' with now("UTC").
#' @return the current date and time as a POSIXct object
#'
#' @seealso \code{\link{here}}
#'
#' @keywords chron utilities
#' @examples
#' now()
#' now("GMT")
#' now("")
#' now() == now() # would be true if computer processed both at the same instant
#' now() < now() # TRUE
#' now() > now() # FALSE
now <- function(tzone = "")
  with_tz(Sys.time(), tzone)

#' The current time in your local timezone
#'
#' @export here
#' @return the current date and time as a POSIXct object
#'
#' @seealso \code{\link{now}}
#'
#' @keywords chron utilities
#' @examples
#' here()
here <- function() now("")


#' The current date
#'
#' @export today
#' @param tzone a character vector specifying which time zone you would like to
#'   find the current date of. tzone defaults to the system time zone set on your
#'   computer.
#' @return the current date as a Date object
#'
#' @keywords chron utilities
#' @examples
#' today()
#' today("GMT")
#' today() == today("GMT") # not always true
#' today() < as.Date("2999-01-01") # TRUE  (so far)
today <- function(tzone = "") {
  as.Date(force_tz(floor_date(now(tzone), "day"), tzone = "UTC"))
}


#' 1970-01-01 UTC
#'
#' Origin is the date-time for 1970-01-01 UTC in POSIXct format. This date-time
#' is the origin for the numbering system used by POSIXct, POSIXlt, chron, and
#' Date classes.
#'
#' @export origin
#' @keywords data chron
#' @examples
#' origin
#' # "1970-01-01 GMT"
origin <- with_tz(structure(0, class = c("POSIXct", "POSIXt")), "UTC")


##' Efficient creation of date-times from numeric representations
##'
##' \code{make_datetime} is a very fast drop-in replacement for
##' \code{base::ISOdate} and \code{base::ISOdatetime}. \code{make_date} produces
##' objects of class \code{Date}.
##'
##' Input vectors are silently recycled. All inputs except \code{sec} are
##' silently converted to integer vectors; \code{sec} can be either integer or
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
##' @useDynLib lubridate make_dt
##' @examples
##' make_datetime(year = 1999, month = 12, day = 22, sec = 10)
##' ## "1999-12-22 00:00:10 UTC"
##' make_datetime(year = 1999, month = 12, day = 22, sec = c(10, 11))
##' ## "1999-12-22 00:00:10 UTC" "1999-12-22 00:00:11 UTC"
make_datetime <- function(year = 1970L, month = 1L, day = 1L, hour = 0L, min = 0L, sec = 0, tz = "UTC"){
  lengths <- vapply(list(year, month, day, hour, min, sec), length, 1, USE.NAMES = FALSE)
  if (min(lengths) == 0L){
    .POSIXct(numeric(), tz = tz)
  } else {
    N <- max(lengths)
    .POSIXct(.Call("make_dt",
                   rep_len(as.integer(year), N),
                   rep_len(as.integer(month), N),
                   rep_len(as.integer(day), N),
                   rep_len(as.integer(hour), N),
                   rep_len(as.integer(min), N),
                   rep_len(sec, N)),
             tz = tz)
  }
}

##' @rdname make_datetime
##' @useDynLib lubridate make_d
##' @export
make_date <- function(year = 1970L, month = 1L, day = 1L){
  lengths <- vapply(list(year, month, day), length, 1, USE.NAMES = FALSE)
  if (min(lengths) == 0L){
    as.Date(integer(), origin = origin)
  } else {
    N <- max(lengths)
    secs <- .Call("make_d",
                  rep_len(as.integer(year), N),
                  rep_len(as.integer(month), N),
                  rep_len(as.integer(day), N))
    structure(secs/86400L, class = "Date")
  }
}
