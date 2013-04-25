context("Decimal_date")

test_that("decimal_date works as expected",{
  x <- as.POSIXct("2008-08-03 10:01:59", tz = "America/New_York")
  
  expect_that(decimal_date(x), equals(2008.58846))
})

test_that("decimal_date handles vectors",{
  x <- as.POSIXct(c("2008-08-03 13:01:59", "2009-08-03 10:01:59"), tz = "UTC")
  
  expect_that(round(decimal_date(x), 3), equals(c(2008.589, 2009.587)))
  
})

test_that("decimal_date handles first second of year without returning NaN",{
  
  expect_equal(decimal_date(ymd("2012-01-01")), 2012)
  
})

test_that("date_decimal works as expected",{
  y <- 2008.58846
  expect_equal(as.numeric(date_decimal(y)), 1217754118)
})

test_that("date_decimal handles vectors",{
  y <- c(2008.589, 2009.587)
  expect_equal(as.numeric(date_decimal(y)), c(1217771194, 1249279632))
  
})

test_that("date_decimal reverses decimal_date",{
  date <- ymd("2012-03-01")
  decimal <- decimal_date(date)
  expect_equal(date_decimal(decimal), date)
  
  date2 <- ymd("2012-03-01", tz = "America/Chicago")
  decimal2 <- decimal_date(date2)
  expect_equal(date_decimal(decimal2, tz = "America/Chicago"), date2)
})