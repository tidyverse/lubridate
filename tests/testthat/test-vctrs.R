context("vctrs")

library(vctrs)

# ------------------------------------------------------------------------------
# Common ptype2 / cast

test_that("no common type when mixing Period/Duration/Interval", {
  verify_errors({
    expect_error(vec_ptype2(period(), duration()), class = "vctrs_error_incompatible_type")
    expect_error(vec_ptype2(duration(), period()), class = "vctrs_error_incompatible_type")

    expect_error(vec_ptype2(period(), interval()), class = "vctrs_error_incompatible_type")
    expect_error(vec_ptype2(interval(), period()), class = "vctrs_error_incompatible_type")

    expect_error(vec_ptype2(duration(), interval()), class = "vctrs_error_incompatible_type")
    expect_error(vec_ptype2(interval(), duration()), class = "vctrs_error_incompatible_type")
  })
})

test_that("can't cast between Period/Duration/Interval", {
  verify_errors({
    expect_error(vec_cast(period(), duration()), class = "vctrs_error_incompatible_type")
    expect_error(vec_cast(duration(), period()), class = "vctrs_error_incompatible_type")

    expect_error(vec_cast(period(), interval()), class = "vctrs_error_incompatible_type")
    expect_error(vec_cast(interval(), period()), class = "vctrs_error_incompatible_type")

    expect_error(vec_cast(duration(), interval()), class = "vctrs_error_incompatible_type")
    expect_error(vec_cast(interval(), duration()), class = "vctrs_error_incompatible_type")
  })
})

# ------------------------------------------------------------------------------
# Period - proxy / restore

test_that("proxy is a data frame", {
  x <- period(year = 1:2, day = 3:4)

  expect <- list(
    year = x@year, month = x@month, day = x@day,
    hour = x@hour, minute = x@minute, second = x@.Data
  )

  expect <- new_data_frame(expect)

  expect_identical(vec_proxy(x), expect)
})

test_that("proxy can optionally store vector names in the last column (allowing duplicates)", {
  skip_if_cant_set_s4_names()

  x <- stats::setNames(days(1:3), c("x", "y", "x"))

  proxy <- vec_proxy(x)

  expect_identical(proxy$rcrd_names, names(x))
  expect_identical(match("rcrd_names", names(proxy)), ncol(proxy))
})

test_that("comparison / equality proxies don't have the names column", {
  skip_if_cant_set_s4_names()

  x <- stats::setNames(days(1:3), c("x", "y", "x"))

  expect_null(vec_proxy_compare(x)$rcrd_names)
  expect_null(vec_proxy_equal(x)$rcrd_names)
})

test_that("restore method works", {
  x <- period(year = 1:2, day = 3:4)
  expect_identical(vec_restore(vec_proxy(x), x), x)
})

test_that("restore method retains names", {
  skip_if_cant_set_s4_names()
  x <- stats::setNames(days(1), "x")
  expect_named(vec_restore(vec_proxy(x), x), "x")
})

# ------------------------------------------------------------------------------
# Period - ptype2

test_that("Period default ptype2 method falls through to `vec_default_ptype2()`", {
  verify_errors({
    expect_error(vec_ptype2(period(), 1), class = "vctrs_error_incompatible_type")
    expect_error(vec_ptype2(1, period()), class = "vctrs_error_incompatible_type")
  })
})

test_that("common type of Period and Period exists", {
  expect_identical(vec_ptype2(period(), period()), period())
})

test_that("common type of Period and NULL exists", {
  expect_identical(vec_ptype2(period(), NULL), period())
  expect_identical(vec_ptype2(NULL, period()), period())
})

test_that("common type of Period and unspecified exists", {
  expect_identical(vec_ptype2(period(), NA), period())
  expect_identical(vec_ptype2(NA, period()), period())

  expect_identical(vec_ptype2(period(), vctrs::unspecified()), period())
  expect_identical(vec_ptype2(vctrs::unspecified(), period()), period())
})

# ------------------------------------------------------------------------------
# Period - cast

