context("Settors")

test_that("minutes settor correctly performs simple updates", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  minute(poslt) <- 10
  minute(posct) <- 10
  minute(date) <- 10

  expect_equal(minute(poslt), 10)
  expect_equal(minute(posct), 10)
  expect_equal(minute(date), 10)

})

test_that("minutes settor rolls over as expected", {
  poslt <- as.POSIXlt("2010-12-31 23:59:59", tz = "UTC", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  minute(poslt) <- 69
  minute(posct) <- 69
  minute(date) <- 69

  expect_equal(second(poslt), 59)
  expect_equal(minute(poslt), 9)
  expect_equal(hour(poslt), 0)
  expect_equal(mday(poslt), 1)
  expect_equal(wday(poslt), 7)
  expect_equal(yday(poslt), 1)
  expect_equal(month(poslt), 1)
  expect_equal(year(poslt), 2011)
  expect_equal(tz(poslt), "UTC")

  expect_equal(second(posct), 59)
  expect_equal(minute(posct), 9)
  expect_equal(hour(posct), 0)
  expect_equal(mday(posct), 1)
  expect_equal(wday(posct), 7)
  expect_equal(yday(posct), 1)
  expect_equal(month(posct), 1)
  expect_equal(year(posct), 2011)
  expect_equal(tz(posct), "UTC")

  expect_equal(second(date), 0)
  expect_equal(minute(date), 9)
  expect_equal(hour(date), 1)
  expect_equal(mday(date), 31)
  expect_equal(wday(date), 6)
  expect_equal(yday(date), 365)
  expect_equal(month(date), 12)
  expect_equal(year(date), 2010)
  expect_equal(tz(date), "UTC")

})

test_that("minutes settor does not change time zone", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  minute(poslt) <- 1
  minute(posct) <- 1
  minute(date) <- 1

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "UTC")

  minute(poslt) <- 70
  minute(posct) <- 70
  minute(date) <- 70

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "UTC")
})

test_that("minutes settor returns NA for spring dst gap", {
  poslt <- as.POSIXlt("2010-03-14 01:59:59", tz = "UTC", format
                      = "%Y-%m-%d %H:%M:%S")
  poslt <- force_tz(poslt, tzone = "America/New_York")
  posct <- as.POSIXct(poslt)

  minute(poslt) <- 70
  minute(posct) <- 70

  expect_true(is.na(poslt))
  expect_true(is.na(posct))

})

test_that("minutes settor retains object class", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  minute(poslt) <- 1
  minute(posct) <- 1
  minute(date) <- 1

  expect_is("minute<-"(poslt, 1), "POSIXlt")
  expect_is("minute<-"(posct, 1), "POSIXct")
  expect_is("minute<-"(date, 1), "POSIXlt")

  minute(poslt) <- 70
  minute(posct) <- 70
  minute(date) <- 70

  expect_is("minute<-"(poslt, 70), "POSIXlt")
  expect_is("minute<-"(posct, 70), "POSIXct")
  expect_is("minute<-"(date, 70), "POSIXlt")

})
