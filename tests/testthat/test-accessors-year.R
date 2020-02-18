context("Settors")

test_that("years settor correctly performs simple updates", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  year(poslt) <- 2000
  year(posct) <- 2000
  year(date) <- 2000

  expect_equal(year(poslt), 2000)
  expect_equal(year(posct), 2000)
  expect_equal(year(date), 2000)
})

test_that("years settor does not change time zone", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  year(poslt) <- 2000
  year(posct) <- 2000
  year(date) <- 2000

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "UTC")
})

test_that("years settor returns NA for spring dst gap", {
  poslt <- as.POSIXlt("2009-03-14 02:59:59", tz = "UTC", format
                      = "%Y-%m-%d %H:%M:%S")
  poslt <- force_tz(poslt, tzone = "America/New_York")
  posct <- as.POSIXct(poslt)

  year(poslt) <- 2010
  year(posct) <- 2010

  expect_true(is.na(poslt))
  expect_true(is.na(posct))

})

test_that("years settor retains object class", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  year(poslt) <- 2000
  year(posct) <- 2000
  year(date) <- 2000

  expect_is(poslt, "POSIXlt")
  expect_is(posct, "POSIXct")
  expect_is(date, "Date")
})