test_that("Period default cast method falls through to `vec_default_cast()`", {
  verify_errors({
    expect_error(vec_cast(period(), 1), class = "vctrs_error_incompatible_type")
    expect_error(vec_cast(1, period()), class = "vctrs_error_incompatible_type")
  })
})

test_that("Period can be cast to Period", {
  expect_identical(vec_cast(days(1), months(1)), days(1))
})

test_that("can cast around `NULL`", {
  expect_identical(vec_cast(NULL, period()), NULL)
  expect_identical(vec_cast(period(), NULL), period())
})

test_that("can cast unspecified to Period", {
  expect_identical(vec_cast(NA, period()), period()[NA_real_])
  expect_error(vec_cast(period(), NA), class = "vctrs_error_incompatible_type")
})

# ------------------------------------------------------------------------------
# Period - vctrs functionality

test_that("can slice Period objects", {
  expect_identical(vec_slice(days(3:4), 2:1), days(4:3))
})

test_that("slicing preserves names", {
  skip_if_cant_set_s4_names()
  x <- stats::setNames(days(1:2), c("x", "y"))
  expect_named(vec_slice(x, c(1, 1, 2)), c("x", "x", "y"))
})

test_that("can combine Period objects", {
  expect_identical(vec_c(days(1), days(2)), days(1:2))
})

test_that("can row bind Period objects", {
  skip_if_cant_set_s4_names()
  x <- stats::setNames(days(1), "x")
  expect_identical(vec_rbind(x, x), data.frame(x = c(x, x)))
})

test_that("can row bind data frames with Period objects", {
  expect_identical(
    vec_rbind(data.frame(x = days(1)), data.frame(x = days(1))),
    data.frame(x = days(c(1, 1)))
  )
})

test_that("can column bind Period objects", {
  expect_identical(
    vec_cbind(x = days(1), y = days(1:2)),
    data.frame(x = days(c(1, 1)), y = days(1:2))
  )
})

test_that("can column bind data frames with Period objects", {
  expect_identical(
    vec_cbind(data.frame(x = days(1)), data.frame(y = days(1:2))),
    data.frame(x = days(c(1, 1)), y = days(1:2))
  )
})

test_that("Period objects can be ordered", {
  expect_identical(vec_order(vec_c(years(1), days(1))), c(2L, 1L))
  expect_identical(vec_order(vec_c(days(2), days(1))), c(2L, 1L))
})

# ------------------------------------------------------------------------------
# Duration - proxy / restore

test_that("proxy is the underlying number of seconds", {
  x <- ddays(1:2)
  expect_identical(vec_proxy(x), x@.Data)
})

test_that("proxy stores the names", {
  skip_if_cant_set_s4_names()
  x <- stats::setNames(ddays(1:3), c("x", "y", "x"))
  expect_named(vec_proxy(x), c("x", "y", "x"))
})

test_that("comparison / equality proxies don't store names", {
  skip_if_cant_set_s4_names()
  x <- stats::setNames(ddays(1:3), c("x", "y", "x"))
  expect_named(vec_proxy_compare(x), NULL)
  expect_named(vec_proxy_equal(x), NULL)
})

test_that("restore method works", {
  x <- ddays(1:2)
  expect_identical(vec_restore(vec_proxy(x), x), x)
})

test_that("restore method retains names", {
  skip_if_cant_set_s4_names()
  x <- stats::setNames(ddays(1), "x")
  expect_named(vec_restore(vec_proxy(x), x), "x")
})

# ------------------------------------------------------------------------------
# Duration - ptype2

test_that("Duration default ptype2 method falls through to `vec_default_ptype2()`", {
  verify_errors({
    expect_error(vec_ptype2(duration(), 1), class = "vctrs_error_incompatible_type")
    expect_error(vec_ptype2(1, duration()), class = "vctrs_error_incompatible_type")
  })
})

test_that("common type of Duration and Duration exists", {
  expect_identical(vec_ptype2(duration(), duration()), duration())
})

test_that("common type of Duration and NULL exists", {
  expect_identical(vec_ptype2(duration(), NULL), duration())
  expect_identical(vec_ptype2(NULL, duration()), duration())
})

