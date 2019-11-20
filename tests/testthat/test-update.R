context("Updating dates")

test_that("update.Date returns a date object", {
  date <- as.Date("05/05/2010", "%m/%d/%Y")
  expect_is(update(date, days = 1), "Date")
  expect_is(update(date, ydays = 1), "Date")
  expect_is(update(date, mdays = 1), "Date")
  expect_is(update(date, wdays = 1), "Date")
  expect_is(update(date, months = 1), "Date")
  expect_is(update(date, years = 2001), "Date")
  expect_is(update(date, tzs = "UTC"), "Date")
})

test_that("update.Date returns a posix object if time is manipulated", {
  date <- as.Date("05/05/2010", "%m/%d/%Y")
  expect_is(update(date, seconds = 1), "POSIXt")
  expect_is(update(date, minutes = 1), "POSIXt")
  expect_is(update(date, hours = 1), "POSIXt")
})

test_that("update.POSIXlt returns a POSIXlt object", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "GMT", format = "%Y-%m-%d %H:%M:%S")
  expect_is(update(poslt, seconds = 1), "POSIXlt")
  expect_is(update(poslt, minutes = 1), "POSIXlt")
  expect_is(update(poslt, hours = 1), "POSIXlt")
  expect_is(update(poslt, days = 1), "POSIXlt")
  expect_is(update(poslt, ydays = 1), "POSIXlt")
  expect_is(update(poslt, mdays = 1), "POSIXlt")
  expect_is(update(poslt, wdays = 1), "POSIXlt")
  expect_is(update(poslt, months = 1), "POSIXlt")
  expect_is(update(poslt, years = 2001), "POSIXlt")
  expect_is(update(poslt, tzs = "UTC"), "POSIXlt")
})

test_that("update.POSIXct returns a POSIXct object", {
  posct <- as.POSIXct("2010-02-03 13:45:59", tz = "GMT", format
     = "%Y-%m-%d %H:%M:%S")
  expect_is(update(posct, seconds = 1), "POSIXct")
  expect_is(update(posct, minutes = 1), "POSIXct")
  expect_is(update(posct, hours = 1), "POSIXct")
  expect_is(update(posct, days = 1), "POSIXct")
  expect_is(update(posct, ydays = 1), "POSIXct")
  expect_is(update(posct, mdays = 1), "POSIXct")
  expect_is(update(posct, wdays = 1), "POSIXct")
  expect_is(update(posct, months = 1), "POSIXct")
  expect_is(update(posct, years = 2001), "POSIXct")
  expect_is(update(posct, tzs = "UTC"), "POSIXct")
})

test_that("update.Date performs simple operation as expected", {
  date <- as.Date("05/05/2010", "%m/%d/%Y")
  expect_equal(second(update(date, seconds = 1)), 1)
  expect_equal(minute(update(date, minutes = 1)), 1)
  expect_equal(hour(update(date, hours = 1)), 1)
  expect_equal(mday(update(date, mdays = 1)), 1)
  expect_equal(wday(update(date, mdays = 1)), 7)
  expect_equal(yday(update(date, mdays = 1)), 121)
  expect_equal(yday(update(date, ydays = 1)), 1)
  expect_equal(mday(update(date, ydays = 1)), 1)
  expect_equal(wday(update(date, ydays = 1)), 6)
  expect_equal(wday(update(date, wdays = 1)), 1)
  expect_equal(yday(update(date, wdays = 1)), 122)
  expect_equal(mday(update(date, wdays = 1)), 2)
  expect_equal(month(update(date, months = 1)), 1)
  expect_equal(year(update(date, years = 2000)), 2000)
  expect_match(tz(update(date, tzs = "UTC")), "UTC")
})

