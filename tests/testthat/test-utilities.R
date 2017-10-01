context("Utilities")

test_that("leap_year correctly identifies leap years", {
  x <- as.POSIXct("2009-08-03 12:01:59", tz = "UTC")
  y <- as.POSIXct("2008-08-03 12:01:59", tz = "UTC")

  expect_that(leap_year(x), is_false())
  expect_that(leap_year(y), is_true())
})

test_that("leap_year handles vectors", {
  x <- as.POSIXct(c("2008-08-03 12:01:59", "2009-08-03 12:01:59"), tz = "UTC")

  expect_that(leap_year(x)[1], is_true())
  expect_that(leap_year(x)[2], is_false())
  expect_that(leap_year(as.Date(x))[1], is_true())
  expect_that(leap_year(as.Date(x))[2], is_false())
})

test_that("leap_year handles various classes of date-time object", {
  x <- as.POSIXct(c("2008-08-03 12:01:59", "2009-08-03 12:01:59"), tz = "UTC")

  expect_that(leap_year(x)[1], is_true())
  expect_that(leap_year(x)[2], is_false())
  expect_that(leap_year(as.Date(x))[1], is_true())
  expect_that(leap_year(as.Date(x))[2], is_false())
  expect_that(leap_year(as.POSIXlt(x))[1], is_true())
  expect_that(leap_year(as.POSIXlt(x))[2], is_false())
})
