context("Daylight savings times")

test_that("force_tz returns NA for a time that falls in the spring gap",{
  x <- as.POSIXct("2010-03-14 02:05:05", tz = "UTC")
  
  expect_that(is.na(force_tz(x, "America/New_York")), is_true())
})


test_that("force_tz behaves consistently for the fall overlap",{
  y <- as.POSIXct("2010-11-07 01:30:05", tz = "UTC")

  expect_that(force_tz(y, "America/New_York") + hours(1), 
    equals(as.POSIXct("2010-11-07 02:30:05", tz = "America/New_York")))
  expect_that(force_tz(y, "America/New_York") - hours(1), 
    equals(as.POSIXct("2010-11-07 00:30:05", tz = "America/New_York")))

})

test_that("addition handles daylight savings time for spring gap", {
  x <- as.POSIXct("2010-03-14 00:00:00", tz = "America/New_York")
  y <- as.POSIXct("2010-03-15 01:00:00", tz = "America/New_York")
  
  expect_that(x + days(1), equals(as.POSIXct(
    "2010-03-15 00:00:00", tz = "America/New_York")))
  expect_that(x + edays(1), equals(y))  
    
})  


test_that("subtraction handles daylight savings time for spring gap", {
  x <- as.POSIXct("2010-03-15 00:00:00", tz = "America/New_York")
  y <- as.POSIXct("2010-03-13 23:00:00", tz = "America/New_York")
  
  expect_that(x - days(1), equals(as.POSIXct(
    "2010-03-14 00:00:00", tz = "America/New_York")))
  expect_that(x - edays(1), equals(y))  
    
})

test_that("addition handles daylight savings time for fall overlap", {
  x <- as.POSIXct("2010-11-07 00:00:00", tz = "America/New_York")
  
  expect_that(x + days(1), equals(as.POSIXct(
    "2010-11-08 00:00:00", tz = "America/New_York")))
  expect_that(x + edays(1), equals(as.POSIXct(
    "2010-11-07 23:00:00", tz = "America/New_York")))
})  


test_that("subtraction handles daylight savings time for fall overlap", {
  x <- as.POSIXct("2010-03-15 00:00:00", tz = "America/New_York")
  y <- as.POSIXct("2010-03-13 23:00:00", tz = "America/New_York")
  
  expect_that(x - days(1), equals(as.POSIXct(
    "2010-03-14 00:00:00", tz = "America/New_York")))
  expect_that(x - edays(1), equals(y))  
    
})


test_that("update returns NA for date-times in the spring dst gap",{ 
  poslt <- as.POSIXlt("2010-03-14 01:59:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  poslt <- force_tz(poslt, tz = "America/New_York")
     
  expect_that(is.na(update(poslt, seconds = 61)), is_true())
  expect_that(is.na(update(poslt, minutes = 61)), is_true())
  expect_that(is.na(update(poslt, hours = 2)), is_true())
  
  poslt <- as.POSIXlt("2010-03-13 02:59:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  poslt <- force_tz(poslt, tz = "America/New_York")
  
  expect_that(is.na(update(poslt, mday = 14)), is_true())
  expect_that(is.na(update(poslt, wday = 8)), is_true())
  expect_that(is.na(update(poslt, yday = 73)), is_true())
  
  poslt <- as.POSIXlt("2010-02-14 02:59:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  poslt <- force_tz(poslt, tz = "America/New_York")
  
  expect_that(is.na(update(poslt, months = 3)), is_true())
  
  poslt <- as.POSIXlt("2009-03-14 02:59:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  poslt <- force_tz(poslt, tz = "America/New_York")
  
  expect_that(is.na(update(poslt, years = 2010)), is_true())
  
  poslt <- as.POSIXlt("2010-03-14 02:59:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  
  expect_that(is.na(update(poslt, tz = "America/New_York")), is_true())
})

test_that("update rollovers perform correctly across the fall overlap",{
  poslt <- as.POSIXct("2010-11-07 01:59:59", tz = "America/New_York")       
  expect_that(update(poslt, minutes = 121), equals(as.POSIXct("2010-11-07 03:01:59", tz = "America/New_York")))
  expect_that(update(poslt, minutes = 0), equals(as.POSIXct("2010-11-07 01:00:59", tz = "America/New_York")))

})
