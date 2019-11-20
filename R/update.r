#' Changes the components of a date object
#'
#' `update.Date()` and `update.POSIXt()` return a date with the specified
#' elements updated.  Elements not specified will be left unaltered. update.Date
#' and update.POSIXt do not add the specified values to the existing date, they
#' substitute them for the appropriate parts of the existing date.
#'
#'
#' @name DateTimeUpdate
#' @param object a date-time object
#' @param ... named arguments: years, months, ydays, wdays, mdays, days, hours,
#'   minutes, seconds, tzs (time zone component)
#' @param roll logical. If `TRUE`, and the resulting date-time lands on a
#'   non-existent civil time instant (DST, 29th February, etc.) roll the date
#'   till next valid point. When `FALSE`, the default, produce NA for non
#'   existing date-times.
#' @param week_start week starting day (Default is 7, Sunday). Set
#'   `lubridate.week.start` option to control this.
#' @param simple logical. Deprecated. Same as `roll`.
#' @return a date object with the requested elements updated. The object will
#'   retain its original class unless an element is updated which the original
#'   class does not support. In this case, the date returned will be a POSIXlt
#'   date object.
#' @keywords manip chron
#' @examples
#' date <- ymd("2009-02-10")
#' update(date, year = 2010, month = 1, mday = 1)
#'
#' update(date, year =2010, month = 13, mday = 1)
#'
#' update(date, minute = 10, second = 3)
#' @export
update.POSIXt <- function(object, ..., roll = FALSE,
                          week_start = getOption("lubridate.week.start", 7),
                          simple = NULL) {
  if (!is.null(simple)) roll <- simple
  do.call(update_date_time, c(list(object, roll = roll, week_start = week_start),
                              list(...)))
}

update_date_time <- function(object, years = integer(), months = integer(),
                             days = integer(), mdays = integer(), ydays = integer(), wdays = integer(),
                             hours = integer(), minutes = integer(), seconds = double(), tzs = NULL,
                             roll = FALSE, week_start = 7) {

  if (!length(object)) return(object)

  if (length(days) > 0) mdays = days;
  updates <- list(year = years, month = months,
                  yday = ydays, mday = mdays, wday = wdays,
                  hour = hours, minute = minutes, second = seconds)
  maxlen <- max(unlist(lapply(updates, length)))

  if (maxlen > 1) {
    for (nm in names(updates)) {
      len <- length(updates[[nm]])
      ## len == 1 is treated at C_level
      if (len != maxlen && len > 1)
        updates[[nm]] <- rep_len(updates[[nm]], maxlen)
    }
  }

  if (is.null(tzs))
    tzs <- tz(object)

  ## todo: check if the following lines make any unnecessary copies
  updates[["dt"]] <- as.POSIXct(object)
  updates[["roll"]] <- roll
  updates[["tz"]] <- tzs
  updates[["week_start"]] <- week_start
  reclass_date(do.call(C_update_dt, updates), object)
}

## prior to v1.7.0
update_posixt_old <- function(object, ..., simple = FALSE) {

  if (!length(object)) return(object)
  date <- as.POSIXlt(object)

  ## adjudicate units input
  units <- list(...)
  names(units) <- standardise_lt_names(names(units))

  if (!is.null(new_tz <- units$tz)) {
    units$tz <- NULL
  }

  day.units <- c("day", "wday", "mday", "yday")
  wunit <- day.units %in% names(units)

  if (n <- sum(wunit)) {
    if (n > 1) stop("conflicting days input")
    uname <- day.units[wunit]
    if (uname != "mday") {
      ## we compute everything with mdays (operating with ydays doesn't work)
      if (uname != "day") {
        if (uname == "yday" & !is.null(units$year))
          warning("Updating on both 'year' and 'yday' can lead to wrong results. See bug #319.", call. = F)
        diff <- units[[uname]] - date[[uname]] - 1
        units[[uname]] <- diff + date$mday
      }
      names(units)[names(units) == uname] <- "mday"
    }
  }

  if (!is.null(units$mon)) units$mon <- units$mon - 1
  if (!is.null(units$year)) units$year <- units$year - 1900

  ## make new date-times
  date <- unclass(date)

  date[names(units)] <- units
  date[c("wday", "yday")] <- list(wday = NA, yday = NA)

  ## unbalanced POSIXlt often results in R crashes
  maxlen <- max(unlist(lapply(date, length)))

  if (maxlen > 1) {
    for (nm in names(date))
 if (length(date[[nm]]) != maxlen)
        date[[nm]] <- rep_len(date[[nm]], maxlen)
  }

  class(date) <- c("POSIXlt", "POSIXt")
  if (!is.null(new_tz))
    attr(date, "tzone") <- new_tz

  ## fit to timeline
  ## POSIXct format avoids negative and NA elements in POSIXlt format
  fit_to_timeline(date, class(object)[[1]], simple = simple)
}