test_that("update.POSIXt performs simple operation as expected", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "GMT", format = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct("2010-02-03 13:45:59", tz = "GMT", format = "%Y-%m-%d %H:%M:%S")
  expect_equal(second(update(poslt, seconds = 1)), 1)
  expect_equal(minute(update(poslt, minutes = 1)), 1)
  expect_equal(hour(update(poslt, hours = 1)), 1)
  expect_equal(mday(update(poslt, mdays = 1)), 1)
  expect_equal(wday(update(poslt, mdays = 1)), 2)
  expect_equal(yday(update(poslt, mdays = 1)), 32)
  expect_equal(yday(update(poslt, ydays = 1)), 1)
  expect_equal(mday(update(poslt, ydays = 1)), 1)
  expect_equal(wday(update(poslt, ydays = 1)), 6)
  expect_equal(wday(update(poslt, wdays = 1)), 1)
  expect_equal(yday(update(poslt, wdays = 1)), 31)
  expect_equal(mday(update(poslt, wdays = 1)), 31)
  expect_equal(month(update(poslt, months = 1)), 1)
  expect_equal(year(update(poslt, years = 2000)), 2000)
  expect_match(tz(update(poslt, tzs = "UTC")), "UTC")
  expect_equal(second(update(posct, seconds = 1)), 1)
  expect_equal(minute(update(posct, minutes = 1)), 1)
  expect_equal(hour(update(posct, hours = 1)), 1)
  expect_equal(mday(update(posct, mdays = 1)), 1)
  expect_equal(wday(update(posct, mdays = 1)), 2)
  expect_equal(yday(update(posct, mdays = 1)), 32)
  expect_equal(yday(update(posct, ydays = 1)), 1)
  expect_equal(mday(update(posct, ydays = 1)), 1)
  expect_equal(wday(update(posct, ydays = 1)), 6)
  expect_equal(wday(update(posct, wdays = 1)), 1)
  expect_equal(yday(update(posct, wdays = 1)), 31)
  expect_equal(mday(update(posct, wdays = 1)), 31)
  expect_equal(month(update(posct, months = 1)), 1)
  expect_equal(year(update(posct, years = 2000)), 2000)
  expect_match(tz(update(posct, tzs = "UTC")), "UTC")
})

test_that("update.POSIXt works on wdays", {

  date <- ymd("2017-05-07") ## sunday
  ct <- as.POSIXct("2010-02-03 13:45:59", tz = "America/New_York", format = "%Y-%m-%d %H:%M:%S") ## Wednesday
  expect_equal(wday(update(ct, wdays = 1)), 1)
  expect_equal(wday(update(ct, wdays = 2)), 2)
  expect_equal(wday(update(ct, wdays = 5)), 5)
  expect_equal(wday(update(ct, wdays = 7)), 7)
  expect_equal(wday(update(date, wdays = 1)), 1)
  expect_equal(wday(update(date, wdays = 2)), 2)
  expect_equal(wday(update(date, wdays = 5)), 5)
  expect_equal(wday(update(date, wdays = 7)), 7)

  ws <- 1
  expect_equal(wday(update(ct, wdays = 1, week_start = ws)), 2)
  expect_equal(wday(update(ct, wdays = 2, week_start = ws)), 3)
  expect_equal(wday(update(ct, wdays = 5, week_start = ws)), 6)
  expect_equal(wday(update(ct, wdays = 7, week_start = ws)), 1)
  expect_equal(wday(update(date, wdays = 1, week_start = ws)), 2)
  expect_equal(wday(update(date, wdays = 2, week_start = ws)), 3)
  expect_equal(wday(update(date, wdays = 5, week_start = ws)), 6)
  expect_equal(wday(update(date, wdays = 7, week_start = ws)), 1)

  ws <- 1
  expect_equal(wday(update(ct, wdays = 1, week_start = ws), week_start = ws), 1)
  expect_equal(wday(update(ct, wdays = 2, week_start = ws), week_start = ws), 2)
  expect_equal(wday(update(ct, wdays = 5, week_start = ws), week_start = ws), 5)
  expect_equal(wday(update(ct, wdays = 7, week_start = ws), week_start = ws), 7)
  expect_equal(wday(update(date, wdays = 1, week_start = ws), week_start = ws), 1)
  expect_equal(wday(update(date, wdays = 2, week_start = ws), week_start = ws), 2)
  expect_equal(wday(update(date, wdays = 5, week_start = ws), week_start = ws), 5)
  expect_equal(wday(update(date, wdays = 7, week_start = ws), week_start = ws), 7)

  ws <- 3
  expect_equal(wday(update(ct, wdays = 1, week_start = ws), week_start = ws), 1)
  expect_equal(wday(update(ct, wdays = 2, week_start = ws), week_start = ws), 2)
  expect_equal(wday(update(ct, wdays = 5, week_start = ws), week_start = ws), 5)
  expect_equal(wday(update(ct, wdays = 7, week_start = ws), week_start = ws), 7)
  expect_equal(wday(update(date, wdays = 1, week_start = ws), week_start = ws), 1)
  expect_equal(wday(update(date, wdays = 2, week_start = ws), week_start = ws), 2)
  expect_equal(wday(update(date, wdays = 5, week_start = ws), week_start = ws), 5)
  expect_equal(wday(update(date, wdays = 7, week_start = ws), week_start = ws), 7)

})

