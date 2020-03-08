context("Settors")
#
test_that("dates settor correctly performs simple updates", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  date(poslt) <- as.Date("2000-01-01")
  date(posct) <- as.Date("2000-01-01")
  date(date) <- as.Date("2000-01-01")

  expect_equal(date(poslt), as.Date("2000-01-01"))
  expect_equal(date(posct), as.Date("2000-01-01"))
  expect_equal(date(date), as.Date("2000-01-01"))
})

test_that("dates settor does not change time zone", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  date(poslt) <- as.Date("2000-01-01")
  date(posct) <- as.Date("2000-01-01")
  date(date) <- as.Date("2000-01-01")

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "UTC")
})

test_that("dates settor returns NA for spring dst gap", {
  poslt <- as.POSIXlt("2009-03-14 02:59:59", tz = "UTC", format
                      = "%Y-%m-%d %H:%M:%S")
  poslt <- force_tz(poslt, tzone = "America/New_York")
  posct <- as.POSIXct(poslt)

  date(poslt) <- as.Date("2010-03-14")
  date(posct) <- as.Date("2010-03-14")

  expect_true(is.na(poslt))
  expect_true(is.na(posct))
})

test_that("dates settor retains object class", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  date(poslt) <- as.Date("2000-01-01")
  date(posct) <- as.Date("2000-01-01")
  date(date) <- as.Date("2000-01-01")

  expect_is(poslt, "POSIXlt")
  expect_is(posct, "POSIXct")
  expect_is(date, "Date")
})
