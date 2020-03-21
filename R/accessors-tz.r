#' Get/set time zone component of a date-time
#'
#' @description
#' Conveniently get and set the time zone of date-time, automatically
#' converting dates to date-times as needed.
#'
#' Note that `tz<-` is an alias for [force_tz()], which preserves the
#' local time, creating a different instant in time. Use [with_tz()] if you
#' want keep the instant the same, but change the printed representation.
#'
#' @section Valid time zones:
#' Time zones are stored in system specific database, so are not guaranteed
#' to be the same on every system (however, they are usually pretty similar
#' unless your sytsem is very out of date). You can see a complete list with
#' [OlsonNames()]
#'
#' @export
#' @param x A date-time vector, usually of class POSIXct or POSIXlt.
#' @return A character vector of length 1, giving the time zone of the vector.
#'   An empty string (`""`) represents the current/default timezone.
#'
#'   For backward compatibility, the time zone of a date, `NA`, or
#'   character vector is `"UTC"`.
#' @seealso See [DateTimeClasses] for a description of the underlying
#'   `tzone` attribute..
#' @keywords utilities manip chron methods
#' @examples
#' x <- ymd("2012-03-26", tz = "UTC")
#' tz(x)
#'
#' tz(x) <- "GMT"
#' x
tz <- function(x) {
  UseMethod("tz")
}

#' @export
tz.POSIXt <- function(x) {
  tzone <- attr(x, "tzone")
  if (is.null(tzone)) {
    ""
  } else {
    tzone[[1]]
  }
}

#' @export
tz.Date <- function(x) {
  "UTC"
}

#' @export
tz.character <- function(x) {
  "UTC"
}

#' @export
tz.logical <- function(x) {
  if (all(is.na(x))) {
    "UTC"
  } else {
    NextMethod()
  }
}

#' @export
tz.default <- function(x) {
  ### FIXME: make this `stop` in next major release
  ## VS[21-03-2020]: v.1.7.8 already sent notification to broken packages
  warning(
    "tz(): Don't know how to compute timezone for object of class ",
    paste0(class(x), collapse = "/"),
    "; returning \"UTC\". This warning will become an error in the next major version of lubridate.",
    call. = FALSE
  )
  "UTC"
}

#' @export
tz.zoo <- function(x) {
  tz(zoo::index(x))
}

#' @export
tz.zooreg <- function(x) {
  tz(zoo::index(x))
}

#' @export
tz.yearmon <- function(x) {
  "UTC"
}

#' @export
tz.yearqtr <- function(x) {
  "UTC"
}

#' @export
tz.timeSeries <- function(x) {
  tz(x@FinCenter)
}

#' @rdname tz
#' @param value New value of time zone.
#' @export
"tz<-" <- function(x, value) {
  force_tz(x, value)
}
