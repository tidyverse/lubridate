#' Get date-time in a different time zone
#'
#' with_tz returns a date-time as it would appear in a different time zone.
#' The actual moment of time measured does not change, just the time zone it is
#' measured in. with_tz defaults to the Universal Coordinated time zone (UTC)
#' when an unrecognized time zone is inputted. See [Sys.timezone()]
#' for more information on how R recognizes time zones.
#'
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
#' x <- ymd_hms("2009-08-07 00:00:01", tz = "America/New_York")
#' with_tz(x, "GMT")
#' @export
with_tz <- function (time, tzone = "") {
  if (!C_valid_tz(tzone))
    warning(sprintf("Unrecognized time zone '%s'", tzone))
  if (is.data.frame(time)) {
    for (nm in names(time)) {
      if (is.POSIXt(time[[nm]])) {
        time[[nm]] <- .with_tz(time[[nm]], tzone = tzone)
      }
    }
    time
  } else {
    .with_tz(time, tzone)
  }
}

.with_tz <- function(time, tzone = "") {
  if (!is.POSIXt(time)) {
    time <- as.POSIXct(time)
  }
  attr(time, "tzone") <- tzone
  time
}

#' Replace time zone to create new date-time
#'
#' `force_tz` returns the date-time that has the same clock time as input time,
#'  but in the new time zone. `force_tzs` is the parallel version of `force_tz`,
#'  meaning that every element from `time` argument is matched with the
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
#' @seealso [with_tz()], [local_time()]
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
  tzone <- as.character(tzone)
  if (is.data.frame(time)) {
    for (nm in names(time)) {
      if (is.POSIXt(time[[nm]])) {
        time[[nm]] <- force_tz(time[[nm]], tzone = tzone)
      }
    }
    time
  } else {
    if (is.POSIXct(time))
      C_force_tz(time, tz = tzone, roll)
    else if (is.Date(time))
      C_force_tz(date_to_posix(time), tz = tzone, roll)
    else {
      out <- C_force_tz(as.POSIXct(time, tz = tz(time)), tz = tzone, roll)
      reclass_date(out, time)
    }
  }
}

#' @param tzones character vector of timezones to be "enforced" on `time` time
#'   stamps. If `time` and `tzones` lengths differ, the smaller one is recycled
#'   in accordance with usual R conventions.
#' @param tzone_out timezone of the returned date-time vector (for `force_tzs`).
#' @rdname force_tz
#' @examples
#'
#' ## Heterogeneous time-zones:
#'
#' x <- ymd_hms(c("2009-08-07 00:00:01", "2009-08-07 01:02:03"))
#' force_tzs(x, tzones = c("America/New_York", "Europe/Amsterdam"))
#' force_tzs(x, tzones = c("America/New_York", "Europe/Amsterdam"), tzone_out = "America/New_York")
#'
#' x <- ymd_hms("2009-08-07 00:00:01")
#' force_tzs(x, tzones = c("America/New_York", "Europe/Amsterdam"))
#' @export
force_tzs <- function(time, tzones, tzone_out = "UTC", roll = FALSE) {
  if (length(tzones) < length(time))
    tzones <- rep_len(tzones, length(time))
  else if (length(tzones) > length(time)) {
    attr <- attributes(time)
    time <- rep_len(time, length(tzones))
    attributes(time) <- attr
  }
  out <- C_force_tzs(as.POSIXct(time), tzones, tzone_out, roll)
  reclass_date(out, time)
}

#' Get local time from a date-time vector.
#'
#' `local_time` retrieves day clock time in specified time zones. Computation is
#' vectorized over both `dt` and `tz` arguments, the shortest is recycled in
#' accordance with standard R rules.
#'
#' @param dt a date-time object.
#' @param tz a character vector of timezones for which to compute the local time.
#' @param units passed directly to [as.difftime()].
#' @examples
#'
#' x <- ymd_hms(c("2009-08-07 01:02:03", "2009-08-07 10:20:30"))
#' local_time(x, units = "secs")
#' local_time(x, units = "hours")
#' local_time(x, "Europe/Amsterdam")
#' local_time(x, "Europe/Amsterdam") == local_time(with_tz(x, "Europe/Amsterdam"))
#'
#' x <- ymd_hms("2009-08-07 01:02:03")
#' local_time(x, c("America/New_York", "Europe/Amsterdam", "Asia/Shanghai"), unit = "hours")
#' @export
local_time <- function(dt, tz = NULL, units = "secs") {
  if (is.null(tz))
    tz <- tz(dt)
  if (length(tz) < length(dt))
    tz <- rep_len(tz, length(dt))
  else if (length(tz) > length(dt)) {
    attr <- attributes(dt)
    dt <- rep_len(dt, length(tz))
    attributes(dt) <- attr
  }
  secs <- C_local_time(as.POSIXct(dt), tz)
  out <- structure(secs, units = "secs", class = "difftime")
  units(out) <- units
  out
}