test_that("common type of Duration and unspecified exists", {
  expect_identical(vec_ptype2(duration(), NA), duration())
  expect_identical(vec_ptype2(NA, duration()), duration())

  expect_identical(vec_ptype2(duration(), unspecified()), duration())
  expect_identical(vec_ptype2(unspecified(), duration()), duration())
})

test_that("common type of Duration and difftime is Duration", {
  expect_identical(vec_ptype2(duration(), new_duration()), duration())
  expect_identical(vec_ptype2(new_duration(), duration()), duration())
})

# ------------------------------------------------------------------------------
# Duration - cast

test_that("Duration default cast method falls through to `vec_default_cast()`", {
  verify_errors({
    expect_error(vec_cast(duration(), 1), class = "vctrs_error_incompatible_type")
    expect_error(vec_cast(1, duration()), class = "vctrs_error_incompatible_type")
  })
})

test_that("Duration can be cast to Duration", {
  expect_identical(vec_cast(ddays(1), dmonths(1)), ddays(1))
})

test_that("can cast around `NULL`", {
  expect_identical(vec_cast(NULL, duration()), NULL)
  expect_identical(vec_cast(duration(), NULL), duration())
})

test_that("can cast unspecified to Duration", {
  expect_identical(vec_cast(NA, duration()), duration()[NA_real_])
  expect_error(vec_cast(duration(), NA), class = "vctrs_error_incompatible_type")
})

test_that("Duration can be cast to and from difftime", {
  expect_identical(vec_cast(duration(), new_duration()), new_duration())
  expect_identical(vec_cast(new_duration(), duration()), duration())
})

# ------------------------------------------------------------------------------
# Duration - vctrs functionality

test_that("can slice Duration objects", {
  expect_identical(vec_slice(ddays(3:4), 2:1), ddays(4:3))
})

test_that("slicing preserves names", {
  skip_if_cant_set_s4_names()
  x <- stats::setNames(ddays(1:2), c("x", "y"))
  expect_named(vec_slice(x, c(1, 1, 2)), c("x", "x", "y"))
})

test_that("can combine Duration objects", {
  expect_identical(vec_c(ddays(1), ddays(2)), ddays(1:2))
})

test_that("can row bind Duration objects", {
  skip_if_cant_set_s4_names()
  x <- ddays(1)
  x_named <- stats::setNames(x, "x")
  expect_identical(vec_rbind(x_named, x_named), data.frame(x = c(x, x)))
})

test_that("can row bind data frames with Duration objects", {
  expect_identical(
    vec_rbind(data.frame(x = ddays(1)), data.frame(x = ddays(1))),
    data.frame(x = ddays(c(1, 1)))
  )
})

test_that("can column bind Duration objects", {
  expect_identical(
    vec_cbind(x = ddays(1), y = ddays(1:2)),
    data.frame(x = ddays(c(1, 1)), y = ddays(1:2))
  )
})

test_that("can column bind data frames with Duration objects", {
  expect_identical(
    vec_cbind(data.frame(x = ddays(1)), data.frame(y = ddays(1:2))),
    data.frame(x = ddays(c(1, 1)), y = ddays(1:2))
  )
})

# ------------------------------------------------------------------------------
# Interval - proxy / restore

test_that("proxy is a data frame", {
  x <- interval(tzone = "UTC")

  expect <- list(start = POSIXct(tz = "UTC"), span = numeric())
  expect <- new_data_frame(expect)

  expect_identical(vec_proxy(x), expect)
})

test_that("proxy can optionally store vector names in the last column (allowing duplicates)", {
  skip_if_cant_set_s4_names()

  x <- c("2019-01-01", "2019-01-02", "2019-01-03")
  x <- stats::setNames(interval(x), c("x", "y", "x"))

  proxy <- vec_proxy(x)

  expect_identical(proxy$rcrd_names, names(x))
  expect_identical(match("rcrd_names", names(proxy)), ncol(proxy))
})

