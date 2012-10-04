context("Decimal_date")

test_that("decimal_date works as expected",{
  x <- as.POSIXct("2008-08-03 10:01:59", tz = "America/New_York")
  
  expect_that(decimal_date(x), equals(2008.58846))
})

test_that("decimal_date works handles vectors",{
  x <- as.POSIXct(c("2008-08-03 13:01:59", "2009-08-03 10:01:59"), tz = "UTC")
  
  expect_that(round(decimal_date(x), 3), equals(c(2008.589, 2009.587)))
  
})
