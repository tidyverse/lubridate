context("Periods")


test_that("is.period works as expected",{
  expect_that(is.period(234), is_false())
  expect_that(is.period(as.POSIXct("2008-08-03 13:01:59", tz = "UTC")),
    is_false())
  expect_that(is.period(as.POSIXlt("2008-08-03 13:01:59", tz = "UTC")), 
    is_false())
  expect_that(is.period(Sys.Date()), is_false())
  expect_that(is.period(minutes(1)), is_true())
  expect_that(is.period(eminutes(1)), is_false())
  expect_that(is.period(new_interval(
    as.POSIXct("2008-08-03 13:01:59", tz = "UTC"), 
    as.POSIXct("2009-08-03 13:01:59", tz = "UTC") )), is_false())
})

test_that("is.period handles vectors",{
  expect_that(is.period(minutes(1:3)), is_true())
})



test_that("new_period works as expected", {
  per <- new_period(second = 90, minute = 5)
  
  expect_is(per, "Period")
  expect_equal(new_period(hours = 25), hours(25))
  expect_equal(per@year, 0)
  expect_equal(per@month, 0)
  expect_equal(per@day, 0)
  expect_equal(per@hour, 0)
  expect_equal(per@minute, 5)
  expect_equal(per@.Data, 90)
  
})

test_that("period works as expected", {
  per <- period(c(90, 5), c("second", "minute"))
  
  expect_is(per, "Period")
  expect_equal(new_period(hours = 25), hours(25))
  expect_equal(per@year, 0)
  expect_equal(per@month, 0)
  expect_equal(per@day, 0)
  expect_equal(per@hour, 0)
  expect_equal(per@minute, 5)
  expect_equal(per@.Data, 90)
  
})

test_that("new_period handles vector input", {
  per <- new_period(second = c(90,60), minute = 5)
  
  expect_is(per, "Period")
  expect_equal(length(per), 2)
  expect_equal(per@year, c(0, 0))
  expect_equal(per@month, c(0, 0))
  expect_equal(per@day, c(0, 0))
  expect_equal(per@hour, c(0, 0))
  expect_equal(per@minute, c(5, 5))
  expect_equal(per@.Data, c(90, 60))
})


test_that("period objects handle vector input", {
  x <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC")
  expect_that(as.numeric(x + minutes(c(1,3,4))), equals(as.numeric(x + c(60,180,240))))
})

test_that("format.Period works as expected", {
  per <- new_period(second = 90, minute = 5)
  per2 <- new_period(days = 0)
  per3 <- new_period(years = 1, days = NA)
  expect_match(format(per), "5M 90S")
  expect_match(format(per2), "0S")
  expect_equivalent(format(per3), as.character(NA))
})

test_that("as.period handles interval objects", {
  time1 <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC") 
  time2 <- as.POSIXct("2009-08-03 13:01:59", tz = "UTC")
  int <- new_interval(time1, time2)
    
  expect_that(as.period(int), equals(years(1)))
})

test_that("as.period handles NA interval objects", {
  one_missing_date <- as.POSIXct(NA_real_, origin = origin)
  one_missing_interval <- new_interval(one_missing_date, 
    one_missing_date)
  several_missing_dates <- rep(as.POSIXct(NA_real_, origin = origin), 2)
  several_missing_intervals <- new_interval(several_missing_dates, 
    several_missing_dates)
  start_missing_intervals <- new_interval(several_missing_dates, origin)
  end_missing_intervals <- new_interval(origin, several_missing_dates)
  na.per <- new_period(sec= NA, min = NA, hour = NA, day = NA, 
    month = NA, year = NA)
  
  expect_equal(as.period(one_missing_interval, "year"), na.per)
  expect_equal(as.period(several_missing_intervals, "year"), c(na.per, na.per))
  expect_equal(as.period(start_missing_intervals, "year"), c(na.per, na.per))
  expect_equal(as.period(end_missing_intervals, "year"), c(na.per, na.per))
})

test_that("as.period handles NA duration objects", {
  na.per <- new_period(sec= NA, min = NA, hour = NA, day = NA, 
    month = NA, year = NA)
  
  expect_equal(suppressMessages(as.period(dyears(NA))), na.per)
  expect_equal(suppressMessages(as.period(dyears(c(NA, NA)))), c(na.per, na.per))
  expect_equal(suppressMessages(as.period(dyears(c(1, NA)))), c(years(1), na.per))
})
  
test_that("as.period handles NA objects", { 
  na.per <- seconds(NA)
  expect_equal(as.period(NA), na.per)
})

test_that("as.period handles vectors", {
  time1 <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC") 
  time2 <- as.POSIXct("2009-08-03 13:01:59", tz = "UTC")
  time3 <- as.POSIXct("2010-08-03 13:01:59", tz = "UTC")
  int <- new_interval(c(time2, time1), time3)
    
  dur <- new_duration(seconds = 5, minutes = c(30,59))
    
  expect_that(as.period(int), equals(years(1:2)))
  expect_that(as.period(dur), equals(seconds(5) + 
    minutes(c(30,59))))
})

test_that("as.period handles duration objects", {
  dur <- new_duration(seconds = 5, minutes = 30)  
  expect_that(as.period(dur), equals(seconds(5) + minutes(30)))
})

test_that("[<- can subset periods with new periods", {
  Time <- data.frame(Time = c(hms("01:01:01"), hms("02:02:02")))
  Time[1,1] <- Time[1,1] + hours(1)
  
  times <- days(1:3)
  times[1] <- times[1] + hours(2)
  
  expect_equal(Time[1,1], hms("02:01:01"))
  expect_equal(times[1], new_period(days = 1, hours = 2))
  
})

test_that("period correctly handles week units", {
  expect_equal(period(1, "week"), days(7))
  expect_equal(period(8, "days"), days(8))
  expect_equal(period(c(3,2), c("days", "week")), days(c(17)))
})

test_that("format.period correctly displays negative units", {
  expect_match(format(days(-2)), "-2d 0H 0M 0S")
  expect_match(format(new_period(second = -1, hour = -2, day = 3)), "3d -2H 0M -1S")
})

test_that("format.Period correctly displays intervals of length 0", {
  per <- new_period(seconds = 5)
  
  expect_output(per[FALSE], "Period\\(0)")
})

test_that("c.Period correctly handles NAs", {
  per <- new_period(seconds = 5)
  
  expect_true(is.na(c(per, NA)[2]))
})

test_that("summary.Period creates useful summary", {
  per <- new_period(minutes = 5)
  text <- c(rep("5M 0S", 6), 1)
  names(text) <- c("Min.", "1st Qu.", "Median", "Mean", "3rd Qu.", "Max.", "NA's")
  
  expect_equal(summary(c(per, NA)), text)
})