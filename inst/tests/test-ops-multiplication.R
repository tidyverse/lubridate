context("multiplication operations")


# multiplication for everything

test_that("multiplication throws error for instants",{
  x <- as.POSIXct("2010-03-15 00:00:00", tz = "UTC")
  
  expect_that(3 * x, throws_error())
  
})

test_that("multiplication throws error for intervals",{
  time1 <- as.POSIXct("2008-08-03 00:00:00", tz = "UTC") 
  time2 <- as.POSIXct("2009-08-03 00:00:00", tz = "UTC")
  int <- new_interval(time2, time1)
  diff <- difftime(time2, time1)
  int2 <- new_interval(time1 + 2 *diff, time1)
    
  expect_that(2 * int, equals(int2))
})

test_that("multiplication works as expected for periods",{
  
  expect_that(3*months(1), equals(months(3)))
  expect_that(3*months(1), is_a("period"))
  
})

test_that("multiplying vectors works for periods",{
  
  expect_that(c(2,3)*months(1), equals(months(2:3)))
  expect_that(c(2,3)*months(1), is_a("period"))
  
})

test_that("multiplication works as expected for durations",{
    
  expect_that(3*ehours(1), equals(ehours(3)))
  expect_that(3*ehours(1), is_a("duration"))
  
})

test_that("multiplying vectors works for durations",{
  
  expect_that(c(2,3)*dhours(1), equals(dhours(2:3)))
  expect_that(c(2,3)*dhours(1), is_a("duration"))
  
})

test_that("multiplication still works for numbers",{
  expect_that(3*2, equals(6))
  expect_that(c(4,5)*2, equals(c(8,10)))
  expect_that(3*2, is_a("numeric"))
  
})


test_that("make_difftime makes a correct difftime object",{
  x <- as.POSIXct("2008-01-01 12:00:00", tz = "UTC")
  y <- difftime(x + 3600, x)
  attr(y, "tzone") <- NULL
  
  expect_that(make_difftime(3600), equals(y))
  expect_that(make_difftime(3600), is_a("difftime"))  
})

test_that("make_difftime handles vector input",{
  x <- as.POSIXct("2008-01-01 12:00:00", tz = "UTC")
  
  expect_that(make_difftime(c(3600, 900)), equals(difftime(x + c(3600, 900), x)))
  expect_that(make_difftime(c(3600, 900)), is_a("difftime"))
  
})