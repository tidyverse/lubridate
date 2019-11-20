context("Utilities")

test_that("leap_year correctly identifies leap years", {
  x <- as.POSIXct("2009-08-03 12:01:59", tz = "UTC")
  y <- as.POSIXct("2008-08-03 12:01:59", tz = "UTC")

  expect_false(leap_year(x))
  expect_true(leap_year(y))
})

test_that("leap_year handles various date-time vectors", {
  x <- as.POSIXct(c("2008-08-03 12:01:59", "2009-08-03 12:01:59"), tz = "UTC")

  expect_equal(leap_year(x), c(TRUE, FALSE))
  expect_equal(leap_year(as.Date(x)), c(TRUE, FALSE))
  expect_equal(leap_year(as.POSIXlt(x)), c(TRUE, FALSE))
})

test_that("standardise_date_names handles repeated units", {
  expect_equal(
    standardise_date_names(c("seconds", "seconds")),
    c("second", "second")
  )
})