test_that("comparison / equality proxies don't have the names column", {
  skip_if_cant_set_s4_names()

  x <- c("2019-01-01", "2019-01-02", "2019-01-03")
  x <- stats::setNames(interval(x), c("x", "y", "x"))

  expect_null(vec_proxy_compare(x)$rcrd_names)
  expect_null(vec_proxy_equal(x)$rcrd_names)
})

test_that("restore method works", {
  x <- interval(c("2019-01-01", "2019-01-02"), c("2020-01-01", "2020-01-02"))
  expect_identical(vec_restore(vec_proxy(x), x), x)
})

test_that("restore method retains names", {
  skip_if_cant_set_s4_names()
  x <- stats::setNames(interval("2019-01-01"), "x")
  expect_named(vec_restore(vec_proxy(x), x), "x")
})

# ------------------------------------------------------------------------------
# Interval - ptype2

test_that("Interval default ptype2 method falls through to `vec_default_ptype2()`", {
  verify_errors({
    expect_error(vec_ptype2(interval(), 1), class = "vctrs_error_incompatible_type")
    expect_error(vec_ptype2(1, interval()), class = "vctrs_error_incompatible_type")
  })
})

test_that("common type of Interval and Interval exists", {
  expect_identical(vec_ptype2(interval(), interval()), interval())

  x <- interval(tzone = "America/Los_Angeles")
  expect_identical(vec_ptype2(x, x), x)
})

test_that("common tzone uses non-local tzone", {
  x <- interval(tzone = "")
  y <- interval(tzone = "America/Los_Angeles")

  expect_identical(vec_ptype2(x, y)@tzone, "America/Los_Angeles")
  expect_identical(vec_ptype2(y, x)@tzone, "America/Los_Angeles")

  expect_identical(tz(int_start(vec_ptype2(x, y))), "America/Los_Angeles")
  expect_identical(tz(int_start(vec_ptype2(y, x))), "America/Los_Angeles")
})

test_that("common tzone is order dependent", {
  x <- interval(tzone = "America/New_York")
  y <- interval(tzone = "America/Los_Angeles")

  expect_identical(vec_ptype2(x, y)@tzone, "America/New_York")
  expect_identical(vec_ptype2(y, x)@tzone, "America/Los_Angeles")

  expect_identical(tz(int_start(vec_ptype2(x, y))), "America/New_York")
  expect_identical(tz(int_start(vec_ptype2(y, x))), "America/Los_Angeles")
})

test_that("common type of Interval and NULL exists", {
  expect_identical(vec_ptype2(interval(), NULL), interval())
  expect_identical(vec_ptype2(NULL, interval()), interval())
})

test_that("common type of Interval and unspecified exists", {
  expect_identical(vec_ptype2(interval(), NA), interval())
  expect_identical(vec_ptype2(NA, interval()), interval())

  expect_identical(vec_ptype2(interval(), unspecified()), interval())
  expect_identical(vec_ptype2(unspecified(), interval()), interval())
})

# ------------------------------------------------------------------------------
# Interval - cast

test_that("Interval default cast method falls through to `vec_default_cast()`", {
  verify_errors({
    expect_error(vec_cast(interval(), 1), class = "vctrs_error_incompatible_type")
    expect_error(vec_cast(1, interval()), class = "vctrs_error_incompatible_type")
  })
})

test_that("Interval can be cast to Interval", {
  expect_identical(vec_cast(interval(), interval()), interval())
})

test_that("can cast to a different tzone", {
  x_tzone <- "America/Los_Angeles"
  x_start <- as.POSIXct("1970-01-01", tz = x_tzone)
  x_end <- as.POSIXct("1970-01-02", tz = x_tzone)
  x <- interval(x_start, x_end, x_tzone)

  to_tzone <- "America/New_York"
  to <- interval(tzone = to_tzone)

  expect_start <- with_tz(x_start, to_tzone)
  expect_end <- with_tz(x_end, to_tzone)
  expect <- interval(expect_start, expect_end, to_tzone)

  expect_identical(vec_cast(x, to), expect)
})

test_that("can cast around `NULL`", {
  expect_identical(vec_cast(NULL, interval()), NULL)
  expect_identical(vec_cast(interval(), NULL), interval())
})

