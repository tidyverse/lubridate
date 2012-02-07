context("subtraction operations")

###### subtraction for everything

test_that("subtraction works as expected for instants",{
  x <- as.POSIXct("2008-01-01 00:00:02", tz = "UTC")
  y <- as.POSIXlt("2008-01-01 00:00:02", tz = "UTC")
  z <- as.Date("2008-01-03")
  
  expect_that(x - 1, equals(as.POSIXct("2008-01-01 00:00:01", tz = "UTC")))
  expect_that(y - 1, equals(as.POSIXlt("2008-01-01 00:00:01", 
    tz = "UTC")))
  expect_that(z - 1, equals(as.Date("2008-01-02")))
  
  expect_that(x - y, equals(new_interval(y,x)))
  expect_that(y - z, equals(new_interval(z,y)))
  expect_that(z - x, equals(new_interval(x,z)))

  expect_that(x - years(1), equals(as.POSIXct(
    "2007-01-01 00:00:02", tz = "UTC")))
  expect_that(y - years(1), equals(as.POSIXlt(
    "2007-01-01 00:00:02", tz = "UTC")))
  expect_that(z - years(1), equals(as.Date("2007-01-03")))
  
  
  expect_that(x - eyears(1), equals(as.POSIXct(
    "2007-01-01 00:00:02", tz = "UTC")))
  expect_that(y - eyears(1), equals(as.POSIXlt(
    "2007-01-01 00:00:02", tz = "UTC")))
  expect_that(z - eyears(1), equals(as.Date("2007-01-03")))
  
  time1 <- as.POSIXct("2007-08-03 13:01:59", tz = "UTC")
  time2 <- as.POSIXct("2008-01-01 00:00:59", tz = "UTC")
  int <- new_interval(time2, time1)
  diff <- difftime(time2, time1)
  
  expect_that(x - int, equals(x - diff))
  expect_that(y - int, equals(y - diff))
  expect_that(z - int, equals(z - diff))
  
  time3 <- as.POSIXct("2007-08-03 00:00:00", tz = "UTC") 
  time4 <- as.POSIXct("2008-01-01 00:00:02", tz = "UTC") 
  time5 <- as.POSIXct("2008-01-03 00:00:00", tz = "UTC")
  int2 <- new_interval(time4, time3)
  int3 <- new_interval(time5, time3)
  yy <- as.POSIXlt(time3)
  
  expect_that(x - int2, equals(time3))
  expect_that(y - int2, equals(yy))
  expect_that(z - int3, equals(as.Date("2007-08-03")))

})

test_that("subtraction with instants returns correct class",{
  x <- as.POSIXct("2008-01-01 12:00:00", tz = "UTC")
  y <- as.POSIXlt("2008-01-01 12:00:00", tz = "UTC")
  z <- as.Date("2008-01-01")
  
  expect_that(x - 1, is_a("POSIXct"))
  expect_that(y - 1, is_a("POSIXlt"))
  expect_that(z - 1, is_a("Date"))
  
  expect_that(x - years(1), is_a("POSIXct"))
  expect_that(y - years(1), is_a("POSIXlt"))
  expect_that(z - years(1), is_a("Date"))
  
  expect_that(x - eyears(1), is_a("POSIXct"))
  expect_that(y - eyears(1), is_a("POSIXlt"))
  expect_that(z - eyears(1), is_a("Date"))
    
  int2 <- new_interval(as.POSIXct("2009-08-03 00:00:00", tz = 	"UTC"), as.POSIXct("2008-01-01 12:00:00", tz = "UTC"))
  int3 <- new_interval(as.POSIXct("2009-08-03 00:00:00", tz = 
  	"UTC"), as.POSIXct("2008-01-01 00:00:00", tz = "UTC"))
    
  expect_that(x - int2, is_a("POSIXct"))
  expect_that(y - int2, is_a("POSIXlt"))
  expect_that(z - int3, is_a("Date"))
})


