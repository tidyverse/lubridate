context("timespans")

test_that("is.timespan works as expected",{
  expect_that(is.timespan(234), is_false())
  expect_that(is.timespan(as.POSIXct("2008-08-03 13:01:59", tz = "UTC")),
    is_false())
  expect_that(is.timespan(as.POSIXlt("2008-08-03 13:01:59", tz = "UTC")), 
    is_false())
  expect_that(is.timespan(Sys.Date()), is_false())
  expect_that(is.timespan(minutes(1)), is_true())
  expect_that(is.timespan(eminutes(1)), is_true())
  expect_that(is.timespan(new_interval(
    as.POSIXct("2008-08-03 13:01:59", tz = "UTC"), 
    as.POSIXct("2009-08-03 13:01:59", tz = "UTC") )), is_true())
})

test_that("is.timespan handles vectors",{
  expect_that(is.timespan(minutes(1:3)), is_true())
})

test_that("time_length works as expected",{
  expect_that(time_length(period(1, "day")), # period 
              equals(86400)) 
  expect_that(time_length(ymd('2014-12-15')-ymd('2014-11-30'), "day"), # difftime 
              equals(15)) 
  expect_that(time_length(ymd('2014-12-15')-ymd('2014-11-30'), "week"), 
              equals(15/7)) 
  expect_that(time_length(duration(3, "months"), "month"), # duration
              equals(3))
  expect_that(time_length(interval(ymd('2014-11-30'), ymd('2014-12-15')), "weeks"), # interval
              equals(15/7))
  expect_that(time_length(interval(ymd('1900-01-01'), ymd('1999-12-31')), "years"), 
              is_less_than(100))
  expect_that(time_length(as.duration(interval(ymd('1900-01-01'), ymd('1999-12-31'))), "years"), 
              is_more_than(100))
  expect_that(-time_length(interval(ymd('1900-01-01'), ymd('2000-01-01')), "days"),
              equals(time_length(int_flip(interval(ymd('1900-01-01'), ymd('2000-01-01'))), "days")))
  ## time_length should work even if date of birth is a 29 Feb
  expect_that(round(time_length(interval(ymd('1992-02-29'), ymd('1999-02-28')), "years"), 3), 
              equals(6.999))
  expect_that(round(time_length(interval(ymd('1992-02-29'), ymd('1999-03-31')), "years"), 3), 
              equals(7.089))
  ## With a leap year, we expect same number of days
  expect_that(-time_length(interval(ymd('1992-02-28'), ymd('2000-01-01')), "days"),
              equals(time_length(int_flip(interval(ymd('1992-02-28'), ymd('2000-01-01'))), "days")))
  ## If both ends are leap years, the lenths are identical
  expect_true(-time_length(interval(ymd('1992-02-28'), ymd('2000-01-01')), "years") == 
                time_length(int_flip(interval(ymd('1992-02-28'), ymd('2000-01-01'))), "years"))
  ## ... otherwise not
  expect_false(-time_length(interval(ymd('1992-02-28'), ymd('2001-01-01')), "years") == 
                 time_length(int_flip(interval(ymd('1992-02-28'), ymd('2001-01-01'))), "years"))
})

test_that("time_length handles vectors",{
  expect_that(time_length(days(1:3), unit="days"), equals(1:3))
  expect_that(time_length(as.interval(days(1:3), start=today()), unit="days"), equals(1:3))
  expect_that(time_length(as.interval(days(c(1:3,NA)), start=today()), unit="days"), equals(c(1:3,NA)))
})
