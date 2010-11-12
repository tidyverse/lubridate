context("Duration operators")

test_that("addition handles daylight savings time", {
  x <- as.POSIXct("2010-03-14 00:00:00", tz = "America/New_York")
  y <- as.POSIXct("2010-03-15 01:00:00", tz = "America/New_York")
  
  expect_that(x + days(1), equals(as.POSIXct(
    "2010-03-15 00:00:00", tz = "America/New_York")))
  expect_that(x + edays(1), equals(y))  
    
})  


test_that("subtraction handles daylight savings time", {
  x <- as.POSIXct("2010-03-15 00:00:00", tz = "America/New_York")
  y <- as.POSIXct("2010-03-13 23:00:00", tz = "America/New_York")
  
  expect_that(x - days(1), equals(as.POSIXct(
    "2010-03-14 00:00:00", tz = "America/New_York")))
  expect_that(x - edays(1), equals(y))  
    
})  



test_that("addition works as expected for instants",{

  x <- as.POSIXct("2008-01-01 00:00:00", tz = "UTC")
  y <- as.POSIXlt("2008-01-01 00:00:00", tz = "UTC")
  z <- as.Date("2008-01-01")
  
  expect_that(x + 1, equals(as.POSIXct("2008-01-01 00:00:01", tz = "UTC")))
  expect_that(y + 1, equals(as.POSIXlt("2008-01-01 00:00:01", 
    tz = "UTC")))
  expect_that(z + 1, equals(as.Date("2008-01-02")))
  
  expect_that(x + y, throws_error())
  expect_that(y + z, throws_error())
  expect_that(z + x, throws_error())

  expect_that(x + years(1), equals(as.POSIXct("2009-01-01 
    00:00:00", tz = "UTC")))
  expect_that(y + years(1), equals(as.POSIXlt("2009-01-01 
    00:00:00", tz = "UTC")))
  expect_that(z + years(1), equals(as.Date("2009-01-01")))
  
  expect_that(x + eyears(1), equals(as.POSIXct("2008-12-31 00:00:00", tz = "UTC")))
  expect_that(y + eyears(1), equals(as.POSIXlt("2008-12-31 00:00:00", tz = "UTC")))
  expect_that(z + eyears(1), equals(as.Date("2008-12-31")))
  
  time1 <- as.POSIXct("2008-08-02 13:01:59", tz = "UTC") 
  time2 <- as.POSIXct("2009-08-03 13:01:59", tz = "UTC")
  int <- new_interval(time2, time1)
  diff <- difftime(time2, time1)
  
  expect_that(x + int, equals(x + diff))
  expect_that(y + int, equals(y + diff))
  expect_that(z + int, equals(z + diff))
    
  time3 <- as.POSIXct("2009-08-03 00:00:00", tz = "UTC")
  int2 <- new_interval(time3, x)
  lt_time3 <- as.POSIXlt(time3)
    
  expect_that(x + int2, equals(time3))
  expect_that(y + int2, equals(lt_time3))
  expect_that(z + int2, equals(as.Date("2009-08-03")))
  
})

test_that("addition with instants returns correct class",{
  x <- as.POSIXct("2008-01-02 00:00:00", tz = "UTC")
  y <- as.POSIXlt("2008-01-02 00:00:00", tz = "UTC")
  z <- as.Date("2008-01-01")
  
  expect_that(x + 1, is_a("POSIXct"))
  expect_that(y + 1, is_a("POSIXlt"))
  expect_that(z + 1, is_a("Date"))
  
  expect_that(x + years(1), is_a("POSIXct"))
  expect_that(y + years(1), is_a("POSIXlt"))
  expect_that(z + years(1), is_a("Date"))
  
  expect_that(x + eyears(1), is_a("POSIXct"))
  expect_that(y + eyears(1), is_a("POSIXlt"))
  expect_that(z + eyears(1), is_a("Date"))
    
  time1 <- as.POSIXct("2009-08-03 00:00:00", tz = "UTC")  
  int <- new_interval(time1, x)
    
  expect_that(x + int, is_a("POSIXct"))
  expect_that(y + int, is_a("POSIXlt"))
  expect_that(z + int, is_a("Date"))
})


test_that("addition works as expected for periods",{
  
  expect_that(years(1) + 1, equals(new_period(seconds = 1, 
    years = 1)))

  expect_that(years(1) + as.POSIXct("2008-01-01 00:00:00", tz = "UTC"),
    equals(as.POSIXct("2009-01-01 00:00:00", tz = "UTC")))
    
  expect_that(years(1) + as.POSIXlt("2008-01-01 00:00:00", tz = "UTC"),
    equals(as.POSIXlt("2009-01-01 00:00:00", tz = "UTC")))

  expect_that(years(1) + minutes(3),equals(new_period(minutes = 3, 
    years = 1)))
  
  expect_that(years(1) + eyears(1), equals(new_period(seconds = 
    31536000, years = 1)))
    
  time1 <- as.POSIXct("2008-01-02 00:00:00", tz = "UTC") 
  time2 <- as.POSIXct("2009-08-03 00:00:00", tz = "UTC")
  time3 <- as.POSIXct("2010-08-03 00:00:00", tz = "UTC")
  int <- new_interval(time2, time1)
  int2 <- new_interval(time3, time1)
    
  expect_that(years(1) + int, equals(int2))

})

test_that("addition with periods returns correct class",{
  
  expect_that(years(1) + 1, is_a("period"))

  expect_that(years(1) + as.POSIXct(
    "2008-01-01 00:00:00", tz = "UTC"), is_a("POSIXt"))

  expect_that(years(1) + as.POSIXlt(
    "2008-01-01 00:00:00", tz = "UTC"), is_a("POSIXlt"))

  expect_that(years(1) + minutes(3), is_a("period"))  
  expect_that(years(1) + eyears(1), is_a("period"))    
  int2 <- new_interval(as.POSIXct("2008-01-02 00:00:00", tz = "UTC"), 
    as.POSIXct("2009-08-03 00:00:00", tz = "UTC"))
    
  expect_that(years(1) + int2, is_a("interval"))
})


test_that("addition works as expected for durations",{
  x <- as.POSIXct("2008-01-01 00:00:00", tz = "UTC")
  y <- as.POSIXct("2008-12-31 00:00:00", tz = "UTC")
  
  
  expect_that(dyears(1) + 1, equals(new_duration(31536001)))
  expect_that(dyears(1) + x, equals(y))
  expect_that(dyears(1) + minutes(3), equals(new_period(
    minutes = 3, seconds = 31536000)))
  expect_that(dyears(1) + dyears(1), equals(dyears(2)))
    
      
  time1 <- as.POSIXct("2008-01-02 00:00:00", tz = "UTC") 
  time2 <- as.POSIXct("2009-08-03 00:00:00", tz = "UTC")
  time3 <- as.POSIXct("2010-08-03 00:00:00", tz = "UTC")
  int <- new_interval(time2, time1)
  int2 <- new_interval(time3, time1)  

    
  expect_that(dyears(1) + int, equals(int2))

})

test_that("addition with durations returns correct class",{
  ct <- as.POSIXct("2008-01-01 00:00:00", tz = "UTC")
  lt <- as.POSIXlt("2008-01-01 00:00:00", tz = "UTC")
  
  expect_that(dyears(1) + 1, is_a("duration"))
  expect_that(dyears(1) + ct, is_a("POSIXct"))
  expect_that(dyears(1) + lt, is_a("POSIXlt"))
  expect_that(dyears(1) + minutes(3), is_a("period"))  
  expect_that(dyears(1) + dyears(1), is_a("duration"))  
  
  time1 <- as.POSIXct("2008-01-02 00:00:00", tz = "UTC")
  time2 <- as.POSIXct("2009-08-03 00:00:00", tz = "UTC")
  int2 <- new_interval(time2, time1)
    
  expect_that(dyears(1) + int2, is_a("interval"))
})




test_that("addition works as expected for intervals",{
  time1 <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC") 
  time2 <- as.POSIXct("2009-08-03 13:01:59", tz = "UTC")
  time3 <- as.POSIXct("2008-01-01 00:00:00", tz = "UTC")
  diff <- difftime(time2, time1)
  
  int <- new_interval(time2, time1)
  add_int <- function(x) new_interval(time2 + x, time1)

  expect_that(int + time3, equals(time3 + diff))
  expect_that(int + time1, equals(time2))
  expect_that(int + 1, equals(add_int(1)))
  expect_that(int + minutes(3), equals(add_int(minutes(3))))
  expect_that(int + eyears(1), equals(add_int(eyears(1))))
    
  time4 <- as.POSIXct("2008-01-02 00:00:00", tz = "UTC") 
  time5 <- as.POSIXct("2010-08-03 00:00:00", tz = "UTC")
  int2 <- new_interval(time5, time4)
  diff2 <- difftime(time5, time4)
  dur <- as.duration(diff + diff2)
    
  expect_that(int + int2, equals(dur))
    
  int3 <- new_interval(time5, time2)
  int4 <- new_interval(time5, time1)

    
  expect_that(int + int3, equals(int4))    

})

test_that("addition with intervals returns correct class",{
  time1 <- as.POSIXct("2008-08-01 00:00:00", tz = "UTC") 
  time2 <- as.POSIXct("2009-08-03 13:01:59", tz = "UTC")
  int <- new_interval(time2, time1)

  expect_that(int + 1, is_a("interval"))

  expect_that(int + time1, is_a("POSIXct"))
  
  expect_that(int + as.POSIXlt(time1), is_a("POSIXlt"))

  expect_that(int + minutes(3), is_a("interval"))  
  expect_that(int + eyears(1), is_a("interval")) 
  
  time3 <- as.POSIXct("2010-08-03 00:00:00", tz = "UTC")   
  int2 <- new_interval(time3, time2) 
  
    
  expect_that(int + int2, is_a("interval"))
})

test_that("addition still works for numbers",{
  
  expect_that(1 + 1, equals(2))
  expect_that(1 + 1, is_a("numeric"))
})


#### Vectors


test_that("adding vectors works as expected for instants",{
  x <- as.POSIXct(c("2008-01-01 00:00:00", "2009-01-01 00:00:00"),
  	tz = "UTC")
  y <- as.POSIXlt(c("2008-01-01 00:00:00", 
    "2009-01-01 00:00:00"), tz = "UTC")
  z <- c(as.Date("2008-01-01"), as.Date("2008-01-10"))
  
  expect_that(x + 1, equals(as.POSIXct(c("2008-01-01 00:00:01",
    "2009-01-01 00:00:01"), tz = "UTC")))
  expect_that(y + 1, equals(as.POSIXlt(c("2008-01-01 00:00:01", 
    "2009-01-01 00:00:01"), tz = "UTC")))
  expect_that(z + 1, equals(as.Date(c("2008-01-02", 
    "2008-01-11"))))
  
  expect_that(x + y, throws_error())
  expect_that(y + z, throws_error())
  expect_that(z + x, throws_error())

  expect_that(x + years(1), equals(as.POSIXct(c(
    "2009-01-01 00:00:00","2010-01-01 00:00:00"), tz = 
    "UTC")))
  expect_that(y + years(1), equals(as.POSIXlt(c(
    "2009-01-01 00:00:00", "2010-01-01 00:00:00"), 
    tz = "UTC")))
  expect_that(z + years(1), equals(as.Date(c("2009-01-01", 
    "2009-01-10"))))
  
  expect_that(x + eyears(1), equals(as.POSIXct(c(
    "2008-12-31 00:00:00", "2010-01-01 00:00:00"), tz = 
    "UTC")))
  expect_that(y + eyears(1), equals(as.POSIXlt(c(
    "2008-12-31 00:00:00", "2010-01-01 00:00:00"), 
    tz = "UTC")))
  expect_that(z + eyears(1), equals(as.Date(c("2008-12-31", 
    "2009-01-09"))))
  
  time1 <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC") 
  time2 <- as.POSIXct("2009-08-03 13:01:59", tz = "UTC")
  int <- new_interval(time2, time1)
  diff <- difftime(time2, time1)
  
  expect_that(x + int, equals(x + diff))
  expect_that(y + int, equals(y + diff))
  expect_that(z + int, equals(z + diff))

})

test_that("adding vectors works as expected for periods",{
  
  expect_that(years(1:2) + 1, equals(new_period(seconds = 1, 
    years = c(1,2))))

  expect_that(years(1:2) + as.POSIXct("2008-01-01 00:00:00", tz = "UTC"),
    equals(as.POSIXct(c("2009-01-01 00:00:00", 
    "2010-01-01 00:00:00"), tz = "UTC")))
    
  expect_that(years(1:2) + as.POSIXlt("2008-01-01 00:00:00", 
    tz = "UTC"), equals(as.POSIXlt(c("2009-01-01 00:00:00", 
    "2010-01-01 00:00:00"), tz = "UTC")))


  expect_that(years(1:2) + minutes(3), equals(new_period(
    minutes = 3, years = c(1, 2))))
  
  expect_that(years(1:2) + eyears(1), equals(new_period(seconds = 
    31536000, years = c(1:2))))
    
  time1 <- as.POSIXct("2008-01-02 00:00:00", tz = "UTC")
  time2 <- as.POSIXct("2009-08-03 00:00:00", tz = "UTC")
  time3 <- as.POSIXct("2010-08-03 00:00:00", tz = "UTC")
  time4 <- as.POSIXct("2011-08-03 00:00:00", tz = "UTC")
  int <- new_interval(time2, time1)
  int2 <- new_interval(c(time3, time4), time1)
    
  expect_that(years(1:2) + int, equals(int2))

})



test_that("adding vectors works as expected for durations",{
  w <- as.POSIXct("2007-01-01 00:00:00", tz = "UTC") 
  x <- as.POSIXct("2008-01-01 00:00:00", tz = "UTC")
  y <- as.POSIXct(c("2008-01-01 00:00:00", "2008-12-31 00:00:00"), tz = "UTC")
  dur_it <- function(x) structure(x, class = c("duration", "numeric"))
  
  expect_that(dminutes(1:2) + 1, equals(dur_it(c(61, 121))))
  expect_that(dyears(1:2) + w, equals(y))
  expect_that(dyears(1:2) + as.POSIXlt(w), equals(as.POSIXlt(y)))
  expect_that(dyears(1:2) + minutes(3), equals(new_period(
    minutes = 3, seconds = c(1, 2)*31536000)))  
  expect_that(dyears(1:2) + dyears(1), equals(eyears(2:3)))
    
  time1 <- as.POSIXct("2008-01-02 00:00:00", tz = "UTC")
  time2 <- as.POSIXct("2009-08-03 00:00:00", tz = "UTC")
  time3 <- as.POSIXct("2010-08-03 00:00:00", tz = "UTC")
  time4 <- as.POSIXct("2011-08-03 00:00:00", tz = "UTC")
  int <- new_interval(time2, time1)
  int2 <- new_interval(c(time3, time4), time1)
    
  expect_that(eyears(1:2) + int, equals(int2))

})


test_that("adding vectors works as expected for intervals",{
  time1 <- as.POSIXct("2008-08-03 00:00:00", tz = "UTC")
  time2 <- as.POSIXct("2009-08-03 00:00:00", tz = "UTC")
  time3 <- as.POSIXct("2010-08-03 00:00:00", tz = "UTC")
  time4 <- as.POSIXct("2008-01-01 00:00:00", tz = "UTC")
  int <- new_interval(time3, c(time1, time2))
  diff <- difftime(time3, c(time1, time2))
  add_int <- function(x) {
  	result <- new_interval(time3 + x, c(time1, time2))
    attr(result, "tzone") <- NULL
    result
  }
  
  expect_that(int + time4, equals(diff + time4))
  expect_that(int + 1, equals(add_int(1)))
  expect_that(int + minutes(3), equals(add_int(minutes(3))))
  expect_that(int + eyears(1), equals(add_int(eyears(1))))
    
  time5 <- as.POSIXct("2011-08-03 00:00:00", tz = "UTC")
  int2 <- new_interval(time5, time3)
  int3 <- new_interval(time5, c(time1, time2))
    
  expect_that(int + int2, equals(int3))
    

})


test_that("addition still works for numbers",{
  
  expect_that(c(1,2) + 1, equals(c(2,3)))
  expect_that(c(1,2) + 1, is_a("numeric"))
})


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