context("addition operations")

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

  expect_equal(x + years(1), as.POSIXct("2009-01-01 00:00:00", tz = "UTC"))
  expect_equal(y + years(1), as.POSIXlt("2009-01-01 00:00:00", tz = "UTC"))
  expect_equal(z + years(1), as.Date("2009-01-01"))
  
  expect_that(x + eyears(1), equals(as.POSIXct("2008-12-31 00:00:00", tz = "UTC")))
  expect_that(y + eyears(1), equals(as.POSIXlt("2008-12-31 00:00:00", tz = "UTC")))
  expect_that(z + eyears(1), equals(as.Date("2008-12-31")))
  
  time1 <- as.POSIXct("2008-08-02 13:01:59", tz = "UTC") 
  time2 <- as.POSIXct("2009-08-03 13:01:59", tz = "UTC")
  int <- interval(time1, time2)
  num <- as.numeric(time2) - as.numeric(time1)
  
  expect_equal(x + int, x + num)
  expect_equal(y + int, as.POSIXlt(y + num))
  expect_equal(z + int, as.Date(x + int))
    
  time3 <- as.POSIXct("2009-08-03 00:00:00", tz = "UTC")
  int2 <- new_interval(x, time3)
  lt_time3 <- as.POSIXlt(time3)
    
  expect_that(x + int2, equals(time3))
  expect_that(y + int2, equals(lt_time3))
  expect_that(z + int2, equals(as.Date("2009-08-03")))
  
})

test_that("addition with instants returns correct class",{
  x <- as.POSIXct("2008-01-02 00:00:00", tz = "UTC")
  y <- as.POSIXlt("2008-01-02 00:00:00", tz = "UTC")
  z <- as.Date("2008-01-01")
  
  expect_is(x + years(1), "POSIXct")
  expect_is(y + years(1), "POSIXlt")
  expect_is(z + years(1), "Date")
  
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
  int <- new_interval(time1, time2)
  int2 <- new_interval(time1, time3)
    
  expect_that(years(1) + int, equals(int2))

})

test_that("addition with periods returns correct class",{
  
  expect_is(years(1) + 1, "Period")

  expect_is(years(1) + as.POSIXct(
    "2008-01-01 00:00:00", tz = "UTC"), "POSIXt")

  expect_is(years(1) + as.POSIXlt(
    "2008-01-01 00:00:00", tz = "UTC"),"POSIXlt")

  expect_is(years(1) + minutes(3), "Period") 
  expect_is(years(1) + eyears(1), "Period")  
  int2 <- new_interval(as.POSIXct("2008-01-02 00:00:00", tz = "UTC"), 
    as.POSIXct("2009-08-03 00:00:00", tz = "UTC"))
    
  expect_is(years(1) + int2, "Interval")
})


test_that("addition works as expected for durations",{
  x <- as.POSIXct("2008-01-01 00:00:00", tz = "UTC")
  y <- as.POSIXct("2008-12-31 00:00:00", tz = "UTC")
  
  
  expect_equal(dyears(1) + 1, new_duration(31536001))
  expect_that(dyears(1) + x, equals(y))
  expect_equal(dyears(1) + minutes(3), dseconds(60*60*24*365 + 60*3))
  expect_that(dyears(1) + dyears(1), equals(dyears(2)))
    
      
  time1 <- as.POSIXct("2008-01-02 00:00:00", tz = "UTC") 
  time2 <- as.POSIXct("2009-08-03 00:00:00", tz = "UTC")
  time3 <- as.POSIXct("2010-08-03 00:00:00", tz = "UTC")
  int <- new_interval(time1, time2)
  int2 <- new_interval(time1, time3)  

    
  expect_that(dyears(1) + int, equals(int2))

})

test_that("addition with durations returns correct class",{
  ct <- as.POSIXct("2008-01-01 00:00:00", tz = "UTC")
  lt <- as.POSIXlt("2008-01-01 00:00:00", tz = "UTC")
  
  expect_that(dyears(1) + 1, is_a("Duration"))
  expect_that(dyears(1) + ct, is_a("POSIXct"))
  expect_that(dyears(1) + lt, is_a("POSIXlt"))
  expect_that(dyears(1) + minutes(3), is_a("Duration"))  
  expect_that(dyears(1) + dyears(1), is_a("Duration"))  
  
  time1 <- as.POSIXct("2008-01-02 00:00:00", tz = "UTC")
  time2 <- as.POSIXct("2009-08-03 00:00:00", tz = "UTC")
  int2 <- new_interval(time1, time2)
    
  expect_that(dyears(1) + int2, is_a("Interval"))
})




