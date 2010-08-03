context("Intervals")

test_that("new_interval works as expected", {
  int <- new_interval(as.POSIXct("2008-08-03 13:01:59", tz = "UTC"), 
    as.POSIXct("2009-08-03 13:01:59", tz = "UTC"))
  test.list <- structure(list(start = as.POSIXct("2008-08-03 
    13:01:59", tz = "UTC"), end = as.POSIXct("2009-08-03 13:01:59", tz = "UTC")),
    class = c("interval", "data.frame"))
  attr(test.list, "row.names") <- 1L
    
  expect_that(int, equals(test.list))
  expect_that(class(int)[1], matches("interval"))
    
})

test_that("new_interval handles vector input", {
  a <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC")
  b <- as.POSIXct("2009-08-03 13:01:59", tz = "UTC")
  d <- as.POSIXct("2009-08-04 13:01:59", tz = "UTC")
  
  int <- new_interval(c(a,b),d) 
  test.list <- structure(data.frame(start = c(a,b), end = d), class = c("interval", "data.frame"))
    
  expect_that(int, equals(test.list))
})


test_that("print.interval works as expected", {
  int <- new_interval(as.POSIXct("2008-08-03 13:01:59", tz = "UTC"), 
    as.POSIXct("2009-08-03 13:01:59", tz = "UTC"))
  expect_that(print(int), 
    matches("365 days beginning at 2008-08-03 13:01:59"))
})


test_that("as.interval works as expected", {
  a <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC")
  
  expect_that(as.interval(days(1), a), equals(new_interval(a, 
    a + days(1))))
  expect_that(as.interval(edays(1), a), equals(new_interval(a, 
    a + edays(1))))
})

test_that("as.interval handles vector input", {
    a <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC")
    b <- as.POSIXct("2009-08-03 13:01:59", tz = "UTC")
  
  expect_that(as.interval(days(1:2), a), equals(new_interval(a, 
    a + days(1:2))))
  expect_that(as.interval(days(1:2), c(a,b)), 
    equals(new_interval(c(a,b), c(a,b) + days(1:2))))
  expect_that(as.interval(days(1), c(a,b)), 
    equals(new_interval(c(a,b), c(a,b) + days(1))))

})
