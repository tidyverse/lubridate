context("Durations")

test_that("new_difftime works as expected",{
  x <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC")
  y <- difftime(x + 5 + 30*60 + 60*60 + 14*24*60*60, x, tz = "UTC")
  attr(y, "tzone") <- NULL
  diff <- new_difftime(seconds = 5, minutes = 30, days = 0, 
    hour = 1, weeks = 2)
  
  expect_that(diff, equals(y))
})

test_that("new_difftime handles vectors",{
  x <- as.POSIXct(c("2008-08-03 13:01:59", "2008-08-03 13:01:59"), tz = "UTC")
  y <- difftime(x + c(5 + 30*60 + 60*60 + 14*24*60*60, 
    1 + 3*24*60*60 + 60*60), x, tz = "UTC")
  attr(y, "tzone") <- NULL
  z <- difftime(x + c(5 + 30*60 + 60*60 + 14*24*60*60, 5 + 
    30*60 + 60*60 + 14*24*60*60 + 3*24*60*60), x, tz = "UTC")
  attr(z, "tzone") <- NULL
    
  
  expect_that(new_difftime(seconds = c(5, 1), minutes = c(30,
    0), days = c(0, 3), hour = c(1,1), weeks = c(2, 0)),
    equals(y))
    
  expect_that(new_difftime(seconds = 5, minutes = 30, days = 
    c(0, 3), hour = 1, weeks = 2), equals(z))

})


test_that("new_duration works as expected",{
  dur <- new_duration(seconds = 5, minutes = 30, days = 0, 
    hour = 1, weeks = 2)
  
  expect_equal(dur@.Data, 1215005)
  expect_is(dur, "Duration")
})


test_that("new_duration handles vectors",{
  dur1 <- new_duration(seconds = c(5, 1), minutes = c(30, 0), 
  	days = c(0, 3), hour = c(1,1), weeks = c(2, 0))
  dur2 <- new_duration(seconds = 5, minutes = 30, days = 
    c(0, 3), hour = 1, weeks = 2) 
  
  expect_equal(dur1@.Data, c(1215005, 262801))
  expect_equal(dur2@.Data, c(1215005, 1474205))
  expect_is(dur1, "Duration")
  expect_is(dur2, "Duration")

})



test_that("as.duration handles vectors",{
  expect_that(as.duration(minutes(1:3)), equals(eminutes(1:3)))
})

test_that("as.duration handles periods",{
  
  expect_that(as.duration(seconds(1)), equals(dseconds(1)))
  expect_that(as.duration(minutes(2)), equals(dminutes(2)))
  expect_that(as.duration(hours(3)), equals(dhours(3)))
  expect_that(as.duration(days(4)), equals(ddays(4)))
  expect_that(as.duration(weeks(5)), equals(dweeks(5)))
  expect_that(as.duration(months(1)), equals(dseconds(60*60*24*365/12)))
  expect_that(as.duration(years(1)), equals(dseconds(60*60*24*365)))
  expect_that(as.duration(seconds(1) + minutes(4)), equals(dseconds(1) + dminutes(4)))
})

test_that("as.duration handles intervals",{
	time1 <- as.POSIXct("2009-01-02 12:24:03", tz = "UTC")
	time2 <- as.POSIXct("2010-02-03 14:31:42", tz = "UTC")
	dur <- as.duration(interval(time1, time2))
    y <- as.numeric(time2 - time1, units = "secs")
  
  expect_equal(dur@.Data, y)
  expect_is(dur, "Duration")
})

test_that("as.duration handles difftimes",{
  x <- difftime(as.POSIXct("2010-02-03 14:31:42", tz = "UTC"),
    as.POSIXct("2009-01-02 12:24:03", tz = "UTC"))
  dur <- as.duration(x)
  y <- as.numeric(x, units = "secs")
  
  expect_equal(dur@.Data, y)
  expect_is(dur, "Duration")
})


test_that("eobjects handle vectors",{
  dur <- dseconds(c(1,3,4))

  expect_equal(dur@.Data, c(1, 3, 4))
  expect_is(dur, "Duration")
})


test_that("is.duration works as expected",{
  ct_time <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC")
  lt_time <- as.POSIXlt("2009-08-03 13:01:59", tz = "UTC")
	
  expect_that(is.duration(234), is_false())
  expect_that(is.duration(ct_time), is_false())
  expect_that(is.duration(lt_time), is_false())
  expect_that(is.duration(Sys.Date()), is_false())
  expect_that(is.duration(minutes(1)), is_false())
  expect_that(is.duration(eminutes(1)), is_true())
  expect_that(is.duration(new_difftime(1000)), is_false())
  expect_that(is.duration(new_interval(lt_time, ct_time)), is_false())
})

test_that("is.duration handle vectors",{
  expect_that(is.duration(dminutes(1:3)), is_true())
})

test_that("format.Duration correctly displays intervals of length 0", {
  dur <- new_duration(seconds = 5)
  
  expect_output(dur[FALSE], "Duration\\(0)")
})

test_that("format.Duration correctly displays durations with an NA", {
  dur <- new_duration(seconds = c(5, NA))
  
  expect_equivalent(format(dur), c("5s", NA))
})

test_that("summary.Duration creates useful summary", {
  dur <- dminutes(5)
  text <- c(rep("300s (~5 minutes)", 6), 1)
  names(text) <- c("Min.", "1st Qu.", "Median", "Mean", "3rd Qu.", "Max.", "NA's")
  
  expect_equal(summary(c(dur, NA)), text)
})

test_that("compute_estimate works with NA values", {
  x <- list(
    NA,
    c(1, NA),
    c(100, NA),
    c(10000, NA),
    c(100000, NA),
    c(100000000, NA)
  )
  expected <- list(
    "NA seconds",
    c("1 seconds", "NA seconds"),
    c("~1.67 minutes", "NA minutes"),
    c("~2.78 hours", "NA hours"),
    c("~1.16 days", "NA days"),
    c("~3.17 years", "NA years")
  )
  mapply(function(x, expected) {
      expect_identical(expected, lubridate:::compute_estimate(x))
    },
    x, expected)
})

test_that("as.duration handles NA interval objects", {
  one_missing_date <- as.POSIXct(NA_real_, origin = origin)
  one_missing_interval <- new_interval(one_missing_date, 
                                       one_missing_date)
  several_missing_dates <- rep(as.POSIXct(NA_real_, origin = origin), 2)
  several_missing_intervals <- new_interval(several_missing_dates, 
                                            several_missing_dates)
  start_missing_intervals <- new_interval(several_missing_dates, origin)
  end_missing_intervals <- new_interval(origin, several_missing_dates)
  na.dur <- dseconds(NA)
  
  expect_equal(as.duration(one_missing_interval), na.dur)
  expect_equal(as.duration(several_missing_intervals), c(na.dur, na.dur))
  expect_equal(as.duration(start_missing_intervals), c(na.dur, na.dur))
  expect_equal(as.duration(end_missing_intervals), c(na.dur, na.dur))
})

test_that("as.duration handles NA period objects", {
  na.dur <- dseconds(NA)
  
  expect_equal(suppressMessages(as.duration(years(NA))), na.dur)
  expect_equal(suppressMessages(as.duration(years(c(NA, NA)))), c(na.dur, na.dur))
  expect_equal(suppressMessages(as.duration(years(c(1, NA)))), c(dyears(1), na.dur))
})

test_that("as.duration handles NA objects", { 
  na.dur <- dseconds(NA)
  expect_equal(as.duration(NA), na.dur)
})