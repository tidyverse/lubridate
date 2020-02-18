context("Settors")

test_that("seconds settor correctly performs simple updates", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  second(poslt) <- 10
  second(posct) <- 10
  second(date) <- 10

  expect_equal(second(poslt), 10)
  expect_equal(second(posct), 10)
  expect_equal(second(date), 10)

})

test_that("seconds settor rolls over as expected", {
  poslt <- as.POSIXlt("2010-12-31 23:59:59", tz = "UTC", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  second(poslt) <- 69
  second(posct) <- 69
  second(date) <- 69

  expect_equal(second(poslt), 9)
  expect_equal(minute(poslt), 0)
  expect_equal(hour(poslt), 0)
  expect_equal(mday(poslt), 1)
  expect_equal(wday(poslt), 7)
  expect_equal(yday(poslt), 1)
  expect_equal(month(poslt), 1)
  expect_equal(year(poslt), 2011)
  expect_equal(tz(poslt), "UTC")

  expect_equal(second(posct), 9)
  expect_equal(minute(posct), 0)
  expect_equal(hour(posct), 0)
  expect_equal(mday(posct), 1)
  expect_equal(wday(posct), 7)
  expect_equal(yday(posct), 1)
  expect_equal(month(posct), 1)
  expect_equal(year(posct), 2011)
  expect_equal(tz(posct), "UTC")

  expect_equal(second(date), 9)
  expect_equal(minute(date), 1)
  expect_equal(hour(date), 0)
  expect_equal(mday(date), 31)
  expect_equal(wday(date), 6)
  expect_equal(yday(date), 365)
  expect_equal(month(date), 12)
  expect_equal(year(date), 2010)
  expect_equal(tz(date), "UTC")

})

test_that("seconds settor does not change time zone", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  second(poslt) <- 1
  second(posct) <- 1
  second(date) <- 1

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "UTC")

  second(poslt) <- 69
  second(posct) <- 69
  second(date) <- 69

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "UTC")
})

test_that("seconds settor returns NA for spring dst gap", {
  poslt <- as.POSIXlt("2010-03-14 01:59:59", tz = "UTC", format = "%Y-%m-%d %H:%M:%S")
  poslt <- force_tz(poslt, tzone = "America/New_York")
  posxct <- as.POSIXct(poslt)

  second(poslt) <- 69
  second(posxct) <- 69

  expect_true(is.na(poslt))
  expect_true(is.na(posxct))

})

test_that("seconds settor retains object class", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  second(poslt) <- 10
  second(posct) <- 10
  day(date) <- 10

  expect_is(poslt, "POSIXlt")
  expect_is(posct, "POSIXct")
  expect_is(date, "Date")

  second(poslt) <- 70
  second(posct) <- 70
  day(date) <- 32

  expect_is(poslt, "POSIXlt")
  expect_is(posct, "POSIXct")
  expect_is(date, "Date")

})

