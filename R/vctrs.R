#' vctrs methods for lubridate
#'
#' @keywords internal
#' @name lubridate-vctrs
NULL

# ------------------------------------------------------------------------------
# Constructors

new_empty_period <- function() {
  period()
}

new_empty_duration <- function() {
  duration()
}

new_empty_interval <- function() {
  interval()
}

# ------------------------------------------------------------------------------
# Period - ptype2

#' @rdname lubridate-vctrs
#' @export vec_ptype2.Period
#' @export
vec_ptype2.Period <- function(x, y, ...) {
  UseMethod("vec_ptype2.Period", y)
}

#' @method vec_ptype2.Period default
#' @export
vec_ptype2.Period.default <- function(x, y, ...) {
  vctrs::vec_default_ptype2(x, y, ...)
}

#' @method vec_ptype2.Period Period
#' @export
vec_ptype2.Period.Period <- function(x, y, ...) {
  new_empty_period()
}

# ------------------------------------------------------------------------------
# Duration - ptype2

#' @rdname lubridate-vctrs
#' @export vec_ptype2.Duration
#' @export
vec_ptype2.Duration <- function(x, y, ...) {
  UseMethod("vec_ptype2.Duration", y)
}

#' @method vec_ptype2.Duration default
#' @export
vec_ptype2.Duration.default <- function(x, y, ...) {
  vctrs::vec_default_ptype2(x, y, ...)
}

#' @method vec_ptype2.Duration Duration
#' @export
vec_ptype2.Duration.Duration <- function(x, y, ...) {
  new_empty_duration()
}

#' @method vec_ptype2.Duration difftime
#' @export
vec_ptype2.Duration.difftime <- function(x, y, ...) {
  new_empty_duration()
}

# Registered in `.onLoad()`
vec_ptype2.difftime.Duration <- function(x, y, ...) {
  new_empty_duration()
}

# ------------------------------------------------------------------------------
# Interval - ptype2

#' @rdname lubridate-vctrs
#' @export vec_ptype2.Interval
#' @export
vec_ptype2.Interval <- function(x, y, ...) {
  UseMethod("vec_ptype2.Interval", y)
}

#' @method vec_ptype2.Interval default
#' @export
vec_ptype2.Interval.default <- function(x, y, ...) {
  vctrs::vec_default_ptype2(x, y, ...)
}

#' @method vec_ptype2.Interval Interval
#' @export
vec_ptype2.Interval.Interval <- function(x, y, ...) {
  new_empty_interval()
}