test_that("can cast unspecified to Interval", {
  expect_identical(vec_cast(NA, interval()), interval()[NA_real_])
  expect_error(vec_cast(interval(), NA), class = "vctrs_error_incompatible_type")
})

# ------------------------------------------------------------------------------
# Interval - vctrs functionality

test_that("can slice Interval objects", {
  x <- interval(c("1970-01-01", "1970-01-02"))
  expect_identical(vec_slice(x, 2:1), x[2:1])
})

test_that("slicing preserves names", {
  skip_if_cant_set_s4_names()
  x <- interval(c("1970-01-01", "1970-01-02"))
  x <- stats::setNames(x, c("x", "y"))
  expect_named(vec_slice(x, c(1, 1, 2)), c("x", "x", "y"))
})

test_that("can combine Interval objects", {
  x <- interval("1970-01-01")
  y <- interval("1970-01-02")
  expect <- interval(c("1970-01-01", "1970-01-02"))
  expect_identical(vec_c(x, y), expect)
})

test_that("can row bind Interval objects", {
  skip_if_cant_set_s4_names()
  x <- interval("1970-01-01")
  x_named <- stats::setNames(x, "x")
  expect_identical(vec_rbind(x_named, x_named), data.frame(x = c(x, x)))
})

test_that("can row bind data frames with Interval objects", {
  x <- interval("1970-01-01")

  expect_identical(
    vec_rbind(data.frame(x = x), data.frame(x = x)),
    data.frame(x = vec_c(x, x))
  )
})

test_that("can column bind Interval objects", {
  x <- interval("1970-01-01")
  y <- interval(c("1970-01-01", "1970-01-02"))

  expect_identical(
    vec_cbind(x = x, y = y),
    data.frame(x = vec_c(x, x), y = y)
  )
})

test_that("can column bind data frames with Interval objects", {
  x <- interval("1970-01-01")
  y <- interval(c("1970-01-01", "1970-01-02"))

  expect_identical(
    vec_cbind(data.frame(x = x), data.frame(y = y)),
    data.frame(x = vec_c(x, x), y = y)
  )
})

test_that("Interval objects can be ordered", {
  x <- interval("1970-01-01", "1970-01-02")
  y <- interval("1970-01-02", "1970-01-03")
  z <- interval("1970-01-02", "1970-01-04")

  # Different from `order()`!
  expect_identical(vec_order(vec_c(y, x)), c(2L, 1L))

  expect_identical(vec_order(vec_c(z, y)), c(2L, 1L))
})

# ------------------------------------------------------------------------------
# Output

test_that("vctrs methods have informative errors", {
  verify_output(test_path("output", "test-vctrs.txt"), {
    "# no common type when mixing Period/Duration/Interval"
    vec_ptype2(period(), duration())
    vec_ptype2(duration(), period())

    vec_ptype2(period(), interval())
    vec_ptype2(interval(), period())

    vec_ptype2(duration(), interval())
    vec_ptype2(interval(), duration())

    "# can't cast between Period/Duration/Interval"
    vec_cast(period(), duration())
    vec_cast(duration(), period())

    vec_cast(period(), interval())
    vec_cast(interval(), period())

    vec_cast(duration(), interval())
    vec_cast(interval(), duration())

    "# Period default ptype2 method falls through to `vec_default_ptype2()`"
    vec_ptype2(period(), 1)
    vec_ptype2(1, period())

    "# Period default cast method falls through to `vec_default_cast()`"
    vec_cast(period(), 1)
    vec_cast(1, period())

    "# Duration default ptype2 method falls through to `vec_default_ptype2()`"
    vec_ptype2(duration(), 1)
    vec_ptype2(1, duration())

    "# Duration default cast method falls through to `vec_default_cast()`"
    vec_cast(duration(), 1)
    vec_cast(1, duration())

    "# Interval default ptype2 method falls through to `vec_default_ptype2()`"
    vec_ptype2(interval(), 1)
    vec_ptype2(1, interval())

    "# Interval default cast method falls through to `vec_default_cast()`"
    vec_cast(interval(), 1)
    vec_cast(1, interval())
  })
})

