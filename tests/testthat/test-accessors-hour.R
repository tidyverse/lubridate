context("Settors")

test_that("hours settor correctly performs simple updates", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  hour(poslt) <- 10
  hour(posct) <- 10
  hour(date) <- 10

  expect_equal(hour(poslt), 10)
  expect_equal(hour(posct), 10)
  expect_equal(hour(date), 10)

})

test_that("hours settor rolls over as expected", {
  poslt <- as.POSIXlt("2010-12-31 23:59:59", tz = "UTC", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  hour(poslt) <- 25
  hour(posct) <- 25
  hour(date) <- 25

  expect_equal(second(poslt), 59)
  expect_equal(minute(poslt), 59)
  expect_equal(hour(poslt), 1)
  expect_equal(mday(poslt), 1)
  expect_equal(wday(poslt), 7)
  expect_equal(yday(poslt), 1)
  expect_equal(month(poslt), 1)
  expect_equal(year(poslt), 2011)
  expect_equal(tz(poslt), "UTC")

  expect_equal(second(posct), 59)
  expect_equal(minute(posct), 59)
  expect_equal(hour(posct), 1)
  expect_equal(mday(posct), 1)
  expect_equal(wday(posct), 7)
  expect_equal(yday(posct), 1)
  expect_equal(month(posct), 1)
  expect_equal(year(posct), 2011)
  expect_equal(tz(posct), "UTC")

  expect_equal(second(date), 0)
  expect_equal(minute(date), 0)
  expect_equal(hour(date), 1)
  expect_equal(mday(date), 1)
  expect_equal(wday(date), 7)
  expect_equal(yday(date), 1)
  expect_equal(month(date), 01)
  expect_equal(year(date), 2011)
  expect_equal(tz(date), "UTC")

})

test_that("hours settor does not change time zone", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  hour(poslt) <- 1
  hour(posct) <- 1
  hour(date) <- 1

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "UTC")

  hour(poslt) <- 70
  hour(posct) <- 70
  hour(date) <- 70

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "UTC")
})

test_that("hours settor returns NA for spring dst gap", {
  poslt <- as.POSIXlt("2010-03-14 01:59:59", tz = "UTC", format = "%Y-%m-%d %H:%M:%S")
  poslt <- force_tz(poslt, tzone = "America/New_York")
  posct <- as.POSIXct(poslt)

  hour(poslt) <- 2
  hour(posct) <- 2

  expect_true(is.na(poslt))
  expect_true(is.na(posct))

})

test_that("hours settor retains object class", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  hour(poslt) <- 2
  hour(posct) <- 2
  hour(date) <- 2

  expect_is(poslt, "POSIXlt")
  expect_is(posct, "POSIXct")
  expect_is(date, "POSIXlt")

  hour(poslt) <- 25
  hour(posct) <- 25
  hour(date) <- 25

  expect_is(poslt, "POSIXlt")
  expect_is(posct, "POSIXct")
  expect_is(date, "POSIXlt")

})
