#' @include timespans.r
#' @include durations.r
#' @include intervals.r
#' @include periods.r
#' @include Dates.r
#' @include difftimes.r
#' @include numeric.r
#' @include POSIXt.r
#' @include ops-addition.r
NULL

#' Add and subtract months to a date without exceeding the last day of the new month
#'
#' Adding months frustrates basic arithmetic because consecutive months have
#' different lengths. With other elements, it is helpful for arithmetic to
#' perform automatic roll over. For example, 12:00:00 + 61 seconds becomes
#' 12:01:01. However, people often prefer that this behavior NOT occur with
#' months. For example, we sometimes want January 31 + 1 month = February 28 and
#' not March 3. \%m+\% performs this type of arithmetic. Date \%m+\% months(n)
#' always returns a date in the nth month after Date. If the new date would
#' usually spill over into the n + 1th month, \%m+\% will return the last day of
#' the nth month (\code{\link{rollback}}. Date \%m-\% months(n) always returns a
#' date in the nth month before Date.
#'
#' \%m+\% and \%m-\% handle periods with components less than a month by first
#' adding/substracting months and then performing usual arithmetics with smaller
#' units.
#'
#' \%m+\% and \%m-\% should be used with caution as they are not one-to-one
#' operations and results for either will be sensitive to the order of
#' operations.
#'
#' @rdname mplus
#' @usage e1 \%m+\% e2
#' @aliases m+ %m+% m- %m-% %m+%,ANY,ANY-method %m-%,ANY,ANY-method %m+%,Period,ANY-method %m+%,ANY,Period-method %m-%,Period,ANY-method %m-%,ANY,Period-method %m+%,Duration,ANY-method %m+%,ANY,Duration-method %m-%,Duration,ANY-method %m-%,ANY,Duration-method %m+%,Interval,ANY-method %m+%,ANY,Interval-method %m-%,Interval,ANY-method %m-%,ANY,Interval-method
#' @param e1 A period or a date-time object of class \code{\link{POSIXlt}}, \code{\link{POSIXct}}
#' or \code{\link{Date}}.
#' @param e2 A period or a date-time object of class \code{\link{POSIXlt}}, \code{\link{POSIXct}}
#' or \code{\link{Date}}. Note that one of e1 and e2 must be a period and the other a
#' date-time object.
#' @return A date-time object of class POSIXlt, POSIXct or Date
#' @examples
#' jan <- ymd_hms("2010-01-31 03:04:05")
#' jan + months(1:3) # Feb 31 and April 31 returned as NA
#' # NA "2010-03-31 03:04:05 UTC" NA
#' jan %m+% months(1:3) # No rollover
#'
#' leap <- ymd("2012-02-29")
#' "2012-02-29 UTC"
#' leap %m+% years(1)
#' leap %m+% years(-1)
#' leap %m-% years(1)
#' @export
"%m+%" <- function(e1,e2) standardGeneric("%m+%")

#' @export
setGeneric("%m+%")

#' @export
setMethod("%m+%", signature(e2 = "Period"),
  function(e1, e2) add_with_rollback(e1, e2))

#' @export
setMethod("%m+%", signature(e1 = "Period"),
  function(e1, e2) add_with_rollback(e2, e1))

#' @export
setMethod("%m+%", signature(e2 = "ANY"),
          function(e1, e2)
            stop("%m+% handles only Period objects as second argument"))

#' @export
"%m-%" <- function(e1,e2) standardGeneric("%m-%")

#' @export
setGeneric("%m-%")

#' @export
setMethod("%m-%", signature(e2 = "Period"),
  function(e1, e2) add_with_rollback(e1, -e2))

#' @export
setMethod("%m-%", signature(e1 = "Period"),
  function(e1, e2) add_with_rollback(e2, -e1))

#' @export
setMethod("%m-%", signature(e2 = "ANY"),
          function(e1, e2)
            stop("%m-% handles only Period objects as second argument"))

#' \code{add_with_rollback} provides additional functionality to \%m+\% and
#' \%m-\%. It allows rollback to first day of the month instead of the last day
#' of the previous month and controls whether HMS component of the end date is
#' preserved or not.
#' @rdname mplus
#' @param roll_to_first rollback to the first day of the month instead of the
#' last day of the previous month (passed to \code{\link{rollback}})
#' @param preserve_hms retains the same hour, minute, and second information? If
#' FALSE, the new date will be at 00:00:00 (passed to \code{\link{rollback}})
#' @export
add_with_rollback <- function(e1, e2, roll_to_first = FALSE, preserve_hms = TRUE) {

  any_HMS <- any(e2@.Data != 0) || any(e2@minute != 0) || any(e2@hour != 0) || any(e2@day != 0)
  any_year <- any(e2@year != 0)
  if (!is.na(any_year) && any_year) {
    e2$month <- 12 * e2@year + e2@month
    e2$year <- 0L
  }

  new <- .quick_month_add(e1, e2@month)
  roll <- day(new) < day(e1)
  roll <- !is.na(roll) & roll
  new[roll] <- rollback(new[roll], roll_to_first = roll_to_first, preserve_hms = preserve_hms)

  if(!is.na(any_HMS) && any_HMS) {
    e2$month <- 0L
    new + e2
  } else {
    new
  }
}

.quick_month_add <- function(object, mval) {
  tzs <- tz(object)
  utc <- as.POSIXlt(force_tz(object, tzone = "UTC"))
  utc$mon <- utc$mon + mval
  utc <- as.POSIXct(utc)
  new <- force_tz(utc, tzone = tzs)
  reclass_date(new, object)
}

#' Roll back date to last day of previous month
#'
#' rollback changes a date to the last day of the previous month or to the first
#' day of the month. Optionally, the new date can retain the same hour, minute,
#' and second information.
#'
#' @export
#' @param dates A POSIXct, POSIXlt or Date class object.
#' @param roll_to_first Rollback to the first day of the month instead of the
#' last day of the previous month
#' @param preserve_hms Retains the same hour, minute, and second information? If
#' FALSE, the new date will be at 00:00:00.
#' @return A date-time object of class POSIXlt, POSIXct or Date, whose day has
#' been adjusted to the last day of the previous month, or to the first day of
#' the month.
#' @examples
#' date <- ymd("2010-03-03")
#' rollback(date)
#'
#' dates <- date + months(0:2)
#' rollback(dates)
#'
#' date <- ymd_hms("2010-03-03 12:44:22")
#' rollback(date)
#' rollback(date, roll_to_first = TRUE)
#' rollback(date, preserve_hms = FALSE)
#' rollback(date, roll_to_first = TRUE, preserve_hms = FALSE)
rollback <- function(dates, roll_to_first = FALSE, preserve_hms = TRUE) {
  if (length(dates) == 0)
    return(dates)
  day(dates) <- 1
  if (!preserve_hms) {
    hour(dates) <- 0
    minute(dates) <- 0
    second(dates) <- 0
  }
  if (roll_to_first) {
    dates
  } else {
    dates - days(1)
  }
}