test_that("updates on ydays works correctly with leap years", {
  expect_equal(update(ymd("15-02-03", tz = "UTC"), years = 2000, ydays = 1),
               ymd("2000-01-01", tz = "UTC"))
  expect_equal(update(ymd("15-02-03", tz = "UTC"), years = 2015, ydays = 1),
               ymd("2015-01-01", tz = "UTC"))
  expect_equal(update(ymd("15-02-03", tz = "UTC"), years = 2016, ydays = 10),
               ymd("2016-01-10", tz = "UTC"))
  expect_equal(update(ymd("15-02-03", tz = "America/New_York"), years = 2000, ydays = 1),
               ymd("2000-01-01", tz = "America/New_York"))
  expect_equal(update(ymd("15-02-03", tz = "America/New_York"), years = 2015, ydays = 1),
               ymd("2015-01-01", tz = "America/New_York"))
  expect_equal(update(ymd("15-02-03", tz = "America/New_York"), years = 2016, ydays = 10),
               ymd("2016-01-10", tz = "America/New_York"))

  expect_equal(update(ymd(c("2016-02-29", "2016-03-01")), ydays = 1),
               ymd(c("2016-01-01", "2016-01-01")))
  expect_equal(update(ymd(c("2016-02-29", "2016-03-01"), tz = "America/New_York"), ydays = 1),
               ymd(c("2016-01-01", "2016-01-01"), tz = "America/New_York"))
  expect_equal(update(ymd_hms(c("2016-02-29 1:2:3", "2016-03-01 10:20:30")), ydays = 1),
               ymd_hms(c("2016-01-01 1:2:3", "2016-01-01 10:20:30")))
  expect_equal(update(ymd_hms(c("2016-02-29 1:2:3", "2016-03-01 10:20:30"), tz = "America/New_York"), ydays = 1),
               ymd_hms(c("2016-01-01 1:2:3", "2016-01-01 10:20:30"), tz = "America/New_York"))

})


test_that("update performs roll overs correctly for Date objects", {
  date <- as.Date("05/05/2010", "%m/%d/%Y")
  expect_equal(second(update(date, seconds = 61)), 1)
  expect_equal(minute(update(date, seconds = 61)), 1)
  expect_equal(minute(update(date, minutes = 61)), 1)
  expect_equal(hour(update(date, minutes = 61)), 1)
  expect_equal(hour(update(date, hours = 25)), 1)
  expect_equal(mday(update(date, hours = 25)), 6)
  expect_equal(yday(update(date, hours = 25)), 126)
  expect_equal(wday(update(date, hours = 25)), 5)
  expect_equal(mday(update(date, mdays = 32)), 1)
  expect_equal(month(update(date, mdays = 32)), 6)
  expect_equal(wday(update(date, wdays = 31)), 3)
  expect_equal(month(update(date, wdays = 31)), 6)
  expect_equal(yday(update(date, ydays = 366)), 1)
  expect_equal(month(update(date, ydays = 366)), 1)
  expect_equal(month(update(date, months = 13)), 1)
  expect_equal(year(update(date, months = 13)), 2011)
  expect_match(tz(update(date, months = 13)), "UTC")
})

