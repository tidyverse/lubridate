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
  out <- list(
    year = x@year,
    month = x@month,
    day = x@day,
    hour = x@hour,
    minute = x@minute,
    second = x@.Data
  )

  # Push names onto the `second` column (i.e. `.Data`) so they get sliced and restored
  names <- names(x)
  if (!is.null(names)) {
    names(out$second) <- names
  }

  n <- length(out$year)

  vctrs::new_data_frame(out, n = n)
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

  names <- names(x$second)
  if (!is.null(names)) {
    names(out) <- names
  }

  out
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
  out <- x@.Data

  names <- names(x)
  if (!is.null(names)) {
    names(out) <- names
  }

  out
}

# Method registered in `.onLoad()`
vec_restore.Duration <- function(x, to, ...) {
  out <- duration(x, units = "seconds")

  names <- names(x)
  if (!is.null(names)) {
    names(out) <- names
  }

  out
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
  # Ordered in such a way that the start date controls interval ordering.
  # Ties in the start date are resolved by placing shorter intervals first.
  out <- list(
    start = x@start,
    span = x@.Data
  )

  # Push names onto the `span` column (i.e. `.Data`) so they get sliced and restored
  names <- names(x)
  if (!is.null(names)) {
    names(out$span) <- names
  }

  n <- length(out$start)

  vctrs::new_data_frame(out, n = n)
}

# Method registered in `.onLoad()`
vec_restore.Interval <- function(x, to, ...) {
  out <- new(
    "Interval",
    x$span,
    start = x$start,
    tzone = tz(x$start)
  )

  names <- names(x$span)
  if (!is.null(names)) {
    names(out) <- names
  }

  out
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
