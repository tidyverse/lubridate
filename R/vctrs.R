# ------------------------------------------------------------------------------
# Constructors

# S4 constructors are slow, so empty Period/Duration objects are saved for
# repeated use in `vec_ptype2()`. Interval types depend on the `tzone`, so
# the constructor must be used.

delayedAssign("lubridate_shared_empty_period", period())
delayedAssign("lubridate_shared_empty_duration", duration())

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
vec_ptype2.Period.Period <- function(x, y, ...) {
  lubridate_shared_empty_period
}

# ------------------------------------------------------------------------------
# Period - cast

# Method registered in `.onLoad()`
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
vec_ptype2.Duration.Duration <- function(x, y, ...) {
  lubridate_shared_empty_duration
}

# Method registered in `.onLoad()`
vec_ptype2.Duration.difftime <- function(x, y, ...) {
  lubridate_shared_empty_duration
}

# Method registered in `.onLoad()`
vec_ptype2.difftime.Duration <- function(x, y, ...) {
  lubridate_shared_empty_duration
}

# ------------------------------------------------------------------------------
# Duration - cast

# Method registered in `.onLoad()`
vec_cast.Duration.Duration <- function(x, to, ...) {
  x
}

# Method registered in `.onLoad()`
vec_cast.Duration.difftime <- function(x, to, ...) {
  as_duration_from_difftime(x)
}

# Method registered in `.onLoad()`
vec_cast.difftime.Duration <- function(x, to, ...) {
  as_difftime_from_duration(x)
}

# ------------------------------------------------------------------------------
# Interval - proxy / restore

# Method registered in `.onLoad()`
vec_proxy.Interval <- function(x, ...) {
  out <- vec_proxy_interval(x, vctrs::vec_proxy)

  # Track vector names as an extra column since data frame
  # row names must be unique
  names <- names(x)
  if (!is.null(names)) {
    out[["rcrd_names"]] <- names
  }

  out
}

# Method registered in `.onLoad()`
vec_proxy_compare.Interval <- function(x, ...) {
  vec_proxy_interval(x, vctrs::vec_proxy_compare)
}

# Method registered in `.onLoad()`
vec_proxy_equal.Interval <- function(x, ...) {
  vec_proxy_interval(x, vctrs::vec_proxy_equal)
}

# Method registered in `.onLoad()`
vec_restore.Interval <- function(x, to, ...) {
  tzone <- to@tzone

  span <- x$span

  start <- x$start
  start <- vctrs::new_datetime(start, tzone = tzone)

  out <- new("Interval", span, start = start, tzone = tzone)

  names <- x$rcrd_names
  if (!is.null(names)) {
    names(out) <- names
  }

  out
}

vec_proxy_interval <- function(x, proxy_fn) {
  start <- x@start
  span <- x@.Data

  # Proxy the underlying POSIXct as well
  start <- proxy_fn(start)

  # Ordered in such a way that the start date controls interval ordering.
  # Ties in the start date are resolved by placing shorter intervals first.
  cols <- list(
    start = start,
    span = span
  )

  n <- length(start)

  vctrs::new_data_frame(cols, n = n)
}

# ------------------------------------------------------------------------------
# Interval - ptype2

# Method registered in `.onLoad()`
vec_ptype2.Interval.Interval <- function(x, y, ...) {
  new_empty_interval(tzone = tz_union(x, y))
}

# ------------------------------------------------------------------------------
# Interval - cast

# Method registered in `.onLoad()`
vec_cast.Interval.Interval <- function(x, to, ...) {
  x_tzone <- x@tzone
  to_tzone <- to@tzone

  if (identical(x_tzone, to_tzone)) {
    return(x)
  }

  x_span <- x@.Data
  x_start <- x@start

  start <- with_tz(x_start, to_tzone)

  new("Interval", x_span, start = start, tzone = to_tzone)
}

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
