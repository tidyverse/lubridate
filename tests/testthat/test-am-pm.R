context("AM/PM")

test_that("am and pm correctly identify time of day", {
  x <- as.POSIXct(c("2009-08-03 13:01:59", "2008-08-03 10:01:59"), tz = "UTC")
  expect_equal(am(x), c(FALSE, TRUE))
  expect_equal(pm(x), c(TRUE, FALSE))
})

test_that("am and pm handle various classes of date-time object", {
  x <- as.POSIXct(c("2009-08-03 13:01:59", "2008-08-03 10:01:59"), tz = "UTC")
  expect_equal(am(x), c(FALSE, TRUE))
  expect_equal(am(as.POSIXlt(x)), c(FALSE, TRUE))
  expect_equal(am(as.Date(x)), c(TRUE, TRUE))
})