test_that("addition works as expected for intervals",{
  time1 <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC") 
  time2 <- as.POSIXct("2009-08-03 13:01:59", tz = "UTC")
  time3 <- as.POSIXct("2008-01-01 00:00:00", tz = "UTC")
  diff <- difftime(time2, time1)
  
  int <- new_interval(time1, time2)
  add_int <- function(x) new_interval(time1, time2 + x)

  expect_that(int + time3, equals(time3 + diff))
  expect_that(int + time1, equals(time2))
  expect_that(int + 1, equals(add_int(1)))
  expect_that(int + minutes(3), equals(add_int(minutes(3))))
  expect_that(int + eyears(1), equals(add_int(eyears(1))))
    
  time5 <- as.POSIXct("2010-08-03 00:00:00", tz = "UTC")
    
  int3 <- new_interval(time2, time5)
  int4 <- new_interval(time1, time5)

    
  expect_that(int + int3, equals(int4))    

})

test_that("addition with intervals returns correct class",{
  time1 <- as.POSIXct("2008-08-01 00:00:00", tz = "UTC") 
  time2 <- as.POSIXct("2009-08-03 13:01:59", tz = "UTC")
  int <- new_interval(time1, time2)

  expect_that(int + 1, is_a("Interval"))

  expect_that(int + time1, is_a("POSIXct"))
  
  expect_that(int + as.POSIXlt(time1), is_a("POSIXlt"))

  expect_that(int + minutes(3), is_a("Interval"))  
  expect_that(int + eyears(1), is_a("Interval")) 
  
  time3 <- as.POSIXct("2010-08-03 00:00:00", tz = "UTC")   
  int2 <- new_interval(time2, time3) 
  
    
  expect_that(int + int2, is_a("Interval"))
})


#### Vectors


test_that("adding vectors works as expected for instants",{
  x <- as.POSIXct(c("2008-01-01 00:00:00", "2009-01-01 00:00:00"),
  	tz = "UTC")
  y <- as.POSIXlt(c("2008-01-01 00:00:00", 
    "2009-01-01 00:00:00"), tz = "UTC")
  z <- c(as.Date("2008-01-01"), as.Date("2008-01-10"))

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
  int <- interval(time1, time2)
  num <- as.numeric(time2) - as.numeric(time1)
  
  expect_equal(x + int, x + num)
  expect_equal(y + int, as.POSIXlt(y + num))
  expect_equal(z + int, z + num/(60*60*24))

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
  int <- new_interval(time1, time2)
  int2 <- new_interval(time1, c(time3, time4))
    
  expect_that(years(1:2) + int, equals(int2))

})



test_that("adding vectors works as expected for durations",{
  w <- as.POSIXct("2007-01-01 00:00:00", tz = "UTC") 
  x <- as.POSIXct("2008-01-01 00:00:00", tz = "UTC")
  y <- as.POSIXct(c("2008-01-01 00:00:00", "2008-12-31 00:00:00"), tz = "UTC")
  dur <- dminutes(1:2) + 1
  
  expect_equal(dur@.Data, c(61, 121))
  expect_equal(dyears(1:2) + w, y)
  expect_that(dyears(1:2) + as.POSIXlt(w), equals(as.POSIXlt(y)))
  expect_equal(dyears(1:2) + minutes(3), dseconds(c(31536180, 63072180)))  
  expect_that(dyears(1:2) + dyears(1), equals(eyears(2:3)))
    
  time1 <- as.POSIXct("2008-01-02 00:00:00", tz = "UTC")
  time2 <- as.POSIXct("2009-08-03 00:00:00", tz = "UTC")
  time3 <- as.POSIXct("2010-08-03 00:00:00", tz = "UTC")
  time4 <- as.POSIXct("2011-08-03 00:00:00", tz = "UTC")
  int <- new_interval(time1, time2)
  int2 <- new_interval(time1, c(time3, time4))
    
  expect_that(eyears(1:2) + int, equals(int2))

})


test_that("adding vectors works as expected for intervals",{
  time1 <- as.POSIXct("2008-08-03 00:00:00", tz = "UTC")
  time2 <- as.POSIXct("2009-08-03 00:00:00", tz = "UTC")
  time3 <- as.POSIXct("2010-08-03 00:00:00", tz = "UTC")
  time4 <- as.POSIXct("2008-01-01 00:00:00", tz = "UTC")
  int <- interval(c(time1, time2), time3)
  num <- as.numeric(time3) - as.numeric(c(time1, time2))
  
  expect_equal(int + time4, num + time4)
  expect_equal(int + 1, interval(c(time1, time2), time3 + 1))
  expect_equal(int + minutes(3), interval(c(time1, time2), time3 + minutes(3)))
  expect_equal(int + eyears(1), interval(c(time1, time2), time3 + eyears(1)))

    
  time5 <- as.POSIXct("2011-08-03 00:00:00", tz = "UTC")
  int2 <- new_interval(time3, time5)
  int3 <- new_interval(c(time1, time2), time5)
    
  expect_equal(int + int2, int3)
    

})