test_that("update performs roll overs correctly for POSIXlt objects", {
  poslt <- as.POSIXlt("2010-05-05 00:00:00", tz = "GMT", format = "%Y-%m-%d %H:%M:%S")
  expect_equal(second(update(poslt, seconds = 61)), 1)
  expect_equal(minute(update(poslt, seconds = 61)), 1)
  expect_equal(minute(update(poslt, minutes = 61)), 1)
  expect_equal(hour(update(poslt, minutes = 61)), 1)
  expect_equal(hour(update(poslt, hours = 25)), 1)
  expect_equal(mday(update(poslt, hours = 25)), 6)
  expect_equal(yday(update(poslt, hours = 25)), 126)
  expect_equal(wday(update(poslt, hours = 25)), 5)
  expect_equal(mday(update(poslt, mdays = 32)), 1)
  expect_equal(month(update(poslt, mdays = 32)), 6)
  expect_equal(wday(update(poslt, wdays = 31)), 3)
  expect_equal(month(update(poslt, wdays = 31)), 6)
  expect_equal(yday(update(poslt, ydays = 366)), 1)
  expect_equal(month(update(poslt, ydays = 366)), 1)
  expect_equal(month(update(poslt, months = 13)), 1)
  expect_equal(year(update(poslt, months = 13)), 2011)
  expect_match(tz(update(poslt, months = 13)), "GMT")
})

test_that("update performs roll overs correctly for POSIXct objects", {
  posct <- as.POSIXct("2010-05-05 00:00:00", tz = "GMT", format = "%Y-%m-%d %H:%M:%S")
  expect_equal(second(update(posct, seconds = 61)), 1)
  expect_equal(minute(update(posct, seconds = 61)), 1)
  expect_equal(minute(update(posct, minutes = 61)), 1)
  expect_equal(hour(update(posct, minutes = 61)), 1)
  expect_equal(hour(update(posct, hours = 25)), 1)
  expect_equal(mday(update(posct, hours = 25)), 6)
  expect_equal(yday(update(posct, hours = 25)), 126)
  expect_equal(wday(update(posct, hours = 25)), 5)
  expect_equal(mday(update(posct, mdays = 32)), 1)
  expect_equal(month(update(posct, mdays = 32)), 6)
  expect_equal(wday(update(posct, wdays = 31)), 3)
  expect_equal(month(update(posct, wdays = 31)), 6)
  expect_equal(yday(update(posct, ydays = 366)), 1)
  expect_equal(month(update(posct, ydays = 366)), 1)
  expect_equal(month(update(posct, months = 13)), 1)
  expect_equal(year(update(posct, months = 13)), 2011)
  expect_match(tz(update(posct, months = 13)), "GMT")
})

test_that("update performs consecutive roll overs correctly for
  Date objects regardless of order", {
  date <- update(as.Date("11/01/2010", "%m/%d/%Y"),
    months = 13, days = 32, hours = 25, minutes = 61, seconds
     = 61)
  expect_equal(second(date), 1)
  expect_equal(minute(date), 2)
  expect_equal(hour(date), 2)
  expect_equal(mday(date), 2)
  expect_equal(wday(date), 4)
  expect_equal(yday(date), 33)
  expect_equal(month(date), 2)
  expect_equal(year(date), 2011)
  expect_match(tz(date), "UTC")
  date2 <- update(as.Date("11/01/2010", "%m/%d/%Y"),
    seconds = 61, minutes = 61, hours = 25, days = 32, months = 13)
  expect_equal(second(date2), 1)
  expect_equal(minute(date2), 2)
  expect_equal(hour(date2), 2)
  expect_equal(mday(date2), 2)
  expect_equal(wday(date2), 4)
  expect_equal(yday(date2), 33)
  expect_equal(month(date2), 2)
  expect_equal(year(date2), 2011)
  expect_match(tz(date2), "UTC")
})

