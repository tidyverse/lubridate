#' vctrs methods for lubridate
#'
#' @keywords internal
#' @name lubridate-vctrs
NULL

# ------------------------------------------------------------------------------
# Constructors

# TODO: Find a way to generate these once at load time for efficiency. S4
# constructors are very slow and these will be called repeatedly. Doing this
# the standard way in `.onLoad()` seems to trigger some unknown S4 bug.

new_empty_period <- function() {
  period()
}

new_empty_duration <- function() {
  duration()
}

new_empty_interval <- function(tzone) {
  interval(tzone = tzone)
}

# ------------------------------------------------------------------------------
# Period - proxy / restore

# Method registered in `.onLoad()`
vec_proxy.Period <- function(x, ...) {
  out <- vec_proxy_period(x)

  # Track vector names as an extra column since data frame
  # row names must be unique
  names <- names(x)
  if (!is.null(names)) {
    out[["rcrd_names"]] <- names
  }

  out
}

# Method registered in `.onLoad()`
vec_proxy_compare.Period <- function(x, ...) {
  vec_proxy_period(x)
}

# Method registered in `.onLoad()`
vec_proxy_equal.Period <- function(x, ...) {
  vec_proxy_period(x)
}

# Method registered in `.onLoad()`
vec_restore.Period <- function(x, to, ...) {
  out <- period(
    year = x$year,
    month = x$month,
    day = x$day,
    hour = x$hour,
    minute = x$minute,
    second = x$second
  )

  names <- x$rcrd_names
  if (!is.null(names)) {
    names(out) <- names
  }

  out
}

vec_proxy_period <- function(x) {
  cols <- list(
    year = x@year,
    month = x@month,
    day = x@day,
    hour = x@hour,
    minute = x@minute,
    second = x@.Data
  )

  n <- length(x@year)

  vctrs::new_data_frame(cols, n = n)
}

# ------------------------------------------------------------------------------
# Period - ptype2

# Method registered in `.onLoad()`
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
# Period - cast

# Method registered in `.onLoad()`
#' @rdname lubridate-vctrs
#' @export vec_cast.Period
#' @export
vec_cast.Period <- function(x, to, ...) {
  UseMethod("vec_cast.Period", x)
}

#' @method vec_cast.Period default
#' @export
vec_cast.Period.default <- function(x, to, ...) {
  vctrs::vec_default_cast(x, to, ...)
}

#' @method vec_cast.Period Period
#' @export
vec_cast.Period.Period <- function(x, to, ...) {
  x
}

# ------------------------------------------------------------------------------
# Duration - proxy / restore

# Method registered in `.onLoad()`
vec_proxy.Duration <- function(x, ...) {
  out <- vec_proxy_duration(x)
  names(out) <- names(x)
  out
}

# Method registered in `.onLoad()`
vec_proxy_compare.Duration <- function(x, ...) {
  vec_proxy_duration(x)
}

# Method registered in `.onLoad()`
vec_proxy_equal.Duration <- function(x, ...) {
  vec_proxy_duration(x)
}

# Method registered in `.onLoad()`
vec_restore.Duration <- function(x, to, ...) {
  out <- duration(x, units = "seconds")
  names(out) <- names(x)
  out
}

vec_proxy_duration <- function(x) {
  x@.Data
}

# ------------------------------------------------------------------------------
# Duration - ptype2

# Method registered in `.onLoad()`
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
# Duration - cast

# Method registered in `.onLoad()`
#' @rdname lubridate-vctrs
#' @export vec_cast.Duration
#' @export
vec_cast.Duration <- function(x, to, ...) {
  UseMethod("vec_cast.Duration", x)
}

#' @method vec_cast.Duration default
#' @export
vec_cast.Duration.default <- function(x, to, ...) {
  vctrs::vec_default_cast(x, to, ...)
}

#' @method vec_cast.Duration Duration
#' @export
vec_cast.Duration.Duration <- function(x, to, ...) {
  x
}

#' @method vec_cast.Duration difftime
#' @export
vec_cast.Duration.difftime <- function(x, to, ...) {
  as_duration_from_difftime(x)
}

# Registered in `.onLoad()`
vec_cast.difftime.Duration <- function(x, to, ...) {
  as_difftime_from_duration(x)
}

# ------------------------------------------------------------------------------
# Interval - ptype2

# Method registered in `.onLoad()`
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
  new_empty_interval(tzone = tz_union(x, y))
}

# ------------------------------------------------------------------------------
# Interval - cast

# Method registered in `.onLoad()`
#' @rdname lubridate-vctrs
#' @export vec_cast.Interval
#' @export
vec_cast.Interval <- function(x, to, ...) {
  UseMethod("vec_cast.Interval", x)
}

#' @method vec_cast.Interval default
#' @export
vec_cast.Interval.default <- function(x, to, ...) {
  vctrs::vec_default_cast(x, to, ...)
}

#' @method vec_cast.Interval Interval
#' @export
vec_cast.Interval.Interval <- function(x, to, ...) {
  x

# ------------------------------------------------------------------------------

tz_is_local <- function(x) {
  identical(x, "")
}

tz_union <- function(x, y) {
  x_tzone <- x@tzone
  y_tzone <- y@tzone

  if (tz_is_local(x_tzone)) {
    y_tzone
  } else {
    x_tzone
  }
}