test_that("subtraction works as expected for periods",{
  
  expect_that(years(1) - 1, equals(new_period(seconds = -1, 
    years = 1)))

  expect_that(years(1) - as.POSIXct("2008-01-01 00:00:00", tz = "UTC"),
    throws_error())
    
  expect_that(years(1) - as.POSIXct("2008-01-01 00:00:00", tz = "UTC"),
    throws_error())

  expect_that(years(1) - minutes(3), equals(new_period(
    minutes = -3, years = 1)))
  
  expect_that(years(1) - eyears(1), equals(new_period(seconds = 
    -31536000, years = 1)))
    
  time1 <- as.POSIXct("2008-01-02 00:00:00", tz = "UTC")
  time2 <- as.POSIXct("2009-08-03 00:00:00", tz = "UTC")
  time3 <- time2 - years(1)
  int <- new_interval(time2, time1)
  int2 <- -new_interval(time3, time1)
    
  expect_that(years(1) - int, equals(years(1) + seconds(-50025600)))

})

test_that("subtraction with periods returns correct class",{
  
  expect_that(years(1) - 1, is_a("period"))

  expect_that(years(1) - minutes(3), is_a("period"))  
  expect_that(years(1) - eyears(1), is_a("period"))
})


test_that("subtraction works as expected for durations",{
  
  expect_that(dyears(1) - 1, equals(structure(31535999, class = c("duration", "numeric"))))

  expect_that(eyears(1) - as.POSIXct("2008-01-01 00:00:00", tz = "UTC"),
    throws_error())


  expect_that(eyears(1) - minutes(3), equals(new_period(
    minutes = -3, seconds = 31536000)))
  
  expect_that(eyears(2) - eyears(1), equals(eyears(1)))
    
  time1 <- as.POSIXct("2008-01-02 00:00:00", tz = "UTC")
  time2 <- as.POSIXct("2009-08-03 00:00:00", tz = "UTC")
  time3 <- time2 - eyears(1)
  int <- new_interval(time2, time1)
  int2 <- -new_interval(time3, time1)
    
  expect_that(dyears(1) - int, equals(dyears(1) + dseconds(-50025600)))

})

test_that("subtraction with durations returns correct class",{
  
  expect_that(eyears(1) - 1, is_a("duration"))
  expect_that(eyears(1) - minutes(3), is_a("period"))  
  expect_that(dyears(1) - dyears(1), is_a("duration"))
  
})


test_that("subtraction works as expected for intervals",{
  time1 <- as.POSIXct("2008-08-03 00:00:00", tz = "UTC")
  time2 <- as.POSIXct("2009-08-03 00:00:00", tz = "UTC")
  int <- new_interval(time2, time1)
  add_int <- function(x) new_interval(time2 + x, time1)
  
  expect_that(time2 - int, equals(time1))  
  expect_that(int - 1, equals(add_int(-1)))
  expect_that(int - time1, throws_error())
  expect_that(int - minutes(3), equals(add_int(-minutes(3))))
  expect_that(int - eminutes(3), equals(add_int(-eminutes(3))))

    
  time3 <- as.POSIXct("2008-11-02 00:00:00", tz = "UTC") 
  time4 <- as.POSIXct("2009-08-03 00:00:01", tz = "UTC")
  int2 <- new_interval(time4, time3)
  diff1 <- difftime(time2, time1)
  diff2 <- difftime(time4, time3)
  dur <- as.duration(diff1 - diff2)
    
  expect_that(int - int2, equals(dur))  

})

test_that("subtraction with intervals returns correct class",{
  time1 <- as.POSIXct("2008-08-03 00:00:00", tz = "UTC")
  time2 <- as.POSIXct("2009-08-03 00:00:00", tz = "UTC")
  int <- new_interval(time2, time1)

  expect_that(int - 1, is_a("interval"))
  expect_that(int - minutes(3), is_a("interval"))  
  expect_that(int - eyears(1), is_a("interval"))
      
  time3 <- as.POSIXct("2008-11-02 00:00:00", tz = "UTC") 
  int2 <- new_interval(time2, time3)
    
  expect_that(int - int2, is_a("interval"))
})

test_that("subtraction still works for numbers",{
  
  expect_that(1 - 1, equals(0))
  expect_that(1 - 1, is_a("numeric"))
})
