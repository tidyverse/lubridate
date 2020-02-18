context("Settors")

test_that("months settor correctly performs simple updates", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  month(poslt) <- 5
  month(posct) <- 5
  month(date) <- 5

  expect_equal(month(poslt), 5)
  expect_equal(month(posct), 5)
  expect_equal(month(date), 5)
})

test_that("months settor rolls over as expected", {
  poslt <- as.POSIXlt("2010-12-31 23:59:59", tz = "UTC", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  month(poslt) <- 13
  month(posct) <- 13
  month(date) <- 13

  expect_equal(second(poslt), 59)
  expect_equal(minute(poslt), 59)
  expect_equal(hour(poslt), 23)
  expect_equal(mday(poslt), 31)
  expect_equal(wday(poslt), 2)
  expect_equal(yday(poslt), 31)
  expect_equal(month(poslt), 1)
  expect_equal(year(poslt), 2011)
  expect_equal(tz(poslt), "UTC")

  expect_equal(second(posct), 59)
  expect_equal(minute(posct), 59)
  expect_equal(hour(posct), 23)
  expect_equal(mday(posct), 31)
  expect_equal(wday(posct), 2)
  expect_equal(yday(posct), 31)
  expect_equal(month(posct), 1)
  expect_equal(year(posct), 2011)
  expect_equal(tz(posct), "UTC")

  expect_equal(second(date), 0)
  expect_equal(minute(date), 0)
  expect_equal(hour(date), 0)
  expect_equal(mday(date), 31)
  expect_equal(wday(date), 2)
  expect_equal(yday(date), 31)
  expect_equal(month(date), 1)
  expect_equal(year(date), 2011)
  expect_equal(tz(date), "UTC")

})

test_that("months settor does not change time zone", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  month(poslt) <- 1
  month(posct) <- 1
  month(date) <- 1

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "UTC")

  month(poslt) <- 13
  month(posct) <- 13
  month(date) <- 13

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "UTC")
})

test_that("months settor returns NA for spring dst gap", {
  poslt <- as.POSIXlt("2010-02-14 02:59:59", tz = "UTC", format
                      = "%Y-%m-%d %H:%M:%S")
  poslt <- force_tz(poslt, tzone = "America/New_York")
  posct <- as.POSIXct(poslt)

  month(poslt) <- 3
  month(posct) <- 3

  expect_true(is.na(poslt))
  expect_true(is.na(posct))
})

test_that("months settor retains object class", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  month(poslt) <- 1
  month(posct) <- 1
  month(date) <- 1

  expect_is(poslt, "POSIXlt")
  expect_is(posct, "POSIXct")
  expect_is(date, "Date")

  month(poslt) <- 13
  month(posct) <- 13
  month(date) <- 13

  expect_is(poslt, "POSIXlt")
  expect_is(posct, "POSIXct")
  expect_is(date, "Date")

})