#' @export
update.Date <- function(object, ...) {

  ct <- as_datetime(object, tz = "UTC")
  new <- update(ct, ...)
  ## fixme: figure out a way to avoid this, or write specialized update for Date
  new_lt <- as.POSIXlt(new, tz = "UTC")
  if (sum(c(new_lt$hour, new_lt$min, new_lt$sec), na.rm = TRUE)) {
    new
  } else {
    make_date(new_lt$year + 1900, new_lt$mon + 1, new_lt$mday)
  }
}

#' Fit a POSIXlt date-time to the timeline
#'
#' The POSIXlt format allows you to create instants that do not exist in real
#' life due to daylight savings time and other conventions. fit_to_timeline
#' matches POSIXlt date-times to a real times. If an instant does not exist, fit
#' to timeline will replace it with an NA. If an instant does exist, but has
#' been paired with an incorrect timezone/daylight savings time combination,
#' fit_to_timeline returns the instant with the correct combination.
#'
#'
#' @param lt a POSIXlt date-time object.
#' @param class a character string that describes what type of object to return,
#'   POSIXlt or POSIXct. Defaults to POSIXct. This is an optimization to avoid
#'   needless conversions.
#' @param simple if TRUE, \pkg{lubridate} makes no attempt to detect
#'   meaningless time-dates or to correct time zones. No NAs are produced and
#'   the most meaningful valid dates are returned instead. See examples.
#' @return a POSIXct or POSIXlt object that contains no illusory date-times
#'
#' @examples
#' \dontrun{
#'
#' tricky <- structure(list(sec   = c(5,    0,    0,    -1),
#'                          min   = c(0L,   5L,   5L,   0L),
#'                          hour  = c(2L,   0L,   2L,   2L),
#'                          mday  = c(4L,   4L,   14L,  4L),
#'                          mon   = c(10L,  10L,  2L,   10L),
#'                          year  = c(112L, 112L, 110L, 112L),
#'                          wday  = c(0L,   0L,   0L,   0L),
#'                          yday  = c(308L, 308L, 72L,  308L),
#'                          isdst = c(1L,   0L,   0L,   1L)),
#'                     .Names = c("sec", "min", "hour", "mday", "mon",
#'                                "year", "wday", "yday",  "isdst"),
#'                     class = c("POSIXlt", "POSIXt"),
#'                     tzone = c("America/Chicago", "CST", "CDT"))
#'
#' tricky
#' ## [1] "2012-11-04 02:00:00 CDT" Doesn't exist because clocks "fall back" to 1:00 CST
#' ## [2] "2012-11-04 00:05:00 CST" Times are still CDT, not CST at this instant
#' ## [3] "2010-03-14 02:00:00 CDT" DST gap
#' ## [4] "2012-11-04 01:59:59 CDT" Does exist, but has deceptive internal structure
#'
#' fit_to_timeline(tricky)
#' ## Returns:
#' ## [1] "2012-11-04 02:00:00 CST" instant paired with correct tz & DST combination
#' ## [2] "2012-11-04 00:05:00 CDT" instant paired with correct tz & DST combination
#' ## [3] NA - fake time changed to NA (compare to as.POSIXct(tricky))
#' ## [4] "2012-11-04 01:59:59 CDT" -real instant, left as is
#'
#' fit_to_timeline(tricky, simple = TRUE)
#' ## Returns valid time-dates by extrapolating CDT and CST zones:
#' ## [1] "2012-11-04 01:00:05 CST" "2012-11-04 01:05:00 CDT"
#' ## [3] "2010-03-14 03:05:00 CDT" "2012-11-04 01:59:59 CDT"
#' }
#' @export
fit_to_timeline <- function(lt, class = "POSIXct", simple = FALSE) {
  if (class != "POSIXlt" && class != "POSIXct")
    stop("class argument must be POSIXlt or POSIXct")

  if (simple) {

    if (class == "POSIXct") as.POSIXct(lt)
    else as.POSIXlt(as.POSIXct(lt))

  } else {

    ## fall break - DST only changes if it has to
    ct <- as.POSIXct(lt)
    lt2 <- as.POSIXlt(ct)

    dstdiff <- !is.na(ct) & (lt$isdst != lt2$isdst)
    if (any(dstdiff)) {

      dlt <- lt[dstdiff]
      dlt2 <- lt2[dstdiff]
      dlt$isdst <- dlt2$isdst
      dlt$zone <- dlt2$zone
      dlt$gmtoff <- dlt2$gmtoff
      dct <- as.POSIXct(dlt) # should directly match if not in gap

      if (class == "POSIXct")
        ct[dstdiff] <- dct
      else
        lt2[dstdiff] <- dlt

      chours <- format.POSIXlt(as.POSIXlt(dct), "%H", usetz = FALSE)
      lhours <- format.POSIXlt(dlt, "%H", usetz = FALSE)

      any <- any(hdiff <- chours != lhours)
      if (!is.na(any) && any) {
        if (class == "POSIXct")
          ct[dstdiff][hdiff] <- NA
        else
          lt2[dstdiff][hdiff] <- NA
      }
    }
    if (class == "POSIXct") ct else lt2
  }
}
