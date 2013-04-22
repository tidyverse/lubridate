context("Daylight savings times")

test_that("force_tz returns NA for a time that falls in the spring gap",{
  x <- structure(1268532305, class = c("POSIXct", "POSIXt"), tzone = "UTC")
  y <- structure(1268618705, class = c("POSIXct", "POSIXt"), tzone = "UTC")
  z <- structure(1268633105, class = c("POSIXct", "POSIXt"), tzone = "America/New_York")
  result <- is.na(force_tz(x, "America/New_York"))

  expect_true(result)
  expect_equal(force_tz(c(y, x), "America/New_York"), c(z, NA)) 
})


test_that("force_tz behaves consistently for the fall overlap",{
  y <- structure(1289111405, tzone = "America/New_York", class = c("POSIXct", 
    "POSIXt"))
  y2 <- structure(1289115005, class = c("POSIXct", "POSIXt"), 
    tzone = "America/New_York")
  y3 <- structure(1289104205, class = c("POSIXct", "POSIXt"), 
    tzone = "America/New_York")
  
  z <- structure(1289197805, class = c("POSIXct", "POSIXt"), 
    tzone = "America/New_York")
  z2 <- structure(1289201405, class = c("POSIXct", "POSIXt"), 
    tzone = "America/New_York")
  z3 <- structure(1289194205, class = c("POSIXct", "POSIXt"), 
    tzone = "America/New_York")
  
  cdst <- structure(1352012400, tzone = "America/Chicago", class = c("POSIXct", 
    "POSIXt"))
  edst <- structure(1352008800, tzone = "America/New_York", class = c("POSIXct", 
    "POSIXt"))

  expect_equal(y + hours(1), y2)
  expect_equal(c(y, z) + hours(1), c(y2, z2))
  expect_equal(y - hours(1), y3)
  expect_equal(c(y, z) - hours(1), c(y3, z3))
  expect_equal(force_tz(cdst, "America/New_York"), edst) 

})

test_that("addition handles daylight savings time for spring gap", {
  x <- structure(1268542800, class = c("POSIXct", "POSIXt"), 
    tzone = "America/New_York")
  px <- structure(1268625600, class = c("POSIXct", "POSIXt"), 
    tzone = "America/New_York")
  px2 <- structure(1268712000, class = c("POSIXct", "POSIXt"), 
    tzone = "America/New_York")
  ex <- structure(1268629200, class = c("POSIXct", "POSIXt"), 
    tzone = "America/New_York")
  ex2 <- structure(1268715600, tzone = "America/New_York", 
    class = c("POSIXct", "POSIXt"))
  
  expect_equal(x + days(1), px)
  expect_equal(c(x, px) + days(1), c(px, px2))
  expect_equal(x + edays(1), ex) 
  expect_equal(c(x, ex) + edays(1), c(ex, ex2))
    
})  


test_that("subtraction handles daylight savings time for spring gap", {
  x <- structure(1268625600, class = c("POSIXct", "POSIXt"), 
    tzone = "America/New_York")
  px <- structure(1268542800, class = c("POSIXct", "POSIXt"), 
    tzone = "America/New_York")
  px2 <- structure(1268456400, class = c("POSIXct", "POSIXt"), 
    tzone = "America/New_York")
  ex <- structure(1268539200, class = c("POSIXct", "POSIXt"), 
    tzone = "America/New_York")
  ex2 <- structure(1268452800, tzone = "America/New_York", 
    class = c("POSIXct", "POSIXt"))
  
  expect_equal(x - days(1), px)
  expect_equal(c(x, px) - days(1), c(px, px2))
  expect_equal(x - edays(1), ex) 
  expect_equal(c(x, ex) - edays(1), c(ex, ex2))
    
})

test_that("addition handles daylight savings time for fall overlap", {
  x <- structure(1289102400, class = c("POSIXct", "POSIXt"), 
    tzone = "America/New_York")
  px <- structure(1289192400, class = c("POSIXct", "POSIXt"), 
    tzone = "America/New_York")
  px2 <- structure(1289278800, class = c("POSIXct", "POSIXt"), 
    tzone = "America/New_York")
  ex <- structure(1289188800, class = c("POSIXct", "POSIXt"), 
    tzone = "America/New_York")
  ex2 <- structure(1289275200, class = c("POSIXct", "POSIXt"), 
    tzone = "America/New_York")
  
  expect_equal(x + days(1), px)
  expect_equal(c(x, px) + days(1), c(px, px2))
  expect_equal(x + edays(1), ex)
  expect_equal(c(x, ex) + edays(1), c(ex, ex2))
})  


test_that("subtraction handles daylight savings time for fall overlap", {
  x <- structure(1289192400, class = c("POSIXct", "POSIXt"), 
     tzone = "America/New_York")
  px <- structure(1289102400, class = c("POSIXct", "POSIXt"), 
     tzone = "America/New_York")
  px2 <- structure(1289016000, class = c("POSIXct", "POSIXt"), 
     tzone = "America/New_York")
  ex <- structure(1289106000, tzone = "America/New_York", 
     class = c("POSIXct", "POSIXt"))
  ex2 <- structure(1289019600, tzone = "America/New_York", 
     class = c("POSIXct", "POSIXt"))
  
  expect_equal(x - days(1), px)
  expect_equal(c(x, px) - days(1), c(px, px2))
  expect_equal(x - edays(1), ex)  
  expect_equal(c(x, ex) - edays(1), c(ex, ex2))
    
})


