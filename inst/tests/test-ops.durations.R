context("Duration operators")

sysTZ <- Sys.getenv("TZ")
Sys.setenv(TZ = "America/Chicago")

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

  x <- as.POSIXct("2008-01-01 00:00:00")
  y <- as.POSIXlt("2008-01-01 06:00:00", tz = "UTC")
  z <- as.Date("2008-01-01")
  
  expect_that(x + 1, equals(as.POSIXct("2008-01-01 00:00:01")))
  expect_that(y + 1, equals(as.POSIXlt("2008-01-01 06:00:01", 
    tz = "UTC")))
  expect_that(z + 1, equals(as.Date("2008-01-02")))
  
  expect_that(x + y, throws_error())
  expect_that(y + z, throws_error())
  expect_that(z + x, throws_error())

  expect_that(x + years(1), matches(as.POSIXct("2009-01-01 
    00:00:00")))
  expect_that(y + years(1), equals(as.POSIXlt("2009-01-01 
    06:00:00", tz = "UTC")))
  expect_that(z + years(1), equals(as.Date("2009-01-01")))
  
  expect_that(x + eyears(1), matches(as.POSIXct("2008-12-31 00:00:00")))
  expect_that(y + eyears(1), equals(as.POSIXlt("2008-12-31 06:00:00", tz = "UTC")))
  expect_that(z + eyears(1), equals(as.Date("2008-12-31")))
  
  int <- new_interval(as.POSIXct("2008-08-02 13:01:59"), 
    as.POSIXct("2009-08-03 13:01:59"))
  
  expect_that(x + int, throws_error())
  expect_that(y + int, throws_error())
  expect_that(z + int, throws_error())
    
  int2 <- new_interval(as.POSIXct("2008-01-01 00:00:00", tz = 
  	"America/Chicago"), as.POSIXct("2009-08-03 00:00:00", tz = 
  	"America/Chicago"))
  yy <- as.POSIXlt(as.POSIXct("2009-08-03 00:00:00", tz = "America/Chicago"))
    
  expect_that(x + int2, matches(as.POSIXct("2009-08-03 00:00:00")))
  expect_that(y + int2, equals(yy))
  
  int3 <- new_interval(as.POSIXct("2007-12-31 18:00:00"), 
    as.POSIXct("2009-08-03 00:00:00"))
  
  expect_that(z + int3, equals(as.Date("2009-08-03")))
  


})

test_that("addition with instants returns correct class",{
  x <- as.POSIXct("2008-01-02 00:00:00")
  y <- as.POSIXlt("2008-01-02 00:00:00")
  z <- as.Date("2008-01-01")
  
  expect_that(class(x + 1)[2], matches("POSIXct"))
  expect_that(class(y + 1)[2], matches("POSIXlt"))
  expect_that(class(z + 1), matches("Date"))
  
  expect_that(class(x + years(1))[2], matches("POSIXct"))
  expect_that(class(y + years(1))[2], matches("POSIXlt"))
  expect_that(class(z + years(1)), matches("Date"))
  
  expect_that(class(x + eyears(1))[2], matches("POSIXct"))
  expect_that(class(y + eyears(1))[2], matches("POSIXlt"))
  expect_that(class(z + eyears(1)), matches("Date"))
    
  int2 <- new_interval(as.POSIXct("2008-01-02 00:00:00"), 
    as.POSIXct("2009-08-03 00:00:00"))
    
  int3 <- new_interval(as.POSIXct("2008-01-01 00:00:00", tz = 
  	"UTC"), as.POSIXct("2009-08-03 00:00:00", tz = "UTC"))
    
  expect_that(class(x + int2)[2], matches("POSIXct"))
  expect_that(class(y + int2)[2], matches("POSIXlt"))
  expect_that(class(z + int3), matches("Date"))
})


test_that("addition works as expected for periods",{
  
  expect_that(years(1) + 1, equals(new_period(seconds = 1, 
    years = 1)))

  expect_that(years(1) + as.POSIXct("2008-01-01 00:00:00"),
    matches(as.POSIXct("2009-01-01 00:00:00")))
    
  expect_that(years(1) + as.POSIXlt("2008-01-01 00:00:00"),
    equals(as.POSIXlt("2009-01-01 00:00:00")))

  expect_that(years(1) + minutes(3),equals(new_period(minutes = 3, 
    years = 1)))
  
  expect_that(years(1) + eyears(1), equals(new_period(seconds = 
    31536000, years = 1)))
    
  int2 <- new_interval(as.POSIXct("2008-01-02 00:00:00"), 
    as.POSIXct("2009-08-03 00:00:00"))
    
  expect_that(years(1) + int2, equals(new_interval(as.POSIXct(
    "2008-01-02 00:00:00"), as.POSIXct(
    "2010-08-03 00:00:00", tz = "America/Chicago"))))

})

test_that("addition with periods returns correct class",{
  
  expect_that(class(years(1) + 1)[1], matches("period"))

  expect_that(class(years(1) + as.POSIXct(
    "2008-01-01 00:00:00"))[1], matches("POSIXt"))

  expect_that(class(years(1) + as.POSIXlt(
    "2008-01-01 00:00:00"))[2], matches("POSIXlt"))

  expect_that(class(years(1) + minutes(3))[1], 
    matches("period"))  
  expect_that(class(years(1) + eyears(1))[1], matches("period"))    
  int2 <- new_interval(as.POSIXct("2008-01-02 00:00:00"), 
    as.POSIXct("2009-08-03 00:00:00"))
    
  expect_that(class(years(1) + int2)[1], matches("interval"))
})


test_that("addition works as expected for durations",{
  
  expect_that(eyears(1) + 1, equals(make_difftime(31536001)))

  expect_that(eyears(1) + as.POSIXct("2008-01-01 00:00:00"),
    matches(as.POSIXct("2008-12-31 00:00:00")))


  expect_that(eyears(1) + minutes(3), equals(new_period(
    minutes = 3, seconds = 31536000)))
  
  expect_that(eyears(1) + eyears(1), equals(eyears(2)))
    
  int2 <- new_interval(as.POSIXct("2008-01-02 00:00:00"), 
    as.POSIXct("2009-08-03 00:00:00"))
    
  expect_that(eyears(1) + int2, equals(new_interval(as.POSIXct(
    "2008-01-02 00:00:00"), as.POSIXct(
    "2010-08-03 00:00:00", tz = "America/Chicago"))))

})

test_that("addition with durations returns correct class",{
  
  expect_that(class(eyears(1) + 1), matches("difftime"))

  expect_that(class(eyears(1) + as.POSIXct(
    "2008-01-01 00:00:00"))[2], matches("POSIXct"))
  
  expect_that(class(eyears(1) + as.POSIXlt(
    "2008-01-01 00:00:00"))[2], matches("POSIXlt"))

  expect_that(class(eyears(1) + minutes(3))[1],
     matches("period"))  
  expect_that(class(eyears(1) + eyears(1)), matches("difftime"))    
  int2 <- new_interval(as.POSIXct("2008-01-02 00:00:00"), 
    as.POSIXct("2009-08-03 00:00:00"))
    
  expect_that(class(eyears(1) + int2)[1], matches("interval"))
})




test_that("addition works as expected for intervals",{
  int <- new_interval(as.POSIXct("2008-08-03 13:01:59"), 
    as.POSIXct("2009-08-03 13:01:59"))
  
  
  expect_that(int + 1, equals(new_interval(
    as.POSIXct("2008-08-03 13:01:59"), 
    as.POSIXct("2009-08-03 13:02:00", tz = "America/Chicago"))))

  expect_that(int + as.POSIXct("2008-01-01 00:00:00"),
    throws_error())
    
  expect_that(int + as.POSIXct("2008-08-03 13:01:59"),
    equals(as.POSIXct("2009-08-03 13:01:59")))

  expect_that(int + minutes(3), equals(new_interval(
    as.POSIXct("2008-08-03 13:01:59"), 
    as.POSIXct("2009-08-03 13:04:59", tz = "America/Chicago"))))
  
  expect_that(int + eyears(1), equals(new_interval(
    as.POSIXct("2008-08-03 13:01:59"), 
    as.POSIXct("2010-08-03 13:01:59", tz = "America/Chicago"))))
    
  int2 <- new_interval(as.POSIXct("2008-01-02 00:00:00"), 
    as.POSIXct("2009-08-03 00:00:00"))
    
  expect_that(int + int2, throws_error(
    "Intervals do not align"))
    
  int3 <- new_interval(as.POSIXct("2009-08-03 13:01:59"), 
    as.POSIXct("2010-08-03 00:00:00"))
    
  expect_that(int + int3, equals(new_interval(
    as.POSIXct("2008-08-03 13:01:59"), 
    as.POSIXct("2010-08-03 00:00:00"))))    

})

test_that("addition with intervals returns correct class",{
  int <- new_interval(as.POSIXct("2008-08-01 00:00:00"), 
    as.POSIXct("2009-08-03 13:01:59"))

  expect_that(class(int + 1)[1], matches("interval"))
  expect_that(class(int + 1)[2], matches("data.frame"))

  expect_that(class(int + as.POSIXct(
    "2008-08-01 00:00:00"))[2], matches("POSIXct"))
  
  expect_that(class(int + as.POSIXlt(
    "2008-08-01 00:00:00"))[2], matches("POSIXlt"))

  expect_that(class(int + minutes(3))[1], matches("interval"))  
  expect_that(class(int + eyears(1))[1], matches("interval"))    
  int3 <- new_interval(as.POSIXct("2009-08-03 13:01:59"), 
    as.POSIXct("2010-08-03 00:00:00"))
    
  expect_that(class(int + int3)[1], matches("interval"))
})

test_that("addition still works for numbers",{
  
  expect_that(1 + 1, equals(2))
  expect_that(class(1 + 1), matches("numeric"))
})


#### Vectors


test_that("adding vectors works as expected for instants",{
  x <- c(as.POSIXct("2008-01-01 00:00:00"), 
    as.POSIXct("2009-01-01 00:00:00"))
  y <- as.POSIXlt(c("2008-01-01 00:00:00", 
    "2009-01-01 00:00:00"), tz = "UTC")
  z <- c(as.Date("2008-01-01"), as.Date("2008-01-10"))
  
  expect_that(x + 1, equals(c(as.POSIXct("2008-01-01 00:00:01"),
    as.POSIXct("2009-01-01 00:00:01"))))
  expect_that(y + 1, equals(as.POSIXlt(c("2008-01-01 00:00:01", 
    "2009-01-01 00:00:01"), tz = "UTC")))
  expect_that(z + 1, equals(as.Date(c("2008-01-02", 
    "2008-01-11"))))
  
  expect_that(x + y, throws_error())
  expect_that(y + z, throws_error())
  expect_that(z + x, throws_error())

  expect_that(x + years(1), equals(as.POSIXct(c(
    "2009-01-01 00:00:00","2010-01-01 00:00:00"), tz = 
    "America/Chicago")))
  expect_that(y + years(1), equals(as.POSIXlt(c(
    "2009-01-01 00:00:00", "2010-01-01 00:00:00"), 
    tz = "UTC")))
  expect_that(z + years(1), equals(as.Date(c("2009-01-01", 
    "2009-01-10"))))
  
  expect_that(x + eyears(1), equals(as.POSIXct(c(
    "2008-12-31 00:00:00", "2010-01-01 00:00:00"), tz = 
    "America/Chicago")))
  expect_that(y + eyears(1), equals(as.POSIXlt(c(
    "2008-12-31 00:00:00", "2010-01-01 00:00:00"), 
    tz = "UTC")))
  expect_that(z + eyears(1), equals(as.Date(c("2008-12-31", 
    "2009-01-09"))))
  
  int <- new_interval(as.POSIXct("2008-08-03 13:01:59"), 
    as.POSIXct("2009-08-03 13:01:59"))
  
  expect_that(x + int, throws_error())
  expect_that(y + int, throws_error())
  expect_that(z + int, throws_error())

})

test_that("adding vectors works as expected for periods",{
  
  expect_that(years(1:2) + 1, equals(new_period(seconds = 1, 
    years = c(1,2))))

  expect_that(years(1:2) + as.POSIXct("2008-01-01 00:00:00"),
    equals(as.POSIXct(c("2009-01-01 00:00:00", 
    "2010-01-01 00:00:00"), tz = "America/Chicago")))
    
  expect_that(years(1:2) + as.POSIXlt("2008-01-01 00:00:00", 
    tz = "UTC"), equals(as.POSIXlt(c("2009-01-01 00:00:00", 
    "2010-01-01 00:00:00"), tz = "UTC")))


  expect_that(years(1:2) + minutes(3), equals(new_period(
    minutes = 3, years = c(1, 2))))
  
  expect_that(years(1:2) + eyears(1), equals(new_period(seconds = 
    31536000, years = c(1:2))))
    
  int2 <- new_interval(as.POSIXct("2008-01-02 00:00:00"), 
    as.POSIXct("2009-08-03 00:00:00"))
    
  expect_that(years(1:2) + int2, equals(new_interval(as.POSIXct(
    "2008-01-02 00:00:00"), as.POSIXct(c("2010-08-03 00:00:00", 
    "2011-08-03 00:00:00"), tz = "America/Chicago"))))

})



test_that("adding vectors works as expected for durations",{
  x <- as.POSIXct("2008-01-01 00:00:00")
  
  expect_that(eminutes(1:2) + 1, equals(difftime(x + 1 + 60* c(1,2), x)))

  expect_that(eyears(1:2) + as.POSIXct("2007-01-01 00:00:00"),
    equals(as.POSIXct(c("2008-01-01 00:00:00", 
    "2008-12-31 00:00:00"), tz = "America/Chicago")))
    
  expect_that(eyears(1:2) + as.POSIXlt("2007-01-01 00:00:00", 
    tz = "UTC"), equals(as.POSIXlt(c("2008-01-01 00:00:00", 
    "2008-12-31 00:00:00"), tz = "UTC")))


  expect_that(eyears(1:2) + minutes(3), equals(new_period(
    minutes = 3, seconds = c(1, 2)*31536000)))
  
  expect_that(eyears(1:2) + eyears(1), equals(eyears(2:3)))
    
  int2 <- new_interval(as.POSIXct("2008-01-02 00:00:00"), 
    as.POSIXct("2009-08-03 00:00:00"))
    
  expect_that(eyears(1:2) + int2, equals(new_interval(
  as.POSIXct("2008-01-02 00:00:00"), as.POSIXct(c(
    "2010-08-03 00:00:00", "2011-08-03 00:00:00"), 
    tz = "America/Chicago"))))

})


test_that("additing vectors works as expected for intervals",{
  int <- new_interval(as.POSIXct(c("2008-08-03 00:00:00", 
    "2009-08-03 00:00:00")), as.POSIXct(
    "2010-08-03 00:00:00"))
  
  expect_that(int + 1, equals(new_interval(as.POSIXct(c(
    "2008-08-03 00:00:00", "2009-08-03 00:00:00")),
     as.POSIXct("2010-08-03 00:00:01", tz = "America/Chicago"))))

  expect_that(int + as.POSIXct("2008-01-01 00:00:00"),
    throws_error())

  expect_that(int + minutes(3), equals(new_interval(as.POSIXct(
    c("2008-08-03 00:00:00","2009-08-03 00:00:00")),
     as.POSIXct("2010-08-03 00:03:00", tz = "America/Chicago"))))
  
  expect_that(int + eyears(1), equals(new_interval(as.POSIXct(c(
    "2008-08-03 00:00:00", "2009-08-03 00:00:00")),
     as.POSIXct("2011-08-03 00:00:00", tz = "America/Chicago"))))
    
  int2 <- new_interval(as.POSIXct("2010-08-03 00:00:00"), 
    as.POSIXct("2011-08-03 00:00:00"))
    
  expect_that(int + int2, equals(new_interval(as.POSIXct(c(
    "2008-08-03 00:00:00", "2009-08-03 00:00:00")),
     as.POSIXct("2011-08-03 00:00:00"))))
    

})


test_that("addition still works for numbers",{
  
  expect_that(c(1,2) + 1, equals(c(2,3)))
  expect_that(class(c(1,2) + 1), matches("numeric"))
})


###### subtraction for everything

test_that("subtraction works as expected for instants",{
  x <- as.POSIXct("2008-01-01 00:00:02")
  y <- as.POSIXlt("2008-01-01 00:00:02", tz = "UTC")
  z <- as.Date("2008-01-03")
  
  expect_that(x - 1, equals(as.POSIXct("2008-01-01 00:00:01")))
  expect_that(y - 1, equals(as.POSIXlt("2008-01-01 00:00:01", 
    tz = "UTC")))
  expect_that(z - 1, equals(as.Date("2008-01-02")))
  
  expect_that(x - y, equals(new_interval(y,x)))
  expect_that(y - z, equals(new_interval(z,y)))
  expect_that(z - x, equals(new_interval(x,z)))

  expect_that(x - years(1), matches(as.POSIXct(
    "2007-01-01 00:00:02")))
  expect_that(y - years(1), equals(as.POSIXlt(
    "2007-01-01 00:00:02", tz = "UTC")))
  expect_that(z - years(1), equals(as.Date("2007-01-03")))
  
  
  expect_that(x - eyears(1), matches(as.POSIXct(
    "2007-01-01 00:00:02")))
  expect_that(y - eyears(1), equals(as.POSIXlt(
    "2007-01-01 00:00:02", tz = "UTC")))
  expect_that(z - eyears(1), equals(as.Date("2007-01-03")))
  
  int <- new_interval(as.POSIXct("2007-08-03 13:01:59"), 
    as.POSIXct("2008-01-01 00:00:59"))
  
  expect_that(x - int, throws_error())
  expect_that(y - int, throws_error())
  expect_that(z - int, throws_error())
    
  int2 <- new_interval(as.POSIXct("2007-08-03 00:00:00"), 
    as.POSIXct("2008-01-01 00:00:02"))
  int3 <- new_interval(as.POSIXct("2007-08-03 00:00:00"), 
    as.POSIXct("2008-01-01 00:00:02", tz = "UTC"))
  int4 <- new_interval(as.POSIXct("2007-08-03 00:00:00"), 
    as.POSIXct("2008-01-02 18:00:00"))
  yy <- as.POSIXlt("2007-08-03 00:00:00")
  
  expect_that(x - int2, equals(as.POSIXct(
    "2007-08-03 00:00:00")))
  expect_that(y - int3, equals(yy))
  expect_that(z - int4, equals(as.Date("2007-08-03")))

})

test_that("subtraction with instants returns correct class",{
  x <- as.POSIXct("2008-01-01 12:00:00")
  y <- as.POSIXlt("2008-01-01 12:00:00")
  z <- as.Date("2008-01-01")
  
  expect_that(class(x - 1)[2], matches("POSIXct"))
  expect_that(class(y - 1)[2], matches("POSIXlt"))
  expect_that(class(z - 1), matches("Date"))
  
  expect_that(class(x - years(1))[2], matches("POSIXct"))
  expect_that(class(y - years(1))[2], matches("POSIXlt"))
  expect_that(class(z - years(1)), matches("Date"))
  
  expect_that(class(x - eyears(1))[2], matches("POSIXct"))
  expect_that(class(y - eyears(1))[2], matches("POSIXlt"))
  expect_that(class(z - eyears(1)), matches("Date"))
    
  int2 <- new_interval(as.POSIXct("2009-08-03 00:00:00"), 
    as.POSIXct("2008-01-01 12:00:00"))
  int3 <- new_interval(as.POSIXct("2009-08-03 00:00:00"), 
    as.POSIXct("2007-12-31 18:00:00"))
    
  expect_that(class(x - int2)[2], matches("POSIXct"))
  expect_that(class(y - int2)[2], matches("POSIXlt"))
  expect_that(class(z - int3), matches("Date"))
})


test_that("subtraction works as expected for periods",{
  
  expect_that(years(1) - 1, equals(new_period(seconds = -1, 
    years = 1)))

  expect_that(years(1) - as.POSIXct("2008-01-01 00:00:00"),
    throws_error())
    
  expect_that(years(1) - as.POSIXct("2008-01-01 00:00:00"),
    throws_error())

  expect_that(years(1) - minutes(3), equals(new_period(
    minutes = -3, years = 1)))
  
  expect_that(years(1) - eyears(1), equals(new_period(seconds = 
    -31536000, years = 1)))
    
  int2 <- new_interval(as.POSIXct("2008-01-02 00:00:00"), 
    as.POSIXct("2009-08-03 00:00:00"))
    
  expect_that(years(1) - int2, throws_error())

})

test_that("subtraction with periods returns correct class",{
  
  expect_that(class(years(1) - 1)[1], matches("period"))

  expect_that(class(years(1) - minutes(3))[1], 
    matches("period"))  
  expect_that(class(years(1) - eyears(1))[1], matches("period"))
})


test_that("subtraction works as expected for durations",{
  
  expect_that(eyears(1) - 1, equals(make_difftime(31535999)))

  expect_that(eyears(1) - as.POSIXct("2008-01-01 00:00:00"),
    throws_error())


  expect_that(eyears(1) - minutes(3), equals(new_period(
    minutes = -3, seconds = 31536000)))
  
  expect_that(eyears(2) - eyears(1), equals(eyears(1)))
    
  int2 <- new_interval(as.POSIXct("2008-01-02 00:00:00"), 
    as.POSIXct("2009-08-03 00:00:00"))
    
  expect_that(eyears(1) - int2, throws_error())

})

test_that("subtraction with durations returns correct class",{
  
  expect_that(class(eyears(1) - 1), matches("difftime"))

  expect_that(class(eyears(1) - minutes(3))[1],
     matches("period"))  
  expect_that(class(eyears(1) - eyears(1)), matches("difftime"))
})


test_that("subtraction works as expected for intervals",{
  int <- new_interval(as.POSIXct("2008-08-03 00:00:00"), 
    as.POSIXct("2009-08-03 00:00:00"))
  
  expect_that(as.POSIXct("2009-08-03 00:00:00") - int, equals(
    as.POSIXct("2008-08-03 00:00:00")))
    
  expect_that(as.POSIXct("2008-08-03 00:00:00") - int, 
    throws_error())  
    
  expect_that(int - 1, equals(new_interval(
    as.POSIXct("2008-08-03 00:00:00"), 
    as.POSIXct("2009-08-02 23:59:59", tz = "America/Chicago"))))

  expect_that(int - as.POSIXct("2008-01-01 00:00:00"),
    throws_error())

  expect_that(int - minutes(3), equals(new_interval(
    as.POSIXct("2008-08-03 00:00:00"), 
    as.POSIXct("2009-08-02 23:57:00", tz = "America/Chicago"))))
  
  expect_that(int - eminutes(3), equals(new_interval(
    as.POSIXct("2008-08-03 00:00:00"), 
    as.POSIXct("2009-08-02 23:57:00", tz = "America/Chicago"))))
    
  int2 <- new_interval(as.POSIXct("2008-11-02 00:00:00"), 
    as.POSIXct("2009-08-03 00:00:01"))
    
  expect_that(int - int2, throws_error(
    "Intervals do not align"))
    
  int3 <- new_interval(as.POSIXct("2009-08-03 00:00:00"), 
    as.POSIXct("2010-11-02 00:00:00"))
    
  expect_that(int + int3, equals(new_interval(
    as.POSIXct("2008-08-03 00:00:00"), 
    as.POSIXct("2010-11-02 00:00:00"))))    

})

test_that("subtraction with intervals returns correct class",{
  int <- new_interval(as.POSIXct("2008-08-03 00:00:00"), 
    as.POSIXct("2009-08-03 00:00:00"))

  expect_that(class(int - 1)[1], matches("interval"))
  expect_that(class(int - 1)[2], matches("data.frame"))

  expect_that(class(int - minutes(3))[1], matches("interval"))  
  expect_that(class(int - eyears(1))[1], matches("interval"))    
  int3 <- new_interval(as.POSIXct("2008-11-02 00:00:00"), 
    as.POSIXct("2009-08-03 00:00:00"))
    
  expect_that(class(int - int3)[1], matches("interval"))
})

test_that("subtraction still works for numbers",{
  
  expect_that(1 - 1, equals(0))
  expect_that(class(1 - 1), matches("numeric"))
})



# multiplication for everything

test_that("multiplication throws error for instants",{
  x <- as.POSIXct("2010-03-15 00:00:00")
  
  expect_that(3 * x, throws_error())
  
})

test_that("multiplication throws error for intervals",{
  int <- new_interval(as.POSIXct("2008-08-03 00:00:00"), 
    as.POSIXct("2009-08-03 00:00:00"))
    
  expect_that(2 * int, throws_error())
})

test_that("multiplication works as expected for periods",{
  
  expect_that(3*months(1), equals(months(3)))
  expect_that(class(3*months(1))[1], matches("period"))
  
})

test_that("multiplying vectors works for periods",{
  
  expect_that(c(2,3)*months(1), equals(months(2:3)))
  expect_that(class(c(2,3)*months(1))[1], matches("period"))
  
})

test_that("multiplication works as expected for durations",{
    
  expect_that(3*ehours(1), equals(ehours(3)))
  expect_that(class(3*ehours(1)), matches("difftime"))
  
})

test_that("multiplying vectors works for durations",{
  
  expect_that(c(2,3)*ehours(1), equals(ehours(2:3)))
  expect_that(class(c(2,3)*ehours(1)), matches("difftime"))
  
})

test_that("multiplication still works for numbers",{
  expect_that(3*2, equals(6))
  expect_that(c(4,5)*2, equals(c(8,10)))
  expect_that(class(3*2), matches("numeric"))
  
})


# division for everything

test_that("division throws error for instants",{
  x <- as.POSIXct("2010-03-15 00:00:00")
  
  expect_that(3 / x, throws_error())
  expect_that(x / 3, throws_error())
  
})

test_that("division throws error for intervals",{
  int <- new_interval(as.POSIXct("2008-08-03 00:00:00"), 
    as.POSIXct("2009-08-03 00:00:00"))
    
  expect_that(2 / int, throws_error())
  expect_that(int / 2, equals(new_interval(int$start, 
    int$start + as.duration(int$end - int$start) /2)))
})

test_that("division works as expected for periods",{
  
  expect_that(3/months(1), throws_error())
  expect_that(months(1)/3, throws_error(
    "periods must have integer values"))
  expect_that(months(9)/3, equals(months(3)))
  expect_that(class(months(9)/3)[1], matches("period"))
  
})

test_that("dividing vectors works for periods",{
  
  expect_that(c(2,3)/months(1), throws_error())
  expect_that(months(1)/c(2,3), throws_error(
    "periods must have integer values"))
  expect_that(months(9)/c(3,1), equals(months(c(3,9))))
  expect_that(class(months(9)/c(3,1))[1], matches("period"))
  
})

test_that("division works as expected for durations",{
    
  expect_that(3/ehours(1), throws_error())
  expect_that(ehours(9)/3, equals(ehours(3)))
  expect_that(class(ehours(9)/3), matches("difftime"))
  
})

test_that("dividing vectors works for durations",{
  
  expect_that(c(2,3)/ehours(1), throws_error())
  expect_that(ehours(9)/c(3,1), equals(ehours(c(3,9))))
  expect_that(class(ehours(9)/c(3,1)), matches("difftime"))
  
})

test_that("division still works for numbers",{
  expect_that(6/2, equals(3))
  expect_that(c(4,6)/2, equals(c(2,3)))
  expect_that(class(3/2), matches("numeric"))
  
})




test_that("make_difftime makes a correct difftime object",{
  x <- as.POSIXct("2008-01-01 12:00:00")
  y <- difftime(x + 3600, x)
  attr(y, "tzone") <- NULL
  
  expect_that(make_difftime(3600), equals(y))
  expect_that(make_difftime(3600), is_a("difftime"))  
})

test_that("make_difftime handles vector input",{
  x <- as.POSIXct("2008-01-01 12:00:00")
  
  expect_that(make_difftime(c(3600, 900)), equals(difftime(x + c(3600, 900), x)))
  expect_that(make_difftime(c(3600, 900)), is_a("difftime"))
  
})

Sys.setenv(TZ = sysTZ)
if (sysTZ == "") Sys.unsetenv("TZ")