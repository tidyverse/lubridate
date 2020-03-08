context("Comparisons operations")

test_that("Comparison operators work with POSIX and Date objects", {
  expect_true(ymd_hms("2016-01-03 00:00:00", tz = "") == "2016-01-03 00:00:00")
  expect_true(ymd_hms("2016-01-03 00:00:00", tz = "") == "2016-01-03")
  expect_true(ymd_hms("2016-01-03 00:00:01", tz = "") > "2016-01-03 00:00:00")
  expect_true(ymd("2016-01-03") == "2016-01-03")
  expect_true(ymd("2016-01-03") >  "2016-01-02")
  expect_true(ymd("2016-01-03") <  "2016-01-04")
  expect_true(ymd("2016-01-03") == ymd_hms("2016-01-03 00:00:00"))
  expect_true(ymd("2016-01-03") < ymd_hms("2016-01-03 00:00:01"))
  expect_true(ymd("2016-01-03") != ymd_hms("2016-01-03 00:00:01"))
  expect_true(ymd("2016-01-03") > ymd_hms("2016-01-02 23:59:59"))
  expect_true(ymd("2016-01-03") > ymd_hms("2016-01-02 23:59:59", tz = "Europe/Paris"))
  expect_true(ymd("2016-01-03") < ymd_hms("2016-01-03 00:00:01", tz = "Europe/Paris"))
  expect_true(ymd("2016-01-03") < ymd_hms("2016-01-03 00:00:01", tz = "Europe/Paris"))
  expect_true(ymd("2016-01-03") < as.POSIXlt(ymd_hms("2016-01-03 00:00:01", tz = "Europe/Paris")))
  expect_true(ymd("2016-01-03") < as.POSIXlt(ymd_hms("2016-01-03 00:00:01", tz = "Europe/Paris")))
})

test_that("Duration and periods are comparable", {
  expect_true(dyears(1) == years(1))
})

test_that("character comparison with periods works as expected", {
  expect_true(period(days = 1) == "day")
  expect_true(period(days = 2, seconds = 2) == "2 days, 2 secs")
  expect_true("day" == period(days = 1))
  expect_true("2 days, 2 secs" == period(days = 2, seconds = 2))
  expect_true(period("day 1s") >  period(days = 1))
  expect_true("day 1s" >  period(days = 1))
  expect_true("day 1S 2H" == period(days = 1, seconds = 1, hours = 2))
  expect_false("day 1S 2H" < period(days = 1, hours = 2))
  expect_true("day 1S 2H 3m 2y" >  period(days = 1, months = 3, years = 2, hours = 2))
})

test_that("duration comparison with periods works as expected", {
  expect_true(period(days = 1) == duration(days = 1))
  expect_true(duration(days = 1) == period(days = 1))
  expect_true(period(days = 2, seconds = 2) == duration("2 days, 2 secs"))
  expect_true(duration("day") == period(days = 1))
  expect_true(ddays() == days())
  expect_true(duration("day 1s") >  period(days = 1))
  expect_true(duration("day 1s") >  period(days = 1))
  expect_true(duration("day 1S 2H") == period(days = 1, seconds = 1, hours = 2))
  expect_false(duration("day 1S 2H") < period(days = 1, hours = 2))
  expect_true(duration("day 1S 2H 3m 2y") >  period(days = 1, months = 3, years = 2, hours = 2))
})

test_that("character comparison with durations works as expected", {
  expect_true("day" == duration(days = 1))
  expect_true("2 days, 2 secs" == duration(days = 2, seconds = 2))
  expect_true(duration("day 1s") >  duration(days = 1))
  expect_true("day 1s" >  duration(days = 1))
  expect_true("day 1S 2H" == duration(days = 1, seconds = 1, hours = 2))
  expect_false("day 1S 2H" < duration(days = 1, hours = 2))
})

test_that("numeric comparison with durations works as expected", {
  expect_true(1 == duration(secs = 1))
  expect_true(172802 == duration(days = 2, seconds = 2))
  expect_true(86401 > duration(days = 1))
  expect_true(93601 == duration(days = 1, seconds = 1, hours = 2))
  expect_true(86400 < duration(days = 1, hours = 2))
  expect_true(10 > as.duration(1))
})

test_that("difftime comparison with periods works", {
  t <- ymd_hms("2019-03-01 12:30:50")
  expect_true(days(1) == (t + days(1)) - t)
  expect_true((t + days(1)) - t == days(1))
})

test_that("difftime comparison with durations works", {
  t <- ymd_hms("2019-03-01 12:30:50")
  expect_true(ddays(1) == (t + ddays(1)) - t)
  expect_true((t + ddays(1)) - t == ddays(1))
})


test_that("Comparison operators work duration and difftime objects (#323)", {
  t1 <- ymd_hms("2019-03-01 12:30:50")
  t2 <- t1 + dhours(1)
  t3 <- t1 + dseconds(1)

  expect_true((t2 - t1) >  dseconds(60))
  expect_false((t2 - t1) >  dseconds(3600))
  expect_true((t2 - t1) < dseconds(3601))

  expect_true(dhours(1) > dminutes(59))
  expect_true(dhours(1) == dseconds(3600))

  expect_true(dhours(1) == 3600)
  expect_false(dhours(1) == 1)
})