test_that("update returns NA for date-times in the spring dst gap",{ 
  poslt <- structure(list(sec = 59, min = 59L, hour = 1L, mday = 14L, mon = 2L, 
    year = 110L, wday = 0L, yday = 72L, isdst = 0L), 
    .Names = c("sec", "min", "hour", "mday", "mon", "year", "wday", "yday", "isdst"), 
    class = c("POSIXlt", "POSIXt"), tzone = c("America/New_York", "EST", "EDT"))
  x <- structure(list(sec = 59, min = 59L, hour = 1L, mday = 15L, mon = 2L, 
    year = 110L, wday = 1L, yday = 73L, isdst = 1L), 
    .Names = c("sec", "min", "hour", "mday", "mon", "year", "wday", "yday", "isdst"),
    class = c("POSIXlt", "POSIXt"), tzone = c("America/New_York", "EST", "EDT"))
  x2 <- structure(list(sec = 59, min = 59L, hour = 2L, mday = 15L, mon = 2L, 
    year = 110L, wday = 1L, yday = 73L, isdst = 1L), 
    .Names = c("sec", "min", "hour", "mday", "mon", "year", "wday", "yday", "isdst"),
    class = c("POSIXlt", "POSIXt"), tzone = c("America/New_York", "EST", "EDT"))
  xu <- structure(list(sec = 59, min = 59L, hour = 2L, mday = 15L, mon = 2L, 
    year = 110L, wday = 1L, yday = 73L, isdst = 1L), 
    .Names = c("sec", "min", "hour", "mday", "mon", "year", "wday", "yday", "isdst"),
    class = c("POSIXlt", "POSIXt"), tzone = "UTC")  
     
  expect_true(is.na(update(poslt, seconds = 61)))
  expect_true(is.na(update(poslt, minutes = 61)))
  expect_true(is.na(update(poslt, hours = 2)))
  expect_equal(update(c(x, poslt), hours = 2), c(x2, NA))
  
  poslt <- structure(list(sec = 59, min = 59L, hour = 2L, mday = 13L, mon = 2L, 
    year = 110L, wday = 6L, yday = 71L, isdst = 0L), 
    .Names = c("sec", "min", "hour", "mday", "mon", "year", "wday", "yday", "isdst"),
    class = c("POSIXlt", "POSIXt"), tzone = c("America/New_York", "EST", "EDT"))
  
  expect_true(is.na(update(poslt, mday = 14)))
  expect_true(is.na(update(poslt, wday = 8)))
  expect_true(is.na(update(poslt, yday = 73)))
  
  poslt <- structure(list(sec = 59, min = 59L, hour = 2L, mday = 14L, mon = 1L, 
    year = 110L, wday = 0L, yday = 44L, isdst = 0L), 
    .Names = c("sec", "min", "hour", "mday", "mon", "year", "wday", "yday", "isdst"),
    class = c("POSIXlt", "POSIXt"), tzone = c("America/New_York", "EST", "EDT"))
  
  expect_true(is.na(update(poslt, months = 3)))
  
  poslt <- structure(list(sec = 59, min = 59L, hour = 2L, mday = 14L, mon = 2L, 
    year = 109L, wday = 6L, yday = 72L, isdst = 0L), 
    .Names = c("sec", "min", "hour", "mday", "mon", "year", "wday", "yday", "isdst"),
    class = c("POSIXlt", "POSIXt"), tzone = c("America/New_York", "EST", "EDT"))
  
  expect_true(is.na(update(poslt, years = 2010)))
  
  poslt <- structure(list(sec = 59, min = 59L, hour = 2L, mday = 14L, mon = 2L, 
    year = 110L, wday = 0L, yday = 72L, isdst = 0L), 
    .Names = c("sec", "min", "hour", "mday", "mon", "year", "wday", "yday", "isdst"),
    class = c("POSIXlt", "POSIXt"), tzone = "UTC")
  
  expect_true(is.na(update(poslt, tz = "America/New_York")))
  expect_equal(update(c(xu, poslt), tz = "America/New_York"), c(x2, NA))
  
  
})

test_that("update rollovers perform correctly across the fall overlap",{
  timest <- structure(1289113199, tzone = "America/New_York", 
    class = c("POSIXct", "POSIXt"))
  posct <- structure(1289109659, tzone = "America/New_York", 
    class = c("POSIXct", "POSIXt"))
  timest2 <- structure(1289116919, class = c("POSIXct", "POSIXt"), 
    tzone = "America/New_York")
  timest3 <- structure(1289124119, tzone = "America/New_York", 
    class = c("POSIXct", "POSIXt"))
  timest0 <- structure(1289116859, tzone = "America/New_York", 
    class = c("POSIXct", "POSIXt"))
  
  expect_equal(update(timest, minutes = 121), timest2)
  expect_equal(update(c(timest, timest2), minutes = 121), c(timest2, timest3))
  expect_equal(update(timest, minutes = 0), posct)
  expect_equal(update(c(timest, timest2), minutes = 0), c(posct, timest0))
  

})

test_that("arithmetic handles fall gap in timespan appropriate way", {
  cdst <- structure(1352012400, tzone = "America/Chicago", class = c("POSIXct",                                                                  "POSIXt"))

  expect_equal(cdst - seconds(1), cdst - 3601)
  expect_equal(cdst - eseconds(1), cdst - 1)
})
          
