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
  
  expect_equal(x - int, x - num)
  expect_equal(y - int, as.POSIXlt(y - num))
  
  time3 <- as.POSIXct("2007-08-03 00:00:00", tz = "UTC") 
  time4 <- as.POSIXct("2008-01-01 00:00:02", tz = "UTC") 
  time5 <- as.POSIXct("2008-01-03 00:00:00", tz = "UTC")
  int2 <- new_interval(time3, time4)
  int3 <- new_interval(time3, time5)
  yy <- as.POSIXlt(time3)
  
  expect_that(x - int2, equals(time3))
  expect_that(y - int2, equals(yy))
  expect_that(z - int3, equals(as.Date("2007-08-03")))

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
    
  int2 <- interval(as.POSIXct("2008-01-01 12:00:00", tz = "UTC"), 
  	as.POSIXct("2009-08-03 00:00:00", tz = 	"UTC"))
  int3 <- interval(as.POSIXct("2008-01-01 00:00:00", tz = "UTC"),
  	as.POSIXct("2009-08-03 00:00:00", tz = "UTC"), )
    
  expect_that(x - int2, is_a("POSIXct"))
  expect_that(y - int2, is_a("POSIXlt"))
  expect_that(z - int3, is_a("Date"))
})


test_that("subtraction works as expected for periods",{
  
  expect_equal(years(1) - 1, period(seconds = -1, years = 1))

  expect_error(years(1) - as.POSIXct("2008-01-01 00:00:00", tz = "UTC"))
    
  expect_error(years(1) - as.POSIXct("2008-01-01 00:00:00", tz = "UTC"))

  expect_equal(years(1) - minutes(3), new_period(minutes = -3, years = 1))
  
  expect_equal(years(1) - eyears(1), new_period(seconds = -31536000, years = 1))
    
  time1 <- as.POSIXct("2008-01-02 00:00:00", tz = "UTC")
  time2 <- as.POSIXct("2009-02-02 00:00:00", tz = "UTC")
  int <- new_interval(time1, time2)
    
  expect_equal(years(1) - int, months(-1))

})

test_that("subtraction with periods returns correct class",{
  
  expect_that(years(1) - 1, is_a("Period"))

  expect_that(years(1) - minutes(3), is_a("Period"))  
  expect_that(years(1) - eyears(1), is_a("Period"))
})


test_that("subtraction works as expected for durations",{
  
  expect_equal(dyears(1) - 1, duration(31535999))

  expect_error(eyears(1) - as.POSIXct("2008-01-01 00:00:00", tz = "UTC"))

  expect_equal(eyears(1) - minutes(3), dseconds(31535820))
  
  expect_equal(eyears(2) - eyears(1), eyears(1))
    
  time1 <- as.POSIXct("2008-01-02 00:00:00", tz = "UTC")
  time2 <- as.POSIXct("2009-08-03 00:00:00", tz = "UTC")
  int <- new_interval(time1, time2)

  expect_equal(dyears(1) - int, dyears(1) + dseconds(-50025600))

})

test_that("subtraction with durations returns correct class",{
  
  expect_that(eyears(1) - 1, is_a("Duration"))
  expect_that(eyears(1) - minutes(3), is_a("Duration"))  
  expect_that(dyears(1) - dyears(1), is_a("Duration"))
  
})


test_that("subtraction works as expected for intervals",{
  time1 <- as.POSIXct("2008-08-03 00:00:00", tz = "UTC")
  time2 <- as.POSIXct("2009-08-03 00:00:00", tz = "UTC")
  int <- new_interval(time1, time2)
  add_int <- function(x) new_interval(time1, time2 + x)
  
  expect_that(time2 - int, equals(time1))  
  expect_that(int - 1, equals(add_int(-1)))
  expect_that(int - time1, throws_error())
  expect_that(int - minutes(3), equals(add_int(-minutes(3))))
  expect_that(int - eminutes(3), equals(add_int(-eminutes(3))))

    
  time3 <- as.POSIXct("2008-11-02 00:00:00", tz = "UTC") 
  int2 <- interval(time3, time2)
  int3 <- interval(time1, time3)
  int4 <- interval(time1 - years(1), time3)
  int5 <- interval(time3, time2 + months(1))

    
  expect_equal(int - int2, int3)  
  expect_equal(int - int3, int2) 
  expect_equal(int3 - int2, int3) 
  expect_equal(int - int4, int2) 
  expect_equal(int - int5, int3)

})

test_that("subtraction with intervals returns correct class",{
  time1 <- as.POSIXct("2008-08-03 00:00:00", tz = "UTC")
  time2 <- as.POSIXct("2009-08-03 00:00:00", tz = "UTC")
  int <- new_interval(time1, time2)

  expect_that(int - 1, is_a("Interval"))
  expect_that(int - minutes(3), is_a("Interval"))  
  expect_that(int - eyears(1), is_a("Interval"))
      
  time3 <- as.POSIXct("2008-11-02 00:00:00", tz = "UTC") 
  int2 <- new_interval(time2, time3)
    
  expect_that(int - int2, is_a("Interval"))
})
