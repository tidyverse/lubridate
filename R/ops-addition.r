#' @include timespans.r
#' @include durations.r
#' @include intervals.r
#' @include periods.r
#' @include Dates.r
#' @include difftimes.r
#' @include numeric.r
#' @include POSIXt.r
NULL


add_duration_to_duration <- function(dur2, dur1)
  new("Duration", dur1@.Data + dur2@.Data)

add_duration_to_date <- function(dur, date) {
  if (is.Date(date)) {
    date <- as.POSIXct(date)
    ans <- with_tz(date + dur@.Data, "UTC")

    if (all(is.na(ans))) return(as.Date(ans))  # ALL NAs

    if (all(hour(na.omit(ans)) == 0  &
            minute(na.omit(ans)) == 0 &
            second(na.omit(ans)) == 0)) {
      return(as.Date(ans))
    }

    return(ans)
  }
  new <- date + dur@.Data
  attr(new, "tzone") <- tz(date)
  reclass_date(new, date)
}

add_period_to_period <- function(per2, per1) {
  new("Period", per1@.Data + per2@.Data,
      year = per1@year + per2@year,
      month = per1@month + per2@month,
      day = per1@day + per2@day,
      hour = per1@hour + per2@hour,
      minute = per1@minute + per2@minute)
}

add_period_to_date <- function(per, date) {

  lt <- as.POSIXlt(date)

  ## add months and years with no backwards rollover
  ms <- month(per) + year(per) * 12
  lt <- add_months(lt, ms)

  if (is.Date(date)) {
    new <- update(as.Date(lt),
                  days = mday(lt) + per@day,
                  hours = per@hour,
                  minutes = per@minute,
                  seconds = per@.Data)
    return(new)
  }

  new <- update(lt,
                days = mday(lt) + per@day,
                hours = hour(lt) + per@hour,
                minutes = minute(lt) + per@minute,
                seconds = second(lt) + per@.Data)

  reclass_date(new, date)
}

add_months <- function(mt, mos) {
  nnas <- !is.na(mos)
  if (all(mos[nnas] == 0L)) {
    return(mt)
  }
  mt$mon <- mt$mon + mos
  ndays <- as.numeric(format.POSIXlt(mt, "%d", usetz = FALSE))
  mt$mon[mt$mday != ndays] <- NA
  mt
}

add_number_to_duration <- function(num, dur) {
  new("Duration", dur@.Data + num)
}

add_number_to_period <- function(num, per) {
  slot(per, ".Data") <- per@.Data + num
  per
}

#' @export
setMethod("+", signature(e1 = "Duration", e2 = "Duration"),
          function(e1, e2) add_duration_to_duration(e2, e1))

#' @export
setMethod("+", signature(e1 = "Duration", e2 = "Date"),
          function(e1, e2) add_duration_to_date(e1, e2))

#' @export
setMethod("+", signature(e1 = "Duration", e2 = "difftime"),
          function(e1, e2) add_duration_to_duration(as.duration(e2), e1))

#' @export
setMethod("+", signature(e1 = "Duration", e2 = "numeric"),
          function(e1, e2) add_number_to_duration(e2, e1))

#' @export
setMethod("+", signature(e1 = "Duration", e2 = "Interval"),
          function(e1, e2) add_number_to_duration(e2, e1))

#' @export
setMethod("+", signature(e1 = "Duration", e2 = "POSIXct"),
          function(e1, e2) add_duration_to_date(e1, e2))

#' @export
setMethod("+", signature(e1 = "Duration", e2 = "POSIXlt"),
          function(e1, e2) add_duration_to_date(e1, e2))

#' @export
setMethod("+", signature(e1 = "Period", e2 = "Period"),
          function(e1, e2) add_period_to_period(e2, e1))

#' @export
setMethod("+", signature(e1 = "Period", e2 = "Date"),
          function(e1, e2) add_period_to_date(e1, e2))

#' @export
setMethod("+", signature(e1 = "Period", e2 = "numeric"),
          function(e1, e2) add_number_to_period(e2, e1))

#' @export
setMethod("+", signature(e1 = "Period", e2 = "Interval"),
          function(e1, e2) add_number_to_period(e2, e1))

#' @export
setMethod("+", signature(e1 = "Period", e2 = "POSIXct"),
          function(e1, e2) add_period_to_date(e1, e2))

#' @export
setMethod("+", signature(e1 = "Period", e2 = "POSIXlt"),
          function(e1, e2) add_period_to_date(e1, e2))

#' @export
setMethod("+", signature(e1 = "Date", e2 = "Duration"),
          function(e1, e2) add_duration_to_date(e2, e1))

#' @export
setMethod("+", signature(e1 = "Date", e2 = "Period"),
          function(e1, e2) add_period_to_date(e2, e1))

#' @export
setMethod("+", signature(e1 = "difftime", e2 = "Duration"),
          function(e1, e2) as.difftime(e2, units = "secs") + e1)

#' @export
setMethod("+", signature(e1 = "numeric", e2 = "Duration"),
          function(e1, e2) add_number_to_duration(e1, e2))

#' @export
setMethod("+", signature(e1 = "numeric", e2 = "Period"),
          function(e1, e2) add_number_to_period(e1, e2))

#' @export
setMethod("+", signature(e1 = "Interval", e2 = "Duration"),
          function(e1, e2) add_number_to_duration(e1, e2))

#' @export
setMethod("+", signature(e1 = "Interval", e2 = "Period"),
          function(e1, e2) add_number_to_period(e1, e2))

#' @export
setMethod("+", signature(e1 = "Interval", e2 = "Interval"),
          function(e1, e2) add_number_to_period(e1, e2))

#' @export
setMethod("+", signature(e1 = "POSIXct", e2 = "Duration"),
          function(e1, e2) add_duration_to_date(e2, e1))

#' @export
setMethod("+", signature(e1 = "POSIXct", e2 = "Period"),
          function(e1, e2) add_period_to_date(e2, e1))

#' @export
setMethod("+", signature(e1 = "POSIXlt", e2 = "Duration"),
          function(e1, e2) add_duration_to_date(e2, e1))

#' @export
setMethod("+", signature(e1 = "POSIXlt", e2 = "Period"),
          function(e1, e2) add_period_to_date(e2, e1))
