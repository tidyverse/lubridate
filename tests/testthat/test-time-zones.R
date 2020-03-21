context("Settors")

test_that("time zone settor correctly performs simple updates", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  tz(poslt) <- "GMT"
  tz(posct) <- "GMT"
  tz(date) <- "GMT" # dates do not have a tz attribute

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "UTC")
})

test_that("time zone settor returns NA for spring dst gap", {
  poslt <- as.POSIXlt("2010-03-14 02:30:59", tz = "UTC", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)

  tz(poslt) <- "America/New_York"
  tz(posct) <- "America/New_York"

  expect_true(is.na(poslt))
  expect_true(is.na(posct))

})

test_that("time zone settor retains object class", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "UTC", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  tz(poslt) <- "GMT"
  tz(posct) <- "GMT"
  tz(date) <- "GMT"

  expect_is(poslt, "POSIXlt")
  expect_is(posct, "POSIXct")
  expect_is(date, "Date")
})
