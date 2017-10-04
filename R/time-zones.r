#' Get date-time in a different time zone
#'
#' with_tz returns a date-time as it would appear in a different time zone.
#' The actual moment of time measured does not change, just the time zone it is
#' measured in. with_tz defaults to the Universal Coordinated time zone (UTC)
#' when an unrecognized time zone is inputted. See [Sys.timezone()]
#' for more information on how R recognizes time zones.
#'
#' @export with_tz
#' @param time a POSIXct, POSIXlt, Date, chron date-time object or a data.frame
#'   object. When a data.frame all POSIXt elements of a data.frame are processed
#'   with `with_tz()` and new data.frame is returned.
#' @param tzone a character string containing the time zone to convert to. R
#'   must recognize the name contained in the string as a time zone on your
#'   system.
#' @return a POSIXct object in the updated time zone
#' @keywords chron manip
#' @seealso [force_tz()]
#' @examples
#' x <- as.POSIXct("2009-08-07 00:00:01", tz = "America/New_York")
#' with_tz(x, "GMT")
with_tz <- function (time, tzone = "") {
  if (is.data.frame(time)) {
    for (nm in names(time)) {
      if (is.POSIXt(time[[nm]])) {
        time[[nm]] <- with_tz(time[[nm]], tzone = tzone)
      }
    }
    time
  } else {
    if (is.POSIXlt(time)) new <- as.POSIXct(time)
    else new <- time
    attr(new, "tzone") <- tzone
    reclass_date(new, time)
  }
}

#' Replace time zone to create new date-time
#'
#' `force_tz` returns the date-time that has the same clock time as input time,
#'  but in the new time zone. `force_tzs` is the parallel version of `force_tz`
#'  in a sense that every element from `time` argument is matched with the
#'  corresponding time zone in `tzones` argument.
#'
#'  Although the new date-time has the same clock time (e.g. the same values in
#'  the year, month, days, etc. elements) it is a different moment of time than
#'  the input date-time.
#'
#'  As R date-time vectors cannot hold elements with non-uniform time zones,
#'  `force_tzs` returns a vector with time zone `tzone_out`, UTC by default.
#'
#' @param time a POSIXct, POSIXlt, Date, chron date-time object, or a data.frame
#'   object. When a data.frame all POSIXt elements of a data.frame are processed
#'   with `force_tz()` and new data.frame is returned.
#' @param tzone a character string containing the time zone to convert to. R
#'   must recognize the name contained in the string as a time zone on your
#'   system.
#' @param roll logical. If TRUE, and `time` falls into the DST-break, assume
#'   the next valid civil time, otherwise return NA. See examples.
#' @return a POSIXct object in the updated time zone
#' @keywords chron manip
#' @seealso [with_tz()]
#' @examples
#' x <- ymd_hms("2009-08-07 00:00:01", tz = "America/New_York")
#' force_tz(x, "UTC")
#' force_tz(x, "Europe/Amsterdam")
#'
#' ## DST skip:
#'
#' y <- ymd_hms("2010-03-14 02:05:05 UTC")
#' force_tz(y, "America/New_York", roll=FALSE)
#' force_tz(y, "America/New_York", roll=TRUE)
#' @export
force_tz <- function(time, tzone = "", roll = FALSE) {
  if (is.data.frame(time)) {
    for (nm in names(time)) {
      if (is.POSIXt(time[[nm]])) {
        time[[nm]] <- force_tz(time[[nm]], tzone = tzone)
      }
    }
    time
  } else {
    out <- C_force_tz(as.POSIXct(time), tz = as.character(tzone), roll)
    reclass_date(out, time)
  }
}

#' @param tzones character vector of timezones to be "enforced" on `time` time
#'   stamps. If `time` and `tzones` lengths differ, usuall R recycling rules
#'   apply.
#' @param tzone_out timezone of the returned date-time vector
#' @rdname force_tz
#' @examples
#'
#' ## Heterogeneous time-zones:
#'
#' x <- ymd_hms(c("2009-08-07 00:00:01", "2009-08-07 00:00:01"))
#' force_tzs(x, tzones = c("America/New_York", "Europe/Amsterdam"))
#' force_tzs(x, tzones = c("America/New_York", "Europe/Amsterdam"), tzone_out = "America/New_York")
#' @export
force_tzs <- function(time, tzones, tzone_out = "UTC", roll = FALSE) {
  if (length(time) != length(tzones))
    tzones <- rep_len(tzones, length(time))
  out <- C_force_tzs(as.POSIXct(time), tzones, tzone_out, roll)
  reclass_date(out, time)
}
