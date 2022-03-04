#' @include timespans.r
#' @include durations.r
#' @include intervals.r
#' @include periods.r
#' @include difftimes.r
#' @include numeric.r
NULL


divide_duration_by_duration <- function(dur1, dur2) {
  dur1@.Data / dur2@.Data
}

divide_duration_by_difftime <- function(dur, diff) {
  dur@.Data / as.numeric(diff, units = "secs")
}

divide_duration_by_number <- function(dur, num) {
  new("Duration", dur@.Data / num)
}

divide_interval_by_duration <- function(int, dur) {
  int@.Data / dur@.Data
}

adjust_estimate <- function(est, int, per) {
  start <- int_start(int)
  end <- int_end(int)
  est <- ceiling(est)

  up_date <- add_with_rollback(start, est * per)
  while (length(which <- which(up_date < end))) {
    est[which] <- est[which] + 1
    up_date[which] <- add_with_rollback(up_date[which], est[which] * per[which])
  }

  low_date <- up_date
  while (length(which <- which(low_date > end))) {
    est[which] <- est[which] - 1
    up_date[which] <- low_date[which]
    low_date[which] <- add_with_rollback(start[which], est[which] * per[which])
  }

  frac <-
    as.numeric(difftime(end, low_date, units = "secs")) /
      as.numeric(difftime(up_date, low_date, units = "secs"))

  frac[low_date == up_date] <- 0

  est + frac
}

divide_interval_by_period <- function(int, per) {
  if (length(int) == 0 || length(per) == 0) {
    return(numeric())
  }

  estimate <- int / as.duration(per)
  not_nas <- !is.na(estimate)
  timespans <- match_lengths(int, per)
  if (all(not_nas)) {
    adjust_estimate(estimate, timespans[[1]], timespans[[2]])
  } else {
    int2 <- timespans[[1]][not_nas]
    per2 <- timespans[[2]][not_nas]
    estimate[not_nas] <- adjust_estimate(estimate[not_nas], int2, per2)
    estimate
  }
}

divide_interval_by_difftime <- function(int, diff) {
  int@.Data / as.double(diff, units = "secs")
}

divide_interval_by_number <- function(int, num) {
  starts <- int@start + rep(0, length(num))
  new("Interval", int@.Data / num, start = starts, tzone = int@tzone)
}


divisible_period <- function(per, anchor) {
  per@month <- per@month + 12 * per@year
  per@year <- rep(0, length(per@year))

  secs.in.months <- as.numeric(anchor + months(per@month)) - as.numeric(anchor)
  days.in.months <- round(secs.in.months / 86400)

  per@day <- per@day + days.in.months
  per@month <- 0

  per
}


divide_period_by_period <- function(per1, per2) {
  period_to_seconds(per1) / period_to_seconds(per2)
}

divide_period_by_number <- function(per, num) {
  new("Period", per@.Data / num,
    year = per@year / num,
    month = per@month / num, day = per@day / num, hour = per@hour / num,
    minute = per@minute / num
  )
}



divide_difftime_by_duration <- function(dif, dur) {
  as.numeric(dif, units = "secs") / dur@.Data
}






#' @export
setMethod(
  "/", signature(e1 = "Duration", e2 = "Duration"),
  function(e1, e2) divide_duration_by_duration(e1, e2)
)

#' @export
setMethod("/", signature(e1 = "Duration", e2 = "Interval"), function(e1, e2) {
  stop_incompatible_classes(e1, e2, "/")
})

#' @export
setMethod("/", signature(e1 = "Duration", e2 = "Period"), function(e1, e2) {
  stop_incompatible_classes(e1, e2, "/")
})

#' @export
setMethod(
  "/", signature(e1 = "Duration", e2 = "difftime"),
  function(e1, e2) divide_duration_by_difftime(e1, e2)
)

#' @export
setMethod(
  "/", signature(e1 = "Duration", e2 = "numeric"),
  function(e1, e2) divide_duration_by_number(e1, e2)
)


#' @export
setMethod(
  "/", signature(e1 = "Interval", e2 = "Duration"),
  function(e1, e2) divide_interval_by_duration(e1, e2)
)

#' @export
setMethod("/", signature(e1 = "Interval", e2 = "Interval"), function(e1, e2) {
  stop_incompatible_classes(e1, e2, "/")
})

#' @export
setMethod(
  "/", signature(e1 = "Interval", e2 = "Period"),
  function(e1, e2) divide_interval_by_period(e1, e2)
)

#' @export
setMethod(
  "/", signature(e1 = "Interval", e2 = "difftime"),
  function(e1, e2) divide_interval_by_difftime(e1, e2)
)

#' @export
setMethod(
  "/", signature(e1 = "Interval", e2 = "numeric"),
  function(e1, e2) divide_interval_by_number(e1, e2)
)


#' @export
setMethod("/", signature(e1 = "Period", e2 = "Duration"), function(e1, e2) {
  stop_incompatible_classes(e1, e2, "/")
})

#' @export
setMethod("/", signature(e1 = "Period", e2 = "Interval"), function(e1, e2) {
  stop_incompatible_classes(e1, e2, "/")
})

#' @export
setMethod(
  "/", signature(e1 = "Period", e2 = "Period"),
  function(e1, e2) divide_period_by_period(e1, e2)
)

#' @export
setMethod("/", signature(e1 = "Period", e2 = "difftime"), function(e1, e2) {
  stop_incompatible_classes(e1, e2, "/")
})

#' @export
setMethod(
  "/", signature(e1 = "Period", e2 = "numeric"),
  function(e1, e2) divide_period_by_number(e1, e2)
)



#' @export
setMethod(
  "/", signature(e1 = "difftime", e2 = "Duration"),
  function(e1, e2) divide_difftime_by_duration(e1, e2)
)

#' @export
setMethod("/", signature(e1 = "difftime", e2 = "Interval"), function(e1, e2) {
  stop_incompatible_classes(e1, e2, "/")
})

#' @export
setMethod("/", signature(e1 = "difftime", e2 = "Period"), function(e1, e2) {
  stop_incompatible_classes(e1, e2, "/")
})



#' @export
setMethod(
  "/", signature(e1 = "numeric", e2 = "Duration"),
  function(e1, e2) stop_incompatible_classes(e1, e2, "/")
)
#' @export
setMethod(
  "/", signature(e1 = "numeric", e2 = "Interval"),
  function(e1, e2) stop_incompatible_classes(e1, e2, "/")
)
#' @export
setMethod(
  "/", signature(e1 = "numeric", e2 = "Period"),
  function(e1, e2) stop_incompatible_classes(e1, e2, "/")
)
