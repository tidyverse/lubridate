context("Decimal_date")

test_that("decimal_date handles vectors", {
  x <- as.POSIXct(c("2008-08-03 13:01:59", "2009-08-03 10:01:59"), tz = "UTC")
  expect_that(round(decimal_date(x), 3), equals(c(2008.589, 2009.587)))
})

test_that("decimal_date handles first second of year without returning NaN", {
  expect_equal(decimal_date(ymd("2012-01-01")), 2012)
})

test_that("date_decimal works as expected", {
  y <- 2008.58846
  expect_equal(as.numeric(date_decimal(y)), 1217754118)
})

test_that("date_decimal handles vectors", {
  y <- c(2008.589, 2009.587)
  expect_equal(as.numeric(date_decimal(y)), c(1217771194, 1249279632))
})

test_that("date_decimal reverses decimal_date", {
  date <- ymd("2012-03-01", tz = "UTC")
  decimal <- decimal_date(date)
  expect_equal(date_decimal(decimal), date)

  date2 <- ymd("2012-03-01")
  decimal2 <- decimal_date(date2)
  expect_equal(as.Date(date_decimal(decimal2)), date2)

  ## before day light shift
  date3 <- ymd_hms("2008-02-03 10:01:59", tz = "America/New_York")
  decimal3 <- decimal_date(date3)
  date_decimal(decimal3, tz = "America/New_York")
  expect_equal(date_decimal(decimal3, tz = "America/New_York"), date3)

  ## after
  date <- ymd_hms("2008-05-03 10:01:59", tz = "America/New_York")
  decimal <- decimal_date(date)
  date_decimal(decimal, tz = "America/New_York")
  expect_equal(date_decimal(decimal, tz = "America/New_York"), date)
})

test_that("decimal_date returns NA on NA date input", {
  expect_equal(decimal_date(as.Date(NA)), as.numeric(NA))
})

test_that("decimal_date correctly handles daylight savings time", {
  date4 <- ymd_hms("2016-03-13 01:00:00", tz = "America/New_York")
  date4        <- date4 + dhours(-1:1)
  decimal4     <- decimal_date(date4)
  expect_equal(c(2016.196721, 2016.1968351, 2016.196948), decimal4)
  diff.decimal <- diff(decimal4)
  expect_equal(diff.decimal[1], diff.decimal[2])
  expect_equal(c(2016.197290, 2016.197404, 2016.1975182), decimal_date(with_tz(date4, "UTC")))
})