test_that("update performs consecutive roll overs correctly for
  POSIXlt objects", {
  posl <- as.POSIXlt("2010-11-01 00:00:00", tz = "GMT", format
     = "%Y-%m-%d %H:%M:%S")
  poslt <- update(posl, months = 13, days = 32, hours = 25,
    minutes = 61, seconds = 61)

  expect_equal(second(poslt), 1)
  expect_equal(minute(poslt), 2)
  expect_equal(hour(poslt), 2)
  expect_equal(mday(poslt), 2)
  expect_equal(wday(poslt), 4)
  expect_equal(yday(poslt), 33)
  expect_equal(month(poslt), 2)
  expect_equal(year(poslt), 2011)
  expect_match(tz(poslt), "GMT")

  poslt2 <- update(posl, seconds = 61, minutes = 61, hours = 25,
    days = 32, months = 13)

  expect_equal(second(poslt2), 1)
  expect_equal(minute(poslt2), 2)
  expect_equal(hour(poslt2), 2)
  expect_equal(mday(poslt2), 2)
  expect_equal(wday(poslt2), 4)
  expect_equal(yday(poslt2), 33)
  expect_equal(month(poslt2), 2)
  expect_equal(year(poslt2), 2011)
  expect_match(tz(poslt2), "GMT")
})

