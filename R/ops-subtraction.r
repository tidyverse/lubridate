#' @include timespans.r
#' @include durations.r
#' @include intervals.r
#' @include periods.r
#' @include Dates.r
#' @include difftimes.r
#' @include POSIXt.r
NULL


subtract_interval_from_date <- function(int, date) {
  end <- int@start + int@.Data
  dur <- as.duration(int)
  add_duration_to_date(-dur, date)
}

#' @export
setMethod("-", signature(e1 = "Duration", e2 = "missing"),
          function(e1, e2) multiply_duration_by_number(e1, -1))

#' @export
setMethod("-", signature(e1 = "Interval", e2 = "missing"),
          function(e1, e2) multiply_interval_by_number(e1, -1))

#' @export
setMethod("-", signature(e1 = "Period", e2 = "missing"),
          function(e1, e2) multiply_period_by_number(e1, -1))

classes <- c("Duration", "Period", "Interval", "Date", "POSIXct", "POSIXlt", "numeric")
for(class_i in classes) {
  for (class_j in classes) {
    if (class_i == "numeric" && class_j == "numeric")
      break
    setMethod("-", signature(class_i, class_j), function(e1, e2) e1 + (-e2))
  }
}
