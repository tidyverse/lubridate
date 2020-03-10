context("Settors")


test_that("mdays settor correctly performs simple updates", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  mday(poslt) <- 10
  mday(posct) <- 10
  mday(date) <- 10

  expect_equal(mday(poslt), 10)
  expect_equal(mday(posct), 10)
  expect_equal(mday(date), 10)

  expect_equal(yday(poslt), 41)
  expect_equal(yday(posct), 41)
  expect_equal(yday(date), 41)

  expect_equal(wday(poslt), 4)
  expect_equal(wday(posct), 4)
  expect_equal(wday(date), 4)

})

test_that("mdays settor rolls over as expected", {
  poslt <- as.POSIXlt("2010-12-31 23:59:59", tz = "UTC", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  mday(poslt) <- 32
  mday(posct) <- 32
  mday(date) <- 32

  expect_equal(second(poslt), 59)
  expect_equal(minute(poslt), 59)
  expect_equal(hour(poslt), 23)
  expect_equal(mday(poslt), 1)
  expect_equal(wday(poslt), 7)
  expect_equal(yday(poslt), 1)
  expect_equal(month(poslt), 1)
  expect_equal(year(poslt), 2011)
  expect_equal(tz(poslt), "UTC")

  expect_equal(second(posct), 59)
  expect_equal(minute(posct), 59)
  expect_equal(hour(posct), 23)
  expect_equal(mday(posct), 1)
  expect_equal(wday(posct), 7)
  expect_equal(yday(posct), 1)
  expect_equal(month(posct), 1)
  expect_equal(year(posct), 2011)
  expect_equal(tz(posct), "UTC")

  expect_equal(second(date), 0)
  expect_equal(minute(date), 0)
  expect_equal(hour(date), 0)
  expect_equal(mday(date), 1)
  expect_equal(wday(date), 7)
  expect_equal(yday(date), 1)
  expect_equal(month(date), 1)
  expect_equal(year(date), 2011)
  expect_equal(tz(date), "UTC")

})

test_that("mdays settor does not change time zone", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  mday(poslt) <- 1
  mday(posct) <- 1
  mday(date) <- 1

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "UTC")

  mday(poslt) <- 32
  mday(posct) <- 32
  mday(date) <- 32

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "UTC")
})

test_that("mdays settor returns NA for spring dst gap", {
  poslt <- as.POSIXlt("2010-03-13 02:59:59", tz = "UTC", format
                      = "%Y-%m-%d %H:%M:%S")
  poslt <- force_tz(poslt, tzone = "America/New_York")
  posct <- as.POSIXct(poslt)

  mday(poslt) <- 14
  mday(posct) <- 14

  expect_true(is.na(poslt))
  expect_true(is.na(posct))

})

test_that("mdays settor retains object class", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  mday(poslt) <- 3
  mday(posct) <- 3
  mday(date) <- 3

  expect_is(poslt, "POSIXlt")
  expect_is(posct, "POSIXct")
  expect_is(date, "Date")

  mday(poslt) <- 32
  mday(posct) <- 32
  mday(date) <- 32

  expect_is(poslt, "POSIXlt")
  expect_is(posct, "POSIXct")
  expect_is(date, "Date")

})

test_that("ydays settor correctly performs simple updates", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  yday(poslt) <- 41
  yday(posct) <- 41
  yday(date) <- 41

  expect_equal(yday(poslt), 41)
  expect_equal(yday(posct), 41)
  expect_equal(yday(date), 41)

  expect_equal(mday(poslt), 10)
  expect_equal(mday(posct), 10)
  expect_equal(mday(date), 10)

  expect_equal(wday(poslt), 4)
  expect_equal(wday(posct), 4)
  expect_equal(wday(date), 4)
})

test_that("ydays settor rolls over as expected", {
  poslt <- as.POSIXlt("2010-12-31 23:59:59", tz = "UTC", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  yday(poslt) <- 366
  yday(posct) <- 366
  yday(date) <- 366

  expect_equal(second(poslt), 59)
  expect_equal(minute(poslt), 59)
  expect_equal(hour(poslt), 23)
  expect_equal(mday(poslt), 1)
  expect_equal(wday(poslt), 7)
  expect_equal(yday(poslt), 1)
  expect_equal(month(poslt), 1)
  expect_equal(year(poslt), 2011)
  expect_equal(tz(poslt), "UTC")

  expect_equal(second(posct), 59)
  expect_equal(minute(posct), 59)
  expect_equal(hour(posct), 23)
  expect_equal(mday(posct), 1)
  expect_equal(wday(posct), 7)
  expect_equal(yday(posct), 1)
  expect_equal(month(posct), 1)
  expect_equal(year(posct), 2011)
  expect_equal(tz(posct), "UTC")

  expect_equal(second(date), 0)
  expect_equal(minute(date), 0)
  expect_equal(hour(date), 0)
  expect_equal(mday(date), 1)
  expect_equal(wday(date), 7)
  expect_equal(yday(date), 1)
  expect_equal(month(date), 1)
  expect_equal(year(date), 2011)
  expect_equal(tz(date), "UTC")

})

test_that("ydays settor does not change time zone", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  yday(poslt) <- 1
  yday(posct) <- 1
  yday(date) <- 1

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "UTC")

  yday(poslt) <- 366
  yday(posct) <- 366
  yday(date) <- 366

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "UTC")
})

