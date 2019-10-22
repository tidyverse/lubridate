
#' Cyclic encoding of date-times
#'
#' Encode a date-time object into a cyclic coordinate system in which the
#' distances between two pairs of dates separated by the same time duration are
#' the same.
#'
#' Machine learning models don't know that December 31st and January 1st are
#' close in our human calendar sense. `cyclic_encoding` makes it obvious to the
#' machine learner that two calendar dates are close by mapping the dates onto
#' the circle.
#'
#' @param x a date-time object
#' @param periods a character vector of periods. Follows same specification as
#'   [period] and [floor_date] functions.
#' @param encoders names of functions to produce the encoding. Defaults to
#'   "sin" and "cos". Names of any predefined functions accepting a numeric
#'   input are allowed.
#' @param week_start day starting a week (used for weekly periods).
#' @return a numeric matrix with number of columns equal `length(periods) *
#'   length(types)`.
#' @examples
#'
#' times <- ymd_hms("2019-01-01 00:00:00") + hours(0:23)
#' cyclic_encoding(times, c("day", "week", "month"))
#' plot(cyclic_encoding(times, "1d"))
#' plot(cyclic_encoding(times, "2d"), xlim = c(-1, 1))
#' plot(cyclic_encoding(times, "4d"), xlim = c(-1, 1))
#'
#' @export
cyclic_encoding <- function(x, periods, encoders = c("sin", "cos"),
                             week_start = getOption("lubridate.week.start", 7)) {
  Ne <- length(encoders)
  Np <- length(periods)
  out <- matrix(0, nrow = length(x), ncol = Ne * Np)
  colnames(out) <- paste(rep.int(encoders, Np),
                         rep(periods, each = Ne),
                         sep = ".")
  for (pix in seq_along(periods)) {
    p <- periods[[pix]]
    beg <- as.numeric(floor_date(x, unit = p, week_start = week_start))
    end <- as.numeric(ceiling_date(x, unit = p, week_start = week_start))
    diff <- (2*pi)*(as.numeric(x) - beg)/(end - beg)
    diff[end == beg] <- 0
    for (tix in seq_along(encoders)) {
      out[, (pix - 1)*Ne + tix] <- do.call(encoders[[tix]], list(diff))
    }
  }
  out
}
