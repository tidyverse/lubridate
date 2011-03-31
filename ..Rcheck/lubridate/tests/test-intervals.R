context("Intervals")

test_that("new_interval works as expected", {
  time1 <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC") 
  time2 <- as.POSIXct("2009-08-03 13:01:59", tz = "UTC")
  int <- new_interval(time2, time1)
  num <- as.numeric(int)
  diff <- as.numeric(difftime(time2, time1), units = "secs")
  start <- attr(int, "start")
    
  expect_that(num, equals(diff))
  expect_that(start, equals(time1))
  expect_that(class(int)[1], matches("interval"))
    
})

test_that("new_interval handles vector input", {
  time1 <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC")
  time2 <- as.POSIXct("2009-08-03 13:01:59", tz = "UTC")
  time3 <- as.POSIXct("2009-08-04 13:01:59", tz = "UTC")
  int <- new_interval(time3, c(time1,time2)) 
  num <- as.numeric(int)
  diff <- as.numeric(difftime(time3, c(time1, time2)), units = "secs")
  start <- attr(int, "start")

    
  expect_that(num, equals(diff))
  expect_that(start, equals(c(time1, time2)))
  expect_that(class(int)[1], matches("interval"))
  
  int2 <- new_interval(c(time3, time2), time1) 
  num2 <- as.numeric(int2)
  diff2 <- as.numeric(difftime(c(time3, time2), time1), units = "secs")
  start2 <- c(attr(int2, "start"))

    
  expect_that(num2, equals(diff2))
  expect_that(start2, equals(c(time1, time1)))
  expect_that(class(int2)[1], matches("interval"))
})


test_that("print.interval works as expected", {
  time1 <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC") 
  time2 <- as.POSIXct("2009-08-03 13:01:59", tz = "UTC")
  int <- new_interval(time2, time1)
  
  expect_that(print(int), 
    matches("2008-08-03 13:01:59 -- 2009-08-03 13:01:59"))
})


test_that("as.interval works as expected", {
  a <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC")
  pint <- new_interval(a + days(1), a)
  dint <- new_interval(a + days(1), a)
  
  expect_that(as.interval(days(1), a), equals(pint))
  expect_that(as.interval(edays(1), a), equals(dint))
})

test_that("as.interval handles vector input", {
    a <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC")
    b <- as.POSIXct("2009-08-03 13:01:59", tz = "UTC")
    pint <- new_interval(a + days(1:2), a)
    dint <- new_interval(a + edays(1:2), a)
    pint1 <- new_interval(c(a,b) + days(1:2), c(a,b))
    dint1 <- new_interval(c(a,b) + edays(1:2), c(a,b))
    pint2 <- new_interval(c(a,b) + days(1), c(a,b))
    dint2 <- new_interval(c(a,b) + edays(1), c(a,b))
  
  expect_that(as.interval(days(1:2), a), equals(pint))
  expect_that(as.interval(edays(1:2), a), equals(dint))
  expect_that(as.interval(days(1:2), c(a,b)), equals(pint1))
  expect_that(as.interval(days(1:2), c(a,b)), equals(dint1))
  expect_that(as.interval(days(1), c(a,b)), equals(pint2))
  expect_that(as.interval(days(1), c(a,b)), equals(dint2))

})