test_that("ydays settor returns NA for spring dst gap", {
  poslt <- as.POSIXlt("2010-03-13 02:59:59", tz = "UTC", format
                      = "%Y-%m-%d %H:%M:%S")
  poslt <- force_tz(poslt, tzone = "America/New_York")
  posct <- as.POSIXct(poslt)

  yday(poslt) <- 73
  yday(posct) <- 73

  expect_true(is.na(poslt))
  expect_true(is.na(posct))

})

test_that("ydays settor retains object class", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  yday(poslt) <- 3
  yday(posct) <- 3
  yday(date) <- 3

  expect_is(poslt, "POSIXlt")
  expect_is(posct, "POSIXct")
  expect_is(date, "Date")

  yday(poslt) <- 366
  yday(posct) <- 366
  yday(date) <- 366

  expect_is(poslt, "POSIXlt")
  expect_is(posct, "POSIXct")
  expect_is(date, "Date")

})

test_that("wdays settor correctly performs simple updates", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  wday(poslt) <- 5
  wday(posct) <- 5
  wday(date) <- 5

  expect_equal(wday(poslt), 5)
  expect_equal(wday(posct), 5)
  expect_equal(wday(date), 5)

  expect_equal(mday(poslt), 4)
  expect_equal(mday(posct), 4)
  expect_equal(mday(date), 4)

  expect_equal(mday(poslt), 4)
  expect_equal(mday(posct), 4)
  expect_equal(mday(date), 4)

})

test_that("wdays settor rolls over as expected", {
  poslt <- as.POSIXlt("2010-12-31 23:59:59", tz = "UTC", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  wday(poslt) <- 8
  wday(posct) <- 8
  wday(date) <- 8

  expect_equal(second(poslt), 59)
  expect_equal(minute(poslt), 59)
  expect_equal(hour(poslt), 23)
  expect_equal(mday(poslt), 2)
  expect_equal(wday(poslt), 1)
  expect_equal(yday(poslt), 2)
  expect_equal(month(poslt), 1)
  expect_equal(year(poslt), 2011)
  expect_equal(tz(poslt), "UTC")

  expect_equal(second(posct), 59)
  expect_equal(minute(posct), 59)
  expect_equal(hour(posct), 23)
  expect_equal(mday(posct), 2)
  expect_equal(wday(posct), 1)
  expect_equal(yday(posct), 2)
  expect_equal(month(posct), 1)
  expect_equal(year(posct), 2011)
  expect_equal(tz(posct), "UTC")

  expect_equal(second(date), 0)
  expect_equal(minute(date), 0)
  expect_equal(hour(date), 0)
  expect_equal(mday(date), 2)
  expect_equal(wday(date), 1)
  expect_equal(yday(date), 2)
  expect_equal(month(date), 1)
  expect_equal(year(date), 2011)
  expect_equal(tz(date), "UTC")

})

test_that("wdays settor does not change time zone", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  wday(poslt) <- 2
  wday(posct) <- 2
  wday(date) <- 2

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "UTC")

  wday(poslt) <- 8
  wday(posct) <- 8
  wday(date) <- 8

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "UTC")
})

test_that("wdays settor returns NA for spring dst gap", {
  poslt <- as.POSIXlt("2010-03-13 02:59:59", tz = "UTC", format
                      = "%Y-%m-%d %H:%M:%S")
  poslt <- force_tz(poslt, tzone = "America/New_York")
  posct <- as.POSIXct(poslt)

  wday(poslt) <- 8
  wday(posct) <- 8

  expect_true(is.na(poslt))
  expect_true(is.na(posct))

})

test_that("wdays settor retains object class", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  wday(poslt) <- 3
  wday(posct) <- 3
  wday(date) <- 3

  expect_is(poslt, "POSIXlt")
  expect_is(posct, "POSIXct")
  expect_is(date, "Date")

  wday(poslt) <- 8
  wday(posct) <- 8
  wday(date) <- 8

  expect_is(poslt, "POSIXlt")
  expect_is(posct, "POSIXct")
  expect_is(date, "Date")

})
