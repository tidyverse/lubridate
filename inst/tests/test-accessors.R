context("Accessors")

test_that("seconds accessor extracts correct second",{
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)
  
  expect_that(second(poslt), equals(59))
  expect_that(second(posct), equals(59))
  expect_that(second(date), equals(0))

})

test_that("minutes accessor extracts correct minute",{
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)
  
  expect_that(minute(poslt), equals(45))
  expect_that(minute(posct), equals(45))
  expect_that(minute(date), equals(0))

})

test_that("hours accessor extracts correct hour",{
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)
  
  expect_that(hour(poslt), equals(13))
  expect_that(hour(posct), equals(13))
  expect_that(hour(date), equals(0))

})

test_that("days accessors extract correct days",{
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)
  
  expect_that(day(poslt), equals(3))
  expect_that(day(posct), equals(3))
  expect_that(day(date), equals(3))
  
  expect_that(mday(poslt), equals(3))
  expect_that(mday(posct), equals(3))
  expect_that(mday(date), equals(3))
  
  expect_that(yday(poslt), equals(34))
  expect_that(yday(posct), equals(34))
  expect_that(yday(date), equals(34))
  
  expect_that(wday(poslt), equals(4))
  expect_that(wday(posct), equals(4))
  expect_that(wday(date), equals(4))
})

test_that("weeks accessor extracts correct week",{
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)
  
  expect_that(week(poslt), equals(5))
  expect_that(week(posct), equals(5))
  expect_that(week(date), equals(5))

})

test_that("isoweek accessor extracts correct ISO8601 week",{
  poslt <- as.POSIXlt("2010-01-01 13:45:59", tz = "UTC", format = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)
  
  expect_that(isoweek(poslt), equals(53))
  expect_that(isoweek(posct), equals(53))
  expect_that(isoweek(date), equals(53))
  
})

test_that("months accessor extracts correct month",{
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)
  
  expect_that(month(poslt), equals(2))
  expect_that(month(posct), equals(2))
  expect_that(month(date), equals(2))

})

test_that("years accessor extracts correct year",{
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)
  
  expect_that(year(poslt), equals(2010))
  expect_that(year(posct), equals(2010))
  expect_that(year(date), equals(2010))

})

test_that("timezone accessor extracts correct timezone",{
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)
  
  expect_that(tz(poslt), matches("UTC"))
  expect_that(tz(posct), matches("UTC"))
  expect_that(tz(date), matches("UTC"))

})


test_that("accessors handle vectors",{ 
  poslt <- as.POSIXlt(c("2001-01-01 01:01:01", 
    "2002-02-02 02:02:02", "2003-03-03 03:03:03"), 
    tz = "UTC", format = "%Y-%m-%d %H:%M:%S") 
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)
  
  expect_that(second(poslt), equals(c(1,2,3)))
  expect_that(second(posct), equals(c(1,2,3)))
  expect_that(second(date), equals(c(0,0,0)))
  
  expect_that(minute(poslt), equals(c(1,2,3)))
  expect_that(minute(posct), equals(c(1,2,3)))
  expect_that(minute(date), equals(c(0,0,0)))
  
  expect_that(hour(poslt), equals(c(1,2,3)))
  expect_that(hour(posct), equals(c(1,2,3)))
  expect_that(hour(date), equals(c(0,0,0)))
  
  expect_that(mday(poslt), equals(c(1,2,3)))
  expect_that(mday(posct), equals(c(1,2,3)))
  expect_that(mday(date), equals(c(1,2,3)))
  
  expect_that(wday(poslt), equals(c(2,7,2)))
  expect_that(wday(posct), equals(c(2,7,2)))
  expect_that(wday(date), equals(c(2,7,2)))
  
  expect_that(yday(poslt), equals(c(1,33,62)))
  expect_that(yday(posct), equals(c(1,33,62)))
  expect_that(yday(date), equals(c(1,33,62)))
  
  expect_that(week(poslt), equals(c(1,5,9)))
  expect_that(week(posct), equals(c(1,5,9)))
  expect_that(week(date), equals(c(1,5,9)))
  
  expect_that(isoweek(poslt), equals(c(1,5,10)))
  expect_that(isoweek(posct), equals(c(1,5,10)))
  expect_that(isoweek(date), equals(c(1,5,10)))
  
  expect_that(month(poslt), equals(c(1,2,3)))
  expect_that(month(posct), equals(c(1,2,3)))
  expect_that(month(date), equals(c(1,2,3)))
  
  expect_that(year(poslt), equals(c(2001,2002,2003)))
  expect_that(year(posct), equals(c(2001,2002,2003)))
  expect_that(year(date), equals(c(2001,2002,2003)))
  
  expect_that(tz(poslt), matches("UTC"))
  expect_that(tz(posct), matches("UTC"))
  expect_that(tz(date), matches("UTC"))
})

test_that("accessors handle Period objects",{ 
  per <- new_period(seconds = 1, minutes = 2, hours = 3, days = 4, months = 5, 
    years = 6)
  pers <- c(per, per)
  
  expect_equal(second(per), 1)
  expect_equal(minute(per), 2)
  expect_equal(hour(per), 3)
  expect_equal(day(per), 4)
  expect_equal(month(per), 5)
  expect_equal(year(per), 6)
  
  expect_equal(second(pers), c(1, 1))
  expect_equal(minute(pers), c(2, 2))
  expect_equal(hour(pers), c(3, 3))
  expect_equal(day(pers), c(4, 4))
  expect_equal(month(pers), c(5, 5))
  expect_equal(year(pers), c(6, 6))
  
  second(per) <- 2
  minute(per) <- 3
  hour(per) <- 4
  day(per) <- 5
  month(per) <- 6
  year(per) <- 7
  
  expect_equal(per@.Data, 2)
  expect_equal(per@minute, 3)
  expect_equal(per@hour, 4)
  expect_equal(per@day, 5)
  expect_equal(per@month, 6)
  expect_equal(per@year, 7)
  
  second(pers) <- c(2, 3)
  minute(pers) <- c(3, 4)
  hour(pers) <- c(4, 5)
  day(pers) <- c(5, 6)
  month(pers) <- c(6, 7)
  year(pers) <- c(7, 8)
  
  expect_equal(pers@.Data, c(2, 3))
  expect_equal(pers@minute, c(3, 4))
  expect_equal(pers@hour, c(4, 5))
  expect_equal(pers@day, c(5, 6))
  expect_equal(pers@month, c(6, 7))
  expect_equal(pers@year, c(7, 8))

})



context("test days_in_month")

test_that(
  "days in month works for non leap years",
{
  x <- seq(ymd("2011-01-01"), ymd("2011-12-01"), "1 month")
  expected <- c(
    Jan = 31L, Feb = 28L, Mar = 31L, 
    Apr = 30L, May = 31L, Jun = 30L, 
    Jul = 31L, Aug = 31L, Sep = 30L, 
    Oct = 31L, Nov = 30L, Dec = 31L
  )
  expect_that(days_in_month(x), equals(expected))
}
)

test_that(
  "days in month works for leap years",
{
  x <- seq(ymd("2012-01-01"), ymd("2012-12-01"), "1 month")
  expected <- c(
    Jan = 31L, Feb = 29L, Mar = 31L, 
    Apr = 30L, May = 31L, Jun = 30L, 
    Jul = 31L, Aug = 31L, Sep = 30L, 
    Oct = 31L, Nov = 30L, Dec = 31L
  )
  expect_that(days_in_month(x), equals(expected))
}
)

