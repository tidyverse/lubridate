#' @include timespans.r
#' @include durations.r
#' @include intervals.r
#' @include periods.r


setOldClass("difftime")

#' Create a difftime object.
#'
#' `make_difftime()` creates a difftime object with the specified number of
#' units. Entries for different units are cumulative. difftime displays
#' durations in various units,  but these units are estimates given for
#' convenience. The underlying object is always recorded as a fixed number of
#' seconds.
#'
#' Conceptually, difftime objects are a type of duration. They measure the
#' exact passage of time but do not always align with measurements
#' made in larger units of time such as hours, months and years.
#' This is because the length of larger time units can be affected
#' by conventions such as leap years
#' and Daylight Savings Time. \pkg{lubridate} provides a second class for measuring durations, the Duration class.
#' @param num Optional number of seconds
#' @param units a character vector that lists the type of units to use for the
#'   display of the return value (see examples). If `units` is "auto" (the
#'   default) the display units are computed automatically. This might create
#'   undesirable effects when converting `difftime` objects to numeric
#'   values in data processing.
#' @param ... a list of time units to be included in the difftime and their amounts. Seconds,
#'   minutes, hours, days, and weeks are supported. Normally only one of `num` or `...` are present. If
#'   both are present, the `difftime` objects are concatenated.
#' @return a difftime object
#' @seealso [duration()], [as.duration()]
#' @keywords chron classes
#' @export
#' @examples
#' make_difftime(1)
#' make_difftime(60)
#' make_difftime(3600)
#' make_difftime(3600, units = "minute")
#' # Time difference of 60 mins
#' make_difftime(second = 90)
#' # Time difference of 1.5 mins
#' make_difftime(minute = 1.5)
#' # Time difference of 1.5 mins
#' make_difftime(second = 3, minute = 1.5, hour = 2, day = 6, week = 1)
#' # Time difference of 13.08441 days
#' make_difftime(hour = 1, minute = -60)
#' # Time difference of 0 secs
#' make_difftime(day = -1)
#' # Time difference of -1 days
#' make_difftime(120, day = -1, units = "minute")
#' # Time differences in mins
make_difftime <- function(num = NULL, units = "auto", ...) {
  pieces <- list(...)
  if (!is.null(num) && length(pieces) > 0) {
    .difftime_from_num(c(num, .difftime_from_pieces(pieces)), units)
  } else if (!is.null(num)) {
    .difftime_from_num(num, units)
  } else if (length(pieces)) {
    .difftime_from_num(.difftime_from_pieces(pieces), units)
  } else {
    stop("No valid values have been passed to 'make_difftime' constructor")
  }
}

difftime_lengths <- c(secs = 1, mins = 60, hours = 3600, days = 86400, weeks = 7 * 86400)

.difftime_from_num <- function(num, units = "auto") {
  seconds <- abs(na.omit(num))
  units <- units[[1]]
  if (units == "auto") {
    if (any(seconds < 60))
      units <- "secs"
    else if (any(seconds < 3600))
      units <- "mins"
    else if (any(seconds < 86400))
      units <- "hours"
    else
      units <- "days"
  } else {
    units <- standardise_difftime_names(units)
  }
  structure(num/difftime_lengths[[units]], units = units, class = "difftime")
}

.difftime_from_pieces <- function(pieces) {
  names(pieces) <- standardise_difftime_names(names(pieces))
  out <- 0
  for (nm in names(pieces))
    out <- out + pieces[[nm]] * difftime_lengths[[nm]]
  out
}

#' Is x a difftime object?
#'
#' @export is.difftime
#' @param x an R object
#' @return TRUE if x is a difftime object, FALSE otherwise.
#' @seealso [is.instant()], [is.timespan()], [is.interval()],
#'   [is.period()].
#' @keywords logic chron
#' @examples
#' is.difftime(as.Date("2009-08-03")) # FALSE
#' is.difftime(make_difftime(days = 12.4)) # TRUE
is.difftime <- function(x) is(x, "difftime")
