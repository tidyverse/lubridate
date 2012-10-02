context("Intervals")

test_that("is.interval works as expected",{
  expect_that(is.interval(234), is_false())
  expect_that(is.interval(as.POSIXct("2008-08-03 13:01:59", tz = "UTC")),
    is_false())
  expect_that(is.interval(as.POSIXlt("2008-08-03 13:01:59", tz = "UTC")), 
    is_false())
  expect_that(is.interval(Sys.Date()), is_false())
  expect_that(is.interval(minutes(1)), is_false())
  expect_that(is.interval(eminutes(1)), is_false())
  expect_that(is.interval(new_interval(
    as.POSIXct("2008-08-03 13:01:59", tz = "UTC"), 
    as.POSIXct("2009-08-03 13:01:59", tz = "UTC") )), is_true())
})

test_that("is.interval handles vectors",{
  expect_that(is.interval(new_interval(
    as.POSIXct(c("2008-08-03 13:01:59", "2009-08-03 13:01:59"), tz = "UTC"),  
    as.POSIXct("2010-08-03 13:01:59", tz = "UTC"))), is_true())
})


test_that("new_interval works as expected", {
  time1 <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC") 
  time2 <- as.POSIXct("2009-08-03 13:01:59", tz = "UTC")
  int <- interval(time1, time2)
  num <- as.numeric(time2) - as.numeric(time1)
      
  expect_equal(int@.Data, num)
  expect_equal(int@start, time1)
  expect_is(int, "Interval")
    
})

test_that("new_interval handles vector input", {
  time1 <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC")
  time2 <- as.POSIXct("2009-08-03 13:01:59", tz = "UTC")
  time3 <- as.POSIXct("2009-08-04 13:01:59", tz = "UTC")
  int <- interval(c(time1,time2), time3) 
  num <- as.numeric(time3) -  as.numeric(c(time1, time2))

    
  expect_equal(int@.Data, num)
  expect_equal(int@start, c(time1, time2))
  expect_is(int, "Interval")
  
  int2 <- interval(time1, c(time3, time2)) 
  num2 <- as.numeric(c(time3, time2)) - as.numeric(time1)
  starts <- structure(c(time1, time1), "tzone" = "UTC")
    
  expect_equal(int2@.Data, num2)
  expect_equal(int2@start, starts)
  expect_is(int2, "Interval")
})


test_that("format.Interval works as expected", {
  time1 <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC") 
  time2 <- as.POSIXct("2009-08-03 13:01:59", tz = "UTC")
  int <- interval(time1, time2)
  
  expect_match(format(int), "2008-08-03 13:01:59 UTC--2009-08-03 13:01:59 UTC")
})


test_that("as.interval works as expected", {
  a <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC")
  pint <- interval(a, a + days(1))
  dint <- interval(a, a + edays(1))
  
  expect_equal(pint, as.interval(days(1), a))
  expect_equal(dint, as.interval(edays(1), a))
})

test_that("as.interval handles vector input", {
    a <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC")
    b <- as.POSIXct("2009-08-03 13:01:59", tz = "UTC")
    pint <- interval(a, a + days(1:2))
    dint <- interval(a, a + edays(1:2))
    pint1 <- interval(c(a,b), c(a,b) + days(1:2))
    dint1 <- interval(c(a,b), c(a,b) + edays(1:2))
    pint2 <- interval(c(a,b), c(a,b) + days(1))
    dint2 <- interval(c(a,b), c(a,b) + edays(1))
  
  expect_equal(pint, as.interval(days(1:2), a))
  expect_equal(dint, as.interval(edays(1:2), a))
  expect_equal(pint1, as.interval(days(1:2), c(a,b)))
  expect_equal(dint1, as.interval(days(1:2), c(a,b)))
  expect_equal(pint2, as.interval(days(1), c(a,b)))
  expect_equal(dint2, as.interval(days(1), c(a,b)))

})

test_that("[<- can subset intervals", {
  ints <- data.frame(spans = c(interval(ymd(20090201), ymd(20090101)), 
                               interval(ymd(20090201), ymd(20090101))))
  my_int <- interval(ymd(18800101), ymd(18810101))
  ints[1,1] <- 31536000
  ints[2,1] <- my_int
  int2 <- interval(ymd(20090201), ymd(20100201))
  
  expect_equal(ints[1,1], int2)
  expect_equal(ints[2,1], my_int)
  
})

test_that("format.Interval correctly displays intervals of length 0", {
  int <- interval(ymd(18800101), ymd(18810101))
  
  expect_output(int[FALSE], "Interval\\(0)")
})
