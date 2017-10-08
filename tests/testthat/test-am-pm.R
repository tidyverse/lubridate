context("AM/PM")

test_that("am and pm correctly identify time of day", {
  x <- as.POSIXct("2009-08-03 13:01:59", tz = "UTC")
  y <- as.POSIXct("2008-08-03 10:01:59", tz = "UTC")

  expect_that(am(x), is_false())
  expect_that(am(y), is_true())

  expect_that(pm(x), is_true())
  expect_that(pm(y), is_false())
})

test_that("am and pm handle vectors", {
  x <- as.POSIXct(c("2009-08-03 13:01:59", "2008-08-03 10:01:59"), tz = "UTC")
  y <- as.POSIXct(c("2009-08-03 10:01:59", "2008-08-03 13:01:59"), tz = "UTC")

  expect_that(pm(x)[1], is_true())
  expect_that(pm(x)[2], is_false())
  expect_that(am(y)[1], is_true())
  expect_that(am(y)[2], is_false())
})

test_that("am and pm handle various classes of date-time object", {
  x <- as.POSIXct(c("2008-08-03 13:01:59", "2009-08-03 10:01:59"), tz = "UTC")

  expect_that(pm(x)[1], is_true())
  expect_that(pm(x)[2], is_false())
  expect_that(pm(as.Date(x))[1], is_false())
  expect_that(pm(as.POSIXlt(x))[1], is_true())
  expect_that(pm(as.POSIXlt(x))[2], is_false())
})
