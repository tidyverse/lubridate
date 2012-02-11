context("subtraction operations")

###### subtraction for everything

test_that("subtraction works as expected for instants",{
  x <- as.POSIXct("2008-01-01 00:00:02", tz = "UTC")
  y <- as.POSIXlt("2008-01-01 00:00:02", tz = "UTC")
  z <- as.Date("2008-01-03")

  expect_equal(x - years(1), as.POSIXct("2007-01-01 00:00:02", tz = "UTC"))
  expect_equal(y - years(1), as.POSIXlt("2007-01-01 00:00:02", tz = "UTC"))
  expect_equal(z - years(1), as.Date("2007-01-03"))

  expect_equal(x - eyears(1), as.POSIXct("2007-01-01 00:00:02", tz = "UTC"))
  expect_equal(y - eyears(1), as.POSIXlt("2007-01-01 00:00:02", tz = "UTC"))
  expect_equal(z - eyears(1), as.Date("2007-01-03"))  
  
  time1 <- as.POSIXct("2007-08-03 13:01:59", tz = "UTC")
  time2 <- as.POSIXct("2008-01-01 00:00:59", tz = "UTC")
  int <- interval(time1, time2)
  num <- as.numeric(time2) - as.numeric(time1)
  
  expect_error(x - int)
  expect_error(y - int)
  expect_error(z - int)

})

test_that("subtraction with instants returns correct class",{
  x <- as.POSIXct("2008-01-01 12:00:00", tz = "UTC")
  y <- as.POSIXlt("2008-01-01 12:00:00", tz = "UTC")
  z <- as.Date("2008-01-01")
  
  expect_that(x - years(1), is_a("POSIXct"))
  expect_that(y - years(1), is_a("POSIXlt"))
  expect_that(z - years(1), is_a("Date"))
  
  expect_that(x - eyears(1), is_a("POSIXct"))
  expect_that(y - eyears(1), is_a("POSIXlt"))
  expect_that(z - eyears(1), is_a("Date"))

})


test_that("subtraction works as expected for periods",{
  time1 <- as.POSIXct("2008-01-02 00:00:00", tz = "UTC")
  time2 <- as.POSIXct("2009-02-02 00:00:00", tz = "UTC")
  int <- new_interval(time1, time2)
  
  expect_equal(years(1) - 1, period(seconds = -1, years = 1))
  expect_error(years(1) - as.POSIXct("2008-01-01 00:00:00", tz = "UTC"))
  expect_error(years(1) - as.POSIXct("2008-01-01 00:00:00", tz = "UTC"))
  expect_equal(years(1) - minutes(3), new_period(minutes = -3, years = 1))
  expect_error(years(1) - eyears(1))  
  expect_error(years(1) - int)

})

test_that("subtraction with periods returns correct class",{
  
  expect_that(years(1) - 1, is_a("Period"))
  expect_that(years(1) - minutes(3), is_a("Period"))  

})


test_that("subtraction works as expected for durations",{
  time1 <- as.POSIXct("2008-01-02 00:00:00", tz = "UTC")
  time2 <- as.POSIXct("2009-08-03 00:00:00", tz = "UTC")
  int <- new_interval(time1, time2) 
  
  expect_equal(dyears(1) - 1, duration(31535999))
  expect_error(eyears(1) - as.POSIXct("2008-01-01 00:00:00", tz = "UTC"))
  expect_error(eyears(1) - minutes(3))
  expect_equal(eyears(2) - eyears(1), eyears(1))
  expect_error(dyears(1) - int)

})

test_that("subtraction with durations returns correct class",{
  
  expect_that(eyears(1) - 1, is_a("Duration"))
  expect_that(dyears(1) - dyears(1), is_a("Duration"))
  
})


test_that("subtraction works as expected for intervals",{
  time1 <- as.POSIXct("2008-08-03 00:00:00", tz = "UTC")
  time2 <- as.POSIXct("2009-08-03 00:00:00", tz = "UTC")
  time3 <- as.POSIXct("2008-11-02 00:00:00", tz = "UTC") 
  int <- new_interval(time1, time2)
  int2 <- interval(time3, time2)
  
  expect_error(time2 - int)  
  expect_error(int - 1)
  expect_error(int - time1)
  expect_error(int - minutes(3))
  expect_error(int - eminutes(3))
  expect_error(int - int2)  


})