test_that("update performs consecutive roll overs correctly for POSIXct objects", {
  posc <- as.POSIXct("2010-11-01 00:00:00", tz = "GMT", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- update(posc, months = 13, days = 32, hours = 25,
    minutes = 61, seconds = 61)

  expect_equal(second(posct), 1)
  expect_equal(minute(posct), 2)
  expect_equal(hour(posct), 2)
  expect_equal(mday(posct), 2)
  expect_equal(wday(posct), 4)
  expect_equal(yday(posct), 33)
  expect_equal(month(posct), 2)
  expect_equal(year(posct), 2011)
  expect_match(tz(posct), "GMT")

  posct2 <- update(posc, seconds = 61, minutes = 61, hours = 25,
    days = 32, months = 13)

  expect_equal(second(posct2), 1)
  expect_equal(minute(posct2), 2)
  expect_equal(hour(posct2), 2)
  expect_equal(mday(posct2), 2)
  expect_equal(wday(posct2), 4)
  expect_equal(yday(posct2), 33)
  expect_equal(month(posct2), 2)
  expect_equal(year(posct2), 2011)
  expect_match(tz(posct2), "GMT")
})

test_that("update returns NA for date-times in the spring dst gap", {
  poslt <- as.POSIXlt("2010-03-14 01:59:59", tz = "UTC", format = "%Y-%m-%d %H:%M:%S")
  poslt <- force_tz(poslt, tzone = "America/New_York")
  expect_true(is.na(update(poslt, seconds = 65)))
  expect_true(is.na(update(poslt, minutes = 65)))
  expect_true(is.na(update(poslt, hours = 2)))
  poslt <- as.POSIXlt("2010-03-13 02:59:59", tz = "UTC", format = "%Y-%m-%d %H:%M:%S")
  poslt <- force_tz(poslt, tzone = "America/New_York")
  expect_true(is.na(update(poslt, mdays = 14)))
  expect_true(is.na(update(poslt, wdays = 8)))
  expect_true(is.na(update(poslt, ydays = 73)))
  poslt <- as.POSIXlt("2010-02-14 02:59:59", tz = "UTC", format = "%Y-%m-%d %H:%M:%S")
  poslt <- force_tz(poslt, tzone = "America/New_York")
  expect_true(is.na(update(poslt, months = 3)))
  poslt <- as.POSIXlt("2009-03-14 02:59:59", tz = "UTC", format = "%Y-%m-%d %H:%M:%S")
  poslt <- force_tz(poslt, tzone = "America/New_York")
  expect_true(is.na(update(poslt, years = 2010)))
  poslt <- as.POSIXlt("2010-03-14 02:59:59", tz = "UTC", format = "%Y-%m-%d %H:%M:%S")
  expect_true(is.na(update(poslt, tzs = "America/New_York")))
})

test_that("update handles vectors of dates", {
  poslt <- as.POSIXlt(c("2010-02-14 01:59:59", "2010-02-15 01:59:59", "2010-02-16 01:59:59"),
                      tz = "UTC", format = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)
  expect_equal(second(update(poslt, seconds = 1)), c(1, 1, 1))
  expect_equal(second(update(posct, seconds = 1)), c(1, 1, 1))
  expect_equal(day(update(date, days = 1)), c(1, 1, 1))
})

test_that("update handles vectors of dates and conformable vector of inputs", {
  poslt <- as.POSIXlt(c("2010-02-14 01:59:59", "2010-02-15 01:59:59", "2010-02-16
    01:59:59"), tz = "UTC", format = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)
  expect_equal(second(update(poslt, seconds = c(1, 2, 3))), c(1, 2, 3))
  expect_equal(second(update(posct, seconds = c(1, 2, 3))), c(1, 2, 3))
  expect_equal(day(update(date, days = c(1, 2, 3))), c(1, 2, 3))
})

test_that("update handles single vector of inputs", {
  poslt <- as.POSIXlt("2010-03-14 01:59:59", tz = "UTC", format = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)
  expect_equal(second(update(poslt, seconds = c(1, 2, 3))), c(1, 2, 3))
  expect_equal(second(update(posct, seconds = c(1, 2, 3))), c(1, 2, 3))
  expect_equal(day(update(date, days = c(1, 2, 3))), c(1, 2, 3))
})

test_that("update handles conformable vectors of inputs", {
  poslt <- as.POSIXlt("2010-03-10 01:59:59", tz = "UTC", format = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)
  expect_equal(second(update(poslt, seconds = c(1, 2), minutes = c(1, 2, 3, 4))), c(1, 2, 1, 2))
  expect_equal(second(update(posct, seconds = c(1, 2), minutes = c(1, 2, 3, 4))), c(1, 2, 1, 2))
  expect_equal(day(update(date, days = c(1, 2), months = c(1, 2, 3, 4))), c(1, 2, 1, 2))
})

test_that("update.POSIXct returns input of length zero when given input of length zero", {
  x <- structure(vector(mode = "numeric"), class = c("POSIXct", "POSIXt"))
  expect_equal(update(x, days = 1), x)
})

test_that("update.POSIXlt returns input of length zero when given input of length zero", {
  x <- as.POSIXlt(structure(vector(mode = "numeric"), class = c("POSIXct", "POSIXt")))
  expect_equal(update(x, days = 1), x)
})

test_that("update correctly handles 60 seconds on 59 minute (bug #313)", {
  expect_equal(ymd_hms("2015-01-01 00:59:00") + seconds(60),
               ymd_hms("2015-01-01 01:00:00"))
  expect_equal(ymd_hms("2015-01-01 01:59:00") + seconds(60),
               ymd_hms("2015-01-01 02:00:00"))
  expect_equal(ymd_hms("2015-01-01 23:59:00") + seconds(60),
               ymd_hms("2015-01-02 00:00:00"))
  expect_equal(ymd_hms("2015-01-01 00:59:05") + seconds(55),
               ymd_hms("2015-01-01 01:00:00"))
  expect_equal(ymd_hms("2015-01-01 00:59:59") + seconds(1),
               ymd_hms("2015-01-01 01:00:00"))
})

test_that("Updateing on seconds doesn't affect hours", {
  ## https://github.com/tidyverse/lubridate/issues/619

  tt2 <- tt <- Sys.time()
  second(tt2) <- 5
  expect_equal(hour(tt), hour(tt2))
})


## ## bug #319
## x <- structure(list(sec = 0, min = 0, hour = 0, mday = -212, mon = 7L,
##                         year = 108L, wday = NA_integer_, yday = NA_integer_, isdst = 0L,
##                         zone = "EST", gmtoff = -18000L),
##                    .Names = c("sec", "min",
##                        "hour", "mday", "mon", "year", "wday", "yday", "isdst", "zone",
##                        "gmtoff"),
##                    tzone = c("America/New_York", "EST", "EDT"),
##                    class = c("POSIXlt", "POSIXt"))
## update(x, year = year(x) + 1)
