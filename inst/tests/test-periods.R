context("Periods")


test_that("is.period works as expected",{
  expect_that(is.period(234), is_false())
  expect_that(is.period(as.POSIXct("2008-08-03 13:01:59", tz = "UTC")),
    is_false())
  expect_that(is.period(as.POSIXlt("2008-08-03 13:01:59", tz = "UTC")), 
    is_false())
  expect_that(is.period(Sys.Date()), is_false())
  expect_that(is.period(minutes(1)), is_true())
  expect_that(is.period(eminutes(1)), is_false())
  expect_that(is.period(new_interval(
    as.POSIXct("2008-08-03 13:01:59", tz = "UTC"), 
    as.POSIXct("2009-08-03 13:01:59", tz = "UTC") )), is_false())
})

test_that("is.period handles vectors",{
  expect_that(is.period(minutes(1:3)), is_true())
})



test_that("new_period works as expected", {
  per <- new_period(second = 90, minute = 5)
  
  expect_that(class(per)[1], matches("period"))
  expect_that(new_period(hours = 25), equals(hours(25)))
  expect_that(per[[1]], equals(0))
  expect_that(per[[2]], equals(0))
  expect_that(per[[3]], equals(0))
  expect_that(per[[4]], equals(0))
  expect_that(per[[5]], equals(5))
  expect_that(per[[6]], equals(90))
  
})

test_that("new_period handles vector input", {
  per <- new_period(second = c(90,60), minute = 5)
  
  expect_that(dim(per), equals(c(2,6)))
  expect_that(per[[1]], equals(c(0,0)))
  expect_that(per[[2]], equals(c(0,0)))
  expect_that(per[[3]], equals(c(0,0)))
  expect_that(per[[4]], equals(c(0,0)))
  expect_that(per[[5]], equals(c(5,5)))
  expect_that(per[[6]], equals(c(90,60)))


})


test_that("period objects handle vector input", {
  x <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC")
  expect_that(as.numeric(x + minutes(c(1,3,4))), equals(as.numeric(x + c(60,180,240))))
})

test_that("print.period works as expected", {
  per <- new_period(second = 90, minute = 5)
  expect_that(print(per), 
    matches("5 minutes and 90 seconds"))
})

test_that("as.period handles interval objects", {
  time1 <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC") 
  time2 <- as.POSIXct("2009-08-03 13:01:59", tz = "UTC")
  int <- new_interval(time2, time1)
    
  expect_that(as.period(int), equals(years(1)))
})

test_that("as.period handles vectors", {
  time1 <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC") 
  time2 <- as.POSIXct("2009-08-03 13:01:59", tz = "UTC")
  time3 <- as.POSIXct("2010-08-03 13:01:59", tz = "UTC")
  int <- new_interval(time3, c(time2, time1))
    
  dur <- new_duration(seconds = 5, minutes = c(30,59))
    
  expect_that(as.period(int), equals(years(1:2)))
  expect_that(as.period(dur), equals(seconds(5) + 
    minutes(c(30,59))))
})

test_that("as.period handles duration objects", {
  dur <- new_duration(seconds = 5, minutes = 30)  
  expect_that(as.period(dur), equals(seconds(5) + minutes(30)))
})

