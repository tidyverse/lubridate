context("vctrs")

library(vctrs)

# ------------------------------------------------------------------------------
# ptype2

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

# ------------------------------------------------------------------------------
# Period - ptype2

test_that("Period default method falls through to `vec_default_ptype2()`", {
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
# Duration - ptype2

test_that("Duration default method falls through to `vec_default_ptype2()`", {
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
# Interval - ptype2

test_that("Interval default method falls through to `vec_default_ptype2()`", {
  verify_errors({
    expect_error(vec_ptype2(interval(), 1), class = "vctrs_error_incompatible_type")
    expect_error(vec_ptype2(1, interval()), class = "vctrs_error_incompatible_type")
  })
})

test_that("common type of Interval and Interval exists", {
  expect_identical(vec_ptype2(interval(), interval()), interval())
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

test_that("vctrs methods have informative errors", {
  verify_output(test_path("output", "test-vctrs.txt"), {
    "# no common type when mixing Period/Duration/Interval"
    vec_ptype2(period(), duration())
    vec_ptype2(duration(), period())

    vec_ptype2(period(), interval())
    vec_ptype2(interval(), period())

    vec_ptype2(duration(), interval())
    vec_ptype2(interval(), duration())

    "# Period default method falls through to `vec_default_ptype2()`"
    vec_ptype2(period(), 1)
    vec_ptype2(1, period())

    "# Duration default method falls through to `vec_default_ptype2()`"
    vec_ptype2(duration(), 1)
    vec_ptype2(1, duration())

    "# Interval default method falls through to `vec_default_ptype2()`"
    vec_ptype2(interval(), 1)
    vec_ptype2(1, interval())
  })
})